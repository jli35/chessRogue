extends Node2D

@onready var cardScene: PackedScene = preload("res://src/scenes/Card.tscn")
@onready var bishopScene: PackedScene = preload("res://src/scenes/cards/BishopCard.tscn")
@onready var knightScene: PackedScene = preload("res://src/scenes/cards/KnightCard.tscn")
@onready var hand = $CanvasLayer/Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_make_bishop_pressed() -> void:
	var card = bishopScene.instantiate()
	hand.add_card(card)


func _on_make_knight_pressed() -> void:
	var card = knightScene.instantiate()
	hand.add_card(card)
