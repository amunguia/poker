function show_game_started(started) {
	if (started || poker.passed || poker.playing) {
        build_game_center_panel();
	} else {
        build_join_game_panel();
	}
}

function build_game_center_panel() {
	if ($("#stream-panel").length  > 0) {
		return; //Already there.
	}

    var html = '<div class="col-sm-2"></div><div id="stream-panel" class="col-sm-6">';
    html += '<image src="../assets/cards/card_back.png" class="card-img" id="card1">';
    html += '<image src="../assets/cards/card_back.png" class="card-img" id="card2">';
    html += '<image src="../assets/cards/card_back.png" class="card-img" id="card3">';
    html += '<image src="../assets/cards/card_back.png" class="card-img" id="card4">';
    html += '<image src="../assets/cards/card_back.png" class="card-img" id="card5">';
    html += '</div><div id="pot-status" class="col-sm-2"><p id="pot-balance">$0</p></div>';
    $("#game-row").html(html);
}

function build_join_game_panel() {
	if ($("#join-panel").length > 0) {
		return;
	}

	if (poker.passed == false) {
        var html = '<div class="col-sm-2"></div><div id="join-panel" class="col-sm-3 button button-text join-button">';
        html += 'JOIN</div><div id="observe-panel" class="col-sm-3 button button-text observe-button">WATCH</div>';
        html += '<div class="col-sm-2">';
        $("#game-row").html(html);

        $("#join-panel").on('click', function(event) {
             join_game();
             poker.playing = true;
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
    html += '<div id="stay" class="button"><p class="button-text">STAY</p></div>';
    html += '<div id="bet" class="button"><p class="button-text">BET</p></div>';
    html += '<div id="fold" class="button"><p class="button-text">FOLD</p></div>';

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
    html += '<div id="push-bet" class="button button-text action-panel">BET</div>';
    html += '<div id="go-back" class="button button-text action-panel">BACK</div>';

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