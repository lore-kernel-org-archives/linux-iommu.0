From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] iommu/vt-d: Delete unnecessary check
Date: Sun,  8 Oct 2017 23:33:31 +0100
Message-ID: <1507502011-18062-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Variable did_old is unsigned so checking whether it is greater or equal
to zero is not necessary.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ebb4835..cb7ce99 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2054,7 +2054,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_copied(context)) {
 		u16 did_old = context_domain_id(context);
 
-		if (did_old >= 0 && did_old < cap_ndoms(iommu->cap)) {
+		if (did_old < cap_ndoms(iommu->cap)) {
 			iommu->flush.flush_context(iommu, did_old,
 						   (((u16)bus) << 8) | devfn,
 						   DMA_CCMD_MASK_NOBIT,
-- 
2.7.4
