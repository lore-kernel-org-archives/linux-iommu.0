From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 20/24] iommu/tegra: gart: Don't use managed resources
Date: Wed, 12 Dec 2018 23:39:03 +0300
Message-ID: <20181212203907.23461-21-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

GART is a part of the Memory Controller driver that is always built-in,
hence there is no benefit from the use of managed resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 71ff22be9560..2e0e6aff8f70 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -173,7 +173,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
+	client = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 	client->dev = dev;
@@ -199,7 +199,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 fail:
-	devm_kfree(gart->dev, client);
+	kfree(client);
 	spin_unlock(&gart->client_lock);
 	return err;
 }
@@ -214,7 +214,7 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
-			devm_kfree(gart->dev, c);
+			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
@@ -455,7 +455,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -464,7 +464,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -502,6 +502,8 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.20.0
