@echo off
REM Script de deploiement automatique vers Tomcat
REM Ce script copie le fichier WAR genere vers le dossier webapps de Tomcat

echo ============================================
echo Deploiement de teste-framework vers Tomcat
echo ============================================

REM Chemin vers Tomcat
set TOMCAT_WEBAPPS=D:\Tomcat\apache-tomcat-11.0.4\webapps

REM Chemin du fichier WAR genere
set WAR_FILE=target\teste-framework-1.0.0.war

REM Verifier si le fichier WAR existe
if not exist "%WAR_FILE%" (
    echo ERREUR: Le fichier WAR n'existe pas: %WAR_FILE%
    echo Veuillez d'abord compiler le projet avec: mvn clean package
    pause
    exit /b 1
)

REM Verifier si le dossier Tomcat existe
if not exist "%TOMCAT_WEBAPPS%" (
    echo ERREUR: Le dossier Tomcat n'existe pas: %TOMCAT_WEBAPPS%
    echo Veuillez verifier le chemin dans le script
    pause
    exit /b 1
)

REM Supprimer l'ancien deploiement si present
if exist "%TOMCAT_WEBAPPS%\teste-framework-1.0.0.war" (
    echo Suppression de l'ancien WAR...
    del /Q "%TOMCAT_WEBAPPS%\teste-framework-1.0.0.war"
)

if exist "%TOMCAT_WEBAPPS%\teste-framework-1.0.0\" (
    echo Suppression de l'ancien dossier deploye...
    rmdir /S /Q "%TOMCAT_WEBAPPS%\teste-framework-1.0.0\"
)

REM Copier le nouveau fichier WAR
echo Copie du fichier WAR vers Tomcat...
copy "%WAR_FILE%" "%TOMCAT_WEBAPPS%\" >nul

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo Deploiement reussi !
    echo ============================================
    echo Fichier: teste-framework-1.0.0.war
    echo Destination: %TOMCAT_WEBAPPS%
    echo.
    echo Tomcat va automatiquement deployer l'application.
    echo URL: http://localhost:8080/teste-framework-1.0.0/
    echo ============================================
) else (
    echo.
    echo ERREUR: Echec de la copie du fichier WAR
    pause
    exit /b 1
)

pause
