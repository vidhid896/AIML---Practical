"""
Practical 14: University Course Advisory System
Recommends electives from a student's interests and skills.
Python 3 program; no external libraries required.
"""

COURSES = {
    "Artificial Intelligence": {"interests": {"ai", "problem solving"}, "skills": {"python", "logic"}},
    "Machine Learning": {"interests": {"ai", "data"}, "skills": {"python", "mathematics"}},
    "Cyber Security": {"interests": {"security", "networking"}, "skills": {"networking", "programming"}},
    "Web Development": {"interests": {"web", "design"}, "skills": {"html", "javascript", "programming"}},
    "Data Science": {"interests": {"data", "statistics"}, "skills": {"python", "mathematics", "statistics"}},
}


def recommend_courses(student_interests, student_skills):
    interests = {item.strip().lower() for item in student_interests}
    skills = {item.strip().lower() for item in student_skills}

    scores = []
    for course, requirements in COURSES.items():
        interest_match = len(interests & requirements["interests"])
        skill_match = len(skills & requirements["skills"])
        score = interest_match + skill_match
        if score > 0:
            scores.append((score, course, interest_match, skill_match))

    scores.sort(key=lambda item: (-item[0], item[1]))
    return scores


def main():
    print("UNIVERSITY COURSE ADVISORY SYSTEM")
    interests = input("Enter your interests (comma separated): ").split(",")
    skills = input("Enter your skills (comma separated): ").split(",")

    recommendations = recommend_courses(interests, skills)
    if not recommendations:
        print("No matching course found. Try adding more interests or skills.")
        return

    print("\\nRecommended elective courses:")
    for score, course, interest_match, skill_match in recommendations:
        print(f"{course} - match score: {score} "
              f"(interest matches: {interest_match}, skill matches: {skill_match})")


if __name__ == "__main__":
    main()

# Example input:
# Interests: ai, data
# Skills: python, mathematics
# The highest recommendations will include Machine Learning and Data Science.
