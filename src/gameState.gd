extends Node


var cardSelected
var mouseOnPlacement
var projectResolutionWidth
var projectResolutionHeight
var maxCardsAllowed

func _ready() -> void:
	mouseOnPlacement = false
	projectResolutionWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
	projectResolutionHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
	maxCardsAllowed = 6
