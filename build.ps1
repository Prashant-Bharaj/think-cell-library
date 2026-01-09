# Build script for think-cell library
# This script sets up the Visual Studio environment and builds the project

Write-Host "=== Building think-cell Library ===" -ForegroundColor Cyan

# Find Visual Studio installation
$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
if (-not (Test-Path $vsPath)) {
    Write-Host "Error: Visual Studio 2022 not found at expected path" -ForegroundColor Red
    exit 1
}

# Set up vcpkg path
$vcpkgRoot = "C:\vcpkg"
if (-not (Test-Path $vcpkgRoot)) {
    Write-Host "Error: vcpkg not found at $vcpkgRoot" -ForegroundColor Red
    exit 1
}

# Create build directory
$buildDir = "build"
if (Test-Path $buildDir) {
    Write-Host "Cleaning existing build directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $buildDir
}
New-Item -ItemType Directory -Path $buildDir | Out-Null

Write-Host "`nConfiguring CMake..." -ForegroundColor Yellow

# Configure CMake with vcpkg toolchain
$cmakeArgs = @(
    "-S", ".",
    "-B", $buildDir,
    "-DCMAKE_TOOLCHAIN_FILE=$vcpkgRoot\scripts\buildsystems\vcpkg.cmake",
    "-DCMAKE_BUILD_TYPE=Release"
)

# Check if CMake is available
try {
    $cmakeVersion = cmake --version 2>&1
    Write-Host "Using: $cmakeVersion" -ForegroundColor Green
} catch {
    Write-Host "CMake not found in PATH. Attempting to use Visual Studio's CMake..." -ForegroundColor Yellow
    # Try to find CMake in Visual Studio
    $cmakePath = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
    if (Test-Path $cmakePath) {
        $env:Path = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;$env:Path"
    } else {
        Write-Host "Error: CMake not found. Please install CMake or Visual Studio with CMake support." -ForegroundColor Red
        exit 1
    }
}

# Run CMake configure
& cmake $cmakeArgs
if ($LASTEXITCODE -ne 0) {
    Write-Host "CMake configuration failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`nBuilding project..." -ForegroundColor Yellow
& cmake --build $buildDir --config Release
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Build Complete ===" -ForegroundColor Green
Write-Host "Build output: $buildDir" -ForegroundColor Cyan
Write-Host "`nTo run tests:" -ForegroundColor Yellow
Write-Host "  cd $buildDir" -ForegroundColor White
Write-Host "  ctest -C Release" -ForegroundColor White
