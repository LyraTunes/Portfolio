extends Node

var line = 0
var customer = 0
var customers = ["Customer1", "Customer2", "Customer3", "Customer4", "Customer5"]
var in_interjection: bool = false
var spawn_timer = true
var dialogue_timer = true
var ammount_scanned = 0
var objects_dropped = 0
var unlock_point = false
var on_square = false
var cart: Dictionary = {
	"Customer1": [
	],
	"Customer2": [
	],
	"Customer3": [
	],
	"Customer4": [
	],
	"Customer5": [
	]
}
