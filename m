From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 17/18] iommu: exynos: init from dt-specific callback instead
 of initcall
Date: Fri, 23 Jan 2015 16:51:27 +0100
Message-ID: <1422028288-891-18-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch introduces IOMMU_OF_DECLARE-based initialization to the
driver, which replaces subsys_initcall-based procedure.
exynos_iommu_of_setup ensures that each sysmmu controller is probed
before its master device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c53cc8f..ff169ce 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -13,16 +13,21 @@
 #endif
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cacheflush.h>
+#include <asm/dma-iommu.h>
 #include <asm/pgtable.h>
 
 typedef u32 sysmmu_iova_t;
@@ -1072,7 +1077,7 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	return phys;
 }
 
-static const struct iommu_ops exynos_iommu_ops = {
+static struct iommu_ops exynos_iommu_ops = {
 	.domain_init = exynos_iommu_domain_init,
 	.domain_destroy = exynos_iommu_domain_destroy,
 	.attach_dev = exynos_iommu_attach_device,
@@ -1084,6 +1089,8 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 };
 
+static int init_done;
+
 static int __init exynos_iommu_init(void)
 {
 	int ret;
@@ -1116,6 +1123,8 @@ static int __init exynos_iommu_init(void)
 		goto err_set_iommu;
 	}
 
+	init_done = true;
+
 	return 0;
 err_set_iommu:
 	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
@@ -1125,4 +1134,21 @@ err_reg_driver:
 	kmem_cache_destroy(lv2table_kmem_cache);
 	return ret;
 }
-subsys_initcall(exynos_iommu_init);
+
+static int __init exynos_iommu_of_setup(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	if (!init_done)
+		exynos_iommu_init();
+
+	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	of_iommu_set_ops(np, &exynos_iommu_ops);
+	return 0;
+}
+
+IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu",
+		 exynos_iommu_of_setup);
-- 
1.9.2
