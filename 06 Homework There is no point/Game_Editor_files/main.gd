extends Node2D

@export_file("*json") var dialogue_file: String

var point = preload("res://src/UI/point.tscn")

var dialogue : Dictionary = {}
@onready var button = $NextCustomer
@onready var DialogPlayer = $DialogPlayer

func _input(event):
	if event.is_action("ui_accept"):
		if Variables.in_interjection:
			SignalBus.emit_signal("text_adjustment")
		if not Variables.unlock_point:
			SignalBus.emit_signal("display_dialog", Variables.customers[Variables.customer])

func _ready():
	button.visible = false
	DialogPlayer.visible = false
	SignalBus.emit_signal("restart_game")
	dialogue = load_dialogue()
	SignalBus.connect("start_game", Callable(self, "start_game"))
	
func _process(_delta):
	if Variables.customers.size() > Variables.customer:
		if Variables.ammount_scanned == Variables.cart[Variables.customers[Variables.customer]].size() and Variables.line == dialogue[Variables.customers[Variables.customer]].size():
			button.visible = true
		else:
			button.visible = false
	else:
		button.visible = false
	

func _on_button_pressed() -> void:
	Variables.customer += 1
	if Variables.customer == dialogue.size():
		DialogPlayer.visible = false
		spawn_point()
	else:
		Variables.line = 0
		Variables.ammount_scanned = 0
		start_game()

func load_dialogue():
	if FileAccess.file_exists(dialogue_file):
		var file = FileAccess.open(dialogue_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func spawn_point():
	var instance = point.instantiate()
	instance.position = Vector2(1200, 400)
	add_child(instance)
	Variables.unlock_point = true
	
func start_game():
	DialogPlayer.visible = true
	SignalBus.emit_signal("display_dialog", Variables.customers[Variables.customer])
	
