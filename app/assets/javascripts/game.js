//Dependent on ajax_function.js

var BET  = "bet";
var FOLD = "fold";
var STAY = "stay";

var poker = {

	player: "not in game",
    playing: false,
    passed: false,
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
    setInterval(get_game, 1000);
    window.CARD_INTERVAL = setInterval(if_needed_get_cards, 1000);

    if (window.PLAYER_POSITION) {
        poker.playing = true;
    }
});

function show_message(message) {
    console.log(message);
}

function if_needed_get_cards() {
    if (poker.your_card1 == undefined) {
        get_cards();
    } else {
        clearInterval(window.CARD_INTERVAL);
    }
}
