From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.11-rc3
Date: Fri, 24 Mar 2017 12:31:55 +0100
Message-ID: <20170324113148.GA32735@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1462572393737921630=="
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


--===============1462572393737921630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.11-rc3

for you to fetch changes up to 11cd3386a1987a0515d7ce11ee87b242e5015dfe:

  Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes (2017-03-22 23:59:56 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.11-rc3

A few fixes piled up:

	* Fix a NULL-ptr dereference that happens in VT-d on some
	  platforms

	* A fix for ARM MSI region reporting, so that a sane interface
	  makes it to a released kernel

	* Fixes for leaf-checking in ARM io-page-table code

	* Two fixes for IO/TLB flushing code on ARM Exynos platforms

----------------------------------------------------------------
Joerg Roedel (1):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into iommu/fixes

Koos Vriezen (1):
      iommu/vt-d: Fix NULL pointer dereference in device_to_iommu

Marek Szyprowski (2):
      iommu/exynos: Block SYSMMU while invalidating FLPD cache
      iommu/exynos: Workaround FLPD cache flush issues for SYSMMU v5

Oleksandr Tyshchenko (2):
      iommu/io-pgtable-arm: Check for leaf entry before dereferencing it
      iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it

Robin Murphy (1):
      iommu: Disambiguate MSI region types

 drivers/iommu/amd_iommu.c          |  2 +-
 drivers/iommu/arm-smmu-v3.c        |  2 +-
 drivers/iommu/arm-smmu.c           |  2 +-
 drivers/iommu/exynos-iommu.c       |  8 +++++++-
 drivers/iommu/intel-iommu.c        |  4 ++--
 drivers/iommu/io-pgtable-arm-v7s.c |  6 +++++-
 drivers/iommu/io-pgtable-arm.c     |  6 +++++-
 drivers/iommu/iommu.c              |  5 +++--
 drivers/vfio/vfio_iommu_type1.c    |  7 +++----
 include/linux/iommu.h              | 18 +++++++++++++-----
 10 files changed, 41 insertions(+), 19 deletions(-)

Please pull.

Thanks,

	Joerg

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJY1QOkAAoJECvwRC2XARrjt+kQANL2rURsZ38/XHrYyyaXk4CF
OdQ+gqE/E3wKedgCpDDTZFQd+kA0nB3j3yHSAyMqU910Q1KV/VHAYtUi7UYOLXWy
fVHg9j3w6wXbSyQtvLmjnO6Aea53RYKvtMFysqCTCj9S36X51Gi34AcPLE2+HOZT
qX2qjYgGdxvBne8vwVtGImlYA7rTW76uKkxjoHjl/2ZyZ68ciY9QNxhCwFJQ14Q7
464V8nYVVUgRXPzJnef8Bx55lpERleOPQEA6/aJZ7PDqKJR07J8gCzXDVws7ugpC
APZpGqsGagOhzNhDTyGVccO8mvT3kZVCzPJjGQIwiww+7cootcgA5dhSuEaHm4qT
gFdVpslBKCUFRMWLp/vkJr7R2ojANPtG6Lg28QCUy3kn4Pz8bm5sIKW3/LEVOYot
Q1n3JQTRcOyc2EyDJUa5dpwCOLtJh2gi31Gh0iKi7d7AYzh66moTEVFGi/AWX1vs
boT5CjaqwNgzFSNi7JjeFhj8T695JfbowmbTI9PArABe16QiM6b+hQ2X4Ib4L4it
9GTSLkZKxeASA4mFQcXrqWhd5kHcShGIinIfjPlVT+0Rs5YSmFtdyDtLgJIo94xy
RTkh0J2PzThGw8KRFI0h25sm5vxkV4hUdRPfXkAcTKWWbEZIZ7osONtraqp+qmuQ
BNZAKn+5DGh/1h5PprUP
=KQiC
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============1462572393737921630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1462572393737921630==--
