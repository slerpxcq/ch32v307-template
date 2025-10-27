workspace "CH32V307"
	configurations { "Debug", "Release" }

project "Template"
	kind "ConsoleApp"
	language "C"
	targetdir "bin/%{cfg.buildcfg}"
	objdir "obj/%{cfg.buildcfg}"

	ARCH = "-march=rv32imac -mabi=ilp32 -msmall-data-limit=8 -msave-restore"
	LDSCRIPT = "Ld/Link.ld"
	OBJCOPY = "riscv-wch-elf-objcopy"
	SIZE = "riscv-wch-elf-size"

	postbuildcommands {
		"{MOVE} %{cfg.buildtarget.abspath} %{cfg.buildtarget.abspath}.elf",
		"%{SIZE} %{cfg.buildtarget.abspath}.elf",
		"%{OBJCOPY} -O ihex %{cfg.buildtarget.abspath}.elf %{cfg.buildtarget.abspath}.hex"
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
		"%{ARCH}",
		"-flto",
		"-std=gnu11"
	}

	linkoptions {
		"%{ARCH}",
		"-flto",
		"-fmessage-length=0",
		"-fsigned-char",
		"-ffunction-sections",
		"-fdata-sections",
		"-fno-common",
		"-Wunused",
		"-Wuninitialized",
		"-nostartfiles",
		"--specs=nosys.specs",
		"--specs=nano.specs",
		"-Xlinker --gc-sections",
		"-Xlinker -Map=%{prj.name}.map",
		"-T%{LDSCRIPT}",
		"-v"
	}

	links {
		"g_nano",
		"c_nano",
		"m",
		"nosys"
	}

	filter "configurations:Debug"
		symbols "On"
		buildoptions {
			"-O0",
			"-g",
		}
		defines {
			"DEBUG"
		}

		linkoptions {
			"-g",
		}
	
	filter "configurations:Release"
		buildoptions { 
			"-Os" 
		}
		defines {
			"NDEBUG"
		}


