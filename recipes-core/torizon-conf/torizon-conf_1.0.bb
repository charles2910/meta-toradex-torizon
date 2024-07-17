SUMMARY = "Set up configs for Torizon OS"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://docker.sh \
    file://machine.sh \
    file://containers-tags.sh \
"

S = "${WORKDIR}/sources"
UNPACKDIR = "${S}"

PACKAGE_ARCH = "${MACHINE_ARCH}"
EXCLUDE_FROM_WORLD = "1"
INHIBIT_DEFAULT_DEPS = "1"

do_install () {
    install -d ${D}${sysconfdir}/profile.d
    install -m 0755 ${UNPACKDIR}/docker.sh ${D}${sysconfdir}/profile.d/
    install -m 0755 ${UNPACKDIR}/machine.sh ${D}${sysconfdir}/profile.d/
    sed -i "s/@@MACHINE@@/${MACHINE}/g" ${D}${sysconfdir}/profile.d/machine.sh
    install -m 0755 ${UNPACKDIR}/containers-tags.sh ${D}${sysconfdir}/profile.d/
}
