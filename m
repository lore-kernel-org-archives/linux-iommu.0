From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/3] xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
Date: Tue, 23 Apr 2019 12:54:55 +0200
Message-ID: <20190423105457.17502-2-jgross@suse.com>
References: <20190423105457.17502-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423105457.17502-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org, Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The condition in xen_swiotlb_free_coherent() for deciding whether to
call xen_destroy_contiguous_region() is wrong: in case the region to
be freed is not contiguous calling xen_destroy_contiguous_region() is
the wrong thing to do: it would result in inconsistent mappings of
multiple PFNs to the same MFN. This will lead to various strange
crashes or data corruption.

Instead of calling xen_destroy_contiguous_region() in that case a
warning should be issued as that situation should never occur.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2a94f4..42a3924e6d91 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -360,8 +360,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (((dev_addr + size - 1 <= dma_mask)) ||
-	    range_straddles_page_boundary(phys, size))
+	if ((dev_addr + size - 1 <= dma_mask) &&
+	    !WARN_ON(range_straddles_page_boundary(phys, size)))
 		xen_destroy_contiguous_region(phys, order);
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
-- 
2.16.4
