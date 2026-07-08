local global_variables = {
	extends = Node;
	global_interact = true;
}

local function find_module(dir, module, is_root_dir)
		dir = dir:sub(-1, -1) == "/" and dir or dir .. "/"
		local module_scripts = DirAccess:open(dir)

		module_scripts:list_dir_begin()
		local current_item = module_scripts:get_next()

		while current_item ~= "" do

			if module_scripts:current_is_dir() and not current_item:match('%.%.?') then

				local can_search_more = find_module(dir .. current_item .. "/", module)
				if can_search_more then return can_search_more end
			elseif current_item == (module .. '.lua') and not module_scripts:current_is_dir() then

				return dir .. current_item
			end

			current_item = module_scripts:get_next()
		end

		module_scripts:list_dir_end()
		
		if is_root_dir then
			error('Could not find module: ' .. module, 2)
		end;

		return nil;
end

local function load_module(module)
	local static_path = 'res://scripts/module_scripts'

	local dynamic_path = find_module(static_path, module, true)
	local file = FileAccess:open(dynamic_path, FileAccess.READ)
	local file_content = file:get_as_text()
	file:close()
	return load(file_content)
end


function global_variables:_ready()
	table.insert(package.searchers, 1, load_module)
end

return global_variables
