extends Node2D

# This is one of the scripts that controls the level. It checks for zones and instantiates directional markers for scene transitions

var marker_down: PackedScene = preload("res://Scenes/UI/MarkerDown.tscn")
var MarkerPresent: bool = false

# Sets camera to Player Character position on re-entry, instead of the initial position.
func _ready():
	if States.Level_1_1_visited == "True" :
		$Sven.position = $TransitionPoints/Marker1TO2.position
		$Sven/Camera2D.position = $Sven.position
	
# Makes the marker for the transition appear + animate once player character enters the zone

func _on_tp_1to_2_hallwayentered(body):
		if body == $Sven :
			print("entered hallway") #### Prints to Debug Console for Testing Purposes
			var marker = marker_down.instantiate() 
			marker.position = $TransitionPoints/Marker1TO2.position
			$TransitionPoints/Markers.add_child(marker)
			MarkerPresent = true 
			$TransitionPoints/Markers/MarkerDown/MarkerAnimation/AnimationPlayer.play("MarkerMovement")
			States.Level_1_1_visited = "True"
			


# Prints to console for testing purposes
func _on_tp_1to_2_hallwayexited():
	if MarkerPresent == true : 
		print("Marker Present, queue free")
		$TransitionPoints/Markers/MarkerDown.queue_free() 

	
