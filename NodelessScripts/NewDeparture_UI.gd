extends Control

@onready var depart_button = $DepartButton
@onready var spaceship = $"../../Spaceship"

func _ready():
	spaceship.connect("player_crashed", on_player_crashed)


func on_player_crashed(area):
	depart_button.show()


func _on_depart_button_pressed():
	depart_button.hide()
