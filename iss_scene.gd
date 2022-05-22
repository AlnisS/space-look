extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var last_mouse_position = Vector2.ZERO

func _ready():
	$CameraBase.rotation_degrees.y = 60.0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	
	var mouse_delta = get_viewport().get_mouse_position() - last_mouse_position
	
	if Input.is_action_pressed("rotate"):
		$CameraBase/Pivot.rotation_degrees.x = clamp(
			$CameraBase/Pivot.rotation_degrees.x - mouse_delta.y * 0.4,
			-90.0, 90.0
		)
		$CameraBase.rotation_degrees.y -= mouse_delta.x * 0.4
	
	
	
	var mouse_p = get_viewport().get_mouse_position() / get_viewport().size - Vector2(0.5, 0.5)
	
	if Input.is_action_pressed("pan"):
		$CameraBase/Pivot/Camera.translation.x = clamp(
			$CameraBase/Pivot/Camera.translation.x - 0.01 * mouse_delta.x,
			-10.0, 10.0
		)
		$CameraBase/Pivot/Camera.translation.y = clamp(
			$CameraBase/Pivot/Camera.translation.y + 0.01 * mouse_delta.y,
			-5.0, 5.0
		)
	last_mouse_position = get_viewport().get_mouse_position()


func _input(event):
	var zoom_change = 0.0
	
	if Input.is_action_just_pressed("zoom_in"):
		zoom_change += 1.0
	if Input.is_action_just_pressed("zoom_out"):
		zoom_change -= 1.0
	
	$CameraBase/Pivot/Camera.fov = clamp(
		$CameraBase/Pivot/Camera.fov - zoom_change * 1.0,
		5.0, 30.0
	)
