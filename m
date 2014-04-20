From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v3.15-rc1
Date: Sun, 20 Apr 2014 11:45:37 +0200
Message-ID: <20140420094535.GA3237@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9187262027993184749=="
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


--===============9187262027993184749==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.15-rc1

for you to fetch changes up to 3426cb3d3578eab55ec231e0ce4dfc12ec3abc1f:

  Merge git://git.infradead.org/iommu-2.6 into iommu/fixes (2014-04-16 16:09:40 +0200)

----------------------------------------------------------------

IOMMU Fixes for Linux v3.15-rc1

Fixes for regressions:

	* Fix wrong IOMMU enumeration causing some SCSI device drivers
	  initialization failures
	* ARM-SMMU fixes for a panic condition and a wrong return value.

----------------------------------------------------------------
Bin Wang (1):
      iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte

David Woodhouse (1):
      iommu/vt-d: Fix get_domain_for_dev() handling of upstream PCIe bridges

Jiang Liu (2):
      iommu/vt-d: fix memory leakage caused by commit ea8ea46
      iommu/vt-d: fix bug in matching PCI devices with DRHD/RMRR descriptors

Joerg Roedel (1):
      Merge git://git.infradead.org/iommu-2.6 into iommu/fixes

Laurent Pinchart (1):
      iommu/arm-smmu: Return 0 on unmap failure

 drivers/iommu/arm-smmu.c    |    4 ++--
 drivers/iommu/dmar.c        |    3 ++-
 drivers/iommu/intel-iommu.c |   10 +++++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

Please pull.

Thanks,

	Joerg


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJTU5c/AAoJECvwRC2XARrjXXYP/jYyncsBx46WjWXWd6Qa+hqt
Iv4Gr8ciZROJv97o8funMev41kmkUT48Air8fHbcxA7LQJC9DmXv7EOJlO8Pqo2M
5yIMc9MvqUx8/EHLIem7xk6APJWksvRWhPwR8KYd7KO9vROd6SKUD4VRwPQuMP8S
U15S6b+Ybu/XlK34WL8vneiT1C7jY8qU0fDfd/da0EnprBOum8r5aMVd6KaYXrFW
xVscU9SzXhCtVW9+Vl0ZpvJtTy75atMFtFcB/PTQJk9qXzVuQrBizr9luqJjy3vp
ewB5JK3VKNdvXlIjTjgBe2puDjUPOHlQDwiZEh8gIZSJ4Eze5bSCPb/Oqym/hJsJ
3eS+HWg6XGc1kR6OYbvOGudXULGwvk/vQkQvDtG/LbGWcANmrRZvKrsbjGugqzF+
uLod5I5KUxzkLYT1Z0ZTyTgvN6zvvkif67uZYzZd7bTX6zneUMShhbX58BmartYY
QfYK6shuNtC0yQW3WEahYVXKvJDjkfSRycuf199OuAYq0pycTc9zKAAhh/ckhTs6
SI4D8QqmMBceP9aTiRQmADHvM+oazNTQ3wQJLqkUaFqI56SJupko6CWnMDku9bPF
xiVDCTF1mljcSa+hjPXUtSfS8PfAaghupRO62FComQDMPVv8CoVahJ3ddgzEtWaO
flURoUOqhjiRHm0RR6nB
=SRpi
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--



--===============9187262027993184749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9187262027993184749==--
