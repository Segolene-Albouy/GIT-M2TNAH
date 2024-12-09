import pytest
from datetime import date
from src.person import Person


@pytest.fixture
def adult():
    """Fixture for an adult Person instance."""
    return Person(firstname="Zoé", name="Michel", birth=date(1990, 5, 15), city="Paris")


@pytest.fixture
def minor():
    """Fixture for a Person instance representing a minor."""


@pytest.fixture
def elder():
    """Fixture for a Person instance representing an elderly person."""


@pytest.fixture
def person_list(adult, minor, elder):
    """Fixture for a list of Person instances."""
    return [adult]
