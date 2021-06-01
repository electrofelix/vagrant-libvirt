BEGIN {
    printf "[["
    previous=""
    if (chunk_size == "") {
	chunk_size=4
    } else {
	chunk_size = chunk_size + 0
    }
    count = 0
}
match($0, /@test "(.*)" \{/, arr) {
    if ( previous != "" ) {
	printf "%s",previous
    }
    if (count >= chunk_size) {
	printf "],["
	count = 0
    } else {
	if (previous != "" ) {
	    printf ", "
	}
    }
    count++
    previous = sprintf("\"%s\"", arr[1])
}
END {
    printf "%s",previous
    print "]]"
}
