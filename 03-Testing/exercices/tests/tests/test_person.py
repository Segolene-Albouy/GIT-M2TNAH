import pytest
from src.person import Person
from datetime import date


def test_age(adult):
    """Test that the age property is calculated correctly"""


def test_is_adult(adult, minor):
    """Test that the is_adult static method works as expected"""


def test_sort_by_age(person_list):
    """Test that the sort_by_age method sorts a list of Person instances by age"""


@pytest.mark.parametrize(
    "firstname, name, birth, city",
    [
        ("", "", date(0, 0, 0), ""),
    ],
)
def test_invalid_person_initialization(firstname, name, birth, city):
    with pytest.raises(ValueError):
        """Test that invalid data raises a ValueError."""
