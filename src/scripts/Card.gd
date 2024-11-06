@tool
extends Node2D

signal mouse_entered()
signal mouse_exited()

@export var cardName: String = "Card Name"
@export var cardCost: int = 1
@export var cardDescription: String = "Card Description"
@export var cardArt: Sprite2D

@onready var nameLabel: Label = $cardName/nameLabel
@onready var costLabel: Label = $cardCost/costLabel
@onready var descriptionLabel: Label = $cardDescription/descriptionLabel
@onready var cardArtSprite: Sprite2D = $cardArt/cardArtSprite


@onready var card = preload("res://src/scenes/cardInHand.tscn")
var startPosition
var cardHighlighted = false

func _ready() -> void:
	_update_card()
	
func set_card_values(_name: String, _cost: int, _description: String) -> void:
	cardName = _name
	cardCost = _cost
	cardDescription = _description
	
func _update_card() -> void:
	if nameLabel.get_text() != cardName:
		nameLabel.set_text(cardName)
	if costLabel.get_text() != str(cardCost):
		costLabel.set_text(str(cardCost))
	if descriptionLabel.get_text() != cardDescription:
		descriptionLabel.set_text(cardDescription)
	if cardArt != null and cardArtSprite.get_texture() != cardArt.get_texture():
		cardArtSprite.set_texture(cardArt.get_texture())
	
func _process(delta: float) -> void:
	_update_card()	


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
				

func playSelectAnimation() -> void:
	if $selectAnimation != null:
		$selectAnimation.play("select")
		
func playDeselectAnimation() -> void:
	if $selectAnimation != null:
		$selectAnimation.play("deselect")
	

func _on_card_area_mouse_entered() -> void:
	mouse_entered.emit()

func _on_card_area_mouse_exited() -> void:
	mouse_exited.emit()


func _on_card_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
