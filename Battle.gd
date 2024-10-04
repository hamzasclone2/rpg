extends CanvasLayer

@onready var level_label = $"Control/Level Label"
@onready var hp_label = $"Control/HP Label"
@onready var mp_label = $"Control/MP Label"
@onready var exp_label = $"Control/EXP Label"
@onready var gold_label = $"Control/Gold Label"


# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "Level: " + str(PlayerAttributes.level)
	hp_label.text = "HP: " + str(PlayerAttributes.currentHP) + "/" + str(PlayerAttributes.maxHP)
	mp_label.text = "MP: " + str(PlayerAttributes.currentMP) + "/" + str(PlayerAttributes.maxMP)
	exp_label.text = "EXP: " + str(PlayerAttributes.exp)
	gold_label.text = "Gold: " + str(PlayerAttributes.gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
