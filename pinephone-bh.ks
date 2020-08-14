# This base is a standard Fedora image with phosh (and related software).

%include pinephone-base.ks

%packages --excludedocs --instLangs=en --nocore --excludeWeakdeps
megi-kernel-bh
%end

%post --erroronfail --log=/root/anaconda-post.log
# remove some extraneous files
rm -rfv /var/cache/* /var/log/* /tmp/*
%end

%post --nochroot --erroronfail --log=/mnt/sysimage/root/anaconda-post-nochroot.log
set -eux

KEEPLANG=en_US
for dir in locale i18n; do
    find /mnt/sysimage/usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rfv {} +
done
%end
