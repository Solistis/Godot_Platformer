extends Node

var max_health = 3
var current_health = max_health

# Health UI Update function (you can call this from other scripts)
func update_health_ui(hearts_node: Node):
	for i in range(hearts_node.get_child_count()):
		var heart = hearts_node.get_child(i)
		if i < current_health:
			heart.visible = true
		else:
			heart.visible = false
