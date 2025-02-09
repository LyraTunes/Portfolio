extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$TextureRect.visible = false
	$Button.visible = false
	$Label.visible = false
	SignalBus.connect("end_game", Callable(self, "revealEnd"))
	
func revealEnd():
	Variables.unlock_point = false
	get_tree().paused = true
	$TextureRect.visible = true
	$Button.visible = true
	$Label.visible = true



func _on_button_pressed() -> void:
	$TextureRect.visible = false
	$Button.visible = false
	$Label.visible = false
	SignalBus.emit_signal("restart_game")
	
func get_random_items(items: Array, min_count: int, max_count: int) -> Array:
	var count = randi() % (max_count - min_count + 1) + min_count
	var result = []
	for i in range(count):
		result.append(items[randi() % items.size()])
	return result
	
func randomizeCart():
	var items = ["eggs", "milk", "bread", "drink"]
	Variables.cart = {
		"Customer1": get_random_items(items, 3, 7),
		"Customer2": get_random_items(items, 3, 7),
		"Customer3": get_random_items(items, 3, 7),
		"Customer4": get_random_items(items, 3, 7),
		"Customer5": get_random_items(items, 3, 7)
	}
