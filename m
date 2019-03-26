From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 RFC/RFT 2/5] dma-remap: Run alloc_pages() on failure
Date: Tue, 26 Mar 2019 16:01:28 -0700
Message-ID: <20190326230131.16275-3-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190326230131.16275-1-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area.

So this patch moves the alloc_pages() call to the fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changlog
v1->v2:
 * PATCH-2: Initialized page pointer to NULL

 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 2b750f13bc8f..c2076c6d6c17 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -109,14 +109,14 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 {
 	unsigned int pool_size_order = get_order(atomic_pool_size);
 	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 	int ret;
 
 	if (dev_get_cma_area(NULL))
 		page = dma_alloc_from_contiguous(NULL, nr_pages,
 						 pool_size_order, false);
-	else
+	if (!page)
 		page = alloc_pages(gfp, pool_size_order);
 	if (!page)
 		goto out;
-- 
2.17.1
