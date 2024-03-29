#!/bin/bash
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
kernel_version="1"
kernel_name="AR_Beast™"
device_name="Z2_Plus"
zip_name="$kernel_name-$device_name-R$kernel_version-$(date +"%Y%m%d")-$(date +"%H%M%S").zip"


export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="Ayush"
export KBUILD_BUILD_HOST="Beast"


KERNEL_DIR=`pwd`
HOME="/home/ayushr1"
anykernel="$HOME/AR_Beast/ARB-Anykernel2"
TOOLCHAIN_PATH="${HOME}/AR_Beast/uber/bin"
TOOLCHAIN_PATH_2="${HOME}/AR_Beast/linaroe/bin"
CONFIG_FILE="ARB_z2_plus_defconfig"
THREAD="-j$(nproc --all)"
ZIMAGE="$KERNEL_DIR/arch/$ARCH/boot/Image.gz-dtb"
CCACHE=$(command -v ccache)
CROSS_COMPILE="aarch64-linux-gnu-"
CONFIG_CROSS_COMPILE_ARM32="arm-linux-gnueabi-"
CLANG_TC="$HOME/AR_Beast/dtc/bin/clang-8"
CLANG_VERSION="Dragon-TC 8.0.5"

# Functions
prefix() {
         make CC="${CCACHE} ${CLANG_TC}" \
             CLANG_TRIPLE=aarch64-linux-gnu- \
             CROSS_COMPILE=${TOOLCHAIN_PATH}/${CROSS_COMPILE} \
             CROSS_COMPILE_ARM32=${TOOLCHAIN_PATH_2}/${CONFIG_CROSS_COMPILE_ARM32} \
             KBUILD_COMPILER_STRING="${CLANG_VERSION}" \
             HOSTCC="${CLANG_TC}" \
             $@ 
}
version() {
	touch .version
	echo "$(($kernel_version - 1))" > .version
}

compile() {
BUILD_START=$(date +"%s")
echo -e "$blue****************************************************************************"
echo "          Compiling $kernel_name-$device_name-R$kernel_version         "
echo -e       "***************************************************************************$nocol"
echo "          Making Config      "
        prefix $CONFIG_FILE $THREAD
echo "          Appending Version info    "
        version
echo "          Compiling      "
        prefix $THREAD
if ! [ -a $ZIMAGE ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
BUILD_END=$(date +"%s")
}
clean() {
echo -e "$yellow****************************************************************************"
echo "          Cleaning        "
echo -e       "***************************************************************************$nocol"
  cd $KERNEL_DIR
  prefix clean
  prefix mrproper
  rm -rf $anykernel/zImage
  rm -rf $ZIMAGE
}

module_stock(){
  rm -rf $anykernel/modules/
  mkdir $anykernel/modules
  find $objdir -name '*.ko' -exec cp -av {} $anykernel/modules/ \;
  cp -rf $ZIMAGE $anykernel/zImage
}
delete_zip(){
  cd $anykernel
  find . -name "*.zip" -type f
  find . -name "*.zip" -type f -delete
}
build_package(){
  zip -r9 UPDATE-AnyKernel2.zip * -x README UPDATE-AnyKernel2.zip
}
make_name(){
  mv UPDATE-AnyKernel2.zip $zip_name
}
copy_out(){
  mv $HOME/AR_Beast/ARB-Anykernel2/$zip_name $HOME/AR_Beast/out/ZukZ2/$zip_name
}
turn_back(){
cd $sourcedir
}
compile
module_stock
delete_zip
build_package
make_name
copy_out
turn_back
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow****************************************************************************"
echo -e "$cyan Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo -e "***************************************************************************$nocol"
