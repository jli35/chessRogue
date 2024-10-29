extends Control

@onready var card = preload("res://src/scenes/cardOnBoard.tscn")

func _on_mouse_entered() -> void:
	GameState.mouseOnPlacement = true

func _on_mouse_exited() -> void:
	GameState.mouseOnPlacement = false

func placeCard() -> void:
	var cardTemp = card.instantiate()
	global_position = Vector2(GameState.projectResolutionWidth/2, GameState.projectResolutionHeight/2) - self.position
	add_child(cardTemp)
	
