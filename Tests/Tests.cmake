project(openZiaTests)

# Retreive where is located 'Tests.cmake'
get_filename_component(OpenZiaSourcesTestsDir ${CMAKE_CURRENT_LIST_FILE} PATH)

message("Compiling criterion unit-tests for openZia project")

set(TestsSources
    ${OpenZiaSourcesTestsDir}/tests_BaseHTTP.cpp
    ${OpenZiaSourcesTestsDir}/tests_HeaderHTTP.cpp
    ${OpenZiaSourcesTestsDir}/tests_ResponseHTTP.cpp
    ${OpenZiaSourcesTestsDir}/tests_RequestHTTP.cpp
    ${OpenZiaSourcesTestsDir}/tests_Context.cpp
    ${OpenZiaSourcesTestsDir}/tests_IModule.cpp
    ${OpenZiaSourcesTestsDir}/tests_APipeline.cpp
)

add_executable(${PROJECT_NAME} ${TestsSources} ${OpenZiaSources})
target_link_libraries(${PROJECT_NAME} criterion gcov)
target_include_directories(${PROJECT_NAME} PRIVATE ${OpenZiaIncludes})
target_compile_options(${PROJECT_NAME} PUBLIC --coverage)

add_custom_command(
    TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}
    COMMAND gcovr ARGS -r ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}
)