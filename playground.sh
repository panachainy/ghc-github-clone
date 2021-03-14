get_data_raw() {
    echo $(curl -H "Accept: application/vnd.github.v3.raw+json" https://api.github.com/repos/panachainy/github-auto-release/git/blobs/eb079ffdc682e0868619fda16817bad33afcbd9e)
}
echo $get_data_raw
