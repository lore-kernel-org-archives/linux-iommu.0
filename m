From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
Date: Tue,  4 Dec 2018 18:25:01 +0100
Message-ID: <20181204172504.19708-3-joro@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use Use device_iommu_mapped() to check if the device is
already mapped by an IOMMU.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c5dd63072529..bfcf139503f0 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -220,7 +220,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * add_device callback for dev, replay it to get things in order.
 	 */
-	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
+	if (ops && ops->add_device && dev->bus && !device_iommu_mapped(dev))
 		err = ops->add_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-- 
2.17.1
