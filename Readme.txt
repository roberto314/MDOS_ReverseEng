                                   CHAPTER 24 (page 251)
     of M68DOS3_EXORdisk_II_III_Operating_System_Users_Guide from Dec. 78

24.1 Diskette Structure

Information on an MDOS diskette is stored in sectors 128(decimal) bytes in size. 
As the diskette turns, the read/write head in a stationary position will
pass over 26 (decimal) sectors each revolution. The head can be
positioned over 77 (decimal) discrete cylinders. Thus, there
are a total of 2002 (decimal) sectors on each surface of a diskette.
In order to minimize access time and yet provide for a dynamic allocation scheme, 
all diskette space allocation is done in terms of clusters rather than sectors.
MDOS clusters consist of four physically sequential sectors.
A cluster is the smallest structural unit of information on the diskette. Thus, the
smallest possible size that a file can have is one cluster.

MDOS accesses sectors on the diskette via a physical sector number (PSN).
The diskette controller decodes the PSN into the appropriate cylinder/sector position.

                   Single Sided   Double Sided                    
Quantity            DEC  HEX         DEC HEX             
Surfaces/diskette     1    1           2   2               
Bytes/Sector        128   80         128  80              
Sectors/Track        26   1A          26  1A              
Tracks/Cylinder       1    1           2   2               
Sectors/Cylinder     26   1A          52  34              
Cylinders/Diskette   77   4D          77  4D              
Sectors/Surface    2002  7D2        2002 7D2             
Sectors/Diskette   2002  7D2        4004 FA4             
Sectors/Cluster       4    4           4   4               
Clusters/Diskette   500  1F4        1001 3E9             

     Single Sided           Double Sided                    

Cylinder    PSN     Cylinder PSN SFC 0    PSN SFC 1   
DEC HEX  DEC HEX     DEC HEX  DEC HEX      DEC HEX
 0   0     0  000    0   0     0  000      26  01A
 1   1    26  01A    1   1    52  034      78  04E
 2   2    52  034    2   2   104  068     130  082
 3   3    78  04E    3   3   156  09C     182  0B6
 4   4   104  068    4   4   208  0D0     234  0EA
 5   5   130  082    5   5   260  104     286  11E
 6   6   156  09C    6   6   312  138     338  152
 7   7   182  0B6    7   7   364  16C     390  186
 8   8   208  0D0    8   8   416  1A0     442  1BA
 9   9   234  0EA    9   9   468  1D4     494  1EE
