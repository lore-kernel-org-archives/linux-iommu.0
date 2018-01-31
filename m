From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma-mapping updates for Linux 4.16
Date: Wed, 31 Jan 2018 08:43:41 +0100
Message-ID: <20180131074341.z6rusttptrcgezi5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

below is the update for the dma-mapping subsystem for Linux 4.16.
Except for a runtime warning fix from Christian this is all about
consolidating the direct mapping and swiotlb dma maps based on the
x86 code, which will hopefully be switched to this generic code
as well in the next merge window.

Note that there is a small conflict in lib/Kconfig with the block
updates you have already pulled: the block tree adds a new symbol
right next to the symbol that gets renamed in this tree.  The
fix is obvious.

The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:

  Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.16

for you to fetch changes up to 04f56534786c885f578c24461bcd782fe9a787cf:

  MAINTAINERS: add the iommu list for swiotlb and xen-swiotlb (2018-01-25 1=
6:14:15 +0100)

----------------------------------------------------------------
dma mapping changes for Linux 4.16:

This pull requests contains a consolidation of the generic no-IOMMU code,
a well as the glue code for swiotlb.  All the code is based on the x86
implementation with hooks to allow all architectures that aren't cache
coherent to use it.  The x86 conversion itself has been deferred because
the x86 maintainers were a little busy in the last months.

----------------------------------------------------------------
Christian K=F6nig (1):
      swiotlb: suppress warning when __GFP_NOWARN is set

Christoph Hellwig (56):
      alpha: mark jensen as broken
      hexagon: remove unused flush_write_buffers definition
      m32r: remove unused flush_write_buffers definition
      powerpc: remove unused flush_write_buffers definition
      arc: remove CONFIG_ARC_PLAT_NEEDS_PHYS_TO_DMA
      m32r: remove the unused dma_capable helper
      riscv: remove the unused dma_capable helper
      s390: remove the unused dma_capable helper
      dma-mapping: take dma_pfn_offset into account in dma_max_pfn
      arm64: don't override dma_max_pfn
      mips: fix an off-by-one in dma_capable
      dma-mapping: move swiotlb arch helpers to a new header
      dma-mapping: move dma_mark_clean to dma-direct.h
      hexagon: use the generic dma_capable helper
      powerpc: rename dma_direct_ to dma_nommu_
      microblaze: rename dma_direct to dma_nommu
      microblaze: remove dma_nommu_dma_supported
      microblaze: remove the dead !NOT_COHERENT_CACHE dma code
      s390: move s390_pci_dma_ops to asm/pci_dma.h
      dma-mapping: warn when there is no coherent_dma_mask
      dma-mapping: clear harmful GFP_* flags in common code
      dma-mapping: add an arch_dma_supported hook
      dma-mapping: provide a generic asm/dma-mapping.h
      dma-direct: rename dma_noop to dma_direct
      dma-direct: use phys_to_dma
      dma-direct: add dma address sanity checks
      dma-direct: add support for CMA allocation
      dma-direct: use node local allocations for coherent memory
      dma-direct: add support for allocation from ZONE_DMA and ZONE_DMA32
      dma-direct: retry allocations using GFP_DMA for small masks
      dma-direct: make dma_direct_{alloc,free} available to other implement=
