
# called from APPVEYOR.BAT

# if doing interactively then to reload, append -Force
# # Force: Re-import a module and its members, even if the module or its members have an access mode of read-only
#
Import-Module '.\scripts\appveyor-tool.ps1'

SetTimezone # changed to UTC

InstallMiktex # Windows-installed into C:\Program Files\MiKTeX 2.9\miktex
              # added to the Windows Path: C:\Program Files\MiKTeX 2.9\miktex\bin
              
InstallPerl   # portable edition placed into # "C:\Strawberry

InstallInno   # Windows-installed into C:\Program Files (x86)\Inno Setup 5

InstallRtools # Bare-bones Dinosour thin copy placed into C:\rtools (harmless:legacy)

[Environment]::Exit(0)
