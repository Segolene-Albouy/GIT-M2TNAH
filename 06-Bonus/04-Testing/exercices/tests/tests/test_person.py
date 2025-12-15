import pytest
from src.person import Person
from datetime import date


def test_age(adult):
    """Test that the age property is calculated correctly"""
    # TODO: Calculate expected age and verify adult.age equals this value


def test_is_adult(adult, minor):
    """Test that the is_adult static method works as expected"""
    # TODO: Test both adult and minor ages with Person.is_adult()


def test_sort_by_age(person_list):
    """Test that the sort_by_age method sorts a list of Person instances by age"""
    # TODO: Sort the list and verify the order is correct (youngest to oldest)


@pytest.mark.parametrize(
    "firstname, name, birth, city",
    [
        ("", "Dupont", date(1990, 1, 1), "Paris"),  # Empty firstname
        ("Alice", "", date(1990, 1, 1), "Paris"),  # Empty name
        ("Alice", "Dupont", date(2025, 1, 1), "Paris"),  # Future date
    ],
)
def test_invalid_person_initialization(firstname, name, birth, city):
    """Test that invalid data raises a ValueError."""
    # TODO: Test that initializing a Person with invalid data raises ValueError


def test_str_representation(adult):
    """Test the string representation of a Person"""
    # TODO: Verify the string representation matches expected format


@pytest.mark.parametrize(
    "string,first,last,birth,city",
    [
        (
            "Alice Dupont 1985-07-22 Marseille",
            "Alice",
            "Dupont",
            date(1985, 7, 22),
            "Marseille",
        )
    ],
)
def test_from_string(string, first, last, birth, city):
    """Test creating a Person from a valid string"""
    # TODO: Create person from string and verify attributes


@pytest.mark.parametrize(
    "string",
    [
        "Alice Dupont",  # Missing data
        "Alice Dupont 1985-13-45 Marseille",  # Invalid date
        "Alice Dupont not-a-date Marseille",  # Wrong date format
    ],
)
def test_from_string_invalid(string):
    """Test that invalid strings raise ValueError"""
    # TODO: Try creating person from invalid strings and verify ValueErrors


def test_move():
    """Test the move method"""
    # TODO: Create person, move them, verify new city


def test_greet(adult, minor):
    """Test the greeting method"""
    # TODO: Verify greeting message format


def test_negative_age():
    """Test that negative ages are handled correctly"""
    # TODO: Test Person.is_adult with negative age


@pytest.mark.parametrize(
    "birth_date,expected_age",
    [
        (date(2000, 1, 1), None),  # TODO: Calculate expected age
        (date(1995, 12, 31), None),  # TODO: Calculate expected age
        (date(1990, 6, 15), None),  # TODO: Calculate expected age
    ],
)
def test_age_calculation(birth_date, expected_age):
    """Test age calculation for various birth dates"""
    # TODO: Create person with birth_date and verify age


def test_sort_empty_list():
    """Test sorting an empty list of persons"""
    # TODO: Try sorting empty list


def test_sort_single_person():
    """Test sorting a list with single person"""
    # TODO: Try sorting list with one person
