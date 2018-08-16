aux_source_directory(. SRC_FILES)

add_library(JashAdd_static STATIC ${SRC_FILES})
SET_TARGET_PROPERTIES(JashAdd_static 
    PROPERTIES 
        OUTPUT_NAME "JashAdd"
        CLEAN_DIRECT_OUTPUT 1
)

add_library(JashAdd_dynamic SHARED ${SRC_FILES})
SET_TARGET_PROPERTIES(JashAdd_dynamic 
    PROPERTIES 
        OUTPUT_NAME "JashAdd"
        CLEAN_DIRECT_OUTPUT 1
)