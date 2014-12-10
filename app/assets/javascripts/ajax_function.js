//Dependent on build_game.js
//Dependent on game_start.js

function get_game() {
	$.ajax({
		url:"../game_status?id="+window.GAME_ID,
	    success: function(data) {
            var g = JSON.parse(data);
            //console.log(data);
            //console.log(g);
            //console.log(g.winner_id);
            if (!g.winner_id) {
                build_game(data);
            } else {
                //console.log(data.winner_id);
                if (poker.next_game) {
                  //get_next_game();
                } else {
                    build_game(data);
                    new_game_panel();
                }

            }
            show_message(data.message);
	    }
	});
}

function join_game() {
	$.ajax({
        type: "POST",
        url: "../join_game",
        data: {
        	     authenticity_token: window.AUTH_TOKEN,
                 id: window.GAME_ID,
              },
        success: function(data) {
            if (data.result) {
                window.PLAYER_POSITION = data.player;
                poker.playing = true;
                poker.error = false;
                $(".p1").removeClass("p1");
                $(".p2").removeClass("p2");
                $(".p3").removeClass("p3");
                $(".p4").removeClass("p4");
                $(".card-img").attr("src", "../cards/card_back.png");
            } else {
                poker.error = true;
            }
            //show_message(data.message);
        }      
	});
}

function get_cards() {
	$.ajax({
        url: "../get_cards?id="+window.GAME_ID,
        success: function(data) {
            cards = data.cards;
            if (cards.length > 0) {
                $("#mycard1").attr("src", "../"+cards[0]);
                poker.your_card1 = "../"+cards[0];
                $("#mycard2").attr("src", "../"+cards[1]);
                poker.your_card2 = "../"+cards[1];        
            }
            if (data.result) {
                poker.error = false;
            } else {
                poker.error = true;
            }
        }
	});
}

function move(action, amount) {
	amount = Math.floor(amount);
	if (action === BET && amount <= 0) {
		amount = 0;
	}
    else if (action === FOLD) {
        amount = 0;
    }

    $.ajax({
    	type: "POST",
        url: "../move",
        data: {
        	authenticity_token: window.AUTH_TOKEN,
        	id: window.GAME_ID,
        	action_type: action,
        	amt: amount
        },
        success: function(data) {
            if (data.success) {
        	    build_game(game);
                remove_player_turn_panel();
            } else {
                $("#error-message").html(data.message);
                console.log(data.message);
            }
            if (data.result) {
                poker.error = false;
            } else {
                poker.error = true;
            }
        }
    });
}

function get_next_game() {
    $.ajax({
      url: ""+window.TABLE_ID+"/game_id",
      success: function(data) {
        if (data.game_id) {
            window.GAME_ID = data.game_id;
            window.PLAYER_POSITION = false;
            poker.passed = false;
            poker.playing = false;
            poker.your_card1 = undefined;
            poker.your_card2 = undefined;
            $("#mycard1").attr("src", "../cards/card_back.png");
            $("#mycard2").attr("src", "../cards/card_back.png");
            $(".p1").removeClass("p1");
            $(".p2").removeClass("p2");
            $(".p3").removeClass("p3");
            $(".p4").removeClass("p4");
            window.CARD_INTERVAL = setInterval(if_needed_get_cards, 1000);
            poker.next_game = false;
            join_game();
        } 
      }
    });
}

function get_chat_index() {
    $.ajax({
      url: window.TABLE_ID+"/chat_index",
      success: function(data) {
        if (data.success) {
            window.CHAT_INDEX = data.index;
            setInterval(get_chats, 1000);
        }
      }
    });
}

function get_chats() {
    $.ajax({
      url: "../../chats/"+window.TABLE_ID+"/"+window.CHAT_INDEX,
      success: function(data) {
        window.CHAT_INDEX = data.index;
        chats = data.chats;
        if (chats.length > 0) {
            update_chat(chats);
        }    
      }
    });
}


function stay() {
    console.log("stay pressed.");
    move(STAY, 0);
}

function bet() {
    console.log("bet pressed.");
    build_player_bets_panel();
}

function push_bet() {
     var bet = +$("#bet_amt").val();
     if (isNaN(bet)) {
         show_message("Sorry, that is an invalid bet.");
     }
     else {
        move(BET, bet);
    }
}

function fold() {
    console.log("fold pressed.");
    move(FOLD, 0);
}
