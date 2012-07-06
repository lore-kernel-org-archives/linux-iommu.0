From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU fixes for Linux 3.5-rc5
Date: Fri, 6 Jul 2012 15:17:43 +0200
Message-ID: <20120706131743.GA2364@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4581726415513317300=="
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


--===============4581726415513317300==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit eee53537c476c947bf7faa1c916d2f5a0ae8ec93:

  iommu/amd: Fix deadlock in ppr-handling error path (2012-06-04 12:47:44 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.5-rc5

for you to fetch changes up to 3775d4818d72081e2afa2aed2442a2b9ecfc5eab:

  iommu/amd: fix type bug in flush code (2012-07-02 12:11:40 +0200)

----------------------------------------------------------------
IOMMU fixes for Linux v3.5-rc5

The patches fix several issues in the AMD IOMMU driver, the NVidia SMMU
driver, and the DMA debug code. The most important fix for the AMD IOMMU
solves a problem with SR-IOV devices where virtual functions did not
work with IOMMU enabled. The NVidia SMMU patch fixes a possible sleep
while spin-lock situation (queued the small fix for v3.5, a better but
more intrusive fix is coming for v3.6). The DMA debug patches fix a
possible data corruption issue due to bool vs. u32 usage.

----------------------------------------------------------------
Dan Carpenter (2):
      dma-debug: debugfs_create_bool() takes a u32 pointer
      iommu/amd: fix type bug in flush code

Hiroshi DOYU (1):
      iommu/tegra: smmu: Fix unsleepable memory allocation

Joerg Roedel (1):
      iommu/amd: Initialize dma_ops for hotplug and sriov devices

Shuah Khan (1):
      iommu/amd: Fix missing iommu_shutdown initialization in passthrough mode

 drivers/iommu/amd_iommu.c       |   11 ++++++++++-
 drivers/iommu/amd_iommu_init.c  |    6 +++---
 drivers/iommu/amd_iommu_types.h |    2 +-
 drivers/iommu/tegra-smmu.c      |    4 ++--
 lib/dma-debug.c                 |    4 ++--
 5 files changed, 18 insertions(+), 9 deletions(-)

Please pull.

Regards,

	Joerg


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJP9uV3AAoJECvwRC2XARrjPk8QAMFosqWmN4ZdqD6BJ7csCkVA
tHIeO2fK43JeOIgTzgPFMnvRdEv4kM8I9CkQNWffTNbentD0YTm5WFobFrXbdTOO
UiBw9ZKxxyQToYKSdAh/xwVoY+wxG2WFwbIV45NYoI52+8alYr9Nt3vjfRYqge3B
lVjhsYr9li3jC0K/a49kcSLi59JUcBwLcsiL78TzaYbLSRm3wXdkDzN5EhCMeZao
TMD/SX2p29v3jgcWqH9aNg1sum2OOuQvZre3Dxek0WwqMsBPJJHIcfsjRjAlMwYR
+DOznne6pbZf+yXrWN+BZmOvYRToy4UbYxBppPlk7QhE8cy7gMHkU4Xo8EMhb0Qy
00thyC5UcXvPJG41wWDmbP/N3mvOg2pLQTC3QV3G9CS8mKekEvQ4Wb8vdaHhsQbp
dvT7gXUfF++HWoC/hSdlxO0wKAiqj8vU1LpJALnqEBsXIRlEKDQENgaE2rNlr5lI
xXbjK1R2pR0saF1OavgoKB/uVNpgmMPBdtcrRK5UGKAaPbgrogkzcfmELQIMppF/
mMTQSX2WMumoK3ViQFNMi+thrEY1Da4cTC1IrrzaTmtdKDjbD/vNjs+rf8WiN//P
UAwOMKnR0WhdWrA83fQCMuMhFfH3xeQxVUoe6QQBytXIqIwXmVysg/M/Pz0OF6v+
UcSY5l7bbOoCfiEO1Oj6
=Q5ji
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--



--===============4581726415513317300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4581726415513317300==--
