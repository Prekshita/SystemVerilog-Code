RUN LENGTH ENCODER

Run length codes are a simple way to compress data to reduce storage and transmission requirements.Sequences of repeated symbols are replaced by a single occurrence of the symbol and a repeat count. For example, a simple 8-bit run length encoding of ASCII characters might be implemented as follows. If the MSB of the character is 0, the character is a single occurrence of the character. If the MSB of the character is 1, the character is followed by a byte that indicates that total number of occurrences of the character minus 1. Thus the string “Kabooooom” could be run length encoded as:

Example:

0x4B { 0, ‘K’ }
0x61 { 0, ‘a’ }
0x62 { 0, ‘b’ }
0xEF { 1, ‘o’ }
0x04 { 4 }
0x6D { 0, ‘m’ }
