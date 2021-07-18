ARG WINDOWS_VERSION=20H2
FROM mcr.microsoft.com/windows/servercore:$WINDOWS_VERSION

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\\TEMP\\vs_buildtools.exe

# Visual Studio BuildTools
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath C:\BuildTools \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
    --remove Microsoft.VisualStudio.Component.Windows81SDK \
    --add Microsoft.VisualStudio.Workload.VCTools \
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \
    --add Microsoft.VisualStudio.Component.Windows10SDK \
    --add Microsoft.VisualStudio.Component.Windows10SDK.19041

# Install Prerequisites
# https://rustc-dev-guide.rust-lang.org/building/prerequisites.html
# Install tools from Chocolatey
RUN Install-PackageProvider nuget -Force; \
    Install-PackageProvider ChocolateyGet -Force; \
    Install-Package -ProviderName ChocolateyGet cmake -Force; \
    Install-Package -ProviderName ChocolateyGet git -Force; \
    Install-Package -ProviderName ChocolateyGet python -Force;

# Path に CMake を追加
RUN [Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\\Program Files\\CMake\\bin', [EnvironmentVariableTarget]::Machine)

ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

