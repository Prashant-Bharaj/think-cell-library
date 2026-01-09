# Environment check script for think-cell library development

Write-Host "=== C++ Development Environment Check ===" -ForegroundColor Cyan

$allGood = $true

# 1. Check MSVC compiler
Write-Host "`n1. Checking MSVC compiler..." -ForegroundColor Yellow
$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
if (Test-Path $vsPath) {
    Write-Host "  [OK] Visual Studio 2022 found" -ForegroundColor Green
    Write-Host "    Path: $vsPath" -ForegroundColor Gray
} else {
    Write-Host "  [FAIL] Visual Studio 2022 not found" -ForegroundColor Red
    $allGood = $false
}

# 2. Check CMake
Write-Host "`n2. Checking CMake..." -ForegroundColor Yellow
try {
    $cmakeVersion = cmake --version 2>&1 | Select-Object -First 1
    Write-Host "  [OK] CMake found: $cmakeVersion" -ForegroundColor Green
} catch {
    $cmakePath = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
    if (Test-Path $cmakePath) {
        Write-Host "  [OK] CMake found in Visual Studio" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] CMake not found" -ForegroundColor Red
        Write-Host "    Install from: https://cmake.org/download/" -ForegroundColor Gray
        $allGood = $false
    }
}

# 3. Check Git
Write-Host "`n3. Checking Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "  [OK] Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "  [FAIL] Git not found" -ForegroundColor Red
    Write-Host "    Install from: https://git-scm.com/download/win" -ForegroundColor Gray
    $allGood = $false
}

# 4. Check vcpkg
Write-Host "`n4. Checking vcpkg..." -ForegroundColor Yellow
$vcpkgRoot = "C:\vcpkg"
if (Test-Path $vcpkgRoot) {
    Write-Host "  [OK] vcpkg found at: $vcpkgRoot" -ForegroundColor Green
} else {
    Write-Host "  [FAIL] vcpkg not found" -ForegroundColor Red
    $allGood = $false
}

# 5. Check Boost
Write-Host "`n5. Checking Boost..." -ForegroundColor Yellow
$boostInclude = "C:\vcpkg\installed\x64-windows\include\boost"
$boostLib = "C:\vcpkg\installed\x64-windows\lib"
if ((Test-Path $boostInclude) -and (Test-Path $boostLib)) {
    Write-Host "  [OK] Boost found via vcpkg" -ForegroundColor Green
    Write-Host "    Include: $boostInclude" -ForegroundColor Gray
    Write-Host "    Library: $boostLib" -ForegroundColor Gray
    
    # Try to get Boost version
    $versionFile = "$boostInclude\version.hpp"
    if (Test-Path $versionFile) {
        $versionContent = Get-Content $versionFile | Select-String "BOOST_VERSION"
        if ($versionContent) {
            Write-Host "    $versionContent" -ForegroundColor Gray
        }
    }
} else {
    Write-Host "  [FAIL] Boost not found" -ForegroundColor Red
    Write-Host "    Install with: vcpkg install boost:x64-windows" -ForegroundColor Gray
    $allGood = $false
}

# 6. Check think-cell library
Write-Host "`n6. Checking think-cell library..." -ForegroundColor Yellow
if (Test-Path "CMakeLists.txt") {
    Write-Host "  [OK] think-cell library found" -ForegroundColor Green
} else {
    Write-Host "  [FAIL] think-cell library not found in current directory" -ForegroundColor Red
    Write-Host "    Make sure you're in the think-cell-library directory" -ForegroundColor Gray
    $allGood = $false
}

# Summary
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
if ($allGood) {
    Write-Host "All checks passed! You're ready to build." -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "  1. Run: .\build.ps1" -ForegroundColor White
    Write-Host "  2. Study: range.example.cpp" -ForegroundColor White
    Write-Host "  3. Explore: tc\ directory" -ForegroundColor White
} else {
    Write-Host "Some checks failed. Please fix the issues above." -ForegroundColor Red
}
