From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] iommu: remove unnecessary code
Date: Wed, 10 May 2017 22:49:31 -0500
Message-ID: <20170511034931.GA9483@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: iommu@lists.linux-foundation.org

did_old is an unsigned variable and, greater-than-or-equal-to-zero
comparison of an unsigned variable is always true.

Addresses-Coverity-ID: 1398477
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d412a31..98daf4a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2050,7 +2050,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_copied(context)) {
 		u16 did_old = context_domain_id(context);
 
-		if (did_old >= 0 && did_old < cap_ndoms(iommu->cap))
+		if (did_old < cap_ndoms(iommu->cap))
 			iommu->flush.flush_context(iommu, did_old,
 						   (((u16)bus) << 8) | devfn,
 						   DMA_CCMD_MASK_NOBIT,
-- 
2.5.0
