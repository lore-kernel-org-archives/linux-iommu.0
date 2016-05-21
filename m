From: Jan Vesely <jan.vesely@rutgers.edu>
Subject: [PATCH 1/2] iommu/amd: Remove entry from the list before freeing it
Date: Sat, 21 May 2016 14:11:03 -0400
Message-ID: <1463854264-26445-1-git-send-email-jan.vesely@rutgers.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Vesely <jan.vesely@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Jan Vesely <jan.vesely@amd.com>

Signed-off-by: Jan Vesely <jan.vesely@amd.com>
---
 drivers/iommu/amd_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 634f636..17c76f2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3288,8 +3288,10 @@ static void amd_iommu_put_dm_regions(struct device *dev,
 {
 	struct iommu_dm_region *entry, *next;
 
-	list_for_each_entry_safe(entry, next, head, list)
+	list_for_each_entry_safe(entry, next, head, list) {
+		list_del(&entry->list);
 		kfree(entry);
+	}
 }
 
 static const struct iommu_ops amd_iommu_ops = {
-- 
2.5.5
