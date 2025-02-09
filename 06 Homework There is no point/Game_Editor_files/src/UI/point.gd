extends CharacterBody2D

var selected = false
var onObject = false

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true


func _physics_process(delta):
	velocity.x = -100
	move_and_slide()
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and selected:
			selected = false
			if Variables.on_square:
				SignalBus.emit_signal("end_game")
				queue_free()
			if not onObject:
				queue_free()
				SignalBus.emit_signal("restart_game")


func _on_scan_hitbox_area_entered(_area: Area2D) -> void:
	queue_free()
	SignalBus.emit_signal("restart_game")
	



func _on_area_2d_area_entered(_area: Area2D) -> void:
	onObject = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	onObject = false
