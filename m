From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma mapping updates for 4.19
Date: Mon, 13 Aug 2018 10:15:20 +0300
Message-ID: <20180813071520.GA25481@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19

for you to fetch changes up to 6fa1d28e38cfa0c90f8d64c0cab37769e5337b85:

  sh: use generic dma_noncoherent_ops (2018-08-02 13:54:20 +0200)

----------------------------------------------------------------
dma-mapping updates for 4.19

 - a series from Robin to fix bus imposed dma limits by adding a separate
   mask for them to struct device instead of trying to squeeze a second
   meaning out of the existing dma mask as we did before.  This has ACKs
   from the various other subsystems touched
 - a small swiotlb cleanup from Kees (acked by Konrad)
 - conversion of nios2 and sh to the new generic dma-noncoherent code.
   Various other architecture conversions will come through the
   architectures maintainers trees.

----------------------------------------------------------------
Christoph Hellwig (6):
      nios2: use generic dma_noncoherent_ops
      sh: simplify get_arch_dma_ops
      sh: introduce a sh_cacheop_vaddr helper
      sh: use dma_direct_ops for the CONFIG_DMA_COHERENT case
      sh: split arch/sh/mm/consistent.c
      sh: use generic dma_noncoherent_ops

Kees Cook (1):
      swiotlb: clean up reporting

Robin Murphy (9):
      dma-mapping: relax warning for per-device areas
      of/platform: Initialise default DMA masks
      ACPI/IORT: Support address size limit for root complexes
      dma-mapping: Generalise dma_32bit_limit flag
      ACPI/IORT: Set bus DMA mask as appropriate
      of/device: Set bus DMA mask as appropriate
      iommu/dma: Respect bus DMA limit for IOVAs
      ACPI/IORT: Don't set default coherent DMA mask
      OF: Don't set default coherent DMA mask

 arch/nios2/Kconfig                   |   3 +
 arch/nios2/include/asm/Kbuild        |   1 +
 arch/nios2/include/asm/dma-mapping.h |  20 -----
 arch/nios2/mm/dma-mapping.c          | 139 ++++-------------------------------
 arch/sh/Kconfig                      |   4 +-
 arch/sh/include/asm/Kbuild           |   1 +
 arch/sh/include/asm/cacheflush.h     |   7 ++
 arch/sh/include/asm/dma-mapping.h    |  23 ------
 arch/sh/kernel/Makefile              |   4 +-
 arch/sh/kernel/dma-coherent.c        |  83 +++++++++++++++++++++
 arch/sh/kernel/dma-nommu.c           |  88 ----------------------
 arch/sh/mm/consistent.c              |  87 ----------------------
 arch/sh/mm/init.c                    |  10 ---
 arch/x86/kernel/pci-dma.c            |   2 +-
 drivers/acpi/arm64/iort.c            |  48 ++++++++----
 drivers/iommu/dma-iommu.c            |   3 +
 drivers/of/device.c                  |  21 +++---
 drivers/of/platform.c                |   3 +
 drivers/sh/maple/maple.c             |   7 +-
 include/linux/device.h               |   6 +-
 include/linux/dma-mapping.h          |   9 ++-
 kernel/dma/direct.c                  |   6 +-
 kernel/dma/swiotlb.c                 |  18 ++---
 23 files changed, 192 insertions(+), 401 deletions(-)
 delete mode 100644 arch/nios2/include/asm/dma-mapping.h
 delete mode 100644 arch/sh/include/asm/dma-mapping.h
 create mode 100644 arch/sh/kernel/dma-coherent.c
 delete mode 100644 arch/sh/kernel/dma-nommu.c
