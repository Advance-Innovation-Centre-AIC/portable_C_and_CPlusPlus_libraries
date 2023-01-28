#!/bin/bash

# Define the libraries to download and build
libraries=("https://github.com/septag/sx.git"
           "https://github.com/fmtlib/fmt.git" 
           "https://github.com/emweb/wt.git" 
           "https://github.com/boostorg/boost.git" 
           "https://github.com/sqlite/sqlite.git"                                  
           "https://github.com/gabime/spdlog.git"
           "https://github.com/odygrd/quill.git"
           "https://github.com/PointCloudLibrary/pcl.git"
           "https://github.com/pocoproject/poco.git"
           "https://github.com/3cky/mbusd.git"
           "https://github.com/mirror/ncurses.git"
           "https://github.com/jolibrain/deepdetect.git"
           "https://github.com/curl/curl.git"
           "https://github.com/google/googletest.git")

selected_libraries=()

# Function to display a list of libraries
display_libraries() {
    local _libraries=("${!1}")
    count=1
    for library in "${_libraries[@]}"; do
        echo "$count. $library"
        count=$((count+1))
    done
}

# Function to install selected libraries
download_libraries() {
    for library in "${selected_libraries[@]}"; do
        tput setaf 3
        echo -e "\033[1mInstalling ${library}...\033[0m"
        #LIBNAME=$(basename ${library} .git)
        git clone --recursive ${library}
        if [ $? -ne 0 ]; then
            echo -e "\033[0;31m Error: Failed to clone $library. Please check your internet connection and try again. \033[0m"
            exit 1
        fi
        # Add any additional installation commands here
        echo -e "\033[0;32m Installation complete for ${library}!"
    done
}

#----------------------------------------
# C/C++ Library Installer
#
#
# use:
# install_third_library --boost --curl --deepdetect --fmt --ncurses --pcl --poco 
# --quill --spdlog --sqlite --sx --wt
# --all

# For bold text, you can use the escape code 
#       "\033[1m" before the text and "\033[0m" after the text.
# To make text italic in a shell script, 
# you can use the ANSI escape code "\033[3m" before the text and "\033[0m" after the text.
#
# For color text, you can use the escape code 
#       "\033[x;y;zm" where x is the text attribute (e.g. 0 for default, 1 for bold), 
#              y is the text color (e.g. 31 for red, 32 for green, 33 for yellow, etc.) 
#              z is the background color (e.g. 41 for red, 42 for green, 43 for yellow, etc.).
#
#   Example:
#       echo -e "\033[1;31mHello World\033[0m"
#       printf "\033[1;31mHello World\033[0m\n"


help()
{
  tput setaf 2
  echo -e "\033[1mUsage:\033[0m"
  echo -e "\033[3m To install all libraries by following command... \033[0m"
  echo -e "\033[0;33m install_third_library -all \033[0m"
  echo "---------------------------"
  echo -e "\033[3m To install selected libraries by following command... \033[0m"
  echo -e "\033[0;33m install_third_library --boost --curl --deepdetect --mbusd --sqlite --fmt  \033[0m" 
  echo "    "
echo "---------------------------"
  echo -e "\033[3m To install selected libraries by following command... \033[0m"
  echo -e "\033[0;33m install_third_library --ncurses --pcl --poco --quill --spdlog --sx --wt --googletest  \033[0m" 
  echo "    "
  echo "---------------------------"
  echo -e "\033[3m To install selected libraries by following command... \033[0m"
  echo -e "\033[0;33m install_third_library --boost --curl --deepdetect --mbusd --sqlite --fmt  \033[0m" 
  echo -e "\033[0;33m                       --ncurses --pcl --poco --quill --spdlog --sx --wt --googletest \033[0m"
  echo "    "

  tput setaf 2
  echo -e "\033[1mDescription:\033[0m"
  echo -e "\033[1;32m 1. boost \033[0m: A Peer-reviewed portable C++ source libraries"
  echo -e "\033[1;32m 2. curl \033[0m: A Command line tool and library for transferring data with URL syntax, supporting DICT, FILE, FTP, FTPS, GOPHER, GOPHERS, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, MQTT, POP3, POP3S, RTMP, RTMPS, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET, TFTP, WS and WSS"
  echo -e "\033[1;32m 3. deepdetect \033[0m: A Deep Learning API and Server in C++14 support for Caffe, PyTorch,TensorRT, Dlib, NCNN, Tensorflow, XGBoost and TSNE"
  echo -e "\033[1;32m 4. fmt \033[0m: A modern formatting library"
  echo -e "\033[1;32m 5. ncurses \033[0m: A text-based user interfaces (TUI) in a terminal-independent manner. It is a toolkit for developing "GUI-like" application software that runs under a terminal emulator"
  echo -e "\033[1;32m 6. pcl \033[0m: The Point Cloud Library (PCL) is a standalone, large scale, open project for 2D/3D image and point cloud processing"
  echo -e "\033[1;32m 7. poco \033[0m: The POCO C++ Libraries are powerful cross-platform C++ libraries for building network- and internet-based applications that run on desktop, server, mobile, IoT, and embedded systems"
  echo -e "\033[1;32m 8. quill \033[0m: A cross-platform asychronous low latency logging library based on C++14/C++17 "
  echo -e "\033[1;32m 9. spdlog \033[0m: A Very fast, header-only/compiled, C++ logging library "
  echo -e "\033[1;32m 10. sqlite \033[0m: A C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine"
  echo -e "\033[1;32m 11. sx \033[0m: A minimal and performant base C library, runs on different platforms and OSes. Designed to help C developers"
  echo -e "\033[1;32m 12. wt \033[0m: A web GUI library in modern C++. Quickly develop highly interactive web UIs with widgets, without having to write a single line of JavaScript "
  echo -e "\033[1;32m 13. mbusd \033[0m: An open-source Modbus TCP to Modbus RTU (RS-232/485) gateway. It presents a network of RTU slaves as single TCP slave "
  echo -e "\033[1;32m 14. googletest \033[0m: A Google Testing and Mocking Framework "
}

