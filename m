From: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH] iommu: intel: Flush the IOTLB to get rid of the initial kdump mappings
Date: Fri,  5 May 2017 11:39:59 -0700
Message-ID: <1494009599-20962-1-git-send-email-karahmed@amazon.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>, Anthony Liguori <aliguori@amazon.com>
List-Id: iommu@lists.linux-foundation.org

Ever since commit 091d42e43d ("iommu/vt-d: Copy translation tables from
old kernel") the kdump kernel copies the IOMMU context tables from the
previous kernel. Each device mappings will be destroyed once the driver
for the respective device takes over.

This unfortunately breaks the workflow of mapping and unmapping a new
context to the IOMMU. The mapping function assumes that either:

1) Unmapping did the proper IOMMU flushing and it only ever flush if the
   IOMMU unit supports caching invalid entries.
2) The system just booted and the initialization code took care of
   flushing all IOMMU caches.

This assumption is not true for the kdump kernel since the context
tables have been copied from the previous kernel and translations could
have been cached ever since. So make sure to flush the IOTLB as well
when we destroy these old copied mappings.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Anthony Liguori <aliguori@amazon.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/iommu/intel-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d412a31..478130d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2050,11 +2050,14 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_copied(context)) {
 		u16 did_old = context_domain_id(context);
 
-		if (did_old >= 0 && did_old < cap_ndoms(iommu->cap))
+		if (did_old >= 0 && did_old < cap_ndoms(iommu->cap)) {
 			iommu->flush.flush_context(iommu, did_old,
 						   (((u16)bus) << 8) | devfn,
 						   DMA_CCMD_MASK_NOBIT,
 						   DMA_CCMD_DEVICE_INVL);
+			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
+						 DMA_TLB_DSI_FLUSH);
+		}
 	}
 
 	pgd = domain->pgd;
-- 
2.7.4
