From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v3.16-rc2
Date: Tue, 24 Jun 2014 10:54:18 +0200
Message-ID: <20140624085418.GB2782@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4389855787483763390=="
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


--===============4389855787483763390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.16-rc1

for you to fetch changes up to d73a6d722a675dbba8f6b52c964a7076a24a12c1:

  iommu/amd: Fix small race between invalidate_range_end/start (2014-06-20 16:14:22 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v3.16-rc1

	* Fix VT-d regression with handling multiple RMRR entries per
	  device
	* Fix a small race that was left in the mmu_notifier handling in
	  the AMD IOMMUv2 driver

----------------------------------------------------------------
Jiang Liu (1):
      iommu/vt-d: fix bug in handling multiple RMRRs for the same PCI device

Joerg Roedel (1):
      iommu/amd: Fix small race between invalidate_range_end/start

 drivers/iommu/amd_iommu_v2.c | 18 +++++++++++++-----
 drivers/iommu/intel-iommu.c  |  9 +++------
 2 files changed, 16 insertions(+), 11 deletions(-)

Please pull.

Thanks,

	Joerg


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTqTy6AAoJECvwRC2XARrj2GYP/j1/pT9JkzHRZH5611MhhWzO
/JXvS0xMw7M3qGwDwWDkpzvW03J5KxLAe+wVR7n/OUO+D/ktTSYhB142lVohA074
gWfAJTs3WCv1XJn+CEiIm0NJsIsTgHeNsPZ3YVUO4kJPEf6IaV1edz+oli0g5wmf
iDomliGBsFQI6dymG9ph5qLYYwDadbucZ/pw6gYfAY+3TekxncHKqr2qNkwqnqRM
6xGFuDTyUnTyEanir8SR2nU1ZHSJDXdqs+eRMqrBDQEuzD2sHhAr8ejwW6tJipFA
6+AqySZFR/jlcsRESwNUY5HjLnlB05oKPukUwSzj/jmRhHJubnMhpGo+ZqzjopIQ
4naVOCZM2EcH0Har8OAW8ss7d8VD0WrNWbRM/vFpO/1nRxW3yoR93fYoYSBrGZfj
0KgQQ2mXBrERZh4LSg8c1xtOMN+SsCNsYSU07GAW216223odT6rctSv5qlluk8kB
dbnjQ6jtXOKJSWLwSK4OCZ50XlXhsBp6ln9MJmBg/HTXnnoaS3CZy6awQBL/PGl6
1rGBoY+DVdtXjiQe0y/EtnwqBdCSDEg5JkIa5puYchjkZaKdO5i/xinJsSSm4Lbz
f+lUJ/ebHAQP/UsioMKI9GMgFPtUDwCphkPmhkf6mJcL1qU1UcvO0A+njOqgdoZV
UJWntlWbBhrSrOaNk1Wk
=abg5
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--



--===============4389855787483763390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4389855787483763390==--
