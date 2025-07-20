# Dummy systemd setup

here I have create a basic service for systemd using this <a href="https://documentation.suse.com/smart/systems-management/html/systemd-setting-up-service/index.html">guide</a>. this doc is quite useful to understand what is systemd doing and what are units.

### How to use it these scripts.

```bash
chmod +x ./dummy.sh
sudo mv ./dummy.sh /usr/local/bin
sudo mv ./dummy.service /etc/systemd/system/
sudo systemctl start dummy.service
systemctl is-failed dummy.service
# sudo systemctl enable dummy.service
# sudo systemctl status dummy.service
# sudo systemctl list-units -t service --all
# sudo systemctl stop dummy.service
# sudo systemctl disable dummy.service
# journalctl --catalog --pager-end --unit=dummy
```
