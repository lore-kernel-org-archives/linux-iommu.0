From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Updates for Linux v4.3
Date: Tue, 8 Sep 2015 13:20:56 +0200
Message-ID: <20150908112054.GA26038@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit c13dcf9f2d6f5f06ef1bf79ec456df614c5e058b:

  Linux 4.2-rc8 (2015-08-23 20:52:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v4.3

for you to fetch changes up to 4ad79562577a3936b08365260f86eeb83156479f:

  Merge branches 'arm/omap', 'arm/msm', 'arm/smmu', 'arm/tegra', 'x86/vt-d'=
, 'x86/amd', 'ppc/pamu' and 'core' into next (2015-08-25 11:39:50 +0200)

----------------------------------------------------------------

IOMMU Updates for Linux v4.3

This time the IOMMU updates are mostly cleanups or fixes. No big new
features or drivers this time. In particular the changes include:

	* Bigger cleanup of the Domain<->IOMMU data structures and the
	  code that manages them in the Intel VT-d driver. This makes
	  the code easier to understand and maintain, and also easier to
	  keep the data structures in sync. It is also a preparation
	  step to make use of default domains from the IOMMU core in the
	  Intel VT-d driver.

	* Fixes for a couple of DMA-API misuses in ARM IOMMU drivers,
	  namely in the ARM and Tegra SMMU drivers.

	* Fix for a potential buffer overflow in the OMAP iommu driver's
	  debug code

	* A couple of smaller fixes and cleanups in various drivers

	* One small new feature: Report domain-id usage in the Intel
	  VT-d driver to easier detect bugs where these are leaked.

----------------------------------------------------------------
Alex Williamson (1):
      iommu/vt-d: Report domain usage in sysfs

Dan Williams (1):
      iommu/vt-d: Fix leaked ioremap mapping

Emil Medve (1):
      iommu/fsl: Really fix init section(s) content

Joerg Roedel (39):
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/...=
/will/linux into arm/smmu
      iommu/vt-d: Keep track of per-iommu domain ids
      iommu/vt-d: Add access functions for iommu->domains
      iommu/vt-d: Split up iommu->domains array
      iommu/vt-d: Get rid of iommu_attach_vm_domain()
      iommu/vt-d: Calculate translation in domain_context_mapping_one
      iommu/vt-d: Simplify domain_context_mapping_one
      iommu/vt-d: Pass dmar_domain directly into iommu_flush_iotlb_psi
      iommu/vt-d: Don't pre-allocate domain ids for si_domain
      iommu/vt-d: Kill dmar_domain->id
      iommu/vt-d: Replace iommu_bmp with a refcount
      iommu/vt-d: Simplify io/tlb flushing in intel_iommu_unmap
      iommu/vt-d: Simplify domain_remove_one_dev_info()
      iommu/vt-d: Simplify domain_remove_dev_info()
      iommu/vt-d: Move context-mapping into dmar_insert_dev_info
      iommu/vt-d: Rename dmar_insert_dev_info()
      iommu/vt-d: Rename domain_remove_one_dev_info()
      iommu/vt-d: Rename iommu_detach_dependent_devices()
      iommu/vt-d: Pass an iommu pointer to domain_init()
      iommu/vt-d: Establish domain<->iommu link in dmar_insert_one_dev_info
      iommu/vt-d: Unify domain->iommu attach/detachment
      iommu/vt-d: Only call domain_remove_one_dev_info to detach old domain
      iommu/vt-d: Get rid of domain->iommu_lock
      iommu/vt-d: Remove dmar_global_lock from device_notifier
      iommu/vt-d: Pass device_domain_info to __dmar_remove_one_dev_info
      iommu/vt-d: Only insert alias dev_info if there is an alias
      iommu/vt-d: Avoid duplicate device_domain_info structures
      iommu/amd: Simplify allocation in irq_remapping_alloc()
      iommu/amd: Make a symbol static
      iommu/amd: Use BUG_ON instead of if () BUG()
      iommu/vt-d: Return false instead of 0 in irq_remapping_cap()
      iommu/vt-d: Use BUG_ON instead of if () BUG()
      iommu/vt-d: Make two functions static
      iommu/vt-d: Access iomem correctly
      iommu/msm: Use BUG_ON instead of if () BUG()
      iommu/io-pgtable-arm: Move init-fn declarations to io-pgtable.h
      Merge tag 'tegra-for-4.3-iommu' of git://git.kernel.org/.../tegra/lin=
ux into arm/tegra
      iommu/vt-d: Really use upper context table when necessary
      Merge branches 'arm/omap', 'arm/msm', 'arm/smmu', 'arm/tegra', 'x86/v=
t-d', 'x86/amd', 'ppc/pamu' and 'core' into next

Kees Cook (1):
      iommu/vt-d: Avoid format string leaks into iommu_device_create

Marc Zyngier (2):
      iommu/arm-smmu: Fix enabling of PRIQ interrupt
      iommu/arm-smmu: Fix MSI memory attributes to match specification

Robin Murphy (10):
      iommu/arm-smmu: Sort out coherency
      of: iommu: Silence misleading warning
      iommu/io-pgtable-arm: Allow appropriate DMA API use
      iommu/arm-smmu: Clean up DMA API usage
      iommu/arm-smmu: Clean up DMA API usage
      iommu/ipmmu-vmsa: Clean up DMA API usage
      iommu/io-pgtable-arm: Centralise sync points
      iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
      iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
      iommu/io-pgtable: Remove flush_pgtable callback

Russell King (15):
      iommu/tegra-smmu: Fix iova_to_phys() method
      iommu/tegra-smmu: Fix unmap() method
      iommu/tegra-smmu: Factor out common PTE setting
      iommu/tegra-smmu: Add iova_pd_index() and iova_pt_index() helpers
      iommu/tegra-smmu: Fix page table lookup in unmap/iova_to_phys methods
      iommu/tegra-smmu: Store struct page pointer for page tables
      iommu/tegra-smmu: Use kcalloc() to allocate counter array
      iommu/tegra-smmu: Move flush_dcache to tegra-smmu.c
      iommu/tegra-smmu: Split smmu_flush_ptc()
      iommu/tegra-smmu: smmu_flush_ptc() wants device addresses
      iommu/tegra-smmu: Convert to use DMA API
      iommu/tegra-smmu: Remove PageReserved manipulation
      iommu/tegra-smmu: Use __GFP_ZERO to allocate zeroed pages
      iommu/tegra-smmu: Extract tegra_smmu_pte_get_use()
      iommu/tegra-smmu: Factor out tegra_smmu_set_pde()

Salva Peir=F3 (1):
      iommu/omap: Fix debug_read_tlb() to use seq_printf()

Suman Anna (10):
      Documentation: dt: Add #iommu-cells info to OMAP iommu bindings
      iommu/omap: Remove all module references
      iommu/omap: Move debugfs functions to omap-iommu-debug.c
      iommu/omap: Protect omap-iopgtable.h against double inclusion
      iommu/omap: Remove unused union fields
      iommu/omap: Remove trailing semi-colon from a macro
      iommu/omap: Remove unnecessary error traces on alloc failures
      iommu/omap: Use BIT(x) macros in omap-iopgtable.h
      iommu/omap: Use BIT(x) macros in omap-iommu.h
      iommu/omap: Align code with open parenthesis

Thierry Reding (1):
      iommu/tegra-smmu: Parameterize number of TLB lines

Will Deacon (3):
      iommu/arm-smmu: Limit 2-level strtab allocation for small SID sizes
      iommu/arm-smmu: Treat unknown OAS as 48-bit
      iommu/io-pgtable-arm: Unmap and free table when overwriting with block

Xiao, Nan (1):
      x86/vt-d: Fix documentation of DRHD

 Documentation/Intel-IOMMU.txt                      |   2 +-
 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 +
 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |   6 +
 drivers/iommu/Kconfig                              |   3 +-
 drivers/iommu/amd_iommu.c                          |  21 +-
 drivers/iommu/amd_iommu_init.c                     |   2 +-
 drivers/iommu/amd_iommu_v2.c                       |   4 +-
 drivers/iommu/arm-smmu-v3.c                        |  66 +-
 drivers/iommu/arm-smmu.c                           |  45 +-
 drivers/iommu/dmar.c                               |   2 +-
 drivers/iommu/fsl_pamu.c                           |  26 +-
 drivers/iommu/intel-iommu.c                        | 716 ++++++++++-------=
----
 drivers/iommu/intel_irq_remapping.c                |   6 +-
 drivers/iommu/io-pgtable-arm.c                     | 143 +++-
 drivers/iommu/io-pgtable.c                         |   5 -
 drivers/iommu/io-pgtable.h                         |  14 +-
 drivers/iommu/ipmmu-vmsa.c                         |  19 +-
 drivers/iommu/irq_remapping.c                      |   2 +-
 drivers/iommu/msm_iommu.c                          |   4 +-
 drivers/iommu/of_iommu.c                           |   8 +-
 drivers/iommu/omap-iommu-debug.c                   | 131 +++-
 drivers/iommu/omap-iommu.c                         | 198 +-----
 drivers/iommu/omap-iommu.h                         |  79 +--
 drivers/iommu/omap-iopgtable.h                     |  27 +-
 drivers/iommu/tegra-smmu.c                         | 306 +++++----
 drivers/memory/tegra/tegra114.c                    |  18 +-
 drivers/memory/tegra/tegra124.c                    |  31 +-
 drivers/memory/tegra/tegra30.c                     |  18 +-
 include/linux/intel-iommu.h                        |   2 +-
 include/soc/tegra/mc.h                             |   8 +-
 30 files changed, 943 insertions(+), 975 deletions(-)

Please pull.

Thanks,

	Joerg


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJV7sSWAAoJECvwRC2XARrjY7gQAK0IvaqZ3A7T32pt0X+vo7LQ
BJ36klpWcY31bpxoAfhlACPy4vNID3RC8rav/pnosbo2rRbzin/uJ7LtJHBs2jBk
5+i92o+tPN6mLjpyiSa3TeXmSfIF55lfrRm7HFNEkzEEwdkwygNpds0NOR9/s11W
TfiheXc488NCbRKhiGOql7aNq96l2+QChfQhLWHEUmqga0QBYcmWtGA2whXY2LYU
gcsyHK9pLLOg8li4liApUk6c3TEnY+yuLzLd6kpCQ0YzZn2/bIc4LKMjmeeVI9x+
UGptjttBX4mBwOK9D+8lt3e2ZWQ8+17EYqoAQluwkWYSxSK2wu/VHUP8FKTmJ2my
q456+7NS6+YqRBpnoNSaWC/8iLvIb1CbsgyRloqcfxzc76qH9qeOUbXtF8Q3i+08
Boj0SNSwZzBmCxJLcK4OiCzTOnTwAOPMsfQihta6jitzM94pmz8E9MgvWIdP1DBB
olwqICcID63cm2qaBkxeV6y29YQ9MXfJj50goEg9fdltT4gIAVSWhB+9DVnEEHhO
HfcNoX+j+yIFVpeQbprYjm5lRiuT/1pC+Wr8h3iYw5ckuXYvxTuU7k/0dk4K17yp
DSt7kIIhu2qtgnYlzcJll3oryhIiTAfSkd8jtRTMZBfCGcwsMk9T/1JLmdVz7+go
E1C+U7SqodWlVWI1YYbf
=x4Cc
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
