#!/bin/bash
if [ "$#" -eq 2 ]; then
    wget -O kl_combined.txt --user=$1 --password=$2 https://www.kamioka.awa.tohoku.ac.jp/~preSNmon/combined/skklpresn.txt
    wget -O sk_combined.txt --user=$1 --password=$2 https://www-sk.icrr.u-tokyo.ac.jp/~snwatch/preSN/SKKL_combined/skklpresn.txt
else
    wget -O kl_combined.txt https://www.kamioka.awa.tohoku.ac.jp/~preSNmon/combined/skklpresn.txt
    wget -O sk_combined.txt https://www-sk.icrr.u-tokyo.ac.jp/~snwatch/preSN/SKKL_combined/skklpresn.txt
fi
file_sk="sk_combined.txt"
file_kl="kl_combined.txt"
IFS=',' read -r FPR1 time1 status1 < "$file_sk"
IFS=',' read -r FPR2 time2 status2 < "$file_kl"
# Check if number and status are the same
if [[ "$FPR1" == "$FPR2" && "$status1" == "$status2" ]]; then
    # Check if the time difference is within 10 minutes (600 seconds)
    if (( time2 - time1 <= 600 && time1 - time2 <= 600 )); then
        echo "The combined results from Super-Kamiokande and KamLAND match and the time difference between them is within 10 minutes."
    else
        echo "The combined results from Super-Kamiokande and KamLAND match, but the time difference exceeds 10 minutes."
    fi
else
    echo "The combined results from Super-Kamiokande and KamLAND don't match. If it persists, please contact: contact_combinedsystem@lowbg.org "
fi
