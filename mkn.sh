#!/usr/bin/env bash
set -exu
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

(
    cd $CWD
    mkn -C mkn.base.yaml
    MKN_REPO=$(mkn -G MKN_REPO -C mkn.base.yaml)
    rm -rf build && mkdir build
    (
        cd build
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
                   -DEigen3_DIR="${MKN_REPO}/math/eigen/master/share/eigen3/cmake" \
                   -DBoost_DIR="${MKN_REPO}/org/boost/master/lib/cmake/Boost-1.86.0" \
                   -DFLANN_ROOT="${MKN_REPO}/math/flann/master" \
                   -DCMAKE_INSTALL_PREFIX=$CWD ../p
        ninja && ninja install
    )
    rm -rf build
)
