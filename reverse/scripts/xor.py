import sys

length = len(sys.argv)
argv = sys.argv

if length == 4:
	string = argv[1]
	begin = int(argv[2])
	end = int(argv[3])
	for number in range(begin, end + 1):
		print(str(number) + " ", end="")
		for s in string:
			print(chr(ord(s) ^ number), end=""	)
		print("\n")
else:
	print("Error")