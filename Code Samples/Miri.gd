extends Area2D

@export var Balloon: PackedScene = preload("res://Scenes/UI/balloon.tscn")
#@export var SmallBalloon: PackedScene
@export var title: String = "MiriTalk"
@export var dialogue_resource: DialogueResource = preload("res://Scenes/Dialogue/Dialogue_1_TorgrimssonHouse.dialogue")
var MiriTalkOver: bool = false
var MiriTalkCurrent: bool = false


signal Miri

# Interest Point Script, controls dialogue initiation + animation

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	await get_tree().create_timer(0.4).timeout

# Plays animation to make Miri turn her head + sets flag to let the game know the Miri Dialogue is Active

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Miri.emit() 
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		$"../../Characters/MiriSprite/AnimatedSprite2D".play_backwards("MiriTalk")
		show_dialogue(title)
		MiriTalkCurrent = true

# Shows the Dialogue 

func show_dialogue(key: String) -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs a to point to a DialogueResource.")
	#var is_small_window: bool = ProjectSettings.get_setting("display/window/size/viewport_width") < 400
	var balloon: Node = Balloon.instantiate()
	add_child(balloon)
	balloon.start(dialogue_resource, key)


### Signals

func _on_dialogue_ended(_resource: DialogueResource):
	await get_tree().create_timer(0.4).timeout
	#get_tree().quit()
	if MiriTalkCurrent == true :
		$"../../Characters/MiriSprite/AnimatedSprite2D".play("MiriTalk")
		MiriTalkOver = false
	

# Returns Miri to her Idle Sprite
func _on_miri_sprite_miri_anim_finished():
	if $"../../Characters/MiriSprite/AnimatedSprite2D".is_playing() ==! 'MiriTalk' and MiriTalkOver == true :
		$"../../Characters/MiriSprite/AnimatedSprite2D".play("MiriComputerIdle")
		MiriTalkOver = false
