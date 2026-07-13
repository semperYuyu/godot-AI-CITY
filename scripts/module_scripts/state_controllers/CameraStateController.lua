local CameraStateController = {};
StateController = require("StateController");
CameraStates = require("CameraStates")
StateController.add(CameraStateController);

-- StateController.newCamera = function (CameraNode)
-- 	if not CameraNode then
-- 		error(".newCamera() function needs a Camera3D node passed as first parameter\nSyntax is \".newCamera(CameraNode)\"")
-- 	end;

-- 	CameraNode.mouse_delta = Vector2.ZERO
-- 	CameraNode:switchState(defaultState);
-- end; -- check for node TYPE too

CameraStateController.new = function(CameraNode)

  Node.currentState = StateController.currentState;
	Node.switchState = StateController.switchState;
	Node.process = StateController.process;
	Node.physics_process = StateController.physics_process;
	Node.input = StateController.input;
end;

return CameraStateController;
