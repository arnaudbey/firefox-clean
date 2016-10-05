FILES=~/.mozilla/firefox/*/places.sqlite

while [ $# -gt 0 ]
do
	KEYWORD=$1
	for f in $FILES
	do
		echo $(sqlite3 $f "select count(*) FROM moz_places WHERE moz_places.url LIKE '%$KEYWORD%' OR moz_places.title LIKE '%$KEYWORD%';") suppression pour $KEYWORD
	    sqlite3 $f "DELETE FROM moz_places WHERE moz_places.url LIKE '%$KEYWORD%' OR moz_places.title LIKE '%$KEYWORD%';"
	done
	shift
done