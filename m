From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/9] iommu/of: Use helper functions to access dev->iommu_fwspec
Date: Tue,  4 Dec 2018 17:30:00 +0100
Message-ID: <20181204163002.15800-8-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/of_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c5dd63072529..38232250b5f4 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -164,7 +164,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
 	const struct iommu_ops *ops = NULL;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int err = NO_IOMMU;
 
 	if (!master_np)
@@ -208,6 +208,9 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		}
 	}
 
+	/* The fwspec pointer changed, read it again */
+	fwspec = dev_iommu_fwspec_get(dev);
+
 	/*
 	 * Two success conditions can be represented by non-negative err here:
 	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
@@ -215,7 +218,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * <0 : any actual error
 	 */
 	if (!err)
-		ops = dev->iommu_fwspec->ops;
+		ops = fwspec->ops;
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * add_device callback for dev, replay it to get things in order.
-- 
2.17.1
