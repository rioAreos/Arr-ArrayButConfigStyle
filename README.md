# Arr - Array Configuration Library for Lua

A lightweight Lua library that lets you create and manage arrays with configuration options including type enforcement, size limits, and custom access patterns.

## Quick Start

```lua
Arr.arrayCreate({
  name = "school",
  type = "string",
  deleteExceeds = false,
  showIndex = true,
  value = {"students", "principal", "teacher", "school owner"}
})

print(Arr.school["rand"])
```

## Field Reference

### Required Fields

#### `name`
- **Type:** `string`
- **Description:** The identifier for your array, used to access it globally
- **Example:**
```lua
Arr.arrayCreate({ name = "school" })
-- Access via: Arr.school
```

#### `value`
- **Type:** `table` (Lua array)
- **Description:** Initial values to populate the array
- **Example:**
```lua
value = {"student", "principal", "teacher"}
```

### Optional Fields

#### `type`
- **Type:** `"string" | "number" | "boolean"`
- **Default:** `nil` (no type checking)
- **Description:** Enforces all items to match a specific data type
- **Example:**
```lua
type = "string"
-- Arr.school[1] = 123 will error: expected string, got number
```

#### `itemsize`
- **Type:** `number`
- **Default:** `nil` (unlimited)
- **Description:** Sets maximum capacity for the array
- **Example:**
```lua
itemsize = 3
-- Array can only hold up to 3 items
```

#### `deleteExceeds`
- **Type:** `boolean`
- **Default:** `false`
- **Description:** Controls behavior when array exceeds `itemsize`
  - `false` → Throws error
  - `true` → Silently ignores/removes extra items
- **Example:**
```lua
deleteExceeds = true
-- Safely truncates excess items instead of crashing
```

#### `showIndex`
- **Type:** `boolean`
- **Default:** `false`
- **Description:** When `true`, returns values with their index appended
- **Example:**
```lua
showIndex = true
print(Arr.school[1])
-- Output: student - index of 1
```

## Special Access Keys

### `"rand"`
Returns a random item from the array.

```lua
print(Arr.school["rand"])
-- Returns a random element
```

⚠️ **Important:** Use `"rand"` as a string key, not a variable name.

## Complete Example

```lua
Arr.arrayCreate({
  name = "school",
  type = "string",
  deleteExceeds = false,
  showIndex = true,
  value = {"students", "principal", "teacher", "school owner"}
})

-- Access specific item
print(Arr.school[1])  -- students - index of 1

-- Get random item
print(Arr.school["rand"])  -- random school member

-- Check array size
print(#Arr.school)  -- 4
```

## Features

✅ Type enforcement  
✅ Size constraints  
✅ Random element access  
✅ Custom output formatting  
✅ Lightweight and simple  

## Requirements

- Lua 5.1+
- Termux or VS Code (or any Lua environment)
