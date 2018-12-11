From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/9] iommu/of: Use helper functions to access dev->iommu_fwspec
Date: Tue, 11 Dec 2018 13:19:08 +0100
Message-ID: <20181211121910.5604-8-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211121910.5604-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/of_iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c5dd63072529..8b071f3dcf9e 100644
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
@@ -208,14 +208,18 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		}
 	}
 
+
 	/*
 	 * Two success conditions can be represented by non-negative err here:
 	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
 	 *  0 : we found an IOMMU, and dev->fwspec is initialised appropriately
 	 * <0 : any actual error
 	 */
-	if (!err)
-		ops = dev->iommu_fwspec->ops;
+	if (!err) {
+		/* The fwspec pointer changed, read it again */
+		fwspec = dev_iommu_fwspec_get(dev);
+		ops    = fwspec->ops;
+	}
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * add_device callback for dev, replay it to get things in order.
-- 
2.17.1
