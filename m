From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v3 14/19] iommu/tegra: gart: Allow only one active domain at a time
Date: Sat, 18 Aug 2018 18:54:25 +0300
Message-ID: <20180818155430.5586-15-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

GART has a single address space that is shared by all devices, hence only
one domain could be active at a time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1d45b023adea..9f7d3afb686f 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -55,6 +55,7 @@ struct gart_device {
 	spinlock_t		pte_lock;	/* for pagetable */
 	struct list_head	client;
 	spinlock_t		client_lock;	/* for client list */
+	struct iommu_domain	*active_domain;	/* current active domain */
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
@@ -184,6 +185,12 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 			goto fail;
 		}
 	}
+	if (gart->active_domain && gart->active_domain != domain) {
+		dev_err(gart->dev, "Only one domain can be active at a time\n");
+		err = -EINVAL;
+		goto fail;
+	}
+	gart->active_domain = domain;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
@@ -206,6 +213,8 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			devm_kfree(gart->dev, c);
+			if (list_empty(&gart->client))
+				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
 			return;
 		}
-- 
2.18.0
