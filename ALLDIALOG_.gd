extends Control
#DIALOG/DIALOGUE
signal dialog_Animation_start()
signal dialog_Animation_advance()
signal dialog_Animation_end()
signal dialog_Instant_advance()
var dialogue_state = 0
var dialogue_state2 = 0
onready var showDialogMenu = "false"
var dialogueType
var coolCheck1
func _on_RayCast2D_dialog_Info(targetName, is_talking):
	is_talking = true
	match targetName:
		"Gordien":
			match dialogue_state:
				-1:
					dialogue_state = 0
				0:
					emit_signal("dialog_Animation_start")
					is_talking = true
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/NPCName.text = "Gordien"
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "[shake rate=20 level=20]Did this work?[/shake]" 
					dialogue_state = 1
				1:
					emit_signal("dialog_Animation_advance")
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "If you're reading this, then it [shake rate=20 level=20]WORKED![/shake]"
					dialogue_state = 2
				2:
					emit_signal("dialog_Animation_advance")
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "[rainbow freq=2 sat=10 val=20]That's pretty cool, amirite?[/rainbow]"
					dialogue_state = 3
					
				3:
					emit_signal("dialog_Animation_end")
					dialogue_state = 0
					is_talking = false
		"cabin_fridge":
			match dialogue_state:
				-1:
					dialogue_state = 0
					is_talking = true
				0:
					dialogueType = "text"
					emit_signal("dialog_Animation_start")
					is_talking = true
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/NPCName.text = ""
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "There's a fridge here." 
					dialogue_state = 1
					
				1:
					emit_signal("dialog_Animation_advance")
					showDialogMenu = "true"
					dialogueType = "textAndOptions"
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "Open the fridge?"
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers.bbcode_text = "Yes"
					$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers2.bbcode_text = "No"
					if $MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers.is_visible() == true:
						match dialogSelectOption.d_menu_pos:
							0:
								emit_signal("dialog_Animation_advance")
								#if Input.is_action_pressed("interact"):
								dialogueType = "text"
								showDialogMenu = "false"
								emit_signal("dialog_Animation_advance")
								$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "This isn't your fridge. It isn't polite to open a fridge that isn't yours."
								dialogue_state = 3
							1:
								#if Input.is_action_pressed("interact"):
								emit_signal("dialog_Animation_advance")
								dialogueType = "text"
								showDialogMenu = "false"
								emit_signal("dialog_Animation_advance")
								$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Dialogue.bbcode_text = "Good."
								dialogue_state = 3
				2:
					coolCheck1 = true
					
				3:
					emit_signal("dialog_Animation_end")
					dialogue_state = 0
					is_talking = false
		
					
					
					
					
	if showDialogMenu == "true":
		$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers.show()
		$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers2.show()
		$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/selectOption.show()
	if showDialogMenu == "false":
		$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers.hide()
		$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/Answers2.hide()
		$MarginContainer/VBoxContainer/DialoguePopup/TextureRect/selectOption.hide()



