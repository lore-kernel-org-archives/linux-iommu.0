From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/4] vfio/type1: Make use of iommu_unmap_fast()
Date: Fri, 13 Oct 2017 16:40:12 +0200
Message-ID: <1507905613-30695-4-git-send-email-joro@8bytes.org>
References: <1507905613-30695-1-git-send-email-joro@8bytes.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507905613-30695-1-git-send-email-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Switch from using iommu_unmap to iommu_unmap_fast() and add
the necessary calls the the IOTLB invalidation routines.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/vfio/vfio_iommu_type1.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 92155cc..2b1e81f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -672,10 +672,13 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				      struct vfio_domain, next);
 
 	list_for_each_entry_continue(d, &iommu->domain_list, next) {
-		iommu_unmap(d->domain, dma->iova, dma->size);
+		iommu_unmap_fast(d->domain, dma->iova, dma->size);
+		iommu_tlb_range_add(d->domain, dma->iova, dma->size);
 		cond_resched();
 	}
 
+	iommu_tlb_sync(domain->domain);
+
 	while (iova < end) {
 		size_t unmapped, len;
 		phys_addr_t phys, next;
@@ -698,10 +701,13 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				break;
 		}
 
-		unmapped = iommu_unmap(domain->domain, iova, len);
+		unmapped = iommu_unmap_fast(domain->domain, iova, len);
 		if (WARN_ON(!unmapped))
 			break;
 
+		iommu_tlb_range_add(domain->domain, iova, unmapped);
+		iommu_tlb_sync(domain->domain);
+
 		unlocked += vfio_unpin_pages_remote(dma, iova,
 						    phys >> PAGE_SHIFT,
 						    unmapped >> PAGE_SHIFT,
@@ -885,7 +891,9 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
 	}
 
 	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
-		iommu_unmap(domain->domain, iova, PAGE_SIZE);
+		iommu_unmap_fast(domain->domain, iova, PAGE_SIZE);
+
+	iommu_tlb_sync(domain->domain);
 
 	return ret;
 }
@@ -912,7 +920,9 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 
 unwind:
 	list_for_each_entry_continue_reverse(d, &iommu->domain_list, next)
-		iommu_unmap(d->domain, iova, npage << PAGE_SHIFT);
+		iommu_unmap_fast(d->domain, iova, npage << PAGE_SHIFT);
+
+	iommu_tlb_sync(d->domain);
 
 	return ret;
 }
@@ -1136,12 +1146,14 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain)
 	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
 			IOMMU_READ | IOMMU_WRITE | domain->prot);
 	if (!ret) {
-		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
+		size_t unmapped = iommu_unmap_fast(domain->domain, 0, PAGE_SIZE);
 
 		if (unmapped == PAGE_SIZE)
-			iommu_unmap(domain->domain, PAGE_SIZE, PAGE_SIZE);
+			iommu_unmap_fast(domain->domain, PAGE_SIZE, PAGE_SIZE);
 		else
 			domain->fgsp = true;
+
+		iommu_tlb_sync(domain->domain);
 	}
 
 	__free_pages(pages, order);
-- 
2.7.4
