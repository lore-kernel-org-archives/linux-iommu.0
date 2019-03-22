From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Don't print warning when IOMMU driver only supports unmanaged domains
Date: Fri, 22 Mar 2019 17:04:26 +0100
Message-ID: <20190322160426.1480-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Print the warning about the fall-back to IOMMU_DOMAIN_DMA in
iommu_group_get_for_dev() only when such a domain was
actually allocated.

Otherwise the user will get misleading warnings in the
kernel log when the iommu driver used doesn't support
IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY.

Fixes: fccb4e3b8ab09 ('iommu: Allow default domain type to be set on the kernel command line')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..109de67d5d72 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1105,10 +1105,12 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
 		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
-			dev_warn(dev,
-				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-				 iommu_def_domain_type);
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
+			if (dom) {
+				dev_warn(dev,
+					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
+					 iommu_def_domain_type);
+			}
 		}
 
 		group->default_domain = dom;
-- 
2.16.4
