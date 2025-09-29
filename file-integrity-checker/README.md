# File Integrity Checker

here I have developed a simple script to check integrity of given log file or logs directory.

### How does it work?

here we have 3 options named:

- init) initializes the base of hashes.
- check) verifies if logs has been tampered with.
- update) updates hashes of this file.

at the heart of this script we use **sha256sum** which generates hash and also verifies if hashes for given files are correct.
