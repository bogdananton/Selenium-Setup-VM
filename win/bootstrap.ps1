# disable UAC (after reboot)
New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force

# download / install chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# install apps.
# @todo allow installing a different version of ie (choose via environment variables on up --provision)
choco install -y git phantomjs php google-chrome-x64 opera firefox ie11 wget vcredist2012 jre8 javaruntime -y

# add to path
$path = "$env:PATH;C:\tools\php;C:\Program Files\Git\bin;C:\Program Files (x86)\Java\jre1.8.0_66\bin"
$env:PATH=$path
[Environment]::SetEnvironmentVariable("path", $path, "Machine")

# set php extensions
copy "c:\tools\php\php.ini-development" "c:\tools\php\php.ini"
Add-Content c:\tools\php\php.ini "extension_dir=ext"
Add-Content c:\tools\php\php.ini "extension=php_curl.dll"
Add-Content c:\tools\php\php.ini "extension=php_openssl.dll"

# clone
cd /
git clone https://github.com/bogdananton/Selenium-Setup.git
cd Selenium-Setup

# start.
# @todo specify port (via environment variables on up --provision)
wget https://getcomposer.org/composer.phar -O c:\tools\php\composer.phar
php c:\tools\php\composer.phar update
php C:\Selenium-Setup\bin\selenium-setup.php start

# debug
Start-Sleep -s 10
