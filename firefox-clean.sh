HISTORYFILES=~/.mozilla/firefox/*/places.sqlite

echo "SUPPRESSION ENTREES HISTORIQUE."
while [ $# -gt 0 ]
do
	KEYWORD=$1
	CRITERIA="FROM moz_places WHERE (moz_places.url LIKE '%$KEYWORD%' OR moz_places.title LIKE '%$KEYWORD%') AND NOT EXISTS (SELECT * FROM moz_bookmarks WHERE moz_bookmarks.fk = moz_places.id)"
	for f in $HISTORYFILES
	do
		echo $(sqlite3 $f "SELECT COUNT(id) $CRITERIA") "> $KEYWORD "
	    sqlite3 $f "DELETE $CRITERIA"
	done
	shift
done
echo "SUPPRESSION ENTREES HISTORIQUE OK."

echo "\nOPTI SQLITE"
ALLFILES=~/.mozilla/firefox/*/*.sqlite
for f in $ALLFILES
do
	sqlite3 $f 'VACUUM;'
done
echo "OPTI SQLITE OK."
