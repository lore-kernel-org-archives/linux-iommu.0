From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/9] iommu/amd: Ignore BUS_NOTIFY_UNBOUND_DRIVER event
Date: Wed,  1 Apr 2015 14:58:45 +0200
Message-ID: <1427893132-18310-3-git-send-email-joro@8bytes.org>
References: <1427893132-18310-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427893132-18310-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Detaching a device from its domain at this event is
problematic for several reasons:

	* The device might me in an alias group and
	  detaching it will also detach all other devices in
	  the group. This removes valid DMA mappings from
	  the other devices causing io-page-faults and lets
	  these devices fail.

	* Devices might have unity mappings specified by the
	  IVRS table. These mappings are required for the
	  device even when no device driver is attached.
	  Detaching the device from its domain in driver
	  unbind will also remove these unity mappings.

This patch removes the handling of the BUS_NOTIFY_UNBOUND_DRIVER
event to prevent these issues and align it better with the
behavior of the VT-d driver.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8a1dea4..994cc7d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2422,16 +2422,6 @@ static int device_change_notifier(struct notifier_block *nb,
 	dev_data = get_dev_data(dev);
 
 	switch (action) {
-	case BUS_NOTIFY_UNBOUND_DRIVER:
-
-		domain = domain_for_device(dev);
-
-		if (!domain)
-			goto out;
-		if (dev_data->passthrough)
-			break;
-		detach_device(dev);
-		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 
 		iommu_init_device(dev);
-- 
1.9.1
