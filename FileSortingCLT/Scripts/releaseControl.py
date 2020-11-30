from selenium import webdriver
import os


def main():
	offline_v = get_current_local_release().split(".")
	online_origin = get_current_online_release()
	online_v = online_origin.split(".")
	offline = "" 
	online = ""

	for index in range(0, 3):
		# Versions with "v" as prefix
		offline += offline_v[index] 
		online += online_v[index]

	# Versions without "v" as prefix
	offline = int(offline[1::])
	online = int(online[1::])

	if offline == online:
		print("Local version is up to date")

	elif offline > online:
		print("You should push local changes")

	else:
		answer = str(input("Are you ready to pull [Y/N]: "))

		if answer.lower() == "y":
			os.system("git pull")
			os.system("python3 linking.py")

			# Upgrade local version release
			write_to_file(online_origin)


# Func parses from github latest release
def get_current_online_release():
	browser = webdriver.Firefox()
	browser.get("https://github.com/castlele/File-Sorting/releases/")

	# List of all links on the page
	release_links = browser.find_elements_by_css_selector(".release-header [href]")
	# Link for the latest release
	latest_release = release_links[0].get_attribute("href")
	# Just a tag of the last version
	version = latest_release.split("/")[-1]

	browser.quit()

	return version


# Func read latest ofline version from the file
def get_current_local_release():
	local_release = open("currentRelease.txt", "r")
	local = local_release.readline()
	local_release.close()

	return local


def write_to_file(version):
	file = open("currentRelease.txt", "w")
	file.write(version)

if __name__ == '__main__':
	main()