10   A   260  104   10   A   520  208     546  222
11   B   286  11E   11   B   572  23C     598  256
12   C   312  138   12   C   624  270     650  28A
13   D   338  152   13   D   676  2A4     702  2BE
14   E   364  16C   14   E   728  2D8     754  2F2
15   F   390  186   15   F   780  30C     806  326
16  10   416  1A0   16  10   832  340     858  35A
17  11   442  1BA   17  11   884  374     910  38E
18  12   468  1D4   18  12   936  3A8     962  3C2
19  13   494  1EE   19  13   988  3DC    1014  3F6
20  14   520  208   20  14  1040  410    1066  42A
21  15   546  222   21  15  1092  444    1118  45E
22  16   572  23C   22  16  1144  478    1170  492
23  17   598  256   23  17  1196  4AC    1222  4C6
24  18   624  270   24  18  1248  4E0    1274  4FA
25  19   650  28A   25  19  1300  514    1326  52E
26  1A   676  2A4   26  1A  1352  548    1378  562
27  1B   702  2BE   27  1B  1404  57C    1430  596
28  1C   728  2D8   28  1C  1456  5B0    1482  5CA
29  1D   754  2F2   29  1D  1508  5E4    1534  5FE
30  1E   780  30C   30  1E  1560  618    1586  632
31  1F   806  326   31  1F  1612  64C    1638  666
32  20   832  340   32  20  1664  680    1690  69A
33  21   858  35A   33  21  1716  6B4    1742  6CE
34  22   884  374   34  22  1768  6E8    1794  702
35  23   910  38E   35  23  1820  71C    1846  736
36  24   936  3A8   36  24  1872  750    1898  76A
37  25   962  3C2   37  25  1924  784    1950  79E
38  26   988  3DC   38  26  1976  7B8    2002  7D2
39  27  1014  3F6   39  27  2028  7EC    2054  806
40  28  1040  410   40  28  2080  820    2106  83A
41  29  1066  42A   41  29  2132  854    2158  86E
42  2A  1092  444   42  2A  2184  888    2210  8A2
43  2B  1118  45E   43  2B  2236  8BC    2262  8D6
44  2C  1144  478   44  2C  2288  8F0    2314  90A
45  2D  1170  492   45  2D  2340  924    2366  93E
46  2E  1196  4AC   46  2E  2392  958    2418  972
47  2F  1222  4C6   47  2F  2444  98C    2470  9A6
48  30  1248  4E0   48  30  2496  9C0    2522  9DA
49  31  1274  4FA   49  31  2548  9F4    2574  A0E
50  32  1300  514   50  32  2600  A28    2626  A42
51  33  1326  52E   51  33  2652  A5C    2678  A76
52  34  1352  548   52  34  2704  A90    2730  AAA
53  35  1378  562   53  35  2756  AC4    2782  ADE
54  36  1404  57C   54  36  2808  AF8    2834  B12
55  37  1430  596   55  37  2860  B2C    2886  B46
56  38  1456  5B0   56  38  2912  B60    2938  B7A
57  39  1482  5CA   57  39  2964  B94    2990  BAE
58  3A  1508  5E4   58  3A  3016  BC8    3042  BE2
59  3B  1534  5FE   59  3B  3068  BFC    3094  C16
60  3C  1560  618   60  3C  3120  C30    3146  C4A
61  3D  1586  632   61  3D  3172  C64    3198  C7E
62  3E  1612  64C   62  3E  3224  C98    3250  CB2
63  3F  1638  666   63  3F  3276  CCC    3302  CE6
64  40  1664  680   64  40  3328  D00    3354  D1A
65  41  1690  69A   65  41  3380  D34    3406  D4E
66  42  1716  6B4   66  42  3432  D68    3458  D82
67  43  1742  6CE   67  43  3484  D9C    3510  DB6
68  44  1768  6E8   68  44  3536  DD0    3562  DEA
69  45  1794  702   69  45  3588  E04    3614  E1E
70  46  1820  71C   70  46  3640  E38    3666  E52
71  47  1846  736   71  47  3692  E6C    3718  E86
72  48  1872  750   72  48  3744  EA0    3770  EBA
73  49  1898  76A   73  49  3796  ED4    3822  EEE
74  4A  1924  784   74  4A  3848  F08    3874  F22
75  4B  1950  79E   75  4B  3900  F3C    3926  F56
76  4C  1976  7B8   76  4C  3952  F70    3978  F8A

A portion of each diskette is reserved for some special system tables.
These tables reside in the outermost cylinder of the diskette, cylinder zero.
Each table, with the exception of the directory. occupies a single sector.
The following table summarizes the location of the system tables:

System table                     PSN

Diskette Identification Block    $00                                 
Cluster Allocation Table         $01                            
Lockout Cluster Allocation Table $02                                    
Directory                        $03-$16             
Bootblock, MDOS RIB              $17,$18                       

24.1.1 Diskette Identification Block

The Diskette Identification Block is created during system generation.
It contains an 10. the version and revision number of the resident operating system,
the date the diskette was generated, a user name identification area, and a dynamic 
area for the MDOS overlay RIB addresses. The ID is displayed by the DIR, 
FREE, and REPAIR commands. The Diskette Identification Block has the following formatat:

Bytes Size Contents
HEX           
0-7    8   Diskette ID
8-9    2   Verion Nr.
A-B    2   Revision Nr.
C-11   6   Generation Date
12-25  14  User Name
26-39  14  MDOS Overlay RIB Addresses
3A-7F  46  Zeroes

24.1.2 Cluster Allocation Table

The Cluster Allocation Table (CAT) contains a bit map of the areas on the diskette 
that are available for new space allocation. Each bit in the CAT represents a 
pnysical cluster of diskette storage. The first bit of the first byte of the 
CAT (bit 7 of byte 0) represents cluster 0. The subsequent bits represent subsequent clusters. A bit set to one indicates that the cluster is allocated. If a bit is set
to zero, it indicates that the corresponding cluster is available for allocation. 
Since not all 128 bytes of the CAT correspond to physical clusters, the parts of 
the CAT that represent clusters beyond the physical end of the diskette are 
marked as allocated so that they cannot be used by any MOOS functions.

