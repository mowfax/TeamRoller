extends Node

var group_size: int = 10

var group_names: Dictionary = {
	"1": "BrewDog Berlin Mitte",
	"2": "Albert's Restaurant",
	"3": "PETER PANE Burgergrill & Bar",
	"4": "Papadam Indisches Restaurant",
	"5": "The Flying Monkey",
}

# candidate for separate resource file to save out to userfolder
var group_free_slots: Dictionary = {
	"1": 10,
	"2": 10,
	"3": 10,
	"4": 10,
	"5": 10,
}

var group_face_count: Dictionary = {
	"1": 2,
	"2": 2,
	"3": 2,
	"4": 2,
	"5": 2,
}

# default mapping of die faces to restaurants
var die_face_mapping: Dictionary = {
		"0": "1",
		"1": "2",
		"2": "3",
		"3": "4",
		"4": "5",
		"5": "1",
		"6": "2",
		"7": "3",
		"8": "4",
		"9": "5",
	}