if [[ $# -lt 1 ]]; then
  tput setaf 1
  printf "Error: At least one argument is required.\n\n"
  help
  exit 1
fi

# Parse command line arguments
for arg in "$@"
do
  case $arg in
    -h|--help)
        help
        exit 1
        ;;
    --all)
        selected_libraries=("${libraries[@]}")
        shift
        ;;
    --sx )
      echo "SX selected"
      selected_libraries+=("${libraries[0]}")
      shift
      ;;
    --fmt )
      echo "Fmt selected"
      selected_libraries+=("${libraries[1]}")
      shift
      ;;
    --wt )
      echo "Web Toolkit selected"
      selected_libraries+=("${libraries[2]}")
      shift
      ;;
    --boost )
      echo "Boost selected"
      selected_libraries+=("${libraries[3]}")
      shift
      ;;
    --sqlite )
      echo "Sqlite3 selected"
      selected_libraries+=("${libraries[4]}")
      shift
      ;;
    --spdlog )
      echo "SPDLOG selected"
      selected_libraries+=("${libraries[5]}")
      shift
      ;;
    --quill )
      echo "QUILL selected"
      selected_libraries+=("${libraries[6]}")
      shift
      ;;
    --pcl )
      echo "Point Cloud selected"
      selected_libraries+=("${libraries[7]}")
      shift
      ;;
    --poco )
      echo "POCO selected"
      selected_libraries+=("${libraries[8]}")
      shift
      ;;
    --mbusd )
      echo "Modbus Deamon Gateway selected"
      selected_libraries+=("${libraries[9]}")
      shift
      ;;
    --ncurses )
      echo "NCurses selected"
      selected_libraries+=("${libraries[10]}")
      shift
      ;;
    --deepdetect )
      echo "DeepDetect selected"
      selected_libraries+=("${libraries[11]}")
      shift
      ;;
    --curl )
      echo "CURL selected"
      selected_libraries+=("${libraries[12]}")
      shift
      ;;
    --googletest )
      echo "Google Test selected"
      selected_libraries+=("${libraries[13]}")
      shift
      ;;
    *)
      echo "Invalid option: $key"
      exit 1
      ;;
  esac
done

