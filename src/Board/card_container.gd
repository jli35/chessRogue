extends HBoxContainer

var startPosition

func _ready() -> void:
	self.size.x = GameState.maxCardsAllowed * 105
	self.pivot_offset.x = GameState.maxCardsAllowed * 52.5
	self.global_position.x = GameState.projectResolutionWidth/6
	self.global_position.y = GameState.projectResolutionHeight - 110
	startPosition = self.position


func _on_mouse_entered() -> void:
	var target_position = startPosition + Vector2(0,-100)
	var posTween = get_tree().create_tween()
	var scaleTween = get_tree().create_tween()
	posTween.tween_property(self, "position", target_position, 0.2)
	scaleTween.tween_property(self, "scale", Vector2(1.3,1.3), 0.2)
	

func _on_mouse_exited() -> void:
	if !GameState.cardSelected: # if no card in hand
		var posTween = get_tree().create_tween()
		var scaleTween = get_tree().create_tween()
		posTween.tween_property(self, "position", startPosition, 0.2)
		scaleTween.tween_property(self, "scale", Vector2(1,1), 0.2)
