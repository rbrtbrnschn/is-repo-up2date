# Is Repo Up2Date
Bash script checking if current github repository is up to date.

## Usage
*This script uses status codes for verification*

For example:
```bash
up2date.sh
STATUS_CODE="$?"

if [ "$STATUS_CODE" -eq 0 ]; then
	: # is up to date, do nothing
else
	: # not up to date, do somehting (ie. update, pull, fetch)
fi

```

<hr/> 

> This project was conceived to 'Sweet Creature by Harry Styles'
