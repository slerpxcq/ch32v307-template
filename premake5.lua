workspace "CH32V307"
	configurations { "Debug", "Release" }

project "Template"
	kind "ConsoleApp"
	language "C"
	targetdir "bin/%{cfg.buildcfg}"
	objdir "obj/%{cfg.buildcfg}"

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
		"User/**.c"
	}


	filter "configurations:Debug"
		symbols "On"
	
	filter "configurations:Release"
		optimize "On"

