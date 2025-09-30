while true
do
    sleep 10
    for f in /tmp/en/*.html
    do
	nice -n 19 gzip -9 $f
	echo "$f compressed"
    done
    for f in /tmp/fr/*.html
    do
	nice -n 19 gzip -9 $f
	echo "$f compressed"
    done
done
