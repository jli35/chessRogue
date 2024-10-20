extends Container

@onready var card = preload("res://src/CardInHand/cardInHand.tscn")
var startPosition
var cardHighlighted = false

func _on_mouse_entered() -> void:
	if $selectAnimation != null:
		$selectAnimation.play("select")
		cardHighlighted = true


func _on_mouse_exited() -> void:
	if $selectAnimation != null:
		$selectAnimation.play("deselect")
		cardHighlighted = false


func _on_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton) and (event.button_index == 1): # left mouse button
		if event.button_mask == 1: # mouse down
			if cardHighlighted: 
				var cardTemp = card.instantiate()
				get_tree().get_root().get_node("board/cardHolder").add_child(cardTemp)
				GameState.cardSelected = true
				self.get_child(0).hide() # hide just sprite
		elif event.button_mask == 0: # mouse up
			if !GameState.mouseOnPlacement: # card not dropped in placement area
				cardHighlighted = false
				self.get_child(0).show()
			else: # card dropped in placement area
				self.queue_free() # delete card
				get_node("../../cardPlacement").placeCard()
			get_tree().get_root().get_node("board/cardHolder").get_child(0).queue_free()
			GameState.cardSelected = false
				
