file(GLOB_RECURSE sources CONFIGURE_DEPENDS "*.h" "*.cpp")
target_sources( ${PROJECT_NAME} PRIVATE ${sources} )
