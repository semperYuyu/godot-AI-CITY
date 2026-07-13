local NPCStateController = {};
StateController = require("StateController");
NPCStates = require("NPCStates");
StateController.add(NPCStateController);

NPCStateController.new = function(NPCNode)

	if NPCNode:get_class() ~= "CharacterBody3D" or not NPCNode then
		error("NPC .new() needs a CharacterBody3D as its only parameter");
	end;

	NPCNode.currentState = StateController.currentState;
	NPCNode.switchState = StateController.switchState;
	NPCNode.process = StateController.process;
	NPCNode.physics_process = StateController.physics_process;
	NPCNode.input = StateController.input;
	
	NPCNode:switchState(NPCStates.Idle)
end;

return NPCStateController;
