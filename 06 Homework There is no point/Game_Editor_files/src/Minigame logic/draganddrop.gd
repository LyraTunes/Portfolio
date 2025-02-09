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
			if not onObject:
				queue_free()
				Variables.objects_dropped += 1
				Variables.ammount_scanned += 1
				if Variables.objects_dropped == 1:
					SignalBus.emit_signal("display_dialog", "dropped_one")
				if Variables.objects_dropped == 3:
					SignalBus.emit_signal("display_dialog", "dropped_three")
				if Variables.objects_dropped == 10:
					SignalBus.emit_signal("display_dialog", "dropped_ten")


func _on_scan_hitbox_area_entered(_area: Area2D) -> void:
	queue_free()
	Variables.ammount_scanned += 1

func _on_counter_hitbox_area_entered(_area: Area2D) -> void:
	onObject = true

func _on_counter_hitbox_area_exited(_area: Area2D) -> void:
	onObject = false
