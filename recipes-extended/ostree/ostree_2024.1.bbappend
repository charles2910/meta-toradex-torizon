FILESEXTRAPATHS:prepend := "${THISDIR}/${P}:"

# Beware that the following patches are a bit special:
#
# - 0001-mount-Allow-building-when-macro-MOUNT_ATTR_IDMAP-is-.patch
# - 0002-mount-Allow-building-when-macro-LOOP_CONFIGURE-is-no.patch
#
# because they are applied to the "composefs" submodule. If they need to be
# updated, consider using the switches --src-prefix and --dst-prefix to
# "git format-patch".
#
SRC_URI:append = " \
    file://0001-update-default-grub-cfg-header.patch \
    file://0002-Add-support-for-the-fdtfile-variable-in-uEnv.txt.patch \
    file://0003-ostree-fetcher-curl-set-max-parallel-connections.patch \
    file://0001-Expose-MOUNT_ATTR_IDMAP-detection-result-to-C-code.patch \
    file://0001-mount-Allow-building-when-macro-MOUNT_ATTR_IDMAP-is-.patch \
    file://0002-mount-Allow-building-when-macro-LOOP_CONFIGURE-is-no.patch \
"

require ostree-torizon.inc
