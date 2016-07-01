From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.7-rc5
Date: Fri, 1 Jul 2016 17:36:24 +0200
Message-ID: <20160701153611.GA28903@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4233885177304956091=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4233885177304956091==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a4c34ff1c029e90e7d5f8dd8d29b0a93b31c3cb2:

  iommu/vt-d: Enable QI on all IOMMUs before setting root entry (2016-06-17 11:29:48 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.7-rc5

for you to fetch changes up to 6082ee72e9d89e80a664418be06f47d728243e85:

  iommu/amd: Initialize devid variable before using it (2016-06-27 13:24:46 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.7-rc5

Three fixes:

	* Fix use of smp_processor_id() in preemptible code in the IOVA
	  allocation code. This got introduced with the scalability
	  improvements in this release cycle.

	* A VT-d fix for out-of-bounds access of the iommu->domains
	  array. The bug showed during suspend/resume.

	* AMD IOMMU fix to print the correct device id in the ACPI
	  parsing code.

----------------------------------------------------------------
Chris Wilson (1):
      iommu/iova: Disable preemption around use of this_cpu_ptr()

Jan Niehusmann (1):
      iommu/vt-d: Fix overflow of iommu->domains array

Nicolas Iooss (1):
      iommu/amd: Initialize devid variable before using it

 drivers/iommu/amd_iommu_init.c | 2 +-
 drivers/iommu/intel-iommu.c    | 2 +-
 drivers/iommu/iova.c           | 8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXdo3rAAoJECvwRC2XARrjfTwP/2jiR0l/PqMYSAGKp8sGLw1R
ajt1YJSW7hjnt2xeGlZjpFDNt43WmOOdyLsJ0LIGClY0MIvZg0bBYJdR80zzidfA
o5RWdlFKtzMkB/yj2ypxlB4olDd+DnPm0AmySlmpsUxl0fsYRI375IFPYdkFEr3l
eB06YJZUK6rSAusv+VjoxktWrgAfPGUP0I26oAnfS6dK9+1Sj5Wi6fT1XgMEMb4N
gyBFTOjOKZIVaq6I25ItV9KUdl/4ZML5TLFgM1iiHOIM9OczygSWOWQM+qDTJLCf
ObE+CmOfCCDhUg+Jr3Hq/efrGUBaHzFYEJ1FeuwuZGbrtVIrNZQHJucz8QKXJ8fM
vV5AbCeDRKrtumapQINytErw6Gb1cM6wKU4+8GsMJrdO+6jtJrbDWY0JYkUdUseJ
PphvXmUQioLC9vJPoFEGp7NRBwNOLNT0RQMSn8tO+2D3jgs5nS+XSKEqvTNCSpaQ
8ccPzinhvRB5WUwOb3WCV9wdyvnmxxXEjKNpSGAAjUcNQ8Vbcw7K89HmwmZgFjoP
4yKqQ/Hj1c8NIMgZuYX1i3nB8Pit+nvUp/PYbN4LqwqXNviCYLay1fJN+lLe95kn
vuPtZhFTbDymiEEg0moqN8FiuWl+1BMxlYi55UM07Z5jukgnsrumtfNjDhud63r2
mqA8f5JdFeqHRut3tjCN
=gImg
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--===============4233885177304956091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4233885177304956091==--
