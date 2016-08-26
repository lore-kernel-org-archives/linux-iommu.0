From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.8-rc3
Date: Fri, 26 Aug 2016 17:33:27 +0200
Message-ID: <20160826153318.GA8351@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9181132423086379007=="
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


--===============9181132423086379007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-f=
ixes-v4.8-rc3

for you to fetch changes up to 4df36185bb364f9727d1c0816acac3b9a5ae2603:

  Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/will/linux into iommu/fixes (2016-08-22 12:33:56 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.8-rc3:

=46rom Will Deacon:

	* Fix a couple of thinkos in the CMDQ error handling and
          short-descriptor page table code that have been there since
          day one

	* Disable stalling faults, since they may result in hardware
          deadlock

	* Fix an accidental BUG() when passing disable_bypass=3D1 on
          the cmdline

----------------------------------------------------------------
Joerg Roedel (1):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../w=
ill/linux into iommu/fixes

Robin Murphy (1):
      iommu/io-pgtable-arm-v7s: Fix attributes when splitting blocks

Will Deacon (3):
      iommu/arm-smmu: Fix CMDQ error handling
      iommu/arm-smmu: Disable stalling faults for all endpoints
      iommu/arm-smmu: Don't BUG() if we find aborting STEs with disable_byp=
ass

 drivers/iommu/arm-smmu-v3.c        |  7 +++++--
 drivers/iommu/arm-smmu.c           | 34 +++++++---------------------------
 drivers/iommu/io-pgtable-arm-v7s.c |  4 +++-
 3 files changed, 15 insertions(+), 30 deletions(-)

Please pull.

Thanks,

	Joerg

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXwGE+AAoJECvwRC2XARrjPaQQAKMLsO3G6hbYqZhh/KCz8Yfa
mewj8RJXmvPf2yg9q+XMIK1SIdxzVFvwV4718j4kmcmeVkf0KuPC9f24JuocxuYh
fd14vPxVs68nXKtnEzkiosQmehWpz1HK3mDW4PuifHEgQ6a7mm8f/CIFSlzu4Dvc
w885KYBxbb513JaZEUIQogBm5is+S0gCvdh13DX6UquikpEHyjo+NEGaFisxqZs4
Ab/iveUwz0bMUwXUv+RtrabhXI+S721cqb6x/D4jGSlhvyxCIx/AKfbD7j67H/y8
rpKEekJp2ER4tfu2Y2h26qEKkQHdPxSuRNN+IxtUqM6SmGjA78FIaFn4AAGMVbkP
JNsiekjPyA3O+UN4MvZIobFukT/39AtGlZPriiO8fJlKpdy4Ph1eMF9Kd+1uJRAv
ciET3YAC/8uEbbruuJQuKlDNlxxv0W0uOkUubNl7NGWgoTwHX65Z1me3rOUGGbFs
hQvkOzpGLMc2N96pHorrB8LloF8pqh8xdrdOBIZHaDQ50AXR3aFa/GTeJ9XoYzy8
otD5vyyPSUEWAAKT1H0tgXU3xU2VlacxF/pDX80qiMIopvF+dtABwo3kpXTXyO9b
KFTeXHcGXgJk/eSOirizz7BVl6nVaVgZBHGl4xjkXYGZ1Aas40Jx8lgxW3O96dh9
dLULT4paUQ3wVykmBaYj
=pVrC
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============9181132423086379007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9181132423086379007==--
