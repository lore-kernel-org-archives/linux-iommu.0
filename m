From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for v3.11
Date: Mon, 8 Jul 2013 10:02:18 +0200
Message-ID: <20130708080204.GA3289@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1500962459280569038=="
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


--===============1500962459280569038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d:

  Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v3.11

for you to fetch changes up to 01ce784acfa69a171afe6ec3f85a959546f2d18a:

  Merge branches 'x86/vt-d', 'arm/omap', 'core', 'x86/amd' and 'arm/smmu' into next (2013-06-25 23:34:29 +0200)

----------------------------------------------------------------

IOMMU Updates for Linux 3.11

A few updates this time, most important and exiciting (to me) is:

	* The new ARM SMMU driver. This is a common IOMMU driver that will
	  hopefully be used in a lot of upcoming ARM chips. So the mess in the
	  past where every SOC had its own IOMMU will be over.

Besides that:

	* Some important fixes in the IOMMU unmap path. There are fixes in the
	  common code and also in the AMD IOMMU driver.
	* Other random fixes

----------------------------------------------------------------
Alex Williamson (4):
      iommu/{vt-d,amd}: Remove multifunction assumption around grouping
      iommu: Split iommu_unmaps
      iommu: Fix compiler warning on pr_debug
      iommu/amd: Only unmap large pages from the first pte

Andy Lutomirski (1):
      iommu/vt-d: Downgrade the warning if enabling irq remapping fails

Joe Perches (1):
      iommu: Use %pa and %zx instead of casting

Joerg Roedel (2):
      iommu/amd: Fix memory leak in free_pagetable
      Merge branches 'x86/vt-d', 'arm/omap', 'core', 'x86/amd' and 'arm/smmu' into next

Li, Zhen-Hua (1):
      iommu/vt-d: DMAR reporting table needs at least one DRHD

Suman Anna (2):
      iommu/omap: fix printk formats for dma_addr_t
      iommu/omap: fix checkpatch warnings in omap iommu code

Will Deacon (3):
      documentation/iommu: Add description of ARM System MMU binding
      iommu/arm: Add support for ARM Ltd. System MMU architecture
      MAINTAINERS: add entry for ARM system MMU driver

 .../devicetree/bindings/iommu/arm,smmu.txt         |   70 +
 MAINTAINERS                                        |    6 +
 drivers/iommu/Kconfig                              |   13 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/amd_iommu.c                          |  104 +-
 drivers/iommu/arm-smmu.c                           | 1969 ++++++++++++++++++++
 drivers/iommu/dmar.c                               |    4 +
 drivers/iommu/intel-iommu.c                        |   25 +-
 drivers/iommu/intel_irq_remapping.c                |    3 +-
 drivers/iommu/iommu.c                              |   86 +-
 drivers/iommu/omap-iommu.c                         |   15 +-
 drivers/iommu/omap-iopgtable.h                     |    2 +-
 drivers/iommu/omap-iovmm.c                         |    4 +-
 13 files changed, 2212 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
 create mode 100644 drivers/iommu/arm-smmu.c

Please pull.

Thanks,

	Joerg


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR2nH8AAoJECvwRC2XARrj65EQAM1PoiexYrU7SkU1Vf799xU1
RlvSXPwDYjjJjmECzhR8iVQREw8n6I/9itQ15uaMwdDNWCUI47hk0WbqxJLRqHEN
uicdiNteeJbSUtyZkiZDMcy0y6DVm1WgNMoZLy+7SpYvDQRsKNYIeKMVzbAvMJDc
kThcELUVhsngTW6uRxVbF3P/Lg8Lfzz9Hn168EUm3saDFRpuWdCsDA3V3aLPOU5X
GUtgih++rfCcl71GhSKDFkql9p3aWuvsfA/c6A+CwUaAEM2jR1KY4+fIysEOgkf0
kDjjMpSrgT+RQsYUVA1memVrU/kg+2uUsEOtHBgYbJaWB2RPjcCvf4U5FCY9I21Q
kTCRk4rKk+y3SU3EVlsdz96kNUJqk64y1x9NoAQaVec8xRX9xWgtSPXbbEJuYYZm
qtv7Qs3R3ILWeg0darU4xBu4pb/UAVjzOTExCdIx4sEqBintXxmfajYUXPwIy4vQ
ddttFnnWd0g5BsqSPCZ2U+5V+qKjUL0Rnbi4sNLdCk8zoweKcP39HY7rbJROvBOl
neOoeTyQD3VLID/T6Ih4Yiyd948YfHmj0uy0IMcE6okY5uVc8U1GYgIPuqsOWWYT
y/jWR2eaE1h2rykCz7lxQVyMZZVGEYOjfE37LCOzn3ch+nfS+xMgvfOEq4rLv4ac
aUPaNXbCby35jHhI2m7C
=n49T
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--



--===============1500962459280569038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1500962459280569038==--
