local NPCStateController = {};
StateController = require("StateController");
NPCStates = require("NPCStates");

NPCStateController.new = function(NPCNode)
	if NPCNode:get_class() ~= "CharacterBody3D" or not NPCNode then
		error("NPC .new() needs a CharacterBody3D as its only parameter");
	end;

	local PlayerDetectArea = NPCNode:get_node("PlayerDetectArea")
	PlayerDetectArea:connect("body_entered", Callable(function(body) NPCNode.target = body end))
	PlayerDetectArea:connect("body_exited", Callable(function() NPCNode.target = nil end))
	StateController.new(NPCNode, NPCStates.Idle);
end;

return NPCStateController;
