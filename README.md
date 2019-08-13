# HP RAID reporter

This tool triggers daily and runs a check on your RAID array.

If the report differs from the previous report, it will send an email, using Amazon SES.

## Installation

Just fill out the variables in `amazonsecreds.sh` and run `install.sh`.

## Configuration

```
AMAZONSES_HOST=""
AMAZONSES_USERNAME=""
AMAZONSES_PASSWORD=""
AMAZONSES_EMAIL_FROM=""
AMAZONSES_EMAIL_TO
AMAZONSES_URL="email-smtp.eu-west-1.amazonaws.com:587"
```