ations
      dma-direct: reject too small dma masks
      cris: use dma-direct
      h8300: use dma-direct
      arm64: rename swiotlb_dma_ops
      ia64: rename swiotlb_dma_ops
      powerpc: rename swiotlb_dma_ops
      x86: rename swiotlb_dma_ops
      swiotlb: rename swiotlb_free to swiotlb_exit
      swiotlb: add common swiotlb_map_ops
      swiotlb: wire up ->dma_supported in swiotlb_dma_ops
      swiotlb: refactor coherent buffer freeing
      swiotlb: refactor coherent buffer allocation
      swiotlb: remove various exports
      ia64: replace ZONE_DMA with ZONE_DMA32
      ia64: use generic swiotlb_ops
      ia64: clean up swiotlb support
      ia64: remove an ifdef around the content of pci-dma.c
      unicore32: use generic swiotlb_ops
      tile: replace ZONE_DMA with ZONE_DMA32
      tile: use generic swiotlb_ops
      mips/netlogic: remove swiotlb support
      mips: use swiotlb_{alloc,free}
      arm64: replace ZONE_DMA with ZONE_DMA32
      arm64: use swiotlb_alloc and swiotlb_free
      MAINTAINERS: add the iommu list for swiotlb and xen-swiotlb

 MAINTAINERS                                        |   7 +-
 arch/Kconfig                                       |   4 +
 arch/alpha/Kconfig                                 |   1 +
 arch/arc/Kconfig                                   |   3 -
 arch/arc/include/asm/dma-mapping.h                 |   7 -
 arch/arc/mm/dma.c                                  |  14 +-
 arch/arm/Kconfig                                   |   3 +-
 arch/arm/include/asm/dma-direct.h                  |  36 ++++
 arch/arm/include/asm/dma-mapping.h                 |  35 +---
 arch/arm/mm/dma-mapping-nommu.c                    |  13 +-
 arch/arm64/Kconfig                                 |   3 +-
 arch/arm64/include/asm/dma-mapping.h               |  35 ----
 arch/arm64/mm/dma-mapping.c                        |  54 +-----
 arch/arm64/mm/init.c                               |  16 +-
 arch/cris/Kconfig                                  |   4 +
 arch/cris/arch-v32/drivers/pci/Makefile            |   2 +-
 arch/cris/arch-v32/drivers/pci/dma.c               |  80 --------
 arch/cris/include/asm/Kbuild                       |   1 +
 arch/cris/include/asm/dma-mapping.h                |  20 --
 arch/h8300/Kconfig                                 |   1 +
 arch/h8300/include/asm/Kbuild                      |   1 +
 arch/h8300/include/asm/dma-mapping.h               |  12 --
 arch/h8300/kernel/Makefile                         |   2 +-
 arch/h8300/kernel/dma.c                            |  69 -------
 arch/hexagon/include/asm/dma-mapping.h             |   7 -
 arch/hexagon/include/asm/io.h                      |   2 -
 arch/hexagon/kernel/dma.c                          |   1 +
 arch/ia64/Kconfig                                  |   8 +-
 arch/ia64/hp/common/hwsw_iommu.c                   |   2 +-
 arch/ia64/include/asm/dma-mapping.h                |  19 --
 arch/ia64/include/asm/dma.h                        |   2 -
 arch/ia64/include/asm/swiotlb.h                    |  18 --
 arch/ia64/kernel/dma-mapping.c                     |   9 +
 arch/ia64/kernel/pci-dma.c                         |  19 +-
 arch/ia64/kernel/pci-swiotlb.c                     |  68 -------
 arch/ia64/mm/contig.c                              |   4 +-
 arch/ia64/mm/discontig.c                           |   8 +-
 arch/m32r/Kconfig                                  |   2 +-
 arch/m32r/include/asm/Kbuild                       |   1 +
 arch/m32r/include/asm/dma-mapping.h                |  24 ---
 arch/m32r/include/asm/io.h                         |   2 -
 arch/m68k/kernel/dma.c                             |   2 -
 arch/microblaze/include/asm/dma-mapping.h          |   4 +-
 arch/microblaze/kernel/dma.c                       |  78 +++-----
 arch/mips/Kconfig                                  |   2 +
 arch/mips/cavium-octeon/Kconfig                    |   1 +
 arch/mips/cavium-octeon/dma-octeon.c               |  29 +--
 arch/mips/include/asm/dma-direct.h                 |   1 +
 arch/mips/include/asm/dma-mapping.h                |  10 -
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   8 +
 arch/mips/include/asm/mach-generic/dma-coherence.h |  12 --
 .../include/asm/mach-loongson64/dma-coherence.h    |   8 +
 arch/mips/include/asm/netlogic/common.h            |   3 -
 arch/mips/loongson64/Kconfig                       |   1 +
 arch/mips/loongson64/common/dma-swiotlb.c          |  24 +--
 arch/mips/mm/dma-default.c                         |   3 -
 arch/mips/netlogic/Kconfig                         |   5 -
 arch/mips/netlogic/common/Makefile                 |   1 -
 arch/mips/netlogic/common/nlm-dma.c                |  97 ----------
 arch/mn10300/mm/dma-alloc.c                        |   3 -
 arch/nios2/mm/dma-mapping.c                        |   3 -
 arch/parisc/kernel/pci-dma.c                       |   7 -
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/dma-direct.h              |  29 +++
 arch/powerpc/include/asm/dma-mapping.h             |  36 +---
 arch/powerpc/include/asm/swiotlb.h                 |   4 +-
 arch/powerpc/kernel/dma-iommu.c                    |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c                  |  12 +-
 arch/powerpc/kernel/dma.c                          |  73 ++++----
 arch/powerpc/kernel/pci-common.c                   |   2 +-
 arch/powerpc/kernel/setup-common.c                 |   2 +-
 arch/powerpc/platforms/cell/iommu.c                |  28 +--
 arch/powerpc/platforms/pasemi/iommu.c              |   2 +-
 arch/powerpc/platforms/pasemi/setup.c              |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   4 +-
 arch/powerpc/platforms/pseries/iommu.c             |   2 +-
 arch/powerpc/platforms/pseries/vio.c               |   2 +-
 arch/powerpc/sysdev/dart_iommu.c                   |   4 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   4 +-
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/include/asm/Kbuild                      |   1 +
 arch/riscv/include/asm/dma-mapping.h               |  38 ----
 arch/s390/Kconfig                                  |   2 +-
 arch/s390/include/asm/Kbuild                       |   1 +
 arch/s390/include/asm/dma-mapping.h                |  26 ---
 arch/s390/include/asm/pci_dma.h                    |   3 +
 arch/tile/Kconfig                                  |   3 +-
 arch/tile/include/asm/dma-mapping.h                |  20 --
 arch/tile/kernel/pci-dma.c                         |  38 +---
 arch/tile/kernel/setup.c                           |   8 +-
 arch/unicore32/include/asm/dma-mapping.h           |  29 +--
 arch/unicore32/mm/Kconfig                          |   1 +
 arch/unicore32/mm/Makefile                         |   2 -
 arch/unicore32/mm/dma-swiotlb.c                    |  48 -----
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/dma-direct.h                  |  30 +++
 arch/x86/include/asm/dma-mapping.h                 |  29 +--
 arch/x86/include/asm/swiotlb.h                     |   2 -
 arch/x86/kernel/amd_gart_64.c                      |   1 +
 arch/x86/kernel/pci-dma.c                          |  23 ++-
 arch/x86/kernel/pci-nommu.c                        |   2 +-
 arch/x86/kernel/pci-swiotlb.c                      |   8 +-
 arch/x86/mm/mem_encrypt.c                          |   2 +-
 arch/x86/pci/sta2x11-fixup.c                       |   1 +
 arch/xtensa/include/asm/dma-mapping.h              |  10 -
 drivers/crypto/marvell/cesa.c                      |   1 +
 drivers/iommu/intel-iommu.c                        |   2 +-
 drivers/misc/cxl/vphb.c                            |   2 +-
 drivers/mtd/nand/qcom_nandc.c                      |   1 +
 drivers/xen/swiotlb-xen.c                          |   2 +-
 include/asm-generic/dma-mapping.h                  |  10 +
 include/linux/dma-direct.h                         |  47 +++++
 include/linux/dma-mapping.h                        |  23 ++-
 include/linux/swiotlb.h                            |  12 +-
 lib/Kconfig                                        |   2 +-
 lib/Makefile                                       |   2 +-
 lib/dma-direct.c                                   | 156 ++++++++++++++++
 lib/dma-noop.c                                     |  68 -------
 lib/swiotlb.c                                      | 205 +++++++++++++----=
