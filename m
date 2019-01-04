From: Christoph Hellwig <hch@lst.de>
Subject: Re: crash in gart_unmap_page() with master snapshot (commit
 e1ef035d272e)
Date: Fri, 4 Jan 2019 09:53:18 +0100
Message-ID: <20190104085318.GA15939@lst.de>
References: <20190102083854.GA28932@unicorn.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190102083854.GA28932@unicorn.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi Michal,

can you try the patch below?

---
>From 6b22ae23a1971646dacc8a0ad313a6329a04cf98 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 4 Jan 2019 09:50:33 +0100
Subject: x86/amd_gart: fix unmapping of non-GART mappings

In many cases we don't have to create a GART mapping at all, which
also means there is nothing to unmap.  Fix the range check that was
incorrectly modified when removing the mapping_error method.

Fixes: 9e8aa6b546 ("x86/amd_gart: remove the mapping_error dma_map_ops method")
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/amd_gart_64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index e0ff3ac8c127..2c0aa34af69c 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -256,7 +256,15 @@ static void gart_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	int npages;
 	int i;
 
-	if (dma_addr == DMA_MAPPING_ERROR ||
+	if (WARN_ON_ONCE(dma_addr == DMA_MAPPING_ERROR))
+		return;
+
+	/*
+	 * This driver will not always use a GART mapping, but might have
+	 * created a direct mapping instead.  If that is the case there is
+	 * nothing to unmap here.
+	 */
+	if (dma_addr < iommu_bus_base ||
 	    dma_addr >= iommu_bus_base + iommu_size)
 		return;
 
-- 
2.20.1
