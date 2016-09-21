; -*- encoding: utf-8 -*-

EnvGet, WindowsEnvTempFolder, TEMP
ResourceFolder = %WindowsEnvTempFolder%\Neo2
FileCreateDir, %ResourceFolder%

if (FileExist("ResourceFolder")<>false) {
  FileInstall,BuT_enabled.ico,%ResourceFolder%\BuT_enabled.ico,1
  FileInstall,BuT_disabled.ico,%ResourceFolder%\BuT_disabled.ico,1
}

