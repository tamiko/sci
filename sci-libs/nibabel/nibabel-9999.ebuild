# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3} )

inherit distutils-r1 git-2

DESCRIPTION="Access a cacophony of neuro-imaging file formats."
HOMEPAGE="http://http://nipy.org/nibabel/"
EGIT_REPO_URI="https://github.com/nipy/nibabel.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test dicom"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/nose-0.11[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

RDEPEND="
	>=dev-python/numpy-1.2[${PYTHON_USEDEP}]
	>=sci-libs/scipy-0.7.0[${PYTHON_USEDEP}]
	dicom? ( 
		sci-libs/pydicom[${PYTHON_USEDEP}]
		virtual/python-imaging[${PYTHON_USEDEP}] )"

python_test() {
	distutils_install_for_testing.py
	cd "${T}/test-${EPYTHON}/$(python_get_sitedir)" || die
	echo "backend: Agg" > matplotlibrc
	MPLCONFIGDIR=. PYTHONPATH=. nosetests-"${EPYTHON}" || die
}