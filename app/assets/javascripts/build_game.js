//Dependent on update view_panels.js

function build_game(game) {
	game = JSON.parse(game);
	show_game_started(game.started, game.winner_id);
	update_players(game.users);
	update_cards(game);
	update_pot(game.pot_bal);
	show_message(game.message);
	$(".turn-ind").removeClass("turn-ind");
	if (game.started) {
		$("."+game.current_player).addClass("turn-ind");
	}
	poker.min_bet = game.min_bet

	if (game.current_player == window.PLAYER_POSITION &&
		  poker.your_card1) {	//Wait for game to start before showing panel.
		build_player_turn_panel();
	} else {
		if (game.current_player != "G-O" && window.PLAYER_POSITION != undefined) {
			remove_player_turn_panel();
		}
	}

	if (game.opponents_cards) {
		add_opponents_cards(game.opponents_cards);
	}

	/*var src = $("#mycard1").attr('src');
	if (game.started && src.substring(19) == "back.png") {
		console.log("getting cards in build_game.js");
        get_cards();
	} else {
		//console.log(""+game.started+":\t"+src);
	}*/

	if (game.started && window.PLAYER_POSITION && poker.your_card1 == undefined) {
		get_cards();
		//console.log('hello');
	} else {
		//console.log('here');
		$("#mycard1").attr("src", poker.your_card1);
        $("#mycard2").attr("src", poker.your_card2);
	}

	$("#chat-message").keypress(function(event) {
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
        console.log("tap.");
	});        
	
}

function update_cards(game) {
	if (game.card1) {
        $("#card1").attr("src", "../"+game.card1);
        poker.card1 = "../"+game.card1;
	}
	if (game.card2) {
        $("#card2").attr("src", "../"+game.card2);  
        poker.card2 = "../"+game.card2; 
	}
	if (game.card3) {
        $("#card3").attr("src", "../"+game.card3);
        poker.card3 = "../"+game.card4;
	}
	if (game.card4) {
        $("#card4").attr("src", "../"+game.card4);
        poker.card4 = "../"+game.card4;
	}
	if (game.card5) {
        $("#card5").attr("src", "../"+game.card5);
        poker.card5 = "../"+game.card5;
	}
}

function update_players(users) {
	poker.players = users;
	var pos = window.PLAYER_POSITION;
	var player_number = "";
	var player;
	var string;

	var i = 1;
	if (pos === "p1") {
        player = users["p1"];
        player_number = "p1";
	} else {
		string = users["p1"].username+": $"+users["p1"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-p-"+i).addClass("p1");
		$(".opp-"+i).addClass("p1");
		i++;
	}

	if (pos === "p2") {
		player = users["p2"];
		player_number = "p2";
	} else {
		string = users["p2"].username+": $"+users["p2"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-p-"+i).addClass("p2");
		$(".opp-"+i).addClass("p2");
		i++;
	}

	if (pos ===  "p3") {	
		player = users["p3"];
		player_number = "p3";
	} else {
		string = users["p3"].username+": $"+users["p3"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-p-"+i).addClass("p3");
		$(".opp-"+i).addClass("p3");
		i++;
	}	

    if (pos === "p4" || i > 3) {	
		player = users["p4"];
		player_number = "p4";
	} else {
		string = users["p4"].username+": $"+users["p4"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-p-"+i).addClass("p4");
		$(".opp-"+i).addClass("p4");
		i++;
	}
   
	string = player.username+": $"+player.balance;
	$("#my-p").text(string);
	if (window.PLAYER_POSITION == undefined || window.PLAYER_POSITION.length < 1) {

	} else {
		$("#my-p").addClass(player_number);
	}
}

function update_pot(pot) {
    $("#pot-balance").text("$"+pot);
}

function add_opponents_cards(o_cards) {
	var cards;
	if (o_cards["p1"] && window.PLAYER_POSITION != "p1") {
        cards = $("div.p1 .card-img");
        cards[0].src =  "../"+o_cards["p1"][0];
        cards[1].src = "../"+o_cards["p1"][1];
	} 
	if (o_cards["p2"] && window.PLAYER_POSITION != "p2") {
        cards = $("div.p2 .card-img");
        cards[0].src =  "../"+o_cards["p2"][0];
        cards[1].src = "../"+o_cards["p2"][1];
	}
    if (o_cards["p3"] && window.PLAYER_POSITION != "p3") {
        cards = $("div.p3 .card-img");
        cards[0].src =  "../"+o_cards["p3"][0];
        cards[1].src = "../"+o_cards["p3"][1];
    }
    if (o_cards["p4"] && window.PLAYER_POSITION != "p4") {
        cards = $("div.p4 .card-img");
        cards[0].src =  "../"+o_cards["p4"][0];
        cards[1].src = "../"+o_cards["p4"][1];
    }

}
