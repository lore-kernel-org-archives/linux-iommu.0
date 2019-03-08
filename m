From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping updates for 5.1
Date: Fri, 8 Mar 2019 09:42:14 +0100
Message-ID: <20190308084214.GA17628@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

plese pull the dma-mapping updates below.

There are various conflicts this time.  Most of them are Kconfig conflicts
that just have changes right next to each other, where you should take both.

Additionally the powerpc tree that is now merged switched the powerpc code
to use the generic dma direct code, which means some code touched by this
pull request has now been removed - please take that variant now in mainline
through the powerpc tree.

Also note that the rpmsg adds a new user of dma_declare_coherent_memory,
which loses its last parameter tree.  So when you merge that tree it will
require a manual fixup to compile even if there is no merge conflict.

Last but not least the v4l-dvd tree removes the sh_mobile_ceu driver,
which is trivially modified in this pull request - just stick to the
removal for it, obviously.

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.1

for you to fetch changes up to 9eb9e96e97b3381e94cba81d93f4a390c26ca6cb:

  Documentation/DMA-API-HOWTO: update dma_mask sections (2019-02-20 07:29:47 -0700)

----------------------------------------------------------------
DMA mapping updates for 5.1

 - add debugfs support for dumping dma-debug information (Corentin Labbe)
 - Kconfig cleanups (Andy Shevchenko and me)
 - debugfs cleanups (Greg Kroah-Hartman)
 - improve dma_map_resource and use it in the media code
 - arch_setup_dma_ops / arch_teardown_dma_ops cleanups
 - various small cleanups and improvements for the per-device coherent
   allocator
 - make the DMA mask an upper bound and don't fail "too large" dma mask
   in the remaning two architectures - this will allow big driver
   cleanups in the following merge windows

----------------------------------------------------------------
Andy Shevchenko (1):
      dma-mapping: move debug configuration options to kernel/dma

Christoph Hellwig (18):
      dma-mapping: remove the default map_resource implementation
      dma-mapping: don't BUG when calling dma_map_resource on RAM
      videobuf2: replace a layering violation with dma_map_resource
      dma-mapping: add a kconfig symbol for arch_setup_dma_ops availability
      dma-mapping: add a kconfig symbol for arch_teardown_dma_ops availability
      mfd/sm501: depend on HAS_DMA
      device.h: dma_mem is only needed for HAVE_GENERIC_DMA_COHERENT
      of: select OF_RESERVED_MEM automatically
      dma-mapping: remove an incorrect __iommem annotation
      dma-mapping: improve selection of dma_declare_coherent availability
      dma-mapping: move CONFIG_DMA_CMA to kernel/dma/Kconfig
      dma-mapping: remove dma_mark_declared_memory_occupied
      dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag
      ccio: allow large DMA masks
      sparc64: refactor the ali DMA quirk
      sparc64/iommu: allow large DMA masks
      sparc64/pci_sun4v: allow large DMA masks
      Documentation/DMA-API-HOWTO: update dma_mask sections

Corentin Labbe (1):
      dma-debug: add dumping facility via debugfs

Greg Kroah-Hartman (1):
      dma: debug: no need to check return value of debugfs_create functions

 Documentation/DMA-API-HOWTO.txt                    | 121 +++++++--------------
 Documentation/DMA-API.txt                          |  29 +----
 arch/arc/Kconfig                                   |   3 +-
 arch/arc/include/asm/Kbuild                        |   1 +
 arch/arc/include/asm/dma-mapping.h                 |  13 ---
 arch/arm/Kconfig                                   |   5 +-
 arch/arm/include/asm/dma-mapping.h                 |   9 --
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |  12 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |   3 +-
 arch/arm/mm/dma-mapping.c                          |   2 +
 arch/arm64/Kconfig                                 |   4 +-
 arch/arm64/include/asm/dma-mapping.h               |   9 --
 arch/csky/Kconfig                                  |   2 -
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/include/asm/dma-mapping.h                |  10 --
 arch/mips/mm/dma-noncoherent.c                     |   8 ++
 arch/powerpc/Kconfig                               |   1 -
 arch/powerpc/kernel/dma-swiotlb.c                  |   1 +
 arch/powerpc/kernel/dma.c                          |   1 +
 arch/riscv/Kconfig                                 |   1 -
 arch/sh/Kconfig                                    |   2 +-
 arch/sh/boards/mach-ap325rxa/setup.c               |   5 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   6 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   5 +-
 arch/sh/boards/mach-migor/setup.c                  |   5 +-
 arch/sh/boards/mach-se/7724/setup.c                |   6 +-
 arch/sh/drivers/pci/fixups-dreamcast.c             |   3 +-
 arch/sparc/kernel/iommu.c                          |  13 +--
 arch/sparc/kernel/kernel.h                         |   6 +-
 arch/sparc/kernel/pci.c                            |  46 +++-----
 arch/sparc/kernel/pci_sun4v.c                      |  18 +--
 arch/unicore32/Kconfig                             |   1 -
 arch/x86/Kconfig                                   |   1 -
 arch/xtensa/Kconfig                                |   1 -
 drivers/base/Kconfig                               |  77 -------------
 .../media/common/videobuf2/videobuf2-dma-contig.c  |  41 ++-----
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |   3 +-
 drivers/mfd/Kconfig                                |   3 +
 drivers/of/Kconfig                                 |   6 +-
 drivers/parisc/ccio-dma.c                          |   4 +-
 drivers/usb/host/ohci-sm501.c                      |   3 +-
 drivers/usb/host/ohci-tmio.c                       |   2 +-
 include/linux/device.h                             |   2 +
 include/linux/dma-mapping.h                        |  61 +++++------
 kernel/dma/Kconfig                                 | 121 ++++++++++++++++++++-
 kernel/dma/Makefile                                |   2 +-
 kernel/dma/coherent.c                              |  50 ++-------
 kernel/dma/debug.c                                 | 108 ++++++------------
 kernel/dma/direct.c                                |  14 +++
 lib/Kconfig.debug                                  |  36 ------
 50 files changed, 344 insertions(+), 544 deletions(-)
 delete mode 100644 arch/arc/include/asm/dma-mapping.h