On single-sided diskettes, bytes 0-$3E of the CAT correspond to the physical 
locations on the diskette; however, in byte $3E, bits 0-3 are set to one since 
no physical sectors correspond to those cluster numbers. Bytes $3F-7F are set to 
all ones. The cluster division for allocation only includes 2000 (decimal) sectors. 
Since there are 2002 sectors, the last two physical sectors of a single-sided diskette 
are not available for allocation ($7D0 - 7D1).

On double-sided diskettes, bytes 0-$7D correspond to the physical locations on the 
diskette; however, in byte $7D, bits 0-6 are set to one since no physical sectors
correspond to those cluster numbers. Bytes $7E and $7F are set to all ones.
The cluster division for allocation includes all physical sectors (4004, decimal).
There are no unused sectors on a double-sided diskette.

24.1.3 Lockout Cluster Allocation Table

The Lockout Cluster Allocation Table, or LCAT, is similar to the CAT in structure;
however, it is only used during the DOSGEN and REPAIR processes. The LCAT provides a
map of which areas of the diskette have been flagged as bad during the DOSGEN write/read test. In addition, the LCAT is configured so that those sectors of the diskette 
occupied by the system tables in cylinder zero and any user locked out areas 
(see Chapter 10, DOSGEN command) are flaqged as unavailable for normal allocation.

24.1.4 Directory

The directory occupies twenty sectors. Each directory sector contains eight entries 
of sixteen bytes each. Each entry contains a file name, a suffix, the address of the
file's first cluster, the file's attributes, and some room for expansion.

A file is one or more clusters containing related information. This information may 
be ASCII source programs, binary object records, user-generated data, etc. Each
file must reside wholly on a single diskette. Files are identified to the system 
by their names, suffixes, and logical unit numbers. 

The name as stored in the directory consists of ten bytes; however the MOOS command interpreter deals with an eight-byte name and,a tWO-byte suffix. This is merely a convention of the command interpreter and has no significance in relation to the 
internal format of the directory. System routines and functions dealing with file 
names as a parameter use a ten-byte block which is always dealt with as a monolithic
item.

File names assigned by the user must be from one to eight alphanumeric characters 
in length. The first character must be alphabetic. A file's suffix is used to further
identify the file. The suffix is primarily used to identify the format of the file
content; however, this is purely a convention; the attribute field of the directory 
entry describes the file's physical format. Suffixes are considered as an extension 
of the file name. They can be one or two alphanumeric characters in lenqth.
The first character of the suffix must be alphabetic. Both the file name and the 
suffix, if shorter than their maximum allowable lengths, are left justified and space-filled in the directory entry.

In most cases, the MOOS commands make certain default assumptions about a file's 
suffix if it is not explicitly specified by the operator; however, explicit 
suffixes can be used whenever the default is to be overridden. The standard
MOOS default suffixes are:

Suffix Implied meaning

AL     Assembly listinq file
CF     Chain procedural file
CM     Command file file
ED     EDOS-converted file
LO     Loadable, memory-image file
LX     EXbug-loadable file
RO     Relocatable object file
SA     ASCII source file
SY     Internally-used system file


In addition to a name, each directory entry contains a set of attributes which
characterize the file's content. A file's attributes include inherent attributes 
and assignable attributes. The inherent attributes of a file describe its
allocation scheme (contiguous or segmented), the file format (ASCII record, 
binary record, memory-image, or user-defined), and whether space compression
is used for ASCII records. The file formats are described in section 24.3.

The assignable attributes include write protection, delete protection, and the 
system file attribute. If a file is write protected, it cannot be written into 
or deleted. If a file is delete protected, it cannot be deleted. If a file
has the system attribute, it will be included in the system Generation process 
(DOSGEN) and is handled differently by the DEL and DIR commands.

The format of a directory following table:

Bytes Size Contents
HEX
0-7    8   File name
8-9    2   Suffix
A-B    2   PSN of first cluster
C-D    2   Attributes
E-F    2   Zeroes

The attribute field of a directory has the following format:
F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
|  |  |  |  |  |  |  |  <-- not used (=0) --->
|  |  |  |  |  |__|__|_ File Format (0 = user defined,
|  |  |  |  |                        2 = memory-image,
|  |  |  |  |                        3 = binary record,
|  |  |  |  |                        5 = ASCII record,
|  |  |  |  |                        7 = ASCII-converted binary record)
|  |  |  |  |   
|  |  |  |  |_ Non-compressed space bit                    
|  |  |  |____ Contiguous allocation bit
|  |  |_______ System file bit
|  |__________ Delete protection bit
|_____________ Write protection bit

