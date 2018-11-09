From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/7] vfio/type1: Remove map_try_harder() code path
Date: Fri,  9 Nov 2018 12:07:12 +0100
Message-ID: <20181109110712.12469-8-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The AMD IOMMU driver can now map a huge-page where smaller
mappings existed before, so this code-path is no longer
triggered.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/vfio/vfio_iommu_type1.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d9fd3188615d..7651cfb14836 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -978,32 +978,6 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	return ret;
 }
 
-/*
- * Turns out AMD IOMMU has a page table bug where it won't map large pages
- * to a region that previously mapped smaller pages.  This should be fixed
- * soon, so this is just a temporary workaround to break mappings down into
- * PAGE_SIZE.  Better to map smaller pages than nothing.
- */
-static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
-			  unsigned long pfn, long npage, int prot)
-{
-	long i;
-	int ret = 0;
-
-	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
-		ret = iommu_map(domain->domain, iova,
-				(phys_addr_t)pfn << PAGE_SHIFT,
-				PAGE_SIZE, prot | domain->prot);
-		if (ret)
-			break;
-	}
-
-	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
-		iommu_unmap(domain->domain, iova, PAGE_SIZE);
-
-	return ret;
-}
-
 static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 			  unsigned long pfn, long npage, int prot)
 {
@@ -1013,11 +987,8 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | d->prot);
-		if (ret) {
-			if (ret != -EBUSY ||
-			    map_try_harder(d, iova, pfn, npage, prot))
-				goto unwind;
-		}
+		if (ret)
+			goto unwind;
 
 		cond_resched();
 	}
-- 
2.17.1
