FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
    file://0001-dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://daemon.json \
    file://docker.service \
    file://chrome.json \
"

inherit bash-completion

# Prefer docker.service instead of docker.socket as this is a critical service
SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','docker.service','',d)}"

do_install:append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${UNPACKDIR}/daemon.json ${D}${libdir}/docker/

    # Replace default docker.service with the one provided by this recipe
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -m 644 ${UNPACKDIR}/docker.service ${D}/${systemd_unitdir}/system
    fi

    if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/docker/seccomp
        install -m 0644 ${UNPACKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
    fi

    COMPLETION_DIR=${D}${datadir}/bash-completion/completions
    install -d ${COMPLETION_DIR}
    install -m 0644 ${S}/cli/contrib/completion/bash/docker ${COMPLETION_DIR}
}

FILES:${PN} += "${libdir}/docker"

