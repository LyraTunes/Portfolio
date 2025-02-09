extends Node2D

var bread = preload("res://src/Minigame logic/Items/bread.tscn")
var eggs = preload("res://src/Minigame logic/Items/eggs.tscn")
var milk = preload("res://src/Minigame logic/Items/milk.tscn")
var drink = preload("res://src/Minigame logic/Items/drink.tscn")
var spawned = 0
var customer = 0
var item: String = ""

func _process(_delta):
	if customer != Variables.customer:
		spawned = 0
		customer = Variables.customer
	if Variables.customers.size() > Variables.customer:
		if Variables.cart[Variables.customers[Variables.customer]].size() > spawned and Variables.spawn_timer:
			Variables.spawn_timer = false
			$Cooldown.start()
			item = Variables.cart[Variables.customers[Variables.customer]][spawned]
			spawned += 1
			var rand = randi() % 175 + 400
			inst(item, Vector2(1200, rand))
	
func inst(itemname, pos):
	var instance
	match itemname:
		"bread":
			instance = bread.instantiate()
		"eggs":
			instance = eggs.instantiate()
		"milk":
			instance = milk.instantiate()
		"drink":
			instance = drink.instantiate()
	instance.position = pos
	add_child(instance)

func _on_cooldown_timeout() -> void:
	Variables.spawn_timer = true
