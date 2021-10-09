-- Initialize the components table
local components = {
        active = {},
        inactive = {}
}

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Insert a component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
        -- Component info here
        provider = 'AAAAAAAAAAAAAAAAAAAA'
})

-- Insert another component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
    -- Component info here
})

-- Insert a component that will be on the middle of the statusline
-- when the window is active:
table.insert(components.active[2], {
    -- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is active:
table.insert(components.active[3], {
    -- Component info here
})

-- Insert a component that will be on the left side of the statusline
-- when the window is inactive:
table.insert(components.inactive[1], {
    -- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is inactive:
table.insert(components.inactive[2], {
    -- Component info here
})

require('feline').setup{
          preset = 'noicon'
--        components = components
}

