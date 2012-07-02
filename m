From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU fixes for Linux 3.5-rc1
Date: Mon, 2 Jul 2012 15:09:10 +0200
Message-ID: <20120702130910.GA12232@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3966973713779295959=="
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


--===============3966973713779295959==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
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


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJP8Z12AAoJECvwRC2XARrjInEP/RDmcUtoaMlR/cqCwXU+E37T
Z4C+K9GMYp3mlpq9xVmwEF8dn3IJip8DzvfK807YPAn+2+fZOBVj44jAW7Ht4nj5
8Ws9eJUTXgrZ5W3k9BRLfiHQnCStsNVf/iqhM9UWXc+JUag209OPgtYVMrlm7hjw
1pn4mEcB8tUUINANmA6g48o98fSL+V9hiXZIkf2vvxH/p0m/LaNC6WSS3TjxvYa1
9ynEmvTNDr2IdMy40fb98z2/jsPfxWX9TAew/1g/5uN4u2ifUHdhqFXc9UmhSWz4
hC+KxL2wakHakgKIY4PgwMJmvjzP4oq5NLNdc/8hkob2As1A1TUJgdYDvjxSfJvt
vdYw5ySYMcpzloYIb/3mKfHeiaGvEJqip/H5F+/oTWweJsGuAVGpqhDPzc7JrFRV
rfevLppSWlq1JQNbtsmCOVbNvscCIlK/KvcyYF3C2p7l6jSue6kng8cKWDTFev34
NW4PMQmEjymWWO57DgMLjQzMadmgpeD6RZaBRWjDvNqDBWAGvmfG5WjhPdkSzZkW
b327PdT6kw3Sb8IkSIxbnFEW6W7/mP5Jbn+0OddKPEu5TuwZihrXAPkQKe7M0Y/X
F6itMlj/ubDsyZSTvVWspWk+n3vvldeBArFyiS3vIg3/ow5EPZsyFVHdkqmDikkJ
TVobcOZ7OxHOvb5ltEHa
=4rxZ
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--



--===============3966973713779295959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3966973713779295959==--
