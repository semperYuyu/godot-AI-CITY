local NPCStateController = {};
StateController = require("StateController");
NPCStates = require("NPCStates");
StateController.add(NPCStateController);

NPCStateController.new = function(NPCNode)

	if not NPCNode then
		error("NPC .new needs a CharacterBody3D as its only parameter");
	elseif NPCNode:get_class() ~= "CharacterBody3D" then
		error("NPCNode needs to be a CharacterBody3D");
	end;

	NPCNode.currentState = StateController.currentState;
	NPCNode.switchState = StateController.switchState;
	NPCNode.process = StateController.process;
	NPCNode.physics_process = StateController.physics_process;
	NPCNode.input = StateController.input;
	NPCNode:switchState(NPCStates.Idle)
end;

return NPCStateController;
