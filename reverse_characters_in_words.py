class WordReverser(object):
    """Reverses the characters within each word of a string while maintaining
    the original word order. Written in an unpythonic way because I was
    porting it to MIPS Assembly Language"""
    def __init__(self, string):
        self.string = string
        self.reversed_string = []

    def reverse_string(self):
        i = 0
        word = []
        n = len(self.string)

        while i < n:
            char = self.string[i]
            if char == " ":
                self._reverse_word(word)
                self.reversed_string.append(" ")
            else:
                word.append(char)
            i += 1

        self._reverse_word(word)

    def _reverse_word(self, word):
        i = 0
        n = len(word)

        while i < n:
            next_letter = word.pop()
            self.reversed_string.append(next_letter)
            i += 1

if __name__ == "__main__":
    x = WordReverser("hello world nice")
    x.reverse_string()
    print x.reversed_string