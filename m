From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] dma-mapping: use obj-y instead of lib-y for generic dma ops
Date: Thu, 14 Jun 2018 14:00:28 +0200
Message-ID: <20180614120029.27315-2-hch@lst.de>
References: <20180614120029.27315-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614120029.27315-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We already have exact config symbols to select the direct, non-coherent,
or virt dma ops.  So use the normal obj- scheme to select them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 956b320292fe..5e0e160c9242 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -29,9 +29,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
-lib-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
-lib-$(CONFIG_DMA_NONCOHERENT_OPS) += dma-noncoherent.o
-lib-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
+obj-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
+obj-$(CONFIG_DMA_NONCOHERENT_OPS) += dma-noncoherent.o
+obj-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
-- 
2.17.1
