import random

def gen_except(resources, courses):
	result = dict()
	check = list()
	for i in range(resources - 1):
		result[i] = list()
		c = random.randint(1, courses)
		index = random.randint(0, courses - c)
		for j in range(c):
			if index not in check:
				check.append(index)
			result[i].append(index)
			index = random.randint(index + 1, courses - (c - j - 1))
	result[resources - 1] = list()
	for i in range(courses):
		if i not in check:
			result[resources - 1].append(j)
	except_result = dict()
	for i in result:
		except_result[i] = list()
		for j in range(courses):
			if j not in result[i]:
				except_result[i].append(j)
	return except_result

def gen():
	f = open('gen.mod', 'a')
	f.write('set I;\n/* set of courses */\nset J;\n/* set of rooms */\nset T;\n/* set of teachers */\nset K;\n/* set of time slots */\n')

	courses = 50
	rooms = 24
	teachers = 16
	timeslots = 30

	t_excepted = gen_except(teachers, courses)
	r_excepted = gen_except(rooms, courses)

	for i in range(rooms):
		if len(r_excepted[i]) > 0:
			f.write('set R' + str(i) + ';\n/* room ' + str(i) + ' */\nset ER' + str(i) + ';\n/* exception courses for room ' + str(i) + ' */\n')
	for i in range(teachers):
		if len(t_excepted[i]) > 0:
			f.write('set T' + str(i) + ';\n/* teacher ' + str(i) + ' */\nset ET' + str(i) + ';\n/* exception courses for teacher ' + str(i) + ' */\n')
	
	f.write('param cost{i in I, j in J, t in T, k in K}, >= 0;\n/* cost of allocating room j to course i with teacher t in time slot k */\n\nvar x{i in I, j in J, t in T, k in K} binary;\n/* x[i,j,t,k] = 1 means room j is assigned to course i with teacher t in time slot k\nx[i,j,t,k] = 0 otherwise  */\n\ns.t. first{i in I}: sum{j in J, t in T, k in K} x[i,j,t,k] = 1;\n\ns.t. second{j in J, k in K}: sum{i in I, t in T} x[i,j,t,k] <= 1;\n\ns.t. third{t in T, k in K}: sum{i in I, j in J} x[i,j,t,k] <= 1;\n\n')

	for i in range(rooms):
		if len(r_excepted[i]) > 0:
			f.write('s.t. cr' + str(i) + ': sum{i in ER' + str(i) + ', j in R' + str(i) + ', t in T, k in K} x[i,j,t,k] = 0;\n\n')
	for i in range(teachers):
		if len(t_excepted[i]) > 0:
			f.write('s.t. ct' + str(i) + ': sum{i in ET' + str(i) + ', j in T' + str(i) + ', t in T, k in K} x[i,j,t,k] = 0;\n\n')

	f.write('minimize obj: sum{i in I, j in J, t in T, k in K} cost[i,j,t,k] * x[i,j,t,k];\n/* the objective is to find a cheapest assignment */\n\nsolve;\n\n')
	# f.write('printf {i in I, j in J, t in T, k in K} \'result: %s %s %s %s %s\', i, j, k, t, x[i,j,t,k];\n\n')
	f.write('data;\n\n')

	f.write('set I :=')
	for i in range(courses):
		f.write(' ' + str(i))
	f.write(';\n\n')

	f.write('set T :=')
	for i in range(teachers):
		f.write(' ' + str(i))
	f.write(';\n')

	f.write('set J :=')
	for i in range(rooms):
		f.write(' ' + str(i))
	f.write(';\n')

	f.write('set K :=')
	for i in range(timeslots):
		f.write(' ' + str(i))
	f.write(';\n')

	for i in range(teachers):
		if len(t_excepted[i]) > 0:
			f.write('set T' + str(i) + ' := ' + str(i) + ';\nset ET' + str(i) + ' :=')
			for j in t_excepted[i]:
				f.write(' ' + str(j))
			f.write(';\n\n')
	for i in range(rooms):
		if len(r_excepted[i]) > 0:
			f.write('set R' + str(i) + ' := ' + str(i) + ';\nset ER' + str(i) + ' :=')
			for j in r_excepted[i]:
				f.write(' ' + str(j))
			f.write(';\n\n')

	f.write('param cost :=\n')

	for k in range(timeslots):
		for t in range(teachers):
			f.write('[*,*,' + str(t) + ',' + str(k) + ']:')
			for r in range(rooms):
				f.write(' ' + str(r))
			f.write(' :=\n')
			for i in range(courses):
				f.write(str(i))
				for r in range(rooms):
					f.write(' ' + str(k + 1))
				f.write('\n')
	f.write(';\nend;')			

gen()
