extends Node2D

@onready var Title = $Title
@onready var Background = $Background
@onready var StartGame = $StartGame
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("restart_game", Callable(self, "start_game"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func start_game():
	Variables.unlock_point = false
	get_tree().paused = true
	Title.visible = true
	Background.visible = true
	StartGame.visible = true



func _on_button_pressed() -> void:
	reset_gamestate()
	get_tree().paused = false
	Title.visible = false
	Background.visible = false
	StartGame.visible = false
	Variables.spawn_timer = true
	SignalBus.emit_signal("start_game")

func reset_gamestate():
	Variables.customer = 0
	Variables.line = 0
	Variables.in_interjection = false
	Variables.spawn_timer = true
	Variables.dialogue_timer = true
	Variables.ammount_scanned = 0
	Variables.objects_dropped = 0
	randomizeCart()
	
func get_random_items(items: Array, min_count: int, max_count: int) -> Array:
	var count = randi() % (max_count - min_count + 1) + min_count
	var result = []
	for i in range(count):
		result.append(items[randi() % items.size()])
	return result
	
func randomizeCart():
	var items = ["eggs", "milk", "bread", "drink"]
	Variables.cart = {
		"Customer1": get_random_items(items, 5, 10),
		"Customer2": get_random_items(items, 5, 10),
		"Customer3": get_random_items(items, 5, 10),
		"Customer4": get_random_items(items, 5, 10),
		"Customer5": get_random_items(items, 5, 10)
	}
