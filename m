From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 13/20] iommu/tegra: gart: Fix spinlock recursion
Date: Mon, 24 Sep 2018 03:41:46 +0300
Message-ID: <20180924004153.8232-14-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fix spinlock recursion bug that happens on IOMMU domain destruction if
any of the allocated domains have devices attached to them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1c89b20ba4bb..e6fe139576c3 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -195,25 +195,33 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return err;
 }
 
-static void gart_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
+static void __gart_iommu_detach_dev(struct iommu_domain *domain,
+				    struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_domain->gart;
 	struct gart_client *c;
 
-	spin_lock(&gart->client_lock);
-
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
 			devm_kfree(gart->dev, c);
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
-			goto out;
+			return;
 		}
 	}
-	dev_err(gart->dev, "Couldn't find\n");
-out:
+
+	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+}
+
+static void gart_iommu_detach_dev(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+
+	spin_lock(&gart->client_lock);
+	__gart_iommu_detach_dev(domain, dev);
 	spin_unlock(&gart->client_lock);
 }
 
@@ -253,7 +261,7 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 			struct gart_client *c;
 
 			list_for_each_entry(c, &gart->client, list)
-				gart_iommu_detach_dev(domain, c->dev);
+				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
 	}
-- 
2.19.0
