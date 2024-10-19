extends CanvasLayer

@onready var level_label = $"Control/Level Label"
@onready var hp_label = $"Control/HP Label"
@onready var mp_label = $"Control/MP Label"

var isPlayerTurn: bool = false
var rng = RandomNumberGenerator.new()

var giant_rat = {
  "name": "giant_rat",
  "attack": 10,
  "defense": 10,
  "speed": 10,
  "max_hp": 10,
  "max_mp": 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "Level: " + str(PlayerAttributes.level)
	hp_label.text = "HP: " + str(PlayerAttributes.currentHP) + "/" + str(PlayerAttributes.maxHP)
	mp_label.text = "MP: " + str(PlayerAttributes.currentMP) + "/" + str(PlayerAttributes.maxMP)
	
	decideTurnOrder()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_attack_button_pressed():
	decideTurnOrder()
	print(giant_rat["attack"])
	
func decideTurnOrder():
	var player_speed = getRandNumRange(0.1, PlayerAttributes.speed)
	var enemy_speed = getRandNumRange(0.1, giant_rat.speed)
	if(player_speed > enemy_speed):
		isPlayerTurn = true
	print("players turn?: " + str(isPlayerTurn))
	
func getRandNumRange(percent: float, num: int):
	return rng.randi_range(num - percent*num, num + percent*num)
