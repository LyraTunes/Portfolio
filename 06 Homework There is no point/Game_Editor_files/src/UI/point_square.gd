extends Node2D

func _ready():
	self.visible = false
# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	if Variables.unlock_point:
		self.visible = true
	if not Variables.unlock_point:
		self.visible = false


func _on_area_2d_area_entered(_area: Area2D) -> void:
	Variables.on_square = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	Variables.on_square = false