Associated with each directory entry is an eiqht-bit number, the directory 
entry number (DEN), which is a function of the physical location of the entry 
within the directory. The DEN is not found anywhere in the directory. It is a
calculated quantity and is interpreted as follows:

  7 6 5 4 3   2 1 0
---------------------
|           |       |
---------------------
      ^         ^
      |         |___ Position within sector (0-7)
      |_____________ Physical Sector Number ($03-$16)


24.1.5 Bootblock

The Bootblock is a small loader program that is brought into memory along with 
the next physical sector by the diskette controller during system initialization. 
The second sector that is loaded contains information regarding the size of the 
resident operating system. From this information, the Bootblock program configures
the diskette controller to load into memory the actual resident operating system.

24.2 File Structure

While the contents of a file can be thought of as a logically contiguous block of
information, the actual diskette area allocated to the file mayor may not be
physically contiguous. Space can be allocated to one or more groups of physically
contiguous clusters on the diskette. each contiguous group of clusters is called a
segment. This segmentation allows the dynamic allocation and deallocation of space
to occur without having to move any of the information contained in the file or in 
other files. 
Each file must, therefore, have a table that describes which segments are allocated 
to the file. This table is kept in the first physical sector of each file and is 
called the Retrieval Information Block (RIB). It is the address of the RIB that is
contained in the directory entry of a file.

MDOS accesses sectors within a file by logical sector number (LSN). Since the first
physical sector of a file is not really a data sector, the RIB is given an LSN of
minus one ($FFFF). Therefore, logical sector zero of a file (the first data sector) 
is actually the second physical sector of the file. Logical sector numbers for data
sectors are numbered sequentially beginning with zero. Thus, even though a file may
be segmented (not physically contiguous on the diskette), it is treated as a 
logically contiguous collection of sectors when accessed by logical sector number. 
The system I/O functions decode the LSN into the actual PSN.

24.2.1 Retrieval Information Block

For all files, the RIB contains a series of two-byte entries called segment 
descriptor words (SDWs). A special SDW is used as a terminator to indicate the end 
of the segment descriptors within the RIB. Each SDW (other than the terminator) 
contains two pieces of information: the cluster number of the first cluster in the
segment, and the length of the segment. Since each segment consists of physically
contiguous clusters, this information is all that is needed to describe where a segment 
of the file is located on the diskette. A RIB can contain a maximum of 57 ($39) SDWs
and one terminator.

The RIB of a memory-image file contains some adiitional information that describes 
where the contents of the file are to be loaded in memory. This information includes 
the starting Load address, the number of sectors to load, the number of bytes in the 
last sector, and the starting execution address.

The memory-image file load information is described in the following paragraphs. Both 
the content and the location of each field are described. The offsets used to refer 
to the various bytes are relative to zero (zero being the first byte of the RIS sector).

1. Byte 117 ($75), the number of bytes to load from the last sector, must be non-zero, 
   a multiple of 8, and less than or equal to 128 ($80).
2. Bytes 118-119 ($76,77), the number of sectors to load, must contain a number that 
   is non-zero, less than the total number of sectors allocated to the file, and less 
   than or equal to 512 ($200).
3. Bytes 120-121 ($78,79), the starting load address, are not checked. For programs
   loadinq in an EXORciser I system, in the User Memory Map of an EXORciser II 
   system with the single memory map configured, or in the Executive Memory Map of 
   an EXORciser II system with the dual memory map configured, this value must be 
   greater than hexadecimal location $1F if the program is to be loaded via the 
   MDOS loader. EXORiciser II systems can have programs loaded into the User Memory 
   Map of the dual memory map configuration starting at location zero.
4. The ending load address is calculated from bytes 117-121 in the following manner:
         EL = (NSL - 1) * 128 + NBLS + SL - 1
   where EL is the ending load address, NSL is the number of sectors to load (bytes
   118-119), NBLS is the number of bytes in the last sector (byte 117), and SL is
   the starting load address (bytes 120-121). The ending load address must be less 
   than 65536.
5. Bytes 122-123 ($7A,7B), the starting execution address, must lie within the range 
   of addresses spanned by the file (greater than or equal to the starting load 
   address, and less than or equal to the ending load address).
6. Bytes 124-127 are not used and must be zero.

The following diagrams illustrate the segment descriptor word and the terminator.

SEGMENT DESCRIPTOR WORD

