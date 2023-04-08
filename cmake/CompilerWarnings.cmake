# SPDX-License-Identifier: Unlicense
# by Andy Maloney <asmaloney@gmail.com>

string( TOUPPER ${PROJECT_NAME} PROJECT_NAME_UPPERCASE )

if ( NOT MSVC )
    option( ${PROJECT_NAME_UPPERCASE}_WARN_EVERYTHING "Turn on all warnings (not recommended - used for lib development)" OFF )
endif()

option( ${PROJECT_NAME_UPPERCASE}_WARNING_AS_ERROR "Treat warnings as errors" ON )

# Add warnings based on compiler
# Set some helper variables for readability
set( compiler_is_clang "$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>" )
set( compiler_is_gnu "$<CXX_COMPILER_ID:GNU>" )
set( compiler_is_msvc "$<CXX_COMPILER_ID:MSVC>" )

target_compile_options( ${PROJECT_NAME}
    PRIVATE
        # MSVC only
        $<${compiler_is_msvc}:
            /W4

            /w14263 # 'function': member function does not override any base class virtual member function
            /w14296 # 'operator': expression is always 'boolean_value'
            /w14311 # 'variable': pointer truncation from 'type1' to 'type2'
            /w14545 # expression before comma evaluates to a function which is missing an argument list
            /w14546 # function call before comma missing argument list
            /w14547 # 'operator': operator before comma has no effect; expected operator with side-effect
            /w14549 # 'operator': operator before comma has no effect; did you intend 'operator'?
            /w14619 # pragma warning: there is no warning number 'number'
            /w14640 # thread un-safe static member initialization
            /w14905 # wide string literal cast to 'LPSTR'
            /w14906 # string literal cast to 'LPWSTR'

            # Disable warnings which we don't plan to fix.
            /wd4100  # C4100 (unreferenced formal parameter): Doesn't play nice with polymorphism.
            /wd4127  # C4127 (conditional expression is constant)
            /wd4201  # C4201 (non-standard nameless struct/union): Only relevant for C89.
            /wd4244  # C4244 C4245 C4267 (narrowing conversions): Unavoidable at this scale.
            /wd4245  # C4245 (signed/unsigned mismatch)
            /wd4267  # C4267 (conversion from 'size_t' to 'type', possible loss of data)
            /wd4305  # C4305 (truncation): double to float or real_t, too hard to avoid.
            /wd4514  # C4514 (unreferenced inline function has been removed)
            /wd4714  # C4714 (function marked as __forceinline not inlined)
            /wd4820  # C4820 (padding added after construct)
        >

        # Clang and GNU
        $<$<OR:${compiler_is_clang},${compiler_is_gnu}>:
            -Wall
            -Wcast-align
            -Wctor-dtor-privacy
            -Wextra
            -Wformat=2
            -Wnon-virtual-dtor
            -Wnull-dereference
            -Woverloaded-virtual
            -Wpedantic
            -Wshadow
            -Wunused
            -Wwrite-strings

            # Disable warnings which bleed through from godot-cpp's macros.
            -Wno-unused-parameter
        >

        # Clang only
        $<${compiler_is_clang}:
            -Wdocumentation
            -Wimplicit-fallthrough
        >

        # GNU only
        $<${compiler_is_gnu}:
            -Walloc-zero
            -Wduplicated-branches
            -Wduplicated-cond
            -Wlogical-op
        >
)

# Turn on (almost) all warnings on Clang, Apple Clang, and GNU.
# Useful for internal development, but too noisy for general development.
function( set_warn_everything )
    message( STATUS "[${PROJECT_NAME}] Turning on (almost) all warnings")

    target_compile_options( ${PROJECT_NAME}
        PRIVATE
            # Clang and GNU
            $<$<OR:${compiler_is_clang},${compiler_is_gnu}>:
                -Weverything
                -Wno-c++98-compat
                -Wno-c++98-compat-pedantic
                -Wno-padded
            >
    )
endfunction()

if ( NOT MSVC AND ${PROJECT_NAME_UPPERCASE}_WARN_EVERYTHING )
    set_warn_everything()
endif()

# Treat warnings as errors
function( set_warning_as_error )
    message( STATUS "[${PROJECT_NAME}] Treating warnings as errors")

    if ( CMAKE_VERSION VERSION_GREATER_EQUAL "3.24" )
        set_target_properties( ${PROJECT_NAME}
            PROPERTIES
                COMPILE_WARNING_AS_ERROR ON
        )
    else()
        target_compile_options( ${PROJECT_NAME}
            PRIVATE
            $<${compiler_is_msvc}:/WX>
            $<$<OR:${compiler_is_clang},${compiler_is_gnu}>:-Werror>
        )
    endif()
endfunction()

if ( ${PROJECT_NAME_UPPERCASE}_WARNING_AS_ERROR )
    set_warning_as_error()
endif()
