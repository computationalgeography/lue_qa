cmake_minimum_required(
    VERSION 3.20)

project(LUE_QA
    LANGUAGES NONE)

set(${PROJECT_NAME}_ORGANISATION_NAME "Computational Geography")
set(${PROJECT_NAME}_COPYRIGHT "2022-now Kor de Jong")
set(${PROJECT_NAME}_PROJECT_NAME "${PROJECT_NAME}")
set(${PROJECT_NAME}_HOMEPAGE "https://www.computationalgeography.org")
set(${PROJECT_NAME}_EMAIL "https://info@computationalgeography.org")

list(APPEND CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_LIST_DIR}/environment/cmake)

include(${PROJECT_NAME})

add_subdirectory(documentation)
add_subdirectory(source)
