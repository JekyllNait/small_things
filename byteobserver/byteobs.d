module byteobserver.byteobs;
import std.stdio;

enum ObsMode { 
    byteONLY,
    allInfo
}

void printBytesByLineGroup(T)(ubyte *begin, size_t numColumHEX = 8) {
    immutable size_t stepSize = numColumHEX;
    size_t endline = stepSize;
    while(true)
    {
        if (endline < T.sizeof)
        {
            writefln("%(%02x %)", begin[0 .. stepSize]);
            begin += stepSize;
            endline += stepSize;
        }
        else
        {
            writefln("%(%02x %)", begin[0 .. (T.sizeof - (endline - stepSize))]);
            break;
        }
    }
}

void printBytes(T)(ref T variable, ObsMode mode=ObsMode.allInfo) {
    ubyte * begin = cast(ubyte*)&variable;

    final switch (mode)
    {
        case ObsMode.byteONLY:
            printBytesByLineGroup!T(begin);
            break;
        case ObsMode.allInfo:
            writefln("type   : %s", T.stringof);
            writefln("value  : %s", variable);
            writefln("address: %s", begin);
            writeln("bytes  : ");

            printBytesByLineGroup!T(begin);
            break;
    }
    writeln("------------");
}

void main() {
    int iVar = 42;
    string message = "Hello, World!";
    int[] iDArr = [1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6];
    int[18] iSArr = [1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6];
    double dVar;
    
    printBytes(iVar, ObsMode.byteONLY);
    printBytes(message, ObsMode.byteONLY);
    printBytes(iDArr, ObsMode.byteONLY);
    printBytes(iSArr, ObsMode.byteONLY);
    printBytes(dVar, ObsMode.byteONLY);

    printBytes(iVar);
    printBytes(message);
    printBytes(iDArr);
    printBytes(iSArr);
    printBytes(dVar);
}