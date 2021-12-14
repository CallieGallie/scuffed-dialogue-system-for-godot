extends RayCast2D
var scNAME
var sc_ID
onready var is_Talking = false;
signal dialog_Info(targetName, is_Talking)
signal begin_Transition()
signal raycast_A_object_hit(object, scNAME)
func _input(_dialogevent):
	if Input.is_action_just_pressed("interact"):
		print("button press detected!")
		if .is_colliding():
			print("collider checked!")
			var target = .get_collider().get_parent()
			var targetName = .get_collider().get_parent().get_name()
			print (targetName)
			if target != null:
				if target.is_in_group("NPCs"):
					is_Talking = true
					emit_signal("dialog_Info", targetName, is_Talking)
					print("signal one emitted!")
					
					
					
					
	
var scACTIVE
func _physics_process (_delta):
	if .is_colliding():
		var sc = .get_collider()
		var scNAME = .get_collider().get_name()
		var scene = .get_tree().get_current_scene().get_name()
		scACTIVE = true
		emit_signal("raycast_A_object_hit", .get_collider(), scNAME, sc_ID, scACTIVE, scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
