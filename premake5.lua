outputdir = "%{cfg.buildcfg}/%{cfg.system}-%{cfg.architecture}"

includeDir = {}
includeDir["CLI11"] = "vendor/CLI11/include"

libDir = {}

projectName = "Project"

workspace "takeout" -- ChangeProject
	location "workspace"
	architecture "x86_64"

	startproject "takeout" -- Change this to what's ever the starting project is 

	configurations{
		"Debug",
		"Dist",
		"Release"
	}

	pchheader "pch.hpp"
	pchsource "src/pch.cpp"

	targetdir ("bin/" .. outputdir)
	objdir ("bin-int/" .. outputdir)

	filter "system:windows"
		defines "_WINDOWS"
	filter "system:linux"
		defines "_LINUX"
		libdirs{
			"/usr/lib/x86_64-linux-gnu"
		}
	filter "system:macosx"
		defines "_OSX"
		
    filter "configurations:Debug"
        defines "_DEBUG"
        symbols "On"
        runtime "Debug"
    filter "configurations:Dist"
        defines "_DIST"
        optimize "On"
        runtime "Release"
    filter "configurations:Release"
        defines "_RELEASE"
        optimize "On"
        runtime "Release"

project "takeout" -- Default Project
	language "C++"
	cppdialect "C++17"
	kind "ConsoleApp" -- ConsoleApp / SharedLib
	-- defines "_DLL" -- If SharedLib

	headerdir "include"

	files{
		"src/**.cpp",
		"src/**.c"
	}

	includedirs{
		"include",
		includeDir["CLI11"]
	}

	links{

	}

--[[
project "" -- Default Project
	language "C++"
	cppdialect "C++17"
	kind "" -- ConsoleApp / SharedLib
	-- defines "_DLL" -- If SharedLib
	
	headerdir "include"

	files{
		"src/**.cpp",
		"src/**.c"
	}

	includedirs{
		"include"
	}

	links{

	}
]]--
