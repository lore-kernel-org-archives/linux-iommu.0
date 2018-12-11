From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date: Tue, 11 Dec 2018 16:05:12 +0100
Message-ID: <20181211150513.15161-4-joro@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211150513.15161-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Make sure to invoke this call-back through the proper
function of the IOMMU-API.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/of_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c5dd63072529..4d4847de727e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		ops = dev->iommu_fwspec->ops;
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
+	 * probe for dev, replay it to get things in order.
 	 */
-	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
-		err = ops->add_device(dev);
+	if (dev->bus && !dev->iommu_group)
+		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
-- 
2.17.1
