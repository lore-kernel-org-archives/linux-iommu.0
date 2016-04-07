From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Don't overwrite domain pointer when there is no default_domain
Date: Thu,  7 Apr 2016 14:40:39 +0200
Message-ID: <1460032852-1936-1-git-send-email-joro@8bytes.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

IOMMU drivers that do not support default domains, but make
use of the the group->domain pointer can get that pointer
overwritten with NULL on device add/remove.

Make sure this can't happen by only overwriting the domain
pointer when it is NULL.

Cc: stable@vger.kernel.org #v4.4+
Fixes: 1228236de5f9 ('iommu: Move default domain allocation to iommu_group_get_for_dev()')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfd4f7c..b9df141 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -848,7 +848,8 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (!group->default_domain) {
 		group->default_domain = __iommu_domain_alloc(dev->bus,
 							     IOMMU_DOMAIN_DMA);
-		group->domain = group->default_domain;
+		if (!group->domain)
+			group->domain = group->default_domain;
 	}
 
 	ret = iommu_group_add_device(group, dev);
-- 
1.8.4.5
