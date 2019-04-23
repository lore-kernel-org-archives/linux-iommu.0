From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/3] xen/swiotlb: simplify range_straddles_page_boundary()
Date: Tue, 23 Apr 2019 12:54:56 +0200
Message-ID: <20190423105457.17502-3-jgross@suse.com>
References: <20190423105457.17502-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423105457.17502-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org, Juergen Gross <jgross@suse.com>
List-Id: iommu@lists.linux-foundation.org

range_straddles_page_boundary() is open coding several macros from
include/xen/page.h. Use those instead. Additionally there is no need
to have check_pages_physically_contiguous() as a separate function as
it is used only once, so merge it into range_straddles_page_boundary().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 42a3924e6d91..43b6e65ae256 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -92,34 +92,18 @@ static inline dma_addr_t xen_virt_to_bus(void *address)
 	return xen_phys_to_bus(virt_to_phys(address));
 }
 
-static int check_pages_physically_contiguous(unsigned long xen_pfn,
-					     unsigned int offset,
-					     size_t length)
+static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
-	unsigned long next_bfn;
-	int i;
-	int nr_pages;
+	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
+	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
-	nr_pages = (offset + length + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT;
 
-	for (i = 1; i < nr_pages; i++) {
+	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
-			return 0;
-	}
-	return 1;
-}
+			return 1;
 
-static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
-{
-	unsigned long xen_pfn = XEN_PFN_DOWN(p);
-	unsigned int offset = p & ~XEN_PAGE_MASK;
-
-	if (offset + size <= XEN_PAGE_SIZE)
-		return 0;
-	if (check_pages_physically_contiguous(xen_pfn, offset, size))
-		return 0;
-	return 1;
+	return 0;
 }
 
 static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
-- 
2.16.4
