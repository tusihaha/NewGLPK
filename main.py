import os
os.system("glpsol --model gen.mod > result.txt")

file = open("result.txt", "r")

lines = file.readlines()

cls = []
r = []
t = []

result = []

for line in lines:
	c = line.split(" ")
	if c[0] == "result:" and c[5] == '1\n':
		print(line)
			
