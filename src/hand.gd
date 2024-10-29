@tool
extends Node2D

@export var hand_radius: int = 1000
@export var card_angle: float = -90
@export var angle_limit: float = 25
@export var max_card_spread_angle: float = 5
@export var spacing_ratio : float = 1

@onready var cards: Array[Node2D] = []

# Positions and rotates the cards in a circular fan
func arrange_cards():
	var card_spread = min(angle_limit / cards.size(), max_card_spread_angle)
	var current_angle = -(card_spread * (cards.size() - 1))/2 - 90
	for card in cards:
		_update_card_transform(card, current_angle)
		current_angle += card_spread

func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg)) * spacing_ratio
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(int(x), int(y))
	
func _update_card_transform(card: Node2D, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag + 90))
	
# Adds a card to the hand and arranges them
func add_card(card: Node2D) -> void:
	add_child(card)
	cards.append(card)
	arrange_cards()

func remove_card(index: int) -> Node2D:
	var removing_card = cards[index]
	cards.remove_at(index)
	remove_child(removing_card)
	arrange_cards()
	return removing_card

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	cards = []
	for child in get_children():
		if child is Node2D:
			cards.append(child as Node2D)
	arrange_cards()

# Updates the collision shape radius if needed
func _process(delta: float) -> void:
	pass
