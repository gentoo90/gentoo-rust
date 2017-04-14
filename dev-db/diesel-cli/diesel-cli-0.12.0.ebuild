# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

CRATES="
aho-corasick-0.5.3
ansi_term-0.9.0
atty-0.2.2
bitflags-0.8.2
byteorder-1.0.0
cargo_metadata-0.1.2
chrono-0.3.0
clap-2.23.2
clippy-0.0.118
clippy_lints-0.0.118
diesel-0.12.0
diesel_cli-0.12.0
diesel_infer_schema-0.12.0
dotenv-0.8.0
dtoa-0.4.1
idna-0.1.1
itoa-0.3.1
kernel32-sys-0.2.2
libc-0.2.21
libsqlite3-sys-0.7.1
matches-0.1.4
memchr-0.1.11
mysqlclient-sys-0.2.2
num-0.1.37
num-integer-0.1.34
num-iter-0.1.33
num-traits-0.1.37
pkg-config-0.3.9
pq-sys-0.4.3
quine-mc_cluskey-0.2.4
quote-0.3.15
rand-0.3.15
redox_syscall-0.1.17
regex-0.1.80
regex-syntax-0.3.9
regex-syntax-0.4.0
rustc-serialize-0.3.23
semver-0.6.0
semver-parser-0.7.0
serde-0.9.13
serde_codegen_internals-0.14.2
serde_derive-0.9.13
serde_json-0.9.10
strsim-0.6.0
syn-0.11.10
synom-0.11.3
tempdir-0.3.5
term_size-0.3.0
thread-id-2.0.0
thread_local-0.2.7
time-0.1.36
toml-0.2.1
unicode-bidi-0.2.5
unicode-normalization-0.1.4
unicode-segmentation-1.1.0
unicode-width-0.1.4
unicode-xid-0.0.4
url-1.4.0
utf8-ranges-0.1.3
vec_map-0.7.0
winapi-0.2.8
winapi-build-0.1.1
"

inherit cargo bash-completion-r1

DESCRIPTION="Provides the CLI for the Diesel crate"
HOMEPAGE="http://diesel.rs"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
DOCS=( README.md )

src_prepare() {
	default_src_prepare
	rmdir "${S}"
	ln -sf "${WORKDIR}/cargo_home/gentoo/diesel_cli-${PV}" "${S}"
}

src_compile() {
	cargo_src_compile
	"${S}"/target/release/diesel bash-completion > "${S}"/diesel.bashcomp
}

src_install() {
	cargo_src_install
	einstalldocs
	newbashcomp "${S}"/diesel.bashcomp diesel
}
