module secured.util;

public enum uint FILE_BUFFER_SIZE = 32768;

public class CryptographicException : Exception
{
	this(string message)
	{
		super(message);
	}
}

public bool constantTimeEquality(ubyte[] a, ubyte[] b)
{
	if(a.length != b.length)
		return false;

	int result = 0;
	for(int i = 0; i < a.length; i++)
		result |= a[i] ^ b[i];
	return result == 0;
}

unittest
{
	import std.digest.digest;
	import std.stdio;
	import secured.random;

	writeln("Testing Constant Time Equality:");

	//Test random data
	ubyte[] rnd1 = random(32);
	ubyte[] rnd2 = random(32);
	writeln("Testing with Random Data");
	assert(!constantTimeEquality(rnd1, rnd2));

	//Test equal data
	ubyte[48] key1 = [	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
						0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
						0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF ];
	ubyte[48] key2 = [	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
						0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
						0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF ];
	writeln("Testing with Equal Data");
	assert(constantTimeEquality(key1, key2));
}
