From: Filippo Sironi <sironi@amazon.de>
Subject: [PATCH] intel-iommu: Don't be too aggressive when clearing one context entry
Date: Mon, 28 Aug 2017 16:16:29 +0200
Message-ID: <1503929789-26698-1-git-send-email-sironi@amazon.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Filippo Sironi <sironi@amazon.de>, David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Previously, we were invalidating context cache and IOTLB globally when
clearing one context entry.  This is a tad too aggressive.
Invalidate the context cache and IOTLB for the interested device only.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/intel-iommu.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3e8636f1220e..4bf3e59b0929 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2351,13 +2351,32 @@ static inline int domain_pfn_mapping(struct dmar_domain *domain, unsigned long i
 
 static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
+	unsigned long flags;
+	struct context_entry *context;
+	u16 did_old;
+
 	if (!iommu)
 		return;
 
+	spin_lock_irqsave(&iommu->lock, flags);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!context) {
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		return;
+	}
+	did_old = context_domain_id(context);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 	clear_context_table(iommu, bus, devfn);
-	iommu->flush.flush_context(iommu, 0, 0, 0,
-					   DMA_CCMD_GLOBAL_INVL);
-	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	iommu->flush.flush_context(iommu,
+				   did_old,
+				   (((u16)bus) << 8) | devfn,
+				   DMA_CCMD_MASK_NOBIT,
+				   DMA_CCMD_DEVICE_INVL);
+	iommu->flush.flush_iotlb(iommu,
+				 did_old,
+				 0,
+				 0,
+				 DMA_TLB_DSI_FLUSH);
 }
 
 static inline void unlink_domain_info(struct device_domain_info *info)
-- 
2.7.4
