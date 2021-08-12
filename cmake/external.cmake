# External projects
include(FetchContent)

# TCLAP For argument reader
FetchContent_Declare(
        tclap
        GIT_REPOSITORY https://github.com/mirror/tclap
        GIT_TAG 1.4)

FetchContent_GetProperties(tclap)
if (NOT tclap_POPULATED)
    # Import Only TCLAP Header library (Without the unit tests)
    FetchContent_Populate(tclap)

    add_library(TCLAP INTERFACE)
    target_include_directories(TCLAP INTERFACE "${tclap_SOURCE_DIR}/include/")
    add_subdirectory("${tclap_SOURCE_DIR}/include/tclap" "${tclap_BINARY_DIR}/include/tclap")
endif ()


# YAML-CPP To read/write Yaml configuration files
FetchContent_Declare(
        yaml-cpp
        GIT_REPOSITORY https://github.com/jbeder/yaml-cpp
        GIT_TAG yaml-cpp-0.6.3
)
FetchContent_GetProperties(yaml-cpp)
if (NOT yaml-cpp_POPULATED)

    set(YAML_CPP_BUILD_TESTS OFF)
    set(YAML_CPP_BUILD_TOOLS OFF)
    set(YAML_CPP_BUILD_CONTRIB OFF)
    set(YAML_CPP_INSTALL OFF)
    FetchContent_Populate(yaml-cpp)

    set(YAML_CPP_BUILD_TESTS OFF) # Do not build the tests
    add_subdirectory(${yaml-cpp_SOURCE_DIR} ${yaml-cpp_BINARY_DIR})
endif ()

# Eigen
FetchContent_Declare(
        Eigen3
        GIT_REPOSITORY https://gitlab.com/libeigen/eigen
        GIT_TAG 3.3.7
)
FetchContent_GetProperties(eigen3)
if (NOT eigen3_POPULATED)
    set(BUILD_TESTING OFF)
    FetchContent_Populate(eigen3)
    set(BUILD_TESTING OFF)
    add_subdirectory(${eigen3_SOURCE_DIR} ${eigen3_BINARY_DIR})
endif ()

# Ceres
FetchContent_Declare(
        ceres
        GIT_REPOSITORY https://ceres-solver.googlesource.com/ceres-solver
        GIT_TAG 2.0.0)
if (NOT ceres_POPULATED)
    set(BUILD_TESTING OFF)
    set(PROVIDE_UNINSTALL_TARGET OFF)
    set(BUILD_EXAMPLES OFF)
    FetchContent_Populate(ceres)
    add_subdirectory(${ceres_SOURCE_DIR} ${ceres_BINARY_DIR})
endif ()

# Google Test For Testing
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG release-1.8.0)
FetchContent_MakeAvailable(googletest)
include(GoogleTest)

# Tessil (For Google hashing)
FetchContent_Declare(
        tessil
        GIT_REPOSITORY https://github.com/Tessil/robin-map
        GIT_TAG v0.6.3)

if (NOT tessil_POPULATED)
    set(BUILD_TESTING OFF)
    FetchContent_Populate(tessil)
    add_subdirectory(${tessil_SOURCE_DIR} ${tessil_BINARY_DIR})
endif ()

if (WITH_PYTHON_BINDING)
    # /////////////////////////////////////////////////////////////////////////////////////////////
    # PyBind11
    FetchContent_Declare(
            pybind11 GIT_REPOSITORY https://github.com/pybind/pybind11
            GIT_TAG v2.7.1)

    if (NOT pybind11_POPULATED)
        FetchContent_Populate(pybind11)
        add_subdirectory(${pybind11_SOURCE_DIR} ${pybind11_BINARY_DIR})
    endif ()
endif ()

if (WITH_VIZ3D)

    # VIZ 3D (For Visualization)
    FetchContent_Declare(
            viz3d
            GIT_REPOSITORY git@gitlab.com:pdell/viz3d.git)
    if (NOT viz3d_POPULATED)
        set(BUILD_TESTING OFF)
        FetchContent_Populate(viz3d)
        add_subdirectory(${viz3d_SOURCE_DIR} ${viz3d_BINARY_DIR})
    endif ()
endif (WITH_VIZ3D)