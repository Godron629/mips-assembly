from unittest import TestCase

from reverse_characters_in_words import ReverseWordCharactersInString

class TestReverseWordCharactersInString(TestCase):
    def run_test(self, Reverser):
        Reverser.reverse_string()
        return Reverser.reversed_string

    def test_empty_string(self):
        x = ReverseWordCharactersInString("")
        expected_result = []
        result = self.run_test(x)
        self.assertEqual(result, expected_result)

    def test_all_spaces(self):
        x = ReverseWordCharactersInString("   ")
        expected_result = [" ", " ", " "]
        result = self.run_test(x)
        self.assertEqual(result, expected_result)

    def test_normal_string(self):
        x = ReverseWordCharactersInString("hello world nice")
        expected_result = ["o", "l", "l", "e", "h", " ", "d", "l", "r", "o", "w", " ", "e", "c", "i", "n"]
        result = self.run_test(x)
        self.assertEqual(result, expected_result)
