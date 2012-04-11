From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] iommu/exynos: fix runtime pm support
Date: Wed, 11 Apr 2012 16:34:30 +0200
Message-ID: <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, KyongHo Cho <pullip.cho@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Fix registration to runtime pw and add missing resume callback.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b8daf7c..eef924d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -651,8 +651,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__set_fault_handler(data, &default_fault_handler);
 
-	if (dev->parent)
-		pm_runtime_enable(dev);
+	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
@@ -674,11 +673,28 @@ err_alloc:
 	return ret;
 }
 
+static int exynos_pm_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data;
+
+	data = dev_get_drvdata(dev);
+
+	if (is_sysmmu_active(data))
+		__exynos_sysmmu_enable(data, data->pgtable, NULL);
+
+	return 0;
+}
+
+const struct dev_pm_ops exynos_pm_ops = {
+	.resume = &exynos_pm_resume,
+};
+
 static struct platform_driver exynos_sysmmu_driver = {
 	.probe		= exynos_sysmmu_probe,
 	.driver		= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
+		.pm		= &exynos_pm_ops,
 	}
 };
 
-- 
1.7.1.569.g6f426
