local StateController = {
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
StateController.add = function(NewStateController)
	setmetatable(NewStateController, { __index = StateController })
	return;
end;

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
	-- update to iterate and dynamically find a camera node
	PlayerNode.Camera = CameraNode
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
	CameraNode.mouse_delta = Vector2.ZERO
	CameraNode.currentState = StateController.currentState;
	CameraNode.switchState = StateController.switchState;
	CameraNode.process = StateController.process;
	CameraNode.physics_process = StateController.physics_process;
	CameraNode.input = StateController.input;
	CameraNode:switchState(defaultState);
end; -- check for node TYPE too

StateController.newTextBox = function (ControlNode, TextNode, defaultState)
	if not ControlNode then
		error("..newTextBox() function needs a Control node passed as first parameter\nSyntax is \"..newTextBox(--> ControlNode <--, defaultState)\"")
	elseif not TextNode then
		error("..newTextBox() function needs a RichTextLabel passed as second parameter\nSyntax is \"..newTextBox(ControlNode, --> TextNode <--, defaultState)\"")
	elseif not defaultState then
		error("..newTextBox() function needs a State passed as third parameter\nSyntax is \"..newTextBox(ControlNode, TextNode, --> defaultState <--)\"")
	end;
	-- update to iterate and dynamically find a richtextlabel node

	ControlNode.TextNode = TextNode;
	ControlNode.TextNode:add_theme_font_size_override("normal_font_size", 90) -- check window size to try set this dynamically
	ControlNode.bbcode_enabled = true;
	ControlNode.TextNode.scroll_active = false;
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
