"""
Practical 15: First Order Logic - Unification and Resolution
Python 3 program.

This demonstration uses clauses containing predicates and variables.
Variables are strings beginning with an uppercase letter.
Constants are strings beginning with a lowercase letter.

Knowledge base:
    Human(Socrates)
    NOT Mortal(x) OR Human(x)
Goal:
    Mortal(Socrates)

To prove the goal, add its negation NOT Mortal(Socrates), then resolve.
"""

def is_variable(term):
    return isinstance(term, str) and term[:1].isupper()


def apply_substitution(term, substitution):
    while is_variable(term) and term in substitution:
        term = substitution[term]
    return term


def unify_terms(left, right, substitution):
    left = apply_substitution(left, substitution)
    right = apply_substitution(right, substitution)

    if left == right:
        return substitution
    if is_variable(left):
        substitution[left] = right
        return substitution
    if is_variable(right):
        substitution[right] = left
        return substitution
    return None


def unify_atoms(atom1, atom2):
    # Atom format: (predicate_name, argument)
    if atom1[0] != atom2[0]:
        return None
    substitution = {}
    result = unify_terms(atom1[1], atom2[1], substitution)
    return result


def apply_to_literal(literal, substitution):
    sign, predicate, argument = literal
    return (sign, predicate, apply_substitution(argument, substitution))


def resolve(clause1, clause2):
    """Resolve two clauses if they contain complementary unifiable literals."""
    for index1, lit1 in enumerate(clause1):
        for index2, lit2 in enumerate(clause2):
            sign1, pred1, arg1 = lit1
            sign2, pred2, arg2 = lit2

            if sign1 == sign2 or pred1 != pred2:
                continue

            substitution = unify_atoms((pred1, arg1), (pred2, arg2))
            if substitution is None:
                continue

            remaining1 = [apply_to_literal(lit, substitution)
                          for i, lit in enumerate(clause1) if i != index1]
            remaining2 = [apply_to_literal(lit, substitution)
                          for i, lit in enumerate(clause2) if i != index2]
            resolvent = remaining1 + remaining2

            # Remove duplicate literals while preserving order.
            unique = []
            for literal in resolvent:
                if literal not in unique:
                    unique.append(literal)
            return unique, substitution

    return None, None


def main():
    # Clause 1: Human(Socrates)
    clause1 = [(True, "Human", "socrates")]

    # Clause 2: NOT Human(x) OR Mortal(x)
    # This is equivalent to Human(x) -> Mortal(x).
    clause2 = [(False, "Human", "X"), (True, "Mortal", "X")]

    # Negated goal: NOT Mortal(Socrates)
    negated_goal = [(False, "Mortal", "socrates")]

    print("First Order Logic Resolution Demonstration")
    print("Knowledge: Human(socrates)")
    print("Knowledge: NOT Human(X) OR Mortal(X)")
    print("Negated goal: NOT Mortal(socrates)")

    # Resolve clause2 with clause1: obtains Mortal(socrates).
    first_resolvent, substitution1 = resolve(clause2, clause1)
    print("\\nStep 1 - Resolve rule with fact:")
    print("Substitution:", substitution1)
    print("Resolvent:", first_resolvent)

    # Resolve Mortal(socrates) with NOT Mortal(socrates).
    final_resolvent, substitution2 = resolve(first_resolvent, negated_goal)
    print("\\nStep 2 - Resolve with negated goal:")
    print("Substitution:", substitution2)
    print("Final resolvent:", final_resolvent)

    if final_resolvent == []:
        print("\\nEmpty clause obtained. The theorem is PROVED.")
        print("Therefore, Mortal(socrates) follows from the knowledge base.")
    else:
        print("\\nCould not derive the empty clause.")


if __name__ == "__main__":
    main()
