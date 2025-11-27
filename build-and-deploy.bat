@echo off
REM Script de build et deploiement complet
REM Ce script compile le projet et le deploie automatiquement vers Tomcat

echo ============================================
echo Build et Deploiement de teste-framework
echo ============================================
echo.

REM Definir JAVA_HOME pour utiliser JDK 17
set JAVA_HOME=D:\App\java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%

echo [1/2] Compilation du projet avec Maven...
echo.
call mvn clean package

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERREUR: La compilation a echoue
    pause
    exit /b 1
)

echo.
echo [2/2] Deploiement vers Tomcat...
echo.
call deploy.bat
