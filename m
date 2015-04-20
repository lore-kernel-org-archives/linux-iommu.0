From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Updates for Linux v4.1
Date: Mon, 20 Apr 2015 04:34:35 +0200
Message-ID: <20150420023433.GA3719@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e42391cd048809d903291d07f86ed3934ce138e9:

  Linux 4.0-rc6 (2015-03-29 15:26:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.1

for you to fetch changes up to 7f65ef01e131650d455875598099cd06fea6096b:

  Merge branches 'iommu/fixes', 'x86/vt-d', 'x86/amd', 'arm/smmu', 'arm/tegra' and 'core' into next (2015-04-02 13:33:19 +0200)

----------------------------------------------------------------

IOMMU Updates for Linux v4.1

Not much this time, but the changes include:

	* Moving domain allocation into the iommu drivers to prepare for
	  the introduction of default domains for devices

	* Fixing the IO page-table code in the AMD IOMMU driver to
	  correctly encode large page sizes

	* Extension of the PCI support in the ARM-SMMU driver

	* Various fixes and cleanups

----------------------------------------------------------------
Dan Carpenter (1):
      iommu/amd: Small cleanup in mn_release()

Joerg Roedel (27):
      iommu: Introduce domain_alloc and domain_free iommu_ops
      iommu: Introduce iommu domain types
      iommu: Only allow iommu_map/unmap for paging domains
      iommu/amd: Make use of domain_alloc and domain_free
      iommu/vt-d: Make use of domain_alloc and domain_free
      iommu/omap: Make use of domain_alloc and domain_free
      iommu/arm-smmu: Make use of domain_alloc and domain_free
      iommu/exynos: Make use of domain_alloc and domain_free
      iommu/tegra-smmu: Make use of domain_alloc and domain_free
      iommu/tegra-gart: Make use of domain_alloc and domain_free
      iommu/msm: Make use of domain_alloc and domain_free
      iommu/shmobile: Make use of domain_alloc and domain_free
      iommu/ipmmu-vmsa: Make use of domain_alloc and domain_free
      iommu/rockchip: Make use of domain_alloc and domain_free
      iommu/fsl: Make use of domain_alloc and domain_free
      iommu: Remove domain_init and domain_free iommu_ops
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu/amd: Use BUS_NOTIFY_REMOVED_DEVICE
      iommu/amd: Ignore BUS_NOTIFY_UNBOUND_DRIVER event
      iommu/amd: Don't allocate with __GFP_ZERO in alloc_coherent
      iommu/amd: Add support for contiguous dma allocator
      iommu/amd: Return the pte page-size in fetch_pte
      iommu/amd: Optimize iommu_unmap_page for new fetch_pte interface
      iommu/amd: Optimize alloc_new_range for new fetch_pte interface
      iommu/amd: Optimize amd_iommu_iova_to_phys for new fetch_pte interface
      iommu/amd: Correctly encode huge pages in iommu page tables
      Merge branches 'iommu/fixes', 'x86/vt-d', 'x86/amd', 'arm/smmu', 'arm/tegra' and 'core' into next

Quentin Lambert (1):
      iommu/vt-d: Convert non-returned local variable to boolean when relevant

Robin Murphy (1):
      iommu/arm-smmu: set a more appropriate DMA mask

Thierry Reding (3):
      iommu/tegra: Setup aperture
      iommu/tegra: gart: Set aperture at domain initialization time
      iommu/tegra: smmu: Compute PFN mask at runtime

Will Deacon (3):
      iommu/arm-smmu: ensure CBA2R is initialised before CBAR on SMMUv2
      iommu/arm-smmu: handle multi-alias IOMMU groups for PCI devices
      iommu/io-pgtable-arm: avoid speculative walks through TTBR1

 drivers/iommu/amd_iommu.c           | 250 ++++++++++++++++++------------------
 drivers/iommu/amd_iommu_types.h     |  13 +-
 drivers/iommu/amd_iommu_v2.c        |   2 +-
 drivers/iommu/arm-smmu.c            | 180 ++++++++++++++++----------
 drivers/iommu/exynos-iommu.c        |  87 +++++++------
 drivers/iommu/fsl_pamu_domain.c     |  60 +++++----
 drivers/iommu/fsl_pamu_domain.h     |   2 +-
 drivers/iommu/intel-iommu.c         |  68 +++++-----
 drivers/iommu/intel_irq_remapping.c |  12 +-
 drivers/iommu/io-pgtable-arm.c      |   5 +
 drivers/iommu/iommu.c               |  26 ++--
 drivers/iommu/ipmmu-vmsa.c          |  42 +++---
 drivers/iommu/msm_iommu.c           |  73 ++++++-----
 drivers/iommu/omap-iommu.c          |  49 ++++---
 drivers/iommu/rockchip-iommu.c      |  40 +++---
 drivers/iommu/shmobile-iommu.c      |  39 +++---
 drivers/iommu/tegra-gart.c          |  88 ++++++++-----
 drivers/iommu/tegra-smmu.c          |  59 +++++----
 include/linux/iommu.h               |  33 ++++-
 19 files changed, 644 insertions(+), 484 deletions(-)

Please pull.

Thanks,

	Joerg


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGW5AAoJECvwRC2XARrjG/AP/3yDyLfwXih2xH4wOXAM2h8V
aH7evNFKVuCuQklVmVgNExR8Nlzww3X084D65uU7KP2ga4kbTj4pC4Y87Ok0Tk2n
EOy5EAjrVoBpxMSAuvU2spPNpXzumcqq6jfaXM8jm9B6b3AkynZHzLJgQ57+Us1t
o2K7IN654klICKCNjql48FZoG+igQqA1i9T7YKZ8qeGdFYhyFlGtwH8KKikQdO6S
CenypuHfuQvIglJkRUHrZS3wxo5uw5oErwVh9txr+ABXK5VgCjMuAAYnwV6iA6on
/1+9HiyzvXXYzYXJQ+lJAAx69/H+uh0Ay4rH1QHReNCuc71OjTl6uSaGa3aa0R9B
XEtXNn+WIM8dtq4WsUjN0F/wC8Q849WkRVdehvj1YwoIogQZRpTNpDxjV4uROxQN
3i/r2bsfLXxRRI3LGOwC0+wB+HQKPJeG1RgiWmo+d4XTwN6gbGs0EpehYN4+YTTx
Q/BPEJXvOi2iiDMrJJOE7Or9xfvUKrOy4sfq19JsvdCXTP1DIA9oav3/M/9ZnyQ0
dMxJh4q4yuW6TeVsk4PR7q8gvs0SIYzeQT2w0KOd4YPiKBMjWP/FGoKkFzqtoMoY
sjilZhJQvRYKzG0LMRcFcFl4+2+O7YPCtfMw5w7JnP7eiFv2NGUIb7sZ34NP5K03
UwMZjdUyu9Kgxp4FX1hi
=Ntwn
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
