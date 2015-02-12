From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Updates for Linux v3.20
Date: Thu, 12 Feb 2015 16:19:42 +0100
Message-ID: <20150212151942.GA21126@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e36f014edff70fc02b3d3d79cead1d58f289332e:

  Linux 3.19-rc7 (2015-02-01 20:07:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v3.20

for you to fetch changes up to a20cc76b9efae10c20123049df361adcd7f0e0b3:

  Merge branches 'arm/renesas', 'arm/smmu', 'arm/omap', 'ppc/pamu', 'x86/amd' and 'core' into next (2015-02-04 16:53:44 +0100)

----------------------------------------------------------------

IOMMU Updates for Linux v3.20

This time with:

	* Generic page-table framework for ARM IOMMUs using the LPAE page-table
	  format, ARM-SMMU and Renesas IPMMU make use of it already.

	* Break out of the IO virtual address allocator from the Intel IOMMU so
	  that it can be used by other DMA-API implementations too. The first
	  user will be the ARM64 common DMA-API implementation for IOMMUs

	* Device tree support for Renesas IPMMU

	* Various fixes and cleanups all over the place

----------------------------------------------------------------
Arnd Bergmann (2):
      iommu: Disable on !MMU builds
      iommu/arm-smmu: Avoid build warning

Emil Medve (3):
      iommu/fsl: Fix section mismatch
      iommu/fsl: Remove unused fsl_of_pamu_ids[]
      iommu/fsl: Various cleanups

Joerg Roedel (9):
      Merge branch 'iommu/next' of git://linuxtv.org/pinchartl/fbdev into arm/renesas
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branch 'arm/smmu' into arm/renesas
      iommu: Make more drivers depend on COMPILE_TEST
      iommu/omap: Print phys_addr_t using %pa
      iommu/fsl: Use %pa to print phys_addr_t
      iommu/amd: Use wait_event in put_pasid_state_wait
      iommu: Update my email address
      Merge branches 'arm/renesas', 'arm/smmu', 'arm/omap', 'ppc/pamu', 'x86/amd' and 'core' into next

Laurent Pinchart (10):
      iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
      iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page table
      iommu/ipmmu-vmsa: Invalidate TLB after unmapping
      iommu/ipmmu-vmsa: Add device tree bindings documentation
      iommu/ipmmu-vmsa: Add device tree support
      iommu/ipmmu-vmsa: Support multiple micro TLBs per device
      iommu/ipmmu-vmsa: Remove platform data support
      iommu: io-pgtable-arm: add non-secure quirk
      iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
      iommu/ipmmu-vmsa: Fix IOMMU lookup when multiple IOMMUs are registered

Matt Wagantall (1):
      iopoll: Introduce memory-mapped IO polling macros

Mitchel Humpherys (2):
      iommu/arm-smmu: don't touch the secure STLBIALL register
      iommu/arm-smmu: add support for iova_to_phys through ATS1PR

Peter Zijlstra (1):
      iommu/amd: Fix amd_iommu_free_device()

Quentin Lambert (1):
      iommu/amd: Convert non-returned local variable to boolean when relevant

Robin Murphy (4):
      iommu: Allow building iova.c independently
      iommu: Consolidate IOVA allocator code
      iommu: Make IOVA domain low limit flexible
      iommu: Make IOVA domain page size explicit

Shuah Khan (3):
      iommu: Fix trace_unmap() to report original iova
      iommu: Change trace unmap api to report unmapped size
      iommu: Fix trace_map() to report original iova and original size

Will Deacon (4):
      iommu: introduce generic page table allocation framework
      iommu: add ARM LPAE page table allocator
      iommu: add self-consistency tests to ARM LPAE IO page table allocator
      iommu/arm-smmu: make use of generic LPAE allocator

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  41 +
 MAINTAINERS                                        |   1 +
 arch/arm64/Kconfig                                 |   1 -
 arch/powerpc/include/asm/fsl_pamu_stash.h          |   4 +-
 drivers/iommu/Kconfig                              |  51 +-
 drivers/iommu/Makefile                             |   5 +-
 drivers/iommu/amd_iommu.c                          |  14 +-
 drivers/iommu/amd_iommu_init.c                     |   2 +-
 drivers/iommu/amd_iommu_proto.h                    |   2 +-
 drivers/iommu/amd_iommu_types.h                    |   2 +-
 drivers/iommu/amd_iommu_v2.c                       |  35 +-
 drivers/iommu/arm-smmu.c                           | 935 +++++++------------
 drivers/iommu/fsl_pamu.c                           | 216 ++---
 drivers/iommu/fsl_pamu.h                           |  15 +-
 drivers/iommu/fsl_pamu_domain.c                    | 173 ++--
 drivers/iommu/intel-iommu.c                        |  45 +-
 drivers/iommu/io-pgtable-arm.c                     | 986 +++++++++++++++++++++
 drivers/iommu/io-pgtable.c                         |  82 ++
 drivers/iommu/io-pgtable.h                         | 143 +++
 drivers/iommu/iommu.c                              |   7 +-
 drivers/iommu/iova.c                               |  53 +-
 drivers/iommu/ipmmu-vmsa.c                         | 674 ++++----------
 drivers/iommu/irq_remapping.h                      |   2 +-
 drivers/iommu/omap-iommu.c                         |   2 +-
 include/linux/iopoll.h                             | 144 +++
 include/linux/iova.h                               |  41 +-
 include/linux/platform_data/ipmmu-vmsa.h           |  24 -
 include/trace/events/iommu.h                       |  31 +-
 28 files changed, 2239 insertions(+), 1492 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
 create mode 100644 drivers/iommu/io-pgtable-arm.c
 create mode 100644 drivers/iommu/io-pgtable.c
 create mode 100644 drivers/iommu/io-pgtable.h
 create mode 100644 include/linux/iopoll.h
 delete mode 100644 include/linux/platform_data/ipmmu-vmsa.h

Please pull.

Thanks,

	Joerg


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJU3MSOAAoJECvwRC2XARrjLeAQAKOXYCziHVCqUssAqLvr7Ws6
bGxilbM5sLFvZNDynWv7zl2pyqvB1PqC6Kd120tKc1VBFoErn6VIS/5QsIi93rqW
4v0DPxgp1hltSDvm91GQs2TsnoMebIgi5OMlITs5fRkcNvE9lu6FEulqwFI5/fS4
gb9bww16fyrO4QNSjXRla3U6smcVIcMV/vdu100B21/3wApzQDB7fdWkl0aXidEc
YYQvRVVcq7MavNDQhn66vRpaHfw1mzij/tq/P7yXnHZR1zZ3NLUwzA7jYsX8Gk6L
ZWT4XbMGubVhHa1zrxJOmT9GrO5HDE77q8BoyoI83c9B/2WeVWmKDG3HL89Nwb7L
QVY0Q029xCEtWb2tizS7VL4cjR5Z4p82h+rFuo4//GejlmGGe+pA1GFhZyRl3Bpm
V87Bdrs8n3uk+bnqPLnPrFob2UYNgt2ZYNL2Qb4IOVdGDqKothEMFJcvsNgySROw
Fvep1gb0cNkykZb9miiOE/GGJ+F3Qp7FSqsCjkfmAHPjMkeAEjloTLLkkJOlcRQR
nOWGKLV9xKsiseI0OTlqp7Ew7gbkq2nKDsbkEWhDltG4eoIcrXtCZscCAXWrcNYV
cqFcRXX+2dXZn3wCUujVs1rBMf6OmxuU0lAQQSEo4o9b2HFj0YRwjBPpW3oEdTFW
geafZQC1ls5T/M46Lz1a
=Jubq
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
