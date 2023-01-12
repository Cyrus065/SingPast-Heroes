extends Pawn

signal go_exploration
signal go_house

export (String) var location

func go():
	var string = "go_"+location
	emit_signal(string)
