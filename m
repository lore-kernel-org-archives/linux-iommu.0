From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/amd: Fix cleanup_domain for mass device removal
Date: Tue, 19 Aug 2014 00:49:58 +0200
Message-ID: <1408402199-15178-3-git-send-email-joro@8bytes.org>
References: <1408402199-15178-1-git-send-email-joro@8bytes.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1408402199-15178-1-git-send-email-joro@8bytes.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

When multiple devices are detached in __detach_device, they
are also removed from the domains dev_list. This makes it
unsafe to use list_for_each_entry_safe, as the next pointer
might also not be in the list anymore after __detach_device
returns. So just repeatedly remove the first element of the
list until it is empty.

Cc: stable@vger.kernel.org
Tested-by: Marti Raudsepp <marti@juffo.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1840531..ecb0109 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3149,14 +3149,16 @@ free_domains:
 
 static void cleanup_domain(struct protection_domain *domain)
 {
-	struct iommu_dev_data *dev_data, *next;
+	struct iommu_dev_data *entry;
 	unsigned long flags;
 
 	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
 
-	list_for_each_entry_safe(dev_data, next, &domain->dev_list, list) {
-		__detach_device(dev_data);
-		atomic_set(&dev_data->bind, 0);
+	while (!list_empty(&domain->dev_list)) {
+		entry = list_first_entry(&domain->dev_list,
+					 struct iommu_dev_data, list);
+		__detach_device(entry);
+		atomic_set(&entry->bind, 0);
 	}
 
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
-- 
1.9.1