----
 119 files changed, 728 insertions(+), 1266 deletions(-)
 create mode 100644 arch/arm/include/asm/dma-direct.h
 delete mode 100644 arch/cris/arch-v32/drivers/pci/dma.c
 delete mode 100644 arch/cris/include/asm/dma-mapping.h
 delete mode 100644 arch/h8300/include/asm/dma-mapping.h
 delete mode 100644 arch/h8300/kernel/dma.c
 delete mode 100644 arch/ia64/include/asm/swiotlb.h
 delete mode 100644 arch/ia64/kernel/pci-swiotlb.c
 delete mode 100644 arch/m32r/include/asm/dma-mapping.h
 create mode 100644 arch/mips/include/asm/dma-direct.h
 delete mode 100644 arch/mips/netlogic/common/nlm-dma.c
 create mode 100644 arch/powerpc/include/asm/dma-direct.h
 delete mode 100644 arch/riscv/include/asm/dma-mapping.h
 delete mode 100644 arch/s390/include/asm/dma-mapping.h
 delete mode 100644 arch/unicore32/mm/dma-swiotlb.c
 create mode 100644 arch/x86/include/asm/dma-direct.h
 create mode 100644 include/asm-generic/dma-mapping.h
 create mode 100644 include/linux/dma-direct.h
 create mode 100644 lib/dma-direct.c
 delete mode 100644 lib/dma-noop.c
