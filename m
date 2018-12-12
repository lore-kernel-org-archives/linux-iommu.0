From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 02/24] iommu/tegra: gart: Clean up driver probe errors handling
Date: Wed, 12 Dec 2018 23:38:45 +0300
Message-ID: <20181212203907.23461-3-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Properly clean up allocated resources on the drivers probe failure and
remove unneeded checks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ff75cf60117b..1cd470b2beea 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -411,9 +411,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (gart_handle)
-		return -EIO;
-
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
 	/* the GART memory aperture is required */
@@ -448,8 +445,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU\n");
-		iommu_device_sysfs_remove(&gart->iommu);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	gart->dev = &pdev->dev;
@@ -463,7 +459,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto unregister_iommu;
 	}
 
 	platform_set_drvdata(pdev, gart);
@@ -472,6 +469,13 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart_handle = gart;
 
 	return 0;
+
+unregister_iommu:
+	iommu_device_unregister(&gart->iommu);
+remove_sysfs:
+	iommu_device_sysfs_remove(&gart->iommu);
+
+	return ret;
 }
 
 static const struct dev_pm_ops tegra_gart_pm_ops = {
-- 
2.20.0
