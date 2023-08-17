# Combined Super-Kamiokande and KamLAND pre-supernova alarm - check consistency
For any questions, please contact: contact_combinedsystem@lowbg.org

check_consistency.sh:
Please it to check the consistency between the combined results from Super-Kamiokande and KamLAND.
Use the results if the False Alarm Rate is the same and if the time difference between them is within 10 minutes.

To use it:
chmod +x check_consistency.sh

If your access method is the IP address authentication:
./check_consistency.sh

If your access method is User name and password authentication:
./check_consistency.sh your_username your_password

The consistency check script automatically downloads results from both Super-Kamiokande and KamLAND servers and produces a single file named "preSN_combinedSKKL.txt"
The script will verify the consistency and currency of the results and will yield the same status codes as the combined alert system.

https://www.lowbg.org/presnalarm/