F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
| |             | <-- Starting Cluster Nr. -->
|  <-----------> 
|        |________ Number of contiguous clusters - 1
|_________________ Zero(non-terminator bit)


TERMINATOR

F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
|  <-- Logical Sector nr. of logical EOF ---->
|__ One (Terminator bit)

The SDW terminator is used to monitor the logical end-of-file. It contains the logical
sector number of the end-of-file. The sector which is the end of a file may be
partially filled with null characters. Thus, no actual end-of-file record will be found
within a file. This feature allows files to be merged toqether without having to read
through the entire file looking for an end-of-file record. 
The actual format of a RIB is shown in the following diagram. For non-memory-imaqe 
files, the bytes following the terminator must all be zero. Only memory-image files 
can have non-zero bytes following the terminator, and then those bytes must meet the 
six criteria listed above.
    
     F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
     ----------------------------------------------
00  |                  SDW 0                       |
     ----------------------------------------------
02  |                  SDW 1                       |
     ----------------------------------------------
04  |                  SDW 2                       |
     ----------------------------------------------
    |                                              |
    ~               other   SDW's                  ~
    |                                              |
     ----------------------------------------------
    |                Terminator                    |
     ----------------------------------------------
    |                                              |
    ~                  zeroes                      ~
74  |                       | Bytes in last sector |
     ----------------------------------------------
76  |           Number of Sectors to load          |
     ----------------------------------------------
78  |           Starting load Address              |
     ----------------------------------------------
7A  |           Starting execution Address         |
     ----------------------------------------------
7C  |                   zero                       |
     ----------------------------------------------
7E  |                   zero                       |
     ----------------------------------------------

24.2.2 File formats

MDOS deals with four types of file formats on diskette: user-defined, memory-image, 
binary record, and ASCII record. 
User-defined files are dealt with by MDOS at the sector level. MDOS will keep track of where the file is and will only allow access to the file by logical sector number. The user has the responsibility of formatting the data within the sectors in the manner 
suited to his application.

Memory-image files include all files whose contents are to be loaded into memory directly from the diskette by the MDOS loader. Memory-imaqe files are allocated contiguous
space on the diskette. The only information retained about where the content is to be
loaded is kept in the file's RIB. The data within the sectors of the file contain 
no load or record information. It is merely an imaqe of a block of memory to be loaded
into. Due to the nature of the diskette controller, MDOS programs can only be loaded in
multiples of eight bytes. A further restriction placed on memory-image files is that 
their content cannot load below memory location $20 if they are to reside in the single
memory map of an EXORciser I or EXORciser II system.

Binary record files are used primarily for the relocatable object datA produced by the
Macro Assembler and the relocatable FORTRAN compiler; however, the user can create data
files usinq this binary record format as well.

ASCII record files are used to contain all other MDOS-supported data. Such files can be 
in either space-compressed or non-space-compressed form. Normally, MDOS will always
create ASCII files with the space-compression attribute to conserve diskette space.

The non-memory-image files can be allocated in either contiguous or segmented fashion.
Normally, MDOS will create such files in a segmented manner to take advantage of the
dynamic allocation scheme. If files are segmented, they can expand to the full capacity 
of the diskette when they need to grow in size; however, if files have contiquously
allocated space. then they can only be expanded if they are allocated space that is
contiguous to the originally allocate1 space. Normally, contiguous files are created 
with the maximum space that they will ever need.

24.3 Record Structure

This section describes in detail the two record types supported for diskette files.
In addition, a special record type used fot COpying binary files to a non-diskette
device is also discussed. fhe actual use of such records is fully discussed in 
Chapter 25 which describes the supported I/O functions. All records supported by MOOS 
are terminated by a carriage return, line feed, and null sequence; however, on
the diskette, only the carriage return character is retained in order to conserve 
diskette space. When diskette files are copied to a non-diskette device, the other 
two characters are automatically supplied by MOOS.

24.3.1 Binary records

Binary records are used primarily as output from the Macro Assembler and the FORTRAN
compiler, and for input to the Linking Loader. Binary records contain a special record
header, a byte count, and a checksum. The checksum is a two's-complemented sum of 
all bytes in the record from the byte count through the last data byte, inclusive. 
A maximum of 254 (decimal) data bytes can be contained in each binary record.

The format of a binary record can be illustrated as:

 --------------------//-------------
| D | BC |     DATA       | CK | CR |
 --------------------//-------------

The symbols take on the following meanings:

