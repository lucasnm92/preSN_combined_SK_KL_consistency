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
        rm -f $file_sk
        mv $file_kl preSN_combinedSKKL.txt
        exit 1

    else
        echo "The combined results from Super-Kamiokande and KamLAND match, but the time difference exceeds 10 minutes."
        if [ $time1 -gt $time2  ]; then
            rm -f $file_kl
            mv $file_sk preSN_combinedSKKL.txt
            exit 1
        else
            rm -f $file_sk
            mv $file_kl preSN_combinedSKKL.txt
            exit 1
        fi                  
    fi

elif [[ "$status1" == "3" || $(( $(date +%s) - time2 )) -gt 900 ]]; then
    echo "Results are from Super-Kamiokande only (KamLAND offline)."
    rm -f $file_kl
    mv $file_sk preSN_combinedSKKL.txt
    exit 2

elif [[ "$status2" == "2" || $(( $(date +%s) - time1 )) -gt 900 ]]; then
    echo "Results are from KamLAND only (Super-Kamiokande offline)."
    rm -f $file_sk
    mv $file_kl preSN_combinedSKKL.txt
    exit 3

else
    echo "The combined results from Super-Kamiokande and KamLAND don't match. If it persists, please contact: contact_combinedsystem@lowbg.org "
    rm -f $file_sk $file_kl

    exit 0
fi
