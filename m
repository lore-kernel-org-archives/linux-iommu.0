From: Matthew Leach <matthew@mattleach.net>
Subject: [RFC PATCH 15/15] iommu/exynos: update to use iommu big-endian
Date: Wed,  8 Jun 2016 19:31:10 +0100
Message-ID: <20160608183110.13851-16-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add initial support for big endian by always writing the pte
in le32. Note, revisit if hardware capable of doing big endian
fetches.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 5ecc86c..dd8b3b3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -54,6 +54,10 @@ typedef u32 sysmmu_pte_t;
 #define lv2ent_small(pent) ((*(pent) & 2) == 2)
 #define lv2ent_large(pent) ((*(pent) & 3) == 1)
 
+#ifdef CONFIG_BIG_ENDIAN
+#warning "revisit driver if we can enable big-endian ptes"
+#endif
+
 /*
  * v1.x - v3.x SYSMMU supports 32bit physical and 32bit virtual address spaces
  * v5.0 introduced support for 36bit physical address space by shifting
@@ -716,7 +720,7 @@ static inline void update_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 {
 	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
 				DMA_TO_DEVICE);
-	*ent = val;
+	*ent = cpu_to_le32(val);
 	dma_sync_single_for_device(dma_dev, virt_to_phys(ent), sizeof(*ent),
 				   DMA_TO_DEVICE);
 }
-- 
2.8.3
