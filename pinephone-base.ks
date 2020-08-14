# This base is a standard Fedora image with phosh (and related software).

repo --name copr_njha_mobile --baseurl https://download.copr.fedorainfracloud.org/results/elxreno/multimc/fedora-33-aarch64/ --install

firstboot --disable
services --enabled=phosh

%include fedora-kickstarts/fedora-arm-base.ks


%packages --excludedocs --instLangs=en --nocore --excludeWeakdeps
-kernel

phosh
phoc
squeekboard
feedbackd
kgx
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
