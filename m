From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/3] dma-mapping: clear dangling pointers consistently
Date: Thu, 13 Sep 2018 17:17:13 +0200
Message-ID: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-renesas-soc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: iommu@lists.linux-foundation.org

When working with dma_set_max_seg_size(), I noticed issues with a
dangling dma_parms pointer. I saw Christoph just worked on handling
something similar for the dma_ops pointer, too. I came up with three
patches on top of Christoph's work which I send out for discussion here:

Patch 1 fixes a meanwhile stale comment.

Patch 2 makes clearing the dma_ops pointer more consistent because it
was missed on the custom ARM implementation to the best of my knowledge.

Patch 3 generalizes teardown_dma_ops to teardown_dma, so that clearing
dma_parms can be added there.

All these patches are based on the dma-mapping for-next branch. They are
build tested and runtime tested on a Renesas Salvator-XS board (R-Car
M3-N, ARM64) and Renesas Lager board (R-Car H2, ARM32).

A branch containing these (and dma_parms additions for the above boards)
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/set_max_seg

Looking forward to opinions.

Regards,

   Wolfram


Wolfram Sang (3):
  ARM: dma-mapping: update comment about handling dma_ops when detaching
    from IOMMU
  dma-mapping: clear dma_ops pointer also on ARM
  dma-mapping: clear dma_parms on teardown, too

 arch/arm/mm/dma-mapping.c   | 8 ++++----
 include/linux/dma-mapping.h | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.18.0
