

REM
REM To *** install the software ***, powershell requires
REM Start -> Command Prompt->More -> Run as Administror
REM 

REM before RUNNING CHECK
REM
REM https://github.com/rwinlib/base
REM
REM LOOKING for ANY recent COMMITS

REM
set source=https://cran.r-project.org/src/base-prerelease/R-latest.tar.gz
set archive=r-patched
REM ALTERNATIVELY ... SEE THE appveyor.yml web page
REM 

REM NOTE: %builddir% SEEMS not USED: but IT is the 
REM sibling directory location OF *THIS* directory and CALLED "BUILD"
REM
REM important in build.bat (HARD-CODED RELATIVE BUILD PATH)
REM
REM e.g. my current directory could be 
REM          W:\R-3.5._\base.AMMENDED
REM e.g. my build directory would then be 
REM          W:\R-3.5._\BUILD
REM output folder then WOULD BE THE FOLLOWING
REM   W:\R-3.5._\BUILD\R-source-win32
REM
REM   OR
REM   W:\R-3.5._\BUILD\R-latest.AMMENDED-win32 
REM
REM   W:\R-3.5._\BUILD\R-source-win64
REM   OR
REM   W:\R-3.5._\BUILD\R-latest.AMMENDED-win64
REM
REM (THIS *NAME* IS BASED ON WHATEVER NAME IS USED IN THE CALL STATEMENT) 
REM E.G.
REM
REM call .\scripts\build.bat R-latest.AMMENDED.tar.gz 32
REM call .\scripts\build.bat R-latest.AMMENDED.tar.gz 64
REM 
REM INSIDE OF build-r-release.bat OR build-r-patched.bat OR build-r-devel
REM 
REM if called 
REM .\scripts\build.bat R-source.tar.gz
REM
REM THEN THE OUTPUT may? be?
REM 
REM R-source-win64-win64
REM


REM IF I ALREADY HAVE THE GITHUB FILES (FROM A .ZIP) 
REM THEN I **DO NOT DO THIS**
REM 
REM git clone https://github.com/rwinlib/base



REM appveyor-tool.ps1
REM 
if not exist .\scripts\appveyor-tool.ps1.ORIG ( 
  move .\scripts\appveyor-tool.ps1        .\scripts\appveyor-tool.ps1.ORIG
)
REM
REM <one change>
REM
REM Instead ofinstalled into "C:\Program Files (x86)\Inno Setup 5\ISCC.exe"
REM Actually  installed into "C:\InnoSetup5"
REM
if not exist .\scripts\appveyor-tool.ps1 ( 
  copy .\scripts\appveyor-tool.ps1.fixed  .\scripts\appveyor-tool.ps1
)



REM
REM NOTE: from APPVEYOR01.PS1, the rtools/Rtools LOCATION 
REM IS OVERWRIDDEN AND HARDCODED in BOTH (see far below): 
REM
REM build.bat AND MkRules.local.in
REM 
REM APPVEYOR01.PS1 rtools/Rtools is just a bare-bones OLD cygwin directory
REM (SEEMS not-used)



REM build.bat
REM
REM example of relative (sibling) directory build
REM
REM (directories)
REM set SOURCEDIR=%~dp0..
REM mkdir ..\BUILD
REM cd ..\BUILD
REM set BUILDDIR=%CD%
REM 
REM
if not exist .\scripts\build.bat.ORIG ( 
  move .\scripts\build.bat       .\scripts\build.bat.ORIG
)
REM 
REM <changes>
REM
REM explicitly HARD path to MY R Tools
REM 
REM set PATH=W:\Rtools35\bin;%PATH% 
REM REM
REM NOTE: MY RTOOLS has a tar that can DO: "--strip-components=1" ( 'C R tools' can NOT)
REM 
REM try HARD to remove a directory
REM 
REM icacls %R_NAME% /grant Everyone:(f) /grant Users:(f) /t /inheritance:e /t
REM :: rm -Rf %R_NAME%
REM rd /S /Q %R_NAME%
REM mkdir %R_NAME%
REM icacls %R_NAME% /inheritance:e /grant Everyone:(f)
REM
REM changed to a backslash (\)
REM
REM tar -xf %SOURCEDIR%\%TARBALL% -C %R_NAME% --strip-components=1
REM
REM assign debugging symbols flag
REM
REM echo "G_FLAG = -ggdb3" >> %R_HOME%/src/gnuwin32/MkRules.local
REM
REM make debug versions 
REM HARD NOTE: WITHOUT "DEBUG=T" flag "-s" WILL *strip* BINARIES of DEBUG information.
REM
REM make 32-bit DEBUG=T 
REM make distribution DEBUG=T
REM
if not exist .\scripts\build.bat ( 
  copy .\scripts\build.bat.fixed  .\scripts\build.bat
)



REM MkRules.local.in
REM
REM Where it accesses R tools
REM
REM ### For non-multilib compilers ###
REM WIN = @win@
REM BINPREF = $(RTOOLS)/mingw_32/bin/
REM BINPREF64 = $(RTOOLS)/mingw_64/bin/
REM ICU_PATH = $(RTOOLS)/mingw_libs
REM ###
REM
REM TI5 = $(RTOOLS)/texinfo5
REM
if not exist .\files\MkRules.local.in.ORIG ( 
  move .\files\MkRules.local.in       .\files\MkRules.local.in.ORIG
)
REM 
REM <changes> 
REM
REM explicitly HARD path to MY R Tools
REM
REM RTOOLS=W:/Rtools35
REM
REM fix wrong location (to the correct location) of Inno Installer
REM
REM ISDIR = C:/InnoSetup5
REM
if not exist .\files\MkRules.local.in ( 
  copy .\files\MkRules.local.in.fixed  .\files\MkRules.local.in
)