Symbol     Meaning
------    ---------
  D       The binary record header character "D" ($44).
  BC      A one byte "byte count" contains the number of data
          Bytes in the record plus one (for checksum).
  DATA    A maximum of 254 (dec.) data bytes. Any eight-bit values are 
          valid for the data bytes.
  CK      The two's-complemented sum of the byte count and all data bytes. 
          CK is a one byte field.
  CR      The terminatinq carriage return. For non-diskette devices this 
          will actually be a carriage return, line feed, and null sequence.

Since diskette files contain the logical end-of-file indicator in the RIB, the 
binary EOF record only will be seen on non-diskette devices. The binary EOF 
record has the following format:

 ------------------
| E | BC | CK | CR |
 ------------------

The symbol "E" is the end-ot-file record header which is the letter "E" ($45). 
The other symbols are the same as in the above table. The EOF record has no 
data bytes. Thus, the byte count will be equal to one.

24.3.2 ASCII records

ASCII records are used primarily for source files on the diskette; however, 
EXbug-loadable format files are ASCII even though they are object files output 
from the assemblers or Linking Loader.

ASCII records contain no record headers, byte counts, or checksum fields. The 
first ASCII record in a file begins with the first data character of a file and 
is terminated by the first carriage return. All other ASCII records in the
file begin with the first data character following a carriage return. When 
ASCII records are copied to non-diskette devices, the terminating carriage return 
is actually a combination of three control characters: carriage return,
line feed and null. ASCII records should contain only displayable characters.

When MOOS writes ASCII records to diskette, they normally contain space compression
characters to conserve diskette space. A space compression character is indicated
by a data byte having the sign bit (bit 7) set to a one. The remaining bits (O-6) 
contain a binary number representing the number of spaces ($20) to be inserted in 
place of the compressed character. MDOS automatically expands these characters into 
spaces when such files are read. MDOS will also automatically create these compressed
characters when such tiles are written. 

Since MDOS maintains the loqical end-at-file indicator in a file's RIB, no ASCII 
EOF record will be seen in a diskette file; however, when ASCII record files are 
written to a non-diskette device, the following EOF record will be supplied:

 --------
| 1A | CR |
 --------

where the "1A" symbol represents the end-of-file indicator. It is the hexadecimal 
value $1A or SUB control character (CTL-Z). The CH symbol is the carriage return, 
line feed, and null sequence.

If ASCII record files generated on another system are to be processed by MDOS, it 
is important that the carriage return, line feed. and null sequence be present at 
the end of each record. Otherwise, it is possible for each data record to lose 
one or two characters from its beginning.


24.3.3 ASCII-converted-binary records

A special form of the binary record exists when copying to a non-diskette device 
that can only accept seven-bit data. This record format is usually never kept in 
a diskette file. fhe format of the ASCII-converted-binary record is identical
to the binary record; however, each byte, with the exception of the special header
character and the terminating carriage return, line feed, and null sequence, is 
converted into two eight-bit bytes with bit seven set to zero. This is
accomplished by taking each half of the original byte and adding the bit mask 
%00110000 to the half-byte. The result is a displayable two-byte sequence. For
example, the hexadecimal data byte $85 would be converted into the two byte 
sequence $38 and $35.

24.3.4 File descriptor records

MDOS I/0 operations with non-diskette devices can be in one of two modes: file 
format or non-file format. The non-file format mode requires no special processing 
and uses only the ASCII record format.

The file format mode allows MDOS to treat the data on certain non-diskette devices 
as a "file", similar to a file on diskette. The File Descriptor Record (FDR) is 
employed to serve the same function as a directory entry for a diskette file. 
The FDR contains a file name, suffix, and a file format descriptor. Thus, MDOS
can search for a named file on a cassette or paper tape, if it was originally 
created using the file format mode.

All FDRs are identical in format, reqardless of the record format of the data file.
Since the FDR must be acceptable to any Device, it is written in the ASCII-converted-binary form, even if the remaining data of the file is in binary 
or ASCII. The FDR format is shown in the following diagram:

 ------------------------------------------------
| H | BC | NAME | SUFX | NU | FDF | NU | CK | CR |
 ------------------------------------------------

The symbols take on the followinq meaninqs:

