//Dependent on build_game.js
//Dependent on game_start.js

function get_game() {
	$.ajax({
		url:"../game_status?id="+window.GAME_ID,
	    success: function(data) {
            console.log(data);
            if (!data.winner_id) {
                build_game(data);
            } else {
                get_next_game();
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
                poker.error = false;
            } else {
                poker.error = true;
            }
            show_message(data.message);
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
	else if (action === STAY) {
		action = BET;
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
            poker.your_card1 = "../cards/card_back.png";
            poker.your_card2 = "../cards/card_back.png";
            $("#mycard1").attr("src", "../cards/card_back.png");
            $("#mycard2").attr("src", "../cards/card_back.png");
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
