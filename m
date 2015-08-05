From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 26/26] iommu/vt-d: Avoid duplicate device_domain_info structures
Date: Wed,  5 Aug 2015 17:18:57 +0200
Message-ID: <1438787937-7340-27-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

When a 'struct device_domain_info' is created as an alias
for another device, this struct will not be re-used when the
real device is encountered. Fix that to avoid duplicate
device_domain_info structures being added.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3882072..5cd3d36 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2269,12 +2269,16 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
 		found = find_domain(dev);
-	else {
+
+	if (!found) {
 		struct device_domain_info *info2;
 		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
-		if (info2)
-			found = info2->domain;
+		if (info2) {
+			found      = info2->domain;
+			info2->dev = dev;
+		}
 	}
+
 	if (found) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		free_devinfo_mem(info);
-- 
1.9.1
