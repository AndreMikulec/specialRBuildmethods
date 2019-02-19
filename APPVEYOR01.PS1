
# called from APPVEYOR.BAT

Import-Module '.\scripts\appveyor-tool.ps1'

SetTimezone # to UTC

InstallMiktex # Windows-installed into C:\Program Files\MiKTeX 2.9\miktex
              # added to the Windows Path: C:\Program Files\MiKTeX 2.9\miktex\bin
              
InstallPerl   # portable edition placed into # "C:\Strawberry

InstallInno  # Windows-installed into "C:\InnoSetup5"

InstallRtools # Bare-bones Dinosour thin copy placed into C:\rtools (harmless:legacy)

[Environment]::Exit(0)
