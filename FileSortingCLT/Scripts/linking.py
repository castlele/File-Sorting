#! /usr/bin python3			
import os

# Read path, where the project is
def read_file(file):
	path_to_proj = open(file, "r")
	path = path_to_proj.readline()
	path_to_proj.close()

	# Return the line with path from file
	return path.split('\n')[0]


# Delete old linking and make new
def link_file(path_to_proj, linking_path):
	os.chdir(path_to_proj)

	if os.path.exists(linking_path):
		os.remove(linking_path)
		os.system("swift build --configuration release")
		os.system("cp -f .build/release/sorting /usr/local/bin/sorting")

	else:
		os.system("swift build --configuration release")
		os.system("cp -f .build/release/sorting /usr/local/bin/sorting")


if __name__ == '__main__':
	path = read_file("pathToProj.txt")
	linking_path = "/usr/local/bin/sorting/"
	link_file(path, linking_path)