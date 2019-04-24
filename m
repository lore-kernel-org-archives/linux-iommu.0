From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/6] iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
Date: Wed, 24 Apr 2019 15:55:15 +0200
Message-ID: <20190424135518.25150-4-geert+renesas@glider.be>
References: <20190424135518.25150-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424135518.25150-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

Make the IPMMU_CTX_MAX constant unsigned, to match the type of
ipmmu_features.number_of_contexts.

This allows to use plain min() instead of type-casting min_t().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Add Reviewed-by,

v2:
  - Add Reviewed-by.
---
 drivers/iommu/ipmmu-vmsa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index f2061bd1dc7b8852..87acf86f295fac0d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -36,7 +36,7 @@
 #define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
-#define IPMMU_CTX_MAX 8
+#define IPMMU_CTX_MAX 8U
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
@@ -1060,8 +1060,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	if (mmu->features->use_ns_alias_offset)
 		mmu->base += IM_NS_ALIAS_OFFSET;
 
-	mmu->num_ctx = min_t(unsigned int, IPMMU_CTX_MAX,
-			     mmu->features->number_of_contexts);
+	mmu->num_ctx = min(IPMMU_CTX_MAX, mmu->features->number_of_contexts);
 
 	irq = platform_get_irq(pdev, 0);
 
-- 
2.17.1
