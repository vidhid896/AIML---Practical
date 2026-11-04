"""
Practical 13: Blocks World state representation and validation.
Python 3 program.

A state is represented by:
- on(block, support): a block is on another block
- on_table(block): a block is on the table
- clear(block): no block is placed on top of it
"""

def validate_state(blocks, on, on_table):
    errors = []

    # Every block must be either on the table or on exactly one other block.
    supports = {}
    for block in blocks:
        locations = int(block in on_table) + sum(1 for b, _ in on if b == block)
        if locations != 1:
            errors.append(f"{block} must have exactly one location.")

    # A block cannot support itself; all referenced blocks must exist.
    for block, support in on:
        if block not in blocks or support not in blocks:
            errors.append(f"Unknown block in relation on({block}, {support}).")
        if block == support:
            errors.append(f"{block} cannot be on itself.")
        if block in supports:
            errors.append(f"{block} is placed on more than one support.")
        supports[block] = support

    # Detect cycles such as A on B and B on A.
    for start in blocks:
        visited = set()
        current = start
        while current in supports:
            if current in visited:
                errors.append(f"Cycle detected involving block {current}.")
                break
            visited.add(current)
            current = supports[current]

    if errors:
        return False, errors

    clear = set(blocks) - {support for _, support in on}
    return True, sorted(clear)


def main():
    blocks = {"A", "B", "C"}
    on = [("A", "B"), ("B", "C")]
    on_table = {"C"}

    valid, result = validate_state(blocks, on, on_table)
    if valid:
        print("The Blocks World state is VALID.")
        print("Clear blocks:", ", ".join(result) if result else "None")
    else:
        print("The Blocks World state is INVALID.")
        for error in result:
            print("-", error)


if __name__ == "__main__":
    main()

# Expected output:
# The Blocks World state is VALID.
# Clear blocks: A
