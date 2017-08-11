From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/8] iommu/vt-d: Allow to flush more than 4GB of device TLBs
Date: Fri, 11 Aug 2017 16:41:17 +0200
Message-ID: <1502462478-22045-8-git-send-email-joro@8bytes.org>
References: <1502462478-22045-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502462478-22045-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, dwmw2@infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The shift qi_flush_dev_iotlb() is done on an int, which
limits the mask to 32 bits. Make the mask 64 bits wide so
that more than 4GB of address range can be flushed at once.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index c8b0329..ca5ebae 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1343,7 +1343,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
 
 	if (mask) {
 		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));
-		addr |= (1 << (VTD_PAGE_SHIFT + mask - 1)) - 1;
+		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
 		desc.high = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
 	} else
 		desc.high = QI_DEV_IOTLB_ADDR(addr);
-- 
2.7.4