Symbol     Meaning
------    ---------
  H       The FDR header character "H" ($48).
  BC      A one byte "byte count" contains the number of bytes in 
          all fields from NAME through CK, inclusive. This number is
          fixed for FDR records at 17 (dec.). This number reflects the real 
          data bytes in the unconverted binary form, not the bytes written in 
          the ASClI-converted-binary form.
  NAME    The eight-character file name
  SUFX    The two-character suffix.
  NU      A two-byte field which is not used. It contains zeroes.
  FDF     A two-byte field similar in format to the attribute field of a 
          directory entry. Only bits $8-$A are used to describe the file format.
  CK      The two's-complemented sum of the byte count and all data bytes. 
          CK is a one byte field.
  CR      The terminating character sequence of carriage return, line feed, and null.

The length of all fields of the FDR (except H and CR) is doubled when written 
(ASCII-converted-binary format). Thus, if the CR field is counted as three characters 
(carriage return, line feed, null), then the physical length of an FDR in the 
ASClI-converted-binary format is 36 (decimal) bytes.

24.4 System Files


On every MDOS diskette there are nine files which comprise the operating system.
These files contain the resident operating system, a series of overlays to reduce 
the main memory requirements of the system, and standard error messaqes. The 
resident operating system file MDOS.SY must reside in a fixed place on the 
diskette if the Bootblock program is to work after being activated by the Diskette
controller. The other system files must remain in fixed positions after MDOS has 
been initialized since they are referenced by their physical sector numbers.


24.4.1 System overlays

The system overlay files are loaded into memory into one of the four overlay regions
discussed in the subsequent section. The overlay handler only brings an overlay into
memory if it is not already in memory at the time a specific function is required.
If an overlay remains in memory, access to its function is faster than if it has be 
to loaded from the diskette. The functions contained in the seven overlay files are 
shown in the following table:


 Overlay      Function

MDOSOV0.SY   Diskette space allocation and deallocation.
MDOSOV1.SY   Processing standard file names, allocating contiguous memory, reserving
             a device, releasing a device, writing standard records, writing FDRs, 
             writing End-of-file records, console reader / punch device handling.
MDOSOV2.SY   Reading standrd records, reading FDRs.
MDOSOV3.SY   Closing a file / device, rewinding diskette files, changing file names
             and attributes.
MDOSOV4.SY   Opening a file / device.
MDOSOV5.SY   Chain file execution.
MDOSOV6.SY   Command line interpretation.

When MDOS is initialized, the directory is searched for the seven overlays by name. 
The physical diskette addresses are then retained so that a subsequent reference to 
an overlay function does not involve another directory search. Thus, MDOS must be
reinitialized each time the diskette in drive zero is changed so that the overlays 
can be located again.

Overlays MOOSOVO and MDOSOV1 use overlay region one. Overlays MDOSOV2 and MDOSOV3 use overlay region two. Overlays MDOSOV4 and MDOSOV5 use overlay region three, and
overlay MDOSOV6 uses the User Program Area into which the MDOS commands also are loaded. The overlay regions are shown in the memory map diagram of section 24.5.

24.4.2 System error message file

In an attempt to use English language descriptions for the various error conditions 
that may arise, all standard error messages are kept in the-system file MOOSER.SY. 
This file is accessed by the error message function .MDERR (section 27.4).
The error messages are placed in this file so that the most frequently used messages 
are near the beginning.

If the error message file cannot be read or accessed, the error message function will
display a message injicatinq that an invalid error message has been requested.

24.5 Memory Map

Ine memory mapping of MDOS within the EXORciser system is illustrated in the following
diaqram:

      ---------------------------------
0000 | DISKETTE CONTROLLER VAHIABLES   |
      ---------------------------------
0020 ~ UNUSED DIRECT ADDRESSING AREA   ~
     ~                                 ~
      ---------------------------------
00AE |      COMMAND LINE BUFFER        |
      ---------------------------------
00FE |   COMMAND LINE BUFFER POINTER   |
      ---------------------------------
0100 |       MOOS VARIABLES            |
     |    IOCBs and SYSTEM BUFFERS     |
      ---------------------------------
022F |          SWI HANDLER            |
027F |     KERNEL SYSTEM FUNCTIONS     |
      ---------------------------------
     |  CONTROLLER DESCRIPTOR BLOCKS   |
      ---------------------------------
     |   SUPPORTED DEVICE DRIVERS      |
      ---------------------------------
     |   RESIDENT SYSTEM FUNCTIONS     |
      ---------------------------------
     |       OVERLAY HANDLER           |
      ---------------------------------
     |       OVERLAY HEGION 1          |
      ---------------------------------
     |       OVERLAY REGION 2          |
      ---------------------------------
     |       OVERLAY REGION 3          |
      ---------------------------------
     |       OVERLAY REGION 4          |
