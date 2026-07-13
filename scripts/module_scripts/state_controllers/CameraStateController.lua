local CameraStateController = {};
StateController = require("StateController");
CameraStates = require("CameraStates");

CameraStateController.new = function(CameraNode)
  if not CameraNode then
    error("Camera .new() takes Camera Node as its only parameter");
  elseif CameraNode:get_class() == "Camera3D" then
    error("Camera Node needs to be a Node3D with the following hierarchy\nParentNode/HorizontalPivot/VerticalPivot/SpringArm3D/Camera3D");
  end;

  CameraNode.max_zoom = 30;
  CameraNode.zoom_speed = 1;
  CameraNode.mouse_delta = Vector2.ZERO;
  CameraNode.HPivot = CameraNode:get_node("./HorizontalPivot");
	CameraNode.VPivot = CameraNode:get_node("./HorizontalPivot/VerticalPivot");
	CameraNode.CameraSpring = CameraNode:get_node("./HorizontalPivot/VerticalPivot/CameraSpring");
  CameraNode.currentState = StateController.currentState;
	CameraNode.switchState = StateController.switchState;
	CameraNode.process = StateController.process;
	CameraNode.physics_process = StateController.physics_process;
	CameraNode.input = StateController.input;

  CameraNode:switchState(CameraStates.Locked);
end;

return CameraStateController;
