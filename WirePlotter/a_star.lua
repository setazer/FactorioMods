local MinPriorityQueue = require "MinPriorityQueue"

---A* search
---@generic T
---@param src T
---@param dst T
---@param id fun(n:T):any Identifier for node that can be used as table key
---@param neighbors fun(n:T):T[]
---@param cost fun(from:T,to:T):number
---@param approx_cost_to_dst fun(from:T):number Heuristic
---@return T[]|nil path
return function(src, dst, id, neighbors, cost, approx_cost_to_dst)
	---Nodes that need to be examined, with best-guess cost of path through node as key
	local examine = MinPriorityQueue.new()
	examine:insert(approx_cost_to_dst(src), src, id(src))

	---Preceding node on current cheapest path, by lookup ID
	---@type table<any,any>
	local prev = {}

	---Cost of cheapest-known path from src to node, by lookup ID
	---@type table<any,number>
	local cost_from_start = { [id(src)] = 0 }

	while #examine ~= 0 do
		local cur = select(2, examine:extract())
		if cur == dst then -- Reached destination!
			-- Determine path we took
			local path = { cur }
			while true do
				local a_prev = prev[id(cur)]
				if not a_prev then return path end
				path[#path + 1] = a_prev
				cur = a_prev
			end
		end

		local cur_cost_from_start = cost_from_start[id(cur)]
		for _, neighbor in pairs(neighbors(cur)) do
			if neighbor ~= prev[cur] then -- Quick exit
				local edge_cost = cost(cur, neighbor)
				assert(edge_cost >= 0, "cost must be nonnegative")
				local neighbor_cost_from_start = cur_cost_from_start + edge_cost
				local neighbor_id = id(neighbor)
				-- Did we find a shorter way to reach neighbor?
				if neighbor_cost_from_start < (cost_from_start[neighbor_id] or math.huge) then
					-- Update our data, possibly moving neighbor forward in the examine queue
					prev[neighbor_id] = cur
					cost_from_start[neighbor_id] = neighbor_cost_from_start
					examine:insert_or_decrease_key(neighbor_cost_from_start + approx_cost_to_dst(neighbor),
						neighbor, neighbor_id)
				end
			end
		end
	end
	return nil
end
