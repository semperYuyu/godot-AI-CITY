local PlayerStateController = {};
StateController = require("StateController");
PlayerStates = require("PlayerStates");
StateController.add(PlayerStateController);

PlayerStateController.new = function(PlayerNode, CameraNode)
  if PlayerNode:get_class() ~= "CharacterBody3D" or not PlayerNode then
    error("Player .new() needs CharacterBody3D as its first parameter");
  elseif CameraNode:get_class() == "Camera3D" then
    print("It is very recommended that Camera Node not be a direct Camera3D, and follows this hierarchy:");
    print("ParentNode/HorizontalPivotNode/VerticalPivotNode/SpringArm3D/Camera3D");
    print("Parent, Horizontal, and Vertical Pivot can be Node3D");
    print("Pass in --> Horizontal Pivot <-- as the Camera Node");
  elseif not CameraNode then
    error("Player .new() needs a Camera passed as second parameter, please read console after doing so");
  end;

  PlayerNode.Camera = CameraNode;
  PlayerNode.currentState = StateController.currentState;
	PlayerNode.switchState = StateController.switchState;
	PlayerNode.process = StateController.process;
	PlayerNode.physics_process = StateController.physics_process;
	PlayerNode.input = StateController.input;

  PlayerNode:switchState(PlayerStates.Idle);
end;

return PlayerStateController;
