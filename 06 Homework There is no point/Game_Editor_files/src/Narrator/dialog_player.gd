extends CanvasLayer

@export_file("*json") var dialogue_file: String
@export_file("*json") var interjection_file: String

var dialogue: Dictionary = {}
var interjection: Dictionary = {}
var selected_text: Array = []
var dialogue_text: Array = []
var in_progress: bool = false

@onready var background = $Background
@onready var text_label = $TextLabel

func _ready():
	background.visible = false
	dialogue = load_dialogue()
	interjection = load_interjection()
	SignalBus.connect("text_adjustment", Callable(self, "text_adjustment"))
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))
	
func load_dialogue():
	if FileAccess.file_exists(dialogue_file):
		var file = FileAccess.open(dialogue_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()
		
func load_interjection():
	if FileAccess.file_exists(interjection_file):  # <-- Use interjection_file, not dialogue_file
		var file = FileAccess.open(interjection_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()
	return {}  # Return empty dict if file missing

func next_line(text_key):
	# Check if the key exists and line is valid
	if dialogue.has(text_key) and Variables.line < dialogue[text_key].size():
		text_label.text = dialogue[text_key][Variables.line]
		Variables.line += 1
	else:
		# Handle end of dialogue
		text_label.text = ""
		background.visible = false
		in_progress = false
		
	
func on_display_dialog(text_key):
	if text_key.contains("Customer") and Variables.dialogue_timer:
		Variables.dialogue_timer = false
		$DialogueTimer.start()
		if not dialogue.has(text_key):
			push_error("Dialogue key missing: ", text_key)
			return
		if in_progress and Variables.line < dialogue[Variables.customers[Variables.customer]].size():
			next_line(text_key)
		if not in_progress and Variables.line < dialogue[Variables.customers[Variables.customer]].size():
			background.visible = true
			in_progress = true
			text_label.text = dialogue[text_key][Variables.line]
			Variables.line += 1
	if not text_key.contains("Customer"):
		if not interjection.has(text_key):
			push_error("Interjection key missing: ", text_key)
			return
		Variables.in_interjection = true
		text_label.text = interjection[text_key][0]
		Variables.line = max(0, Variables.line - 1) 

func text_adjustment():
	if interjection.has("adjustment") and interjection["adjustment"].size() > 0:
		Variables.dialogue_timer = false
		$DialogueTimer.start()
		var rand_index = randi() % interjection["adjustment"].size()
		text_label.text = interjection["adjustment"][rand_index]
		Variables.in_interjection = false


func _on_dialogue_timer_timeout() -> void:
	Variables.dialogue_timer = true
