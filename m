From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu: exynos: pointers are nto physical addresses
Date: Mon, 29 Feb 2016 09:45:59 +0100
Message-ID: <1456735568-3886545-1-git-send-email-arnd@arndb.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The exynos iommu driver changed an incorrect cast from pointer
to 'unsigned int' to an equally incorrect cast to a 'phys_addr_t',
which results in an obvious compile-time error when phys_addr_t
is wider than pointers are:

drivers/iommu/exynos-iommu.c: In function 'alloc_lv2entry':
drivers/iommu/exynos-iommu.c:918:32: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

The code does not actually want the physical address (which would
involve using virt_to_phys()), but just checks the alignment,
so we can change it to use a cast to uintptr_t instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 740a01eee9ad ("iommu/exynos: Add support for v5 SYSMMU")
---
I also see that some incorrect __raw_writel() calls have crept in
around the same time, which breaks running big-endian kernels when
this driver is loaded.

Please fix and that that as well.

 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0665042bf29..484b3b37631f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -915,7 +915,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		bool need_flush_flpd_cache = lv1ent_zero(sent);
 
 		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
-		BUG_ON((phys_addr_t)pent & (LV2TABLE_SIZE - 1));
+		BUG_ON((uintptr_t)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
-- 
2.7.0
