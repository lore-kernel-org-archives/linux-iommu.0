From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] dma-mapping: remove a pointless memset in dma_atomic_pool_init
Date: Tue,  4 Dec 2018 08:06:19 -0800
Message-ID: <20181204160619.3253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We already zero the memory after allocating it from the pool that
this function fills, and having the memset here in this form means
we can't support CMA highmem allocations.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reported-by: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
---
 kernel/dma/remap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 68a64e3ff6a1..6e784824326f 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -121,7 +121,6 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 	if (!page)
 		goto out;
 
-	memset(page_address(page), 0, atomic_pool_size);
 	arch_dma_prep_coherent(page, atomic_pool_size);
 
 	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
-- 
2.19.1
