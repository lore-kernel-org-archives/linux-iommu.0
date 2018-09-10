From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] dma-mapping: use phys_to_dma in dma_direct_get_required
Date: Mon, 10 Sep 2018 08:13:32 +0200
Message-ID: <20180910061332.28187-4-hch@lst.de>
References: <20180910061332.28187-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910061332.28187-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We need to apply an DMA offset for the function to work as expected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7812b861b6da..6feac7294f8d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -15,7 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -1185,7 +1185,7 @@ int __init platform_bus_init(void)
  */
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 end = ((max_pfn - 1) << PAGE_SHIFT);
+	u64 end = phys_to_dma(dev, (max_pfn - 1) << PAGE_SHIFT);
 
 	return (1 << (fls64(end) - 1)) * 2 - 1;
 }
-- 
2.18.0
