workspace "CH32V307"
	configurations { "Debug", "Release" }

project "Template"
	kind "ConsoleApp"
	language "C"
	targetdir "bin/%{cfg.buildcfg}"
	objdir "obj/%{cfg.buildcfg}"

	ARCH = "-march=rv32imac -mabi=ilp32"
	LDSCRIPT = "Ld/Link.ld"
	OBJCOPY = "riscv-wch-elf-objcopy"

	postbuildcommands {
		"{MOVE} %{cfg.buildtarget.abspath} %{cfg.buildtarget.abspath}.elf",
		"%{OBJCOPY} -O ihex %{cfg.buildtarget.abspath}.elf %{cfg.buildtarget.abspath}.hex",
	}

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
		"%{ARCH}"
	}

	linkoptions {
		"%{ARCH}",
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
	}

	links {
		"c",
		"m",
		"nosys"
	}

	filter "configurations:Debug"
		buildoptions {
			"-O0",
			"-g",
			"-ggdb"
		}
		defines {
			"DEBUG"
		}

		linkoptions {
			"-g",
			"-ggdb"
		}
	
	filter "configurations:Release"
		buildoptions { 
			"-Ofast" 
		}
		defines {
			"NDEBUG"
		}


