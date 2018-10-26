From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] second round of dma mapping updates for 4.20
Date: Fri, 26 Oct 2018 15:24:03 +0200
Message-ID: <20181026132403.GA23693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: iommu@lists.linux-foundation.org

The following changes since commit b9fd04262a8abc366f40a9e97598e94591352c26:

  dma-direct: respect DMA_ATTR_NO_WARN (2018-10-09 15:08:46 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-1

for you to fetch changes up to 886643b766321f15f63bd950be618cbb6dd22bbc:

  arm64: use the generic swiotlb_dma_ops (2018-10-19 08:53:24 +0200)

----------------------------------------------------------------
Second batch of dma-mapping updates for 4.20:

 - various swiotlb cleanups
 - do not dip into the ѕwiotlb pool for dma coherent allocations
 - add support for not cache coherent DMA to swiotlb
 - switch ARM64 to use the generic swiotlb_dma_ops

----------------------------------------------------------------
Christoph Hellwig (10):
      swiotlb: remove a pointless comment
      swiotlb: mark is_swiotlb_buffer static
      swiotlb: do not panic on mapping failures
      swiotlb: remove the overflow buffer
      swiotlb: merge swiotlb_unmap_page and unmap_single
      swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
      swiotlb: refactor swiotlb_map_page
      swiotlb: don't dip into swiotlb pool for coherent allocations
      swiotlb: add support for non-coherent DMA
      arm64: use the generic swiotlb_dma_ops

 arch/arm64/Kconfig                   |   4 +
 arch/arm64/include/asm/device.h      |   1 -
 arch/arm64/include/asm/dma-mapping.h |   7 +-
 arch/arm64/mm/dma-mapping.c          | 257 ++++++---------------------
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 include/linux/dma-direct.h           |   2 +
 include/linux/swiotlb.h              |   9 -
 kernel/dma/direct.c                  |   2 -
 kernel/dma/swiotlb.c                 | 326 +++++++----------------------------
 9 files changed, 123 insertions(+), 489 deletions(-)
