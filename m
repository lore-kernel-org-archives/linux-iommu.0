From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v3 16/19] iommu/tegra: gart: Prepend error/debug messages with "GART:"
Date: Sat, 18 Aug 2018 18:54:27 +0300
Message-ID: <20180818155430.5586-17-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "GART:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index d019ae8ecfc9..284cddf90888 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -96,7 +96,7 @@ static inline void gart_set_pte(struct gart_device *gart,
 	writel(offs, gart->regs + GART_ENTRY_ADDR);
 	writel(pte, gart->regs + GART_ENTRY_DATA);
 
-	dev_dbg(gart->dev, "%s %08lx:%08x\n",
+	dev_dbg(gart->dev, "GART: %s %08lx:%08x\n",
 		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
 }
 
@@ -134,7 +134,7 @@ static void gart_dump_table(struct gart_device *gart)
 
 		pte = gart_read_pte(gart, iova);
 
-		dev_dbg(gart->dev, "%s %08lx:%08lx\n",
+		dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
 			(GART_ENTRY_PHYS_ADDR_VALID & pte) ? "v" : " ",
 			iova, pte & GART_PAGE_MASK);
 	}
@@ -179,21 +179,22 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	spin_lock(&gart->client_lock);
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
-			dev_err(gart->dev,
-				"%s is already attached\n", dev_name(dev));
+			dev_err(gart->dev, "GART: %s is already attached\n",
+				dev_name(dev));
 			err = -EINVAL;
 			goto fail;
 		}
 	}
 	if (gart->active_domain && gart->active_domain != domain) {
-		dev_err(gart->dev, "Only one domain can be active at a time\n");
+		dev_err(gart->dev,
+			"GART: Only one domain can be active at a time\n");
 		err = -EINVAL;
 		goto fail;
 	}
 	gart->active_domain = domain;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
+	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
 	return 0;
 
 fail:
@@ -215,12 +216,14 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
-			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
+			dev_dbg(gart->dev, "GART: Detached %s\n",
+				dev_name(dev));
 			return;
 		}
 	}
 
-	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
+		dev_name(dev));
 }
 
 static void gart_iommu_detach_dev(struct iommu_domain *domain,
@@ -293,7 +296,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	pfn = __phys_to_pfn(pa);
 	if (!pfn_valid(pfn)) {
-		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
+		dev_err(gart->dev, "GART: Invalid page: %pa\n", &pa);
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
@@ -301,7 +304,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pte = gart_read_pte(gart, iova);
 		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
 			spin_unlock_irqrestore(&gart->pte_lock, flags);
-			dev_err(gart->dev, "Page entry is in-use\n");
+			dev_err(gart->dev, "GART: Page entry is in-use\n");
 			return -EBUSY;
 		}
 	}
@@ -344,7 +347,7 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pa = (pte & GART_PAGE_MASK);
 	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "No entry for %08llx:%pa\n",
+		dev_err(gart->dev, "GART: No entry for %08llx:%pa\n",
 			 (unsigned long long)iova, &pa);
 		gart_dump_table(gart);
 		return -EINVAL;
@@ -455,19 +458,17 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	res_remap = platform_get_resource(to_platform_device(dev),
 					  IORESOURCE_MEM, 1);
 	if (!res_remap) {
-		dev_err(dev, "GART memory aperture expected\n");
+		dev_err(dev, "GART: Memory aperture resource unavailable\n");
 		return ERR_PTR(-ENXIO);
 	}
 
 	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
-	if (!gart) {
-		dev_err(dev, "failed to allocate gart_device\n");
+	if (!gart)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
-		dev_err(dev, "Failed to register IOMMU in sysfs\n");
+		dev_err(dev, "GART: Failed to register IOMMU sysfs\n");
 		goto free_gart;
 	}
 
@@ -476,7 +477,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-		dev_err(dev, "Failed to register IOMMU\n");
+		dev_err(dev, "GART: Failed to register IOMMU\n");
 		goto remove_sysfs;
 	}
 
@@ -491,7 +492,6 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
-		dev_err(dev, "failed to allocate context save area\n");
 		ret = -ENOMEM;
 		goto unregister_iommu;
 	}
-- 
2.18.0
