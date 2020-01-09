extends Node2D

onready var StartButton = $MarginContainer/VBoxContainer/VBoxContainer/StartButton
onready var ExitButton = $MarginContainer/VBoxContainer/VBoxContainer/ExitButton

func _ready():
	StartButton.grab_focus()

func _physics_process(delta):
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
