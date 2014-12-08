//Dependent on update view_panels.js

function build_game(game) {
	game = JSON.parse(game);
	show_game_started(game.started);
	update_players(game.users);
	update_cards(game);
	update_pot(game.pot_bal);
	show_message(game.message);
	$(".turn-ind").removeClass("turn-ind");
	$(game.current_player).addClass("turn-ind");
	poker.min_bet = game.min_bet

	if (game.current_player == window.PLAYER_POSITION &&
		  poker.your_card1) {	//Wait for game to start before showing panel.
		build_player_turn_panel();
	} else {
		remove_player_turn_panel();
	}
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
		$(".opp-p-"+i).("p1");
		i++;
	}

	if (pos === "p2") {
		player = users["p2"];
		player_number = "p2";
	} else {
		string = users["p2"].username+": $"+users["p2"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-i-"+i).addClass("p2");
		i++;
	}

	if (pos ===  "p3") {	
		player = users["p3"];
		player_number = "p3";
	} else {
		string = users["p3"].username+": $"+users["p3"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-p-"+i).addClass("p3");
		i++;
	}	

    if (pos === "p4" || i > 3) {	
		player = users["p4"];
		player_number = "p4";
	} else {
		string = users["p4"].username+": $"+users["p4"].balance;
		$(".opp-p-"+i).text(string);
		$(".opp-p-"+i).addClass("p4");
		i++;
	}

	string = player.username+": $"+player.balance;
	$("#my-p").text(string);
	$("#my-p").addClass(player_number);
}

function update_pot(pot) {
    $("#pot-balance").text("$"+pot);
}