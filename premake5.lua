workspace "CH32V307"
	configurations { "Debug", "Release" }

project "Template"
	kind "ConsoleApp"
	language "C"
	targetdir "bin/%{cfg.buildcfg}"
	objdir "obj/%{cfg.buildcfg}"

	ARCH = "-march=rv32imac -mabi=ilp32"
	LIBS = "-lc -lm -lnosys"
	LDSCRIPT = "Ld/Link.ld"

	includedirs {
		"Core",
		"Debug",
		"Peripheral/inc",
		"User"
	}

	files {
		"Core/*.c",
		"Debug/*.c",
		"Peripheral/src/*.c",
		"User/**.c",
		"Startup/startup_ch32v30x_D8.S"
	}

	buildoptions {
		{ARCH}
	}

	linkoptions {
		"-msave-restore",
		"-fmessage-length=0",
		"-fsigned-char",
		"-ffunction-sections",
		"-fdata-sections",
		"-fno-common",
		"-Wunused",
		"-Wuninitialized",
		"-nostartfiles",
		"-Xlinker",
		"--gc-sections",
		"--specs=nosys.specs",
		"-Wl,-Map=%{prj.name}.map",
		"-T%{LDSCRIPT}",
		{LIBS}
	}

	filter "configurations:Debug"
		buildoptions {
			"-O0",
			"-g"
		}

		linkoptions {
			"-g"
		}
	
	filter "configurations:Release"
		buildoptions { 
			"-Ofast" 
		}


