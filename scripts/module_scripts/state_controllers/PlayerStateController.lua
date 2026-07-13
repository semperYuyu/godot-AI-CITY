local PlayerStateController = {};
StateController = require("StateController");
PlayerStates = require("PlayerStates")
StateController.add(PlayerStateController);

-- StateController.newPlayer = function (PlayerNode, CameraNode)
-- 	if not PlayerNode then
-- 		error(".newPlayer() function needs a CharacterBody3d node passed as first parameter\nSyntax is \".newPlayer(--> PlayerNode <--, defaultState)\"")
--  elseif not CameraNode then
--    error("im not typing all that again !!!")
-- 	end;
-- 	-- update to iterate and dynamically find a camera node

-- 	PlayerNode.Camera = CameraNode
-- 	PlayerNode:switchState(defaultState);
-- end; -- check for node TYPE too

PlayerStateController.new = function(PlayerNode, CameraNode)
  -- make CameraNode findable, dont pass it in
  Node.currentState = StateController.currentState;
	Node.switchState = StateController.switchState;
	Node.process = StateController.process;
	Node.physics_process = StateController.physics_process;
	Node.input = StateController.input;
end;

return PlayerStateController;
