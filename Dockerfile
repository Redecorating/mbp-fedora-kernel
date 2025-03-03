FROM fedora:33

ARG RPMBUILD_PATH=/root/rpmbuild
ARG FEDORA_KERNEL_VERSION=5.14.14-300.fc35      # https://bodhi.fedoraproject.org/updates/?search=&packages=kernel&releases=F35

RUN dnf install -y fedpkg fedora-packager rpmdevtools ncurses-devel pesign git libkcapi libkcapi-devel libkcapi-static libkcapi-tools zip curl dwarves libbpf \
    && rpmdev-setuptree \
    && cd ${RPMBUILD_PATH}/SOURCES \
    && koji download-build --arch=src kernel-${FEDORA_KERNEL_VERSION} \
    && rpm -Uvh kernel-${FEDORA_KERNEL_VERSION}.src.rpm \
    && cd ${RPMBUILD_PATH}/SPECS \
    && dnf -y builddep kernel.spec
