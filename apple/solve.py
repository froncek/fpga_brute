#!/usr/bin/python3
# from pwnlib.util.fiddling import hexdump

bits = [
    0b00101110,
    0b00000000,
    0b11100000,
    0b00000100,
    0b10101110,
    0b00001000,
    0b00000011,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b10100110,
    0b01001110,
    0b10001110,
    0b11001110,
    0b00000001,
    0b00000000,
    0b00000011,
    0b00000000,
    0b11100001,
    0b00001110,
    0b00000000,
    0b00000000,
    0b10111100,
    0b10001110,
    0b11001001,
    0b00001110,
    0b00000000,
    0b00000000,
    0b10111100,
    0b10001110,
    0b11001001,
    0b00001110,
    0b00000001,
    0b00000000,
    0b01001000,
    0b10001110,
    0b11001001,
    0b01101110,
    0b00001000,
    0b11101110,
    0b01000000,
    0b10000000,
    0b01000000,
    0b00000001,
    0b00000110,
    0b10000000,
    0b10001000,
    0b10101101,
    0b10101011,
    0b00010110,
    0b10011001,
    0b00011110,
    0b11110000,
    0b10011110,
    0b00100010,
    0b10011010,
    0b11100010,
    0b11101100,
    0b00001100,
    0b01001100,
    0b11101100,
    0b01010010,
    0b00110010,
    0b01001010,
    0b10100010,
    0b01100010,
    0b01101010,
    0b10110010,
    0b10110010,
    0b10000010,
    0b00001100,
    0b00000000,
    0b01100100,
    0b00010001,
    0b11001010,
    0b01011110,
    0b11001101,
    0b11011110,
    0b00100010,
    0b10011010,
    0b11100010,
    0b11101100,
    0b00001100,
    0b01001100,
    0b11101100,
    0b01010010,
    0b00110010,
    0b01001010,
    0b10100010,
    0b01100010,
    0b01101010,
    0b10110010,
    0b10110010,
    0b10000010,
    0b00001100,
    0b00000000,
    0b10011100,
    0b00011000,
    0b11011110,
    0b00100001,
    0b00000000,
    0b00000000,
    0b10100000,
    0b10110010,
    0b10001010,
    0b10000010,
    0b11100010,
    0b01001100,
    0b10001110,
    0b00100001,
    0b10000000,
    0b00000000,
    0b10100000,
    0b10001100,
    0b10101100,
    0b01100010,
    0b11101100,
    0b10011100,
    0b00110000 ]

#      2	5.447392700000000,Async Serial,0x00 (framing error)
#     35	5.447784800000000,Async Serial,0x00 (framing error)
#    100	5.451658800000000,Async Serial,0x00 (framing error)
#    117	5.451864200000000,Async Serial,0x00 (framing error)
#    166	5.482228400000000,Async Serial,0x00 (framing error)
#    199	5.482620800000000,Async Serial,0x00 (framing error)
#    216	5.496196100000000,Async Serial,0x00 (framing error)
#    249	5.496588400000000,Async Serial,0x00 (framing error)
#    266	5.530855500000000,Async Serial,0x00 (framing error)
#    299	5.531247900000000,Async Serial,0x00 (framing error)
#    316	5.535896400000000,Async Serial,0x00 (framing error)
#    333	5.536101700000000,Async Serial,0x00 (framing error)
#    430	5.669557700000000,Async Serial,0x00 (framing error)
#    447	5.669763000000000,Async Serial,0x00 (framing error)
#    624	5.673688200000000,Async Serial,0x00 (framing error)
#    641	5.673893500000000,Async Serial,0x00 (framing error)
#    818	5.678429800000000,Async Serial,0x00 (framing error)
#    899	5.679383400000000,Async Serial,0x00 (framing error)
#    900	5.779740500000000,Async Serial,0x00 (framing error)
#    901	5.780899600000000,Async Serial,0x00 (framing error)
#    982	5.781853500000000,Async Serial,0x00 (framing error)


positions = [
      2,
     35,
    100,
    117,
    166,
    199,
    216,
    249,
    266,
    299,
    316,
    333,
    430,
    447,
    624,
    641,
    818,
    899,
    900,
    901,
    982,
]



def reverse_int(n):
    cnt = 0
    for x in range(0,8):
        num = (n >> x) & 1
        cnt += num * (2 ** (7-x))
    return cnt

def parse_pos():
    r = []
    for x,y in enumerate(positions):
        if x < len(positions) - 1:
            r.append((positions[x+1] - y - 1)//8)

    return r

def test_reverse_int():
    assert(0b1 == reverse_int(0b10000000))
    assert(0b10000000 == reverse_int(0b1))
    assert(0b11111111 == reverse_int(0b11111111))
    assert(0b00000000 == reverse_int(0b00000000))
    assert(0b10101010 == reverse_int(0b01010101))

def main():
    # test_reverse_int()
    communication = bytearray(map(reverse_int,bits))
    sizes = parse_pos()

    offset = 0
    for size in sizes:
        chunk = communication[offset:offset+size].hex()
        print(f"len {len(chunk):03d} - {chunk}"  )
        offset += size

if __name__ == "__main__":
    main()
