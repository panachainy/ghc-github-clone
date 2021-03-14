get_data() {
    echo $(curl -H "Accept: application/vnd.github.v3+json" $1)
}

# https://api.github.com/repos/panachainy/github-auto-release/git/blobs/eb079ffdc682e0868619fda16817bad33afcbd9e
get_data_raw() {
    echo $(curl -H "Accept: application/vnd.github.V3.raw" $1)
}

# url / type / path
directory_process() {
    local current_json_data
    current_json_data=$(get_data "$1")

    if [ "$2" = "tree" ]; then
        types=$(echo $current_json_data | json tree | json -a type)
        paths=$(echo $current_json_data | json tree | json -a path)
        urls=$(echo $current_json_data | json tree | json -a url)

        local current_json_data2
        current_json_data2=$current_json_data

        count=0
        for i in $types; do
            local current_object
            current_object=$(echo $current_json_data2 | json tree | json $count)

            local url
            local type
            local path

            url=$(echo $current_object | json url)
            type=$(echo $current_object | json type)
            path=$(echo $current_object | json path)

            echo "========="
            echo $type
            echo $path
            echo $url
            echo "========="

            # TODO: try recursive
            directory_process() $url $type

            echo "asdioquwidouasioduoiasd"

            count=$(($count + 1))
        done
    elif [ "$2" = "blob" ]; then
        write_file_from_blob_type "$1" "$3"
    fi
}

directory_process $1 "tree"

# Test section ################################################################################################

## example `mockdata=$(getMockData ./mocks/tree_example.json)`
getMockData() {
    asd=$(json -f $1)
    echo $asd
}

# # test_remove_new_line
# test_remove_new_line=$(remove_new_line "testValue
# newLineValue
# ")
# if [ "$test_remove_new_line" = "testValuenewLineValue" ]; then
#     echo "success"
# else
#     echo "fail: $test_remove_new_line"
# fi

# # not use
# # test_write_file_from_blob_type
# blob_mock_data=$(getMockData ./mocks/blob_example.json)
# write_file_from_blob_type "$blob_mock_data" "$(date)test2.txt"

# ## test_directory_process
# tree_mock_data=$(getMockData ./mocks/tree_example.json)
# directory_process $tree_mock_data tree
# # //TODO: do it.
