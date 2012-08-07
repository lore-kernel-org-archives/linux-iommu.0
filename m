From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for v3.6-rc1
Date: Tue, 7 Aug 2012 16:44:30 +0200
Message-ID: <20120807144430.GA8827@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1183679086918778677=="
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


--===============1183679086918778677==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.6-rc1

for you to fetch changes up to 31fe943599b7e5870edb9decb7fbb9538b218f26:

  iommu/amd: Fix ACS path checking (2012-08-06 18:10:04 +0200)

----------------------------------------------------------------
IOMMU fixes for Linux v3.6-rc1

These patches fix a couple of issues. First of all a few problems with
ACS on x86 introduced in the last merge window, where ACS did not work
on AMD and a NULL pointer dereference when there ran against SR-IOV
devices.
The patches fallen out of coccinelle checks fix a possible invalid
memory reference and a possible memory leak. The other patches mostly
fix build errors and warnings and a wrong return value.

----------------------------------------------------------------
Alex Williamson (2):
      iommu/intel: Fix ACS path checking
      iommu/amd: Fix ACS path checking

Hiroshi Doyu (2):
      iommu/tegra: smmu: Cleanup with lesser nest
      iommu/tegra: smmu: Fix error initial value at domain_init

Joerg Roedel (2):
      iommu: Add missing forward declaration in include file
      iommu/amd: Fix pci_request_acs() call-place

Julia Lawall (2):
      iommu/tegra: remove invalid reference to list iterator variable
      iommu/intel: add missing free_domain_mem

Sachin Kamat (1):
      iommu/exynos: Fix build error

Thierry Reding (1):
      iommu: Include linux/types.h

 drivers/iommu/amd_iommu.c      |   25 ++++++++++++++++++++++---
 drivers/iommu/amd_iommu_init.c |    6 +++---
 drivers/iommu/exynos-iommu.c   |    6 +++---
 drivers/iommu/intel-iommu.c    |   26 +++++++++++++++++++++++---
 drivers/iommu/tegra-smmu.c     |   17 ++++++++++-------
 include/linux/iommu.h          |    2 ++
 6 files changed, 63 insertions(+), 19 deletions(-)

Please pull.

Regards,

	Joerg


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQISnNAAoJECvwRC2XARrjFBIQAKd47G/0gwXifCR80m58+PFl
KOlcmbJ3gIfSQB3jVghGZeI3kp9KSP24W/r6bXF47J/y63gs5eQqQkGYEFJqtAuZ
cqVVB5vEqgqlbQOyRIWBgNtM32SU8BDQ3oCV9npy7GwH6SzElZk2EG3q/QarNMFt
4iaXegkeeL+knBG+VFYrCvuy+svjxbtZDS1zEGt5eM6yhXufHqoF6BfMPAiZGV1S
1wWOKNAkqKpk1Gh+H7KHt1cKQwa/FwJaO59HVpfEkh1UWuCv9wWK6BiMdLU8nP9m
mGSZG+v1vy+/STHF2Hyn8jD2vPy9Aq6hp7wssZf3KnixCdoi1ZXj5j3oyH047Onw
RmAyCHzGuzg+PNqLdB5IGWBPn6wUhyfVth6bdHYW9N53aL9KuS+Upz0Tu3xcbDOv
kiCl11mTjhdkD3aP7wdfLW5xtnotwzs5nK2m8r34ghQXl6FDk2cfWY3+h3hyHtMq
gcW3en1fJh/meBCBX9iKAwO+7+OuYmca+6TgbzteQBbAZfUwsSEzZJAU5kKBDgd8
Pvv9UFMtVH6GjyGAyzlKqIMWr2zoCvgaE1kpP5pHDsRESPgiIfmz3UhmMqotPXwx
1vSN9DLsaucudXtgqUl0tbFpiFsJRivgwF11TGV+dlM8wmsNzt2M6SiUOOUzCLj+
eSBPfWRLjYi0L6G3RFbt
=6RUq
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--



--===============1183679086918778677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1183679086918778677==--
