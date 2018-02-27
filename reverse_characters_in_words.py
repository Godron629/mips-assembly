class ReverseWordCharactersInString(object):
    """Reverses characters within each word of string while maintaining original
    word order. Written in an unpythonic way to port to MIPS Assembly Language"""
    def __init__(self, string):
        self.string = string
        self.reversed_string = []

    def reverse_string(self):
        """Iterate through string - when space is found, reverse previous word and
        append to reversed_string. Otherwise, add character to word"""
        i = 0
        word = []
        n = len(self.string)

        while i < n:
            char = self.string[i]
            if char == " ":
                # At end of a word or repeated space
                self._reverse_word(word)
                self.reversed_string.append(" ")
            else:
                word.append(char)
            i += 1

        """Reversing here decreases loop logic to handle special end case"""
        self._reverse_word(word)

    def _reverse_word(self, word):
        """Pop last character and append to end of reversed string"""
        i = 0
        n = len(word)

        while i < n:
            next_letter = word.pop()
            self.reversed_string.append(next_letter)
            i += 1

if __name__ == "__main__":
    x = ReverseWordCharactersInString("hello world nice")
    x.reverse_string()  # This is janky but oh well (should be automatic)
    print x.reversed_string