REM profile.txt
REM
REM leave as is: W:\R-3.5._\base.AMMENDED\files\profile.txt
REM IF DONE INTERACTIVELY, at MiKTeX, may "hang".
REM USE needs to press return.



REM download and then place and/or install software
REM 
powershell -File APPVEYOR01.PS1
REM 


REM IF I ALREADY HAVE THE SUBMODULES 
REM THEN **DO NOT DO THIS**
REM 
REM SEE .gitmodules: 
REM
REM https://github.com/rwinlib/cairo/archive/master.zip
REM https://github.com/rwinlib/libcurl/archive/master.zip
REM https://github.com/rwinlib/tcltk/archive/master.zip 
REM https://github.com/rwinlib/baselibs/archive/master.zip
REM
REM NEXT: expand into local folders in this DIRECTORY: (all folders/files expanaded): 
REM cairo libcurl tcltk baselibs
REM
REM NOTE: **ALL other FILES**:(icu files, txtinfo: perl script and (perl).pm files) 
REM are *INSIDE* the W:\Rtools35
REM
REM git submodule update --init



REM MAKING A CUSTOM .GZ FILE ( I HAVE NOT YET AUTOMATED THIS YET )
REM
REM NOTE:dwarf-2 (or 3 or 4 or 5) IS NOT AVAILBLE ON 64 BIT WINDOWS.
REM
REM (1) DOWNLOAD (CHOOSE ONE)
REM
REM https://cran.r-project.org/src/base/R-latest.tar.gz            (from build-r-release.bat): CURRENT
REM https://cran.r-project.org/src/base-prerelease/R-latest.tar.gz (from appveyor.yml ): CURRENT (I USED)
REM https://stat.ethz.ch/R/daily/R-patched.tar.gz (from build-r-patched.bat)
REM https://stat.ethz.ch/R/daily/R-devel.tar.gz (from build-r-devel.bat)
REM
REM (2) extract to a folder (USE 7-zip software)
REM
REM (3) run the following modifying Make-like files
REM I USED MSYS2. BUT RTools or cgwnin may? work
REM
REM find . -type f \( -name 'M*k*' -o -name '*.mk' \) -print -exec sed -i 's/-O3/-Og -ggdb3/g' {} \;
REM find . -type f \( -name 'M*k*' -o -name '*.mk' \) -print -exec sed -i 's/-O2/-Og -ggdb3/g' {} \;
REM find . -type f \( -name 'M*k*' -o -name '*.mk' \) -print -exec sed -i 's/-gdwarf-2/-Og -ggdb3/g' {} \;
REM
REM (4) some lines have NOTHING to grab onto ( SO ALSO RUN THESE )
REM
REM find . -type f \( -name 'M*k*' -o -name '*.mk' \) -print -exec sed -i 's/gcc/gcc -Og -ggdb3/g' {} \;
REM find . -type f \( -name 'M*k*' -o -name '*.mk' \) -print -exec sed -i 's/g++/g++ -Og -ggdb3/g' {} \;
REM find . -type f \( -name 'M*k*' -o -name '*.mk' \) -print -exec sed -i 's/gfortran/gfortran -Og -ggdb3/g' {} \;
REM
REM NOTE: LATER: AFTER COMPILING: the only DLL left with stripped info (-s did that) is the following: Rlapack.dll
REM
REM Use 7-zip, CREATE an R-latest.AMMENDED.tar.gz
REM
REM For the 7-zip method, choose "tar"
REM Leave all of the other options at Default.
REM
REM If one chose R-latest.tar.gz or R-patched.tar.gz
REM then 7-zip-up all files into a folder called: /R-patched
REM 
REM Differently, if one chose R-devel.tar.gz, 
REM then 7-zip up all files into a folder called /R-devel
REM
REM (Re)name the .tar file to be: R-latest.AMMENDED.tar
REM Next, just add .gz to the end of the file name: So now have R-latest.AMMENDED.tar.gz
REM
REM (last REQUIRED:RUN) copy R-latest.AMMENDED.tar.gz  R-source.targ.gz
REM Place R-source.targ.gz in the current folder: W:\R-3.5._\base.AMMENDED.
REM
REM IF I ALREADY HAVE THE "CUSTOM" .TAR.GZ 
REM THEN **DO NOT DO THE FOLLOWING**
REM REM
REM IT JUST DOES: Invoke-WebRequest "${env:source}" -OutFile "R-source.tar.gz"
REM REM
REM powershell -ExecutionPolicy Unrestricted  -File APPVEYOR02.PS1

REM ACTUALLY COMPILE R
REM 
.\scripts\build.bat R-source.tar.gz 32
.\scripts\build.bat R-source.tar.gz 64
REM (at the end)
REM Innosetup died here 
REM It knows where it lives
REM Could not find its executable: 
REM Could not find its custom: R.iss
REM
REM W:\R-3.5._\BUILD\distribution.log
REM
REM "C:/InnoSetup5          /iscc" R.iss > R-3.5.2.log 2>&1
REM make[2]: *** [Makefile:175: R-3.5.2-win.exe] Error 127
REM make[1]: *** [Makefile:387: rinstaller] Error 2
REM make: *** [Makefile:401: distribution] Error 2
REM 
REM BUT **STILL** WILL BE LEFT WITH THE FOLLOWIN
REM WORKING R EXECUTABLES
REM
REM output folder then WOULD BE THE FOLLOWING
REM   W:\R-3.5._\BUILD\R-source-win32
REM   W:\R-3.5._\BUILD\R-source-win64





