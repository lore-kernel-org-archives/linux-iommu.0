From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v6 19/21] iommu/tegra: gart: Don't detach devices from inactive domains
Date: Sun,  9 Dec 2018 23:29:48 +0300
Message-ID: <20181209202950.31486-20-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There could be unlimited number of allocated domains, but only one domain
can be active at a time. Hence devices must be detached only from the
active domain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 9d2df43ce50b..f2dc7e72be80 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -171,7 +171,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	struct gart_client *client, *c;
 	int err = 0;
 
@@ -195,6 +195,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 		goto fail;
 	}
 	gart->active_domain = domain;
+	gart_domain->gart = gart;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
@@ -217,8 +218,10 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			kfree(c);
-			if (list_empty(&gart->client))
+			if (list_empty(&gart->client)) {
 				gart->active_domain = NULL;
+				gart_domain->gart = NULL;
+			}
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
 			return;
 		}
@@ -254,7 +257,6 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 	if (!gart_domain)
 		return NULL;
 
-	gart_domain->gart = gart;
 	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
 	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-- 
2.19.1
