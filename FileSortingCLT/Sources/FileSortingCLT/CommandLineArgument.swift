enum CommandLineArgument: CaseIterable {
	case name, ext, date, time, dateTime, help

	init?(argument: String) {
		switch argument {
			case "-n":
				self = .name

			case "-e":
				self = .ext

			case "-d":
				self = .date

			case "-t":
				self = .time

			case "-D":
				self = .dateTime

			case "--name":
				self = .name

			case "--date":
				self = .date

			case "--time":
				self = .time

			case "--help":
				self = .help
				
			default:
				return nil		
		}
	}
}
