//Dependent on ajax_function.js

var BET  = "bet";
var FOLD = "fold";
var STAY = "stay";

var poker = {

	player: "not in game",
    playing: false,
    passed: false,
    error: false,
	players: {
        player1: {
        	username: "----",
        	balance: "----"  
        },
        player2: {
        	username: "----",
        	balance: "----"
        },
        player3: {
        	username: "----",
        	balance: "----"
        },
        player4: {
        	username: "----",
        	balance: "----"
        }
	},
	pot: 0,
    card1: undefined,
    card2: undefined,
    card3: undefined,
    card4: undefined,
    card5: undefined,
    your_card1: undefined,
    your_card2: undefined,
}

$(document).ready(function() {
    /*if ($("#chat-message").length < 1) {
        console.log("\n\n\n\n\n\n\n\n\nUhoh");
    }
    console.log("Hello\n\n"+$(".chat-input"));*/
    $("#chat-message").keypress(function(event){
        if (event.which == 13) {
            if ($("#chat-message").val().length < 1) {
                return;
            }
            $.ajax({
                url: "../../chats/new",
                type: "POST",
                data: {
                    message: $("#chat-message").val(),
                    table_id: $("#chat-table-id").val()
                }
            });
            $("#chat-message").val("");
        } 
        //console.log("tap.");
    });
    setInterval(get_game, 1000);
    window.CARD_INTERVAL = setInterval(if_needed_get_cards, 1000);
    //get_chat_index();
    window.CHAT_INDEX = 0;
    window.CHAT_INTERVAL = setInterval(get_chats, 1000);

    if (window.PLAYER_POSITION) {
        poker.playing = true;
    }

    /*$("#chat-submit").click(function(event) {
      event.preventDefault();
      console.log("Here.");
      $.ajax({
        url: "../../chats/new",
        type: "POST",
        data: {
            message: $("#chat-message").val(),
            table_id: $("#chat-table-id").val()
        }
      });
      $("#chat-message").val("");
    });*/
    console.log('here');

    if (window.PLAYER_POSITION == undefined) {
        join_game();
    }

});

function show_message(message) {
    if (message == undefined || message.length < 1) {
        return;
    }
    //$("#message").html(message);
    if (window.MESSAGE != message) {
      var message_li = $("<li>"+message+"</li>");
      message_li.css("color", "red");
      $("#chat-list").prepend(message_li);
      window.MESSAGE = message;
    }
    if (message.substring(0,13) == "The winner is") {
        window.WINNER_HOLD = 10;
    }


}

function if_needed_get_cards() {
    if (poker.your_card1 == undefined) {
        get_cards();
    } else {
        clearInterval(window.CARD_INTERVAL);
    }
}
