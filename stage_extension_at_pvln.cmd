:: Name:     stage_extension_at_pvln.cmd
:: Purpose:  set enviroment and run deploy script 
:: Author:   pierre@pvln.nl
:: Revision: 2019 02 11 - initial version
::           2020 03 15 - new folder structure
::

@ECHO off
SETLOCAL ENABLEEXTENSIONS

:: BASIC SETTINGS
:: ==============
:: Setting the name of the script
SET me=%~n0
:: Setting the name of the directory with this script
SET parent=%~p0
:: Setting the drive of this commandfile
SET drive=%~d0
:: Setting the directory and drive of this commandfile
SET cmd_dir=%~dp0
::
:: (re)set environment variables
::
SET VERBOSE=YES
::
:: Setting for Error messages
::
SET ERROR_MESSAGE=errorfree

:: Setting required environment variables:
::

:: Where to put the files on the staging/download server
SET download_folder=/download/joomla/modules/ipheiongraphs/
SET update_folder=/update/joomla/modules/ipheiongraphs/

:: Where to find the secrets
SET secrets_folder=..\..\..\_secrets

:: -OUTPUT DIRECTORY FOR BUILD = INPUT DIRECTORY FOR STAGING
:: do not start with \ , and do not end with \
SET output_dir=..\_bin

CD "%cmd_dir%"
:: struc_utils_folder
CD ..\struc\utils\
IF EXIST name.cmd (
   CALL name.cmd
) ELSE (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] file with extension name settings doesn't exist ...
   GOTO ERROR_EXIT
)

CD "%cmd_dir%"
:: struc_utils_folder
CD ..\struc\utils\
IF EXIST version.cmd (
   CALL version.cmd
) ELSE (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] file with version info settings doesn't exist ...
   GOTO ERROR_EXIT
)

CD "%cmd_dir%"

::
:: Assume psftp should be used first. Then pscp. If not available choose ftp
::

:: !! Do not use " or ' at beginning or end of the list
::    Do not use sftp as the password can't be entered from batch files   
SET CHECK_TRANSFER_LIST=psftp pscp ftp

CALL stage_files.cmd
