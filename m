From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU updates for Linux 3.5
Date: Wed, 30 May 2012 14:39:06 +0200
Message-ID: <20120530123906.GB3601@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5644437551016936098=="
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


--===============5644437551016936098==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 76e10d158efb6d4516018846f60c2ab5501900bc:

  Linux 3.4 (2012-05-20 15:29:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v3.5

for you to fetch changes up to 28f8571e1e84782244cc7bf1b129baf6cdc0832e:

  Merge branches 'iommu/fixes', 'dma-debug', 'arm/omap', 'arm/tegra', 'core' and 'x86/amd' into next (2012-05-30 12:41:29 +0200)

----------------------------------------------------------------

IOMMU Updates for Linux 3.5

Not much stuff this time. The only change to the IOMMU core code is the
addition of a handle to the fault handling code. A few updates to the
AMD IOMMU driver to work around new errata. The other patches are mostly
fixes and enhancements to the existing ARM IOMMU drivers and
documentation updates.

A new IOMMU driver for the Exynos platform was also underway but got
merged via the Samsung tree and is not part of this tree.

----------------------------------------------------------------
Hiroshi DOYU (2):
      iommu/tegra: smmu: Print device name correctly
      iommu/tegra: gart: Fix register offset correctly

Jakub Kicinski (1):
      dma-debug: release free_entries_lock before saving stack trace

Joerg Roedel (3):
      iommu/amd: Check for the right TLP prefix bit
      iommu/amd: Add workaround for event log erratum
      Merge branches 'iommu/fixes', 'dma-debug', 'arm/omap', 'arm/tegra', 'core' and 'x86/amd' into next

Ohad Ben-Cohen (1):
      iommu/core: pass a user-provided token to fault handlers

Omar Ramirez Luna (1):
      iommu: OMAP: device detach on domain destroy

Shuah Khan (1):
      Documentation: kernel-parameters.txt Add amd_iommu_dump

Thierry Reding (1):
      iommu: tegra/gart: Add device tree support

Vandana Salve (1):
      iommu: tegra/gart: use correct gart_device

 .../bindings/iommu/nvidia,tegra20-gart.txt         |   14 ++++++++
 Documentation/kernel-parameters.txt                |    6 ++++
 drivers/iommu/amd_iommu.c                          |   37 ++++++++++++++------
 drivers/iommu/iommu.c                              |    5 ++-
 drivers/iommu/omap-iommu.c                         |   32 ++++++++++++-----
 drivers/iommu/tegra-gart.c                         |   20 ++++++++---
 drivers/iommu/tegra-smmu.c                         |    2 +-
 drivers/remoteproc/remoteproc_core.c               |    4 +--
 include/linux/iommu.h                              |   10 +++---
 lib/dma-debug.c                                    |   10 +++---
 10 files changed, 104 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

Please pull.

Regards,

	Joerg


--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPxhTqAAoJECvwRC2XARrjawsP/0L04DUvIXobpMEFLBcYSoDu
Jt9mJWAs0jbQtoGTUtOuF5UI+fiNR9Vbt76C9aMPY8kYS4224RXVsAThSTf4/2VQ
FzkN99U5jrDg0V/Lc9f0qB0CCVAhJ58nrGoC5KIdNipYWtHVEp9DDYgbwd9gqh9f
RK5U40MkZL7iILMV9RLKhiHsokydMEAoaUALOBD8PBC+S3A25Nx0Hkg6Foy/Sg6D
GzuqYqycuPfC8RN9D9uxUk/XSuzDVaf9zxrPWv9eITmshW+VqkMW/0ZEuo3uP0yA
9X99eaSklI0sltuoaErG2JcgMlJE1Ihtz06hOSnFCpVB+TqS+og/jnwXzNIZ84WA
tDj7aJvpldz8mTSKeOq8OMsQ2OwdJEsnjZsaOUim0eWGCI3q53/M9QXfaGX8tHKT
LrUotdOdVvQaqB/BGY3bdaY3LocAP4fKDZ42bw7gbZxq8+/bbhU+arqven8LHzc1
EQ53cE2uFYMbhrIC3sVmitOQp77wwg1Ssw18cf/wj94xTlwi1+BwYUMrq0Evf2+r
KKmhm0JgYWid0cm1QL6iPs2dp+9SG0tOJJSbuGcMhz5nuSuW9dzl09kSJhpW44c6
EnbEPxjIj/VoINlcqTQVfgS5sQKZvLUEH5xvB9WGS3TL5mS0NP0Exf0RM2gErEjO
dtaveyjm/O1QgakaoZ5D
=Hhie
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--



--===============5644437551016936098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5644437551016936098==--
