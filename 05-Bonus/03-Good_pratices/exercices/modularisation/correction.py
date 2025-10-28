# Constants
MAXIMUM_GRADE = 20
MINIMUM_GRADE = 0
PASSING_THRESHOLD = 10


def is_valid_grade(grade: float) -> bool:
    """Check if a grade is within valid range.

    Args:
        grade: The grade to validate

    Returns:
        True if the grade is valid, False otherwise
    """
    return MINIMUM_GRADE <= grade <= MAXIMUM_GRADE


def calculate_statistics(grade_list: list[float]) -> dict:
    """Calculate basic statistics for a list of grades.

    Args:
        grade_list: List of grades to analyze

    Returns:
        Dictionary containing mean, min, max and count of grades
    """
    valid_grades = [grade for grade in grade_list if is_valid_grade(grade)]
    grade_count = len(valid_grades)

    if grade_count == 0:
        return {
            "mean": 0,
            "minimum": 0,
            "maximum": 0,
            "count": 0
        }

    return {
        "mean": sum(valid_grades) / grade_count,
        "minimum": min(valid_grades),
        "maximum": max(valid_grades),
        "count": grade_count
    }


def calculate_passing_rate(grade_list: list[float]) -> float:
    """Calculate the percentage of grades at or above passing threshold.

    Args:
        grade_list: List of grades to analyze

    Returns:
        Passing rate as a percentage
    """
    valid_grades = [grade for grade in grade_list if is_valid_grade(grade)]
    if not valid_grades:
        return 0

    passing_grades = [grade for grade in valid_grades if grade >= PASSING_THRESHOLD]
    return (len(passing_grades) / len(valid_grades)) * 100


def display_grade_details(grade_list: list[float]) -> None:
    """Display each grade with its status.

    Args:
        grade_list: List of grades to display
    """
    print("\nDétails des notes:")
    for grade in grade_list:
        if is_valid_grade(grade):
            status = "Réussite" if grade >= PASSING_THRESHOLD else "Échec"
            print(f"- {grade}/20 ({status})")


def display_results(grade_list: list[float]) -> None:
    """Display a complete report of results.

    Args:
        grade_list: List of grades to analyze
    """
    stats = calculate_statistics(grade_list)
    passing_rate = calculate_passing_rate(grade_list)

    print("Résultats de la classe :")
    print("------------------------")
    print(f"Moyenne : {stats['mean']:.2f}")
    print(f"Note minimale : {stats['minimum']}")
    print(f"Note maximale : {stats['maximum']}")

    display_grade_details(grade_list)

    print(f"\nTaux de réussite : {passing_rate:.1f}%")


# Example usage
if __name__ == "__main__":
    display_results([15, 12, 8, 16, 9, 13, 7, 14])
