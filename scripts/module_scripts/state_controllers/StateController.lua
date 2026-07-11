local StateController = {
	extends = Node;
	currentState = {
		Exit = function (self)
			print("Initializing State Machine for " .. self.name .. "...")
		end;
	};
}
--------
-- Make all of these their own files (NPCStateController, PlayerStateController, etc)
-- and just import base state controller stuff into it
-- so i dont have too much clutter here
-- this file shouldn't have a
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
	NPCNode.input = StateController.input;
	NPCNode:switchState(defaultState);
end; -- check for node TYPE too

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
	PlayerNode.input = StateController.input;
	PlayerNode:switchState(defaultState);
end; -- check for node TYPE too

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
	CameraNode.input = StateController.input;
	CameraNode:switchState(defaultState);
end; -- check for node TYPE too

StateController.newTextBox = function (ControlNode, defaultState)
	if not ControlNode then
		error("..newTextBox() function needs a Control node passed as first parameter\nSyntax is \"..newTextBox(--> ControlNode <--, defaultState)\"")
	elseif not defaultState then
		error("..newTextBox() function needs a State passed as second parameter\nSyntax is \"..newTextBox(ControlNode, --> defaultState <--)\"")
	end;

	ControlNode.currentState = StateController.currentState;
	ControlNode.switchState = StateController.switchState;
	ControlNode.process = StateController.process;
	ControlNode.physics_process = StateController.physics_process;
	ControlNode.input = StateController.input;
	ControlNode:switchState(defaultState);
end;
-------
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

StateController.input = function (self, event)
	self.currentState.Input(self, event)
end;

return StateController;
