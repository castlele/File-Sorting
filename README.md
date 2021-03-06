# File Sorting Assistant

File Sorting is a Command-Line tool written in swift language. This program allows you to sort files into folders using Terminal.app on macOS.

## Instalation

` Make sure Xcode is installed first `

### Swift Package Manager
#### Using Terminal
```
$ git clone https://github.com/castlele/File-Sorting.git
$ cd File-Sorting/FileSortingCLT
$ swift build --configuration release
$ cp -f .build/release/sorting /usr/local/bin/sorting
```
## Usage
```
$ sorting <option> <path>
```
Also you can sort in multiple directories:
```
$ sorting <option> <path> <path1> <path2> ... etc.
```
![Usage example](https://media.giphy.com/media/fheCS7ohGblxaJhpAV/giphy.gif)
## Available arguments
```
-n, --name		Sorting files by name
-e			Sorting files by extension
-d, --date		Sorting files by date
-t, --time		Sorting files by time
-D			Sorting files by date and time
--help			Displays user manual
```
