#!/bin/bash
# script for Installer OpenCorePackage
# OpenCorePackage by chris1111
#
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"

# shell script Notifications
osascript -e 'display notification "OpenCorePackage" with title "Build"  sound name "default"'

# Delete build if exist
rm -rf ./OpenCore-Package
rm -rf /tmp/PackageDIR
rm -rf ./OpenCore-Package.pkg
Sleep 1
mkdir -p ./OpenCore-Package/BUILD-PACKAGE
mkdir -p /tmp/PackageDIR

# Create the Packages with pkgbuild
pkgbuild --root ./OC-EFI --scripts ./ScriptEFI --identifier com.opencorePackage.OpenCorePackage.pkg --version 1.0 --install-location /Private/tmp ./OpenCore-Package/BUILD-PACKAGE/opencorePackage.pkg


Sleep 2
# Expend the Packages with pkgutil
pkgutil --expand ./OpenCore-Package/BUILD-PACKAGE/opencorePackage.pkg /tmp/PackageDIR/opencorePackage.pkg


Sleep 3
# Copy resources and distribution
cp -r ./Distribution ./OpenCore-Package/BUILD-PACKAGE/Distribution.xml
cp -rp ./Resources ./OpenCore-Package/BUILD-PACKAGE/

echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Build final package with Productbuild "
Sleep 3
# Create the final Packages with Productbuild
productbuild --distribution "./OpenCore-Package/BUILD-PACKAGE/Distribution.xml"  \
--package-path "./OpenCore-Package/BUILD-PACKAGE/" \
--resources "./OpenCore-Package/BUILD-PACKAGE/Resources" \
"./OpenCore-Package.pkg"

rm -rf ./OpenCore-Package


