function show_game_started(started) {
	if (started || poker.playing) {
        build_game_center_panel();
	} else {
        build_join_game_panel();
	}
}

function new_game_panel() {
    var html = '<button id="join-panel" class="btn btn-primary button">NEW GAME</button><br>';
    html += '<button id="observe-panel" class="btn btn-danger button">WATCH</button><br>';
    poker.next_game = false;

    $("#action-console").html(html);

        $("#stay").on("click", function(event) {
        console.log("st...");
        stay();
    });

    $("#join-panel").on('click', function(event) {
        get_next_game();
        //join_game();
        poker.playing = true;
        poker.next_game = true;
        //show_game_started(true);
    });

    $("#observe-panel").on('click', function(event) {
        poker.passed = true;
        show_game_started(true);
    });
}

function build_game_center_panel() {
	if ($("#stream-panel").length  > 0) {
		return; //Already there.
	}

    var html = '<div class="col-sm-2"></div><div id="stream-panel" class="col-sm-6">';
    html += '<image src="../../cards/card_back.png" class="card-img" id="card1">';
    html += '<image src="../../cards/card_back.png" class="card-img" id="card2">';
    html += '<image src="../../cards/card_back.png" class="card-img" id="card3">';
    html += '<image src="../../cards/card_back.png" class="card-img" id="card4">';
    html += '<image src="../../cards/card_back.png" class="card-img" id="card5">';
    html += '</div><div id="pot-status" class="col-sm-2"><p id="pot-balance">$0</p></div>';
    $("#game-row").html(html);
}

function build_join_game_panel() {
	if ($("#join-panel").length > 0) {
		return;
	}

	if (poker.passed == false) {
        var html = '<div class="join-observer-box">';
        html += '<table class="join-observer-table"><tr><td>';
        html += '<button type="button" id="join-panel" class="btn btn-danger join-btn btn-lrg">JOIN</button>';
        html += '</td><td>';
        html += '<button type="button" id="observe-panel" class="btn btn-primary observe-btn btn-lrg">WATCH</button>';
        html += '</table></tr></td>';
        html += '</div>';
        $("#game-row").html(html);

        $("#join-panel").on('click', function(event) {
             join_game();
             poker.playing = true;
             //poker.next_game = true;
             show_game_started(true);
        });

        $("#observe-panel").on('click', function(event) {
             poker.passed = true;
             show_game_started(true);
        });
    }


}

function build_player_turn_panel() {
    var error_message = $("#error-message").html();
    if (error_message == undefined) {
        error_message = "";
    }
    if ($("#push-bet").length > 0) {
        return; //Player is betting.
    }

    var html = '<p id="error-message">'+error_message+'</p>'; 
    html += '<button id="stay" class="btn btn-primary button">CALL</button><br>';
    html += '<button id="bet" class="btn btn-danger button">BET</button><br>';
    html += '<button id="fold" class="btn btn-warning button">FOLD</button>';

    $("#action-console").html(html);

        $("#stay").on("click", function(event) {
        console.log("st...");
        stay();
    });

    $("#bet").on("click", function(event) {
        console.log("be....");
        bet();
    });

    $("#fold").on("click", function(event) {
        console.log("fo...");
        fold();
    });
}

function remove_player_turn_panel() {
    $("#action-console").html("");
}

function build_player_bets_panel() {
    var error_message = $("#error-message").html();
    if (error_message == undefined) {
        error_message = "";
    }
    remove_player_turn_panel();

    var min_bet = poker.min_bet;
    if (min_bet == null || min_bet == undefined || min_bet < 0) {
        min_bet = 0;
    }
    var html = '<p id="error-message">'+error_message+'</p>';  
    html += '<p>Minimum bet is $'+min_bet;
    html += '<br>Please enter bet amount: ';
    html += '<input id="bet_amt" type="text"></input></p>';
    html += '<button id="push-bet" class="btn btn-danger button">BET</button><br>';
    html += '<button id="go-back" class="btn btn-primary button">BACK</button>';

    $("#action-console").html(html);

    $("#push-bet").on('click', function(event) {
        console.log("pushed bet.");
        push_bet();
    });

    $("#go-back").on('click', function(event) {
        console.log("go back");
        remove_player_turn_panel();
        build_player_turn_panel();
    });
}


function update_chat(chats) {
    for (var i = 0; i < chats.length; i++) {
        var chat = chats[i];
        if (chat.index > window.CHAT_INDEX) {
            window.CHAT_INDEX = chat.index;
        }
        $("#chat-list").append("<li>"+chat.username+": "+chat.message+"</li>")
    }
}
