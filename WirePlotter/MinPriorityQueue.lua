---Priority queue with elements with minimal keys at the front
---@class MinPriorityQueue
---@field protected heap {k:number,v:any,l:any}[]
---@field protected lookup table<any,integer> Lookup ID to index in heap
local MinPriorityQueue = {}
MinPriorityQueue.__index = MinPriorityQueue

-- Not sure if an extra lookup table is the best way to lookup items for decrease_key, but I think it's ok

---@return MinPriorityQueue
function MinPriorityQueue.new()
	return setmetatable({ heap = {}, lookup = {} }, MinPriorityQueue)
end

function MinPriorityQueue:__len()
	return #self.heap
end

---@param lookup_id any
---@return boolean
function MinPriorityQueue:contains(lookup_id)
	return self.lookup[lookup_id] ~= nil
end

---Insert new element
---@param key number Priority
---@param value any
---@param lookup_id any Identifier for value, used as table key for `contains` and `decrease_key`
function MinPriorityQueue:insert(key, value, lookup_id)
	local heap, lookup = self.heap, self.lookup
	assert(not lookup[lookup_id], "duplicate lookup_key")

	-- Insert at end
	local idx = #heap + 1
	local elem = { k = key, v = value, l = lookup_id }
	heap[idx] = elem
	lookup[lookup_id] = idx

	-- Swap with larger parents
	while idx ~= 1 do
		local parent_idx = math.floor(idx / 2)
		local parent = heap[parent_idx]
		if parent.k <= elem.k then return end
		heap[parent_idx], heap[idx] = elem, parent
		lookup[lookup_id], lookup[parent.l] = parent_idx, idx
		idx = parent_idx
	end
end

---Pop minimal element
---@return number key_sequence, any value, any lookup_id
function MinPriorityQueue:extract()
	local heap, lookup = self.heap, self.lookup

	-- Take first element
	local elem = heap[1]
	assert(elem, "empty")
	lookup[elem.l] = nil

	local len = #heap
	local push_down = heap[len]
	heap[len] = nil
	if len ~= 1 then
		-- Bring last element to front
		local idx = 1
		heap[idx] = push_down
		lookup[push_down.l] = idx

		self:_push_down(idx)
	end

	return elem.k, elem.v, elem.l
end

---Move element more to the front of the queue by decreasing the key
---@param lookup_id any Element identifier
---@param new_key number New (lower) priority
---@param assert_value? any Value that lookup_id should refer to, for debug checks
function MinPriorityQueue:decrease_key(lookup_id, new_key, assert_value)
	local heap, lookup = self.heap, self.lookup
	local idx = lookup[lookup_id]
	local elem = heap[idx]

	if assert_value then
		assert(elem.v == assert_value, "lookup_id does not match with value")
	end
	assert(new_key <= elem.k, "new key is larger than previous key")

	elem.k = new_key
	self:_push_down(idx)
end

---Insert new element or update existing element
---@param key number
---@param value any
---@param lookup_id any
function MinPriorityQueue:insert_or_decrease_key(key, value, lookup_id)
	if self:contains(lookup_id) then
		self:decrease_key(lookup_id, key, value)
	else
		self:insert(key, value, lookup_id)
	end
end

---Swap with smallest smaller children
---@protected
---@param idx integer
function MinPriorityQueue:_push_down(idx)
	local heap, lookup = self.heap, self.lookup
	local push_down = heap[idx]
	while true do
		local child1_idx = idx * 2
		local child2_idx = child1_idx + 1
		local child1, child2 = heap[child1_idx], heap[child2_idx]
		local insert_key = push_down.k
		if not child2 then
			if child1 and insert_key > child1.k then
				heap[idx], heap[child1_idx] = child1, push_down
				lookup[child1.l], lookup[push_down.l] = idx, child1_idx
			end
			return
		end

		local child1_key, child2_key = child1.k, child2.k
		if insert_key <= child1_key and insert_key <= child2_key then return end
		if child1_key < child2_key then
			heap[idx], heap[child1_idx] = child1, push_down
			lookup[child1.l], lookup[push_down.l] = idx, child1_idx
			idx = child1_idx
		else
			heap[idx], heap[child2_idx] = child2, push_down
			lookup[child2.l], lookup[push_down.l] = idx, child2_idx
			idx = child2_idx
		end
	end
end

return MinPriorityQueue
