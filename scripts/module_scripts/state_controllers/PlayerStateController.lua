local PlayerStateController = {};
StateController = require("StateController");
PlayerStates = require("PlayerStates");

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

  PlayerNode.Model = PlayerNode:get_node("Model")
  PlayerNode.SoundController = AudioStreamPlayer3D:new()
  PlayerNode:add_child(PlayerNode.SoundController)
  PlayerNode.Camera = CameraNode;
  StateController.new(PlayerNode, PlayerStates.Idle);
end;

return PlayerStateController;