2000 |             and                 |
     |       USER PROGRAM AREA         |
     ~                                 ~
     ~                                 ~
3FFF |  END OF MINIMUM SYSTEM MEMORY   |
     ~                                 ~
     ~                                 ~
     |     END OF CONTIGUOUS MEMORY    |
      ---------------------------------
            RAM Discontinuity
      ---------------------------------
     ~        NON-MDOS RAM             ~
     ~                                 ~
      ---------------------------------
E800 |    DISKETTE CONTROLLER PROM     |
      ---------------------------------
EC00 |              PIAs               |
      ---------------------------------
F000 |        EXbug MONITOR            |
      ---------------------------------
FFF8 |      INTERRUPT VECTORS          |
      ---------------------------------

Locations s0000-001F, inclusive, are reserved for the variables of the diskette
controller. These locations cannot be initialized by a program loading from the 
diskette. In addition, if a program requires the use of the diskette functions 
(either directly through the diskette controller or through the MOOS functions), 
then these locations cannot be used by the program for storage. Locations 
$00AE - 00FD, inclusive, contain the MOOS command line as it was entered by the 
operator. Command~interpreter-loadable programs must load above location $1FFF.
They can use the direct addressing area for variable storage; however, this Area
cannot be initialized while the program is being loaded into memory. Programs 
that do not make use of MDOS system functions can load anywhere in memory above 
location $001F. If such programs do not use the diskette controller entry points
(Appendix D), the direct addressing area below location $0020 can be used, but 
only after the proqram is resident in memory.




    continue in Document M68DOS3_EXORdisk_II_III_Operating_System_Users_Guide
    from Dec. 78, page 269 (Page24-19).




#########################################################################################
##                               my own observations
#########################################################################################

MDOS.SY gets loaded @ 0x100 - 0x2100
MDOSOV1.SY overwrites part of MDOS.SY from 0x1273 - 0x1862
 from 0x1863 - 0x189C (58, 0x3A) ??
MDOSOV2.SY overwrites part of MDOS.SY from 0x189D - 0x1BFC
 from 0x1BFD - 0x1C0C (16, 0x10) zeroes
MDOSOV4.SY overwrites part of MDOS.SY from 0x1C0D - 0x1F54
 from 0x1F55 - 0x1FFC ?
MDOSOV6.SY overwrites part of MDOS.SY from 0x1FFD - 0x21F4
 (from 0x2171 there is some kind of screen buffer or the Diskette Information Block)

PROM U23:
A4 is alwyas High, Addresses 0-F are not used.
                  Address 
A1A0 IRQ Cntr   CPU    PROM   Entry
 L L  Lo  Lo    FCFC    10      00 - Is used by the Floppy Controller
 L H  Lo  Lo    FCFD    11      F1 - ACIA RX IRQ Enable, DIV1, 8N2, RTS Low No TX Interr.
 H L  Lo  Lo    FCFE    12      F0
 H H  Lo  Lo    FCFF    13      00
 L L  Lo  Hi    FCFC    14      00 - Is used by the Floppy Controller
 L H  Lo  Hi    FCFD    15      F5 - ACIA RX IRQ Enable, DIV1, 8N1, RTS Low No TX Interr.
 H L  Lo  Hi    FCFE    16      F0
 H H  Lo  Hi    FCFF    17      00
 L L  Hi  Lo    FCFC    18      00 - Is used by the Floppy Controller
 L H  Hi  Lo    FCFD    19      71 - ACIA RX IRQ Disable, DIV1, 8N2, RTS Low No TX Interr.
 H L  Hi  Lo    FCFE    1A      F0
 H H  Hi  Lo    FCFF    1B      00
 L L  Hi  Hi    FCFC    1C      00 - Is used by the Floppy Controller
 L H  Hi  Hi    FCFD    1D      75 - ACIA RX IRQ Disable, DIV1, 8N1, RTS Low No TX Interr.
 H L  Hi  Hi    FCFE    1E      F0
 H H  Hi  Hi    FCFF    1F      00
 
 00 F1 F000
 00 F5 F000
 00 71 F000
 00 75 F000
  |  |   |__ Reset Vector
  |  |______ ACIA Config
  |_________ Is used by the Floppy Controller

