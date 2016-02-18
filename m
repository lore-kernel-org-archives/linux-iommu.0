From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 09/13] iommu: exynos: add support for SYSMMU controller with
 bogus version reg
Date: Thu, 18 Feb 2016 15:12:56 +0100
Message-ID: <1455804780-9616-10-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

SYSMMU on some SoCs reports bogus values in VERSION register. Force
hardware version to 1.0 for such controllers. This patch also moves reading
version register to driver's probe() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e42a76cc9674..8e289e2a05fb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -284,6 +284,28 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 	__sysmmu_tlb_invalidate(data);
 }
 
+static void __sysmmu_get_version(struct sysmmu_drvdata *data)
+{
+	u32 ver;
+
+	clk_enable(data->clk_master);
+	clk_enable(data->clk);
+
+	ver = __raw_readl(data->sfrbase + REG_MMU_VERSION);
+
+	/* controllers on some SoCs don't report proper version */
+	if (ver == 0x80000001u)
+		data->version = MAKE_MMU_VER(1, 0);
+	else
+		data->version = MMU_RAW_VER(ver);
+
+	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
+		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
+
+	clk_disable(data->clk);
+	clk_disable(data->clk_master);
+}
+
 static void show_fault_information(struct sysmmu_drvdata *data,
 				   const struct sysmmu_fault_info *finfo,
 				   sysmmu_iova_t fault_addr)
@@ -385,7 +407,6 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 {
 	unsigned int cfg;
 
-	data->version = MMU_RAW_VER(__raw_readl(data->sfrbase + REG_MMU_VERSION));
 	if (data->version <= MAKE_MMU_VER(3, 1))
 		cfg = CFG_LRU | CFG_QOS(15);
 	else if (data->version <= MAKE_MMU_VER(3, 2))
@@ -551,6 +572,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	__sysmmu_get_version(data);
 	pm_runtime_enable(dev);
 
 	return 0;
-- 
1.9.2
