# WATCH AND COMPILE ALL .coffee FILES
coffee -w -c .

# GET LAST COMMIT WHICH AFFECTED <FILE>
git rev-list -n 1 HEAD <FILE>
