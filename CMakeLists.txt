cmake_minimum_required(VERSION 3.16)

project(Notepad VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql Widgets)

qt_standard_project_setup(REQUIRES 6.5)
file(COPY Main.qml LoginPage.qml NotepadPage.qml DESTINATION ${CMAKE_BINARY_DIR})

qt_add_executable(appNotepad
    main.cpp
)

qt_add_qml_module(appNotepad
    URI Notepad
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES DatabaseManager.h
        SOURCES DatabaseManager.cpp
        SOURCES FileManager.h
        SOURCES FileManager.cpp
        QML_FILES LoginPage.qml
        QML_FILES NotepadPage.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appNotepad PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appNotepad
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appNotepad
    PRIVATE Qt6::Quick Qt6::Sql Qt6::Widgets
)

include(GNUInstallDirs)
install(TARGETS appNotepad
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