# Function to install a list of libraries
install_libraries() {

# Define the output directory for headers and libraries
OUTPUT_DIR="output"
DIR_STATIC="static_libs"
DIR_DYNAMIC="dynamic_libs"

# Create the output directories
mkdir -p $OUTPUT_DIR/$DIR_STATIC
mkdir -p $OUTPUT_DIR/$DIR_DYNAMIC

OUTPUT_DIR_STATIC=$OUTPUT_DIR/$DIR_STATIC
OUTPUT_DIR_DYNAMIC=$OUTPUT_DIR/$DIR_DYNAMIC

# Determine the platform
PLATFORM=$(uname)

if [ "$PLATFORM" == "Windows" ]; then
    # Build and install for Windows

    for LIB in ${selected_libraries[@]}; do
        # Get library name from URL
        LIBNAME=$(basename $LIB .git)
        BUILD_DIR="build_$LIBNAME"
        mkdir -p $BUILD_DIR

        echo "Compiling ... $LIBNAME "

        # Build and install as a static library
        cd $BUILD_DIR
        cmake -G "Visual Studio 16 2019" -DBUILD_SHARED_LIBS=OFF ../$LIBNAME
        msbuild.exe $LIBNAME.sln /p:Configuration=Release
        msbuild.exe $LIBNAME.sln /p:Configuration=Release /target:INSTALL /p:TargetDir=../$OUTPUT_DIR_STATIC

        # Build and install as a dynamic library
        cmake -G "Visual Studio 16 2019" -DBUILD_SHARED_LIBS=ON ../$LIBNAME
        msbuild.exe $LIBNAME.sln /p:Configuration=Release
        msbuild.exe $LIBNAME.sln /p:Configuration=Release /target:INSTALL /p:TargetDir=../$OUTPUT_DIR_DYNAMIC
        cd ../
    done

elif [ "$PLATFORM" == "Darwin" ]; then
    # Build and install for MacOS

    for LIB in ${selected_libraries[@]}; do
        # Get library name from URL
        LIBNAME=$(basename $LIB .git)
        BUILD_DIR="build_$LIBNAME"
        mkdir -p $BUILD_DIR

        echo -e "\033[1;32mCompiling ... $LIBNAME\033[0m\n"

        cd $BUILD_DIR
        # Build and install as a static library
        cmake -S ../$LIBNAME -DBUILD_SHARED_LIBS=OFF
        make -j $(sysctl -n hw.ncpu)
        make install DESTDIR=../$OUTPUT_DIR_STATIC

        # Build and install as a dynamic library
        cmake -S ../$LIBNAME -DBUILD_SHARED_LIBS=ON
        make -j $(sysctl -n hw.ncpu)
        make install DESTDIR=../$OUTPUT_DIR_DYNAMIC
        cd ../
    done

elif [ "$PLATFORM" == "Linux" ]; then
    # Build and install for Linux

    for LIB in ${selected_libraries[@]}; do
        # Get library name from URL
        LIBNAME=$(basename $LIB .git)
        BUILD_DIR="build_$LIBNAME"
        mkdir -p $BUILD_DIR

        echo -e "\033[1;32mCompiling ... $LIBNAME\033[0m\n"

        cd $BUILD_DIR
        # Build and install as a static library
        cmake -S ../$LIBNAME -DBUILD_SHARED_LIBS=OFF
        make -j $(nproc)
        make install DESTDIR=../$OUTPUT_DIR_STATIC

        # Build and install as a dynamic library
        cmake -S ../$LIBNAME -DBUILD_SHARED_LIBS=ON
        make -j $(nproc)
        make install DESTDIR=../$OUTPUT_DIR_DYNAMIC
        cd ../
    done

elif [ "$PLATFORM" == "raspberrypi" ]; then
    # Build and install for Raspberry Pi

    for LIB in ${selected_libraries[@]}; do
        # Get library name from URL
        LIBNAME=$(basename $LIB .git)
        BUILD_DIR="build_$LIBNAME"
        mkdir -p $BUILD_DIR

        echo -e "\033[1;32mCompiling ... $LIBNAME\033[0m\n"

        cd $BUILD_DIR
        # Build and install as a static library
        cmake -S ../$LIBNAME -DBUILD_SHARED_LIBS=OFF
        make -j $(nproc)
        make install DESTDIR=../$OUTPUT_DIR_STATIC

        # Build and install as a dynamic library
        cmake -S ../$LIBNAME -DBUILD_SHARED_LIBS=ON
        make -j $(nproc)
        make install DESTDIR=../$OUTPUT_DIR_DYNAMIC
        cd ../
    done

else
    echo -e "\033[1;31mUnsupported platform\033[0m\n"
    exit 1
fi

}

############################## Main script logic ############################
# Print selectedd liibraries
#display_libraries selected_libraries[@]

download_libraries

install_libraries

