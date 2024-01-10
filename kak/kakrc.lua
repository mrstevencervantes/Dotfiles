# Defining a function to save a file
function save_file()
    kak.execute("write")
    local filename = kak.eval("buffer_name")
    kak.execute("echo 'File saved: " .. filename .. "'")
end

# Bind the save_file function to c-s in all modes
kak.map({"normal","visual","insert"}, "<c-s>", ": lua save_file()<ret>", { silent = true })
