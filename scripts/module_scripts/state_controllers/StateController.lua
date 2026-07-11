local StateController = {
	extends = Node;
	currentState = {
		Exit = function (self)
			print("Initializing State Machine for " .. self.name .. "...")
		end;
	};
}

StateController.newNPC = function (NPCNode, defaultState)
	if not NPCNode then
		error(".newNPC() function needs a CharacterBody3D node passed as first parameter\nSyntax is \".newNPC(--> NPCNode <--, defaultState)\"")
	elseif not defaultState then
		error(".newNPC() function needs a State passed as second parameter as a default\nSyntax is \".newNPC(NPCNode, --> defaultState <--)\"")
	end;
	NPCNode.currentState = StateController.currentState;
	NPCNode.switchState = StateController.switchState;
	NPCNode.process = StateController.process;
	NPCNode.physics_process = StateController.physics_process;
	NPCNode:switchState(defaultState);
end;

StateController.newPlayer = function (PlayerNode, CameraNode, defaultState)
	if not PlayerNode then
		error(".newPlayer() function needs a CharacterBody3d node passed as first parameter\nSyntax is \".newPlayer(--> PlayerNode <--, defaultState)\"")
	elseif not defaultState then
		error(".newPlayer() function needs a State passed as third parameter as a default state\nSyntax is \".newPlayer(PlayerNode, --> defaultState <--)\"")
	end;

	PlayerNode.camera = CameraNode
	PlayerNode.currentState = StateController.currentState;
	PlayerNode.switchState = StateController.switchState;
	PlayerNode.process = StateController.process;
	PlayerNode.physics_process = StateController.physics_process;
	PlayerNode:switchState(defaultState);
end;

StateController.newCamera = function (CameraNode, defaultState)
	if not CameraNode then
		error(".newCamera() function needs a Camera3D node passed as first parameter\nSyntax is \".newCamera(--> CameraNode <--, defaultState)\"")
	elseif not defaultState then
		error(".newCamera() function needs a State passed as second parameter\nSyntax is \".newCamera(CameraNode, --> defaultState <--)\"")
	end;
	CameraNode.currentState = StateController.currentState;
	CameraNode.switchState = StateController.switchState;
	CameraNode.process = StateController.process;
	CameraNode.physics_process = StateController.physics_process;
	CameraNode:switchState(defaultState);
end;

StateController.switchState = function (self, state)
	self.currentState.Exit(self)
	self.currentState = state;
	self.currentState.Enter(self);
end;

StateController.process = function (self, dt)
	self.currentState.Update(self, dt)
end;

StateController.physics_process = function (self, dt)
	self.currentState.Physics_Update(self, dt)
end;

return StateController;
