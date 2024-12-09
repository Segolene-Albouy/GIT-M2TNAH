from datetime import date
from typing import List


class Person:
    def __init__(self, firstname: str, name: str, birth: date, city: str = None) -> None:
        if not firstname or not name:
            raise ValueError("Firstname and name cannot be empty.")
        if birth > date.today():
            raise ValueError("Birth date cannot be in the future.")

        self.firstname = firstname
        self.name = name
        self.birth = birth
        self.city = city

    def __str__(self) -> str:
        return f"{self.firstname} {self.name}"

    @property
    def age(self) -> int:
        today = date.today()
        age = today.year - self.birth.year
        if (today.month, today.day) < (self.birth.month, self.birth.day):
            age -= 1
        return age

    @classmethod
    def from_string(cls, data: str) -> "Person":
        """
        Create a Person instance from a string in the format:
        'Firstname Name YYYY-MM-DD City'
        """
        try:
            firstname, name, birth_str, city = data.split(maxsplit=3)
            birth = date.fromisoformat(birth_str)
            return cls(firstname, name, birth, city)
        except ValueError:
            raise ValueError("Input string must be in the format 'Firstname Name YYYY-MM-DD City'")

    @staticmethod
    def is_adult(age: int) -> bool:
        """
        Static method to determine if a given age qualifies as an adult.
        """
        if age < 0:
            raise ValueError("Age cannot be negative.")
        return age >= 18

    def move(self, new_city: str) -> None:
        """
        Change the city where the person lives.
        """
        if not new_city:
            raise ValueError("New city cannot be empty.")
        self.city = new_city

    def greet(self, other: "Person") -> str:
        """
        Generate a greeting for another person.
        """
        return f"Hello {other.firstname}, my name is {self.firstname}!"

    @staticmethod
    def sort_by_age(people: List["Person"]) -> List["Person"]:
        """
        Sort a list of Person instances by their age in ascending order.
        """
        return sorted(people, key=lambda person: person.age)
