# The Protocol


The protocol seems to have the following format:

Packet Type (1 Bytes)
    Packet type specific fields ....
Packet Checksum

## Example Communication

```
len 004 - 74000720 - t
len 008 - 7510c00000000065 - ue
len 002 - 7271 - rq
len 006 - 738000c00087 - s
len 004 - 7000003d - p=
len 002 - 7193 - q
len 004 - 7000003d - p=
len 002 - 7193 - q
len 004 - 70800012 - p
len 002 - 7193 - q
len 002 - 7610 - v
len 012 - 7702010280600111b5d56899 - w`h
len 002 - 780f - x
len 022 - 79445947373032374a4c524546564d4d413000268853 - yDYG7027JLREFVMMA0S
len 002 - 7ab3 - z
len 022 - 7b445947373032374a4c524546564d4d41300039187b - {DYG7027JLREFVMMA09{
len 010 - 840000054d5141473271 - MQAG2q
len 000 -  - 
len 000 -  - 
len 010 - 8401000531354637390c - 15F79
```


## Packet 70
Packet Type     - 70
Unknown         - 0000
Checksum        - 3d

Packet Type     - 70
Unknown         - 8000
Checksum        - 12

## Packet 71
Packet Type     - 71
Checksum        - 93

## Packet 72
Packet Type     - 72
Checksum        - 71

## Packet Type 73
Packet Type     - 73
Unknown         - 8000c000
Checksum        - 87

## Packet 74
Packet Type     - 74
Unknown         - 0007
CheckSum        - 20

## Packet 75
Packet Type     - 75
Unknown         - 10c000000000
Checksum        - 65

## Packet 76
Packet Type     - 76
Checksum        - 10

## Packet 77
Packet Type     - 77
Unknown         - 02010280600111b5d568
Checksum        - 99

## Packet 78
Packet Type     - 78
Checksum        - 0f

## Packet 79
Packet Type     - 79
Unknown         - 445947373032374a4c524546564d4d4130002688
Checksum        - 53

## Packet 7a
Packet Type     - 7a
Checksum        - b3

## Packet 7b
Packet Type     - 7b
Unknown         - 445947373032374a4c524546564d4d4130003918
Checksum        - 7b

## Packet 84

Packet Type     - 84
Report Type     - 00
Size            - 0005
Model           - 4d51414732
Checksum        - 71

Packet Type     - 84
Report Type     - 01
Size            - 0005
Model           - 3135463739
Checksum        - 0c