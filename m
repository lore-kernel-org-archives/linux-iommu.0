From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Date: Wed, 20 Feb 2019 16:05:25 +0100
Message-ID: <20190220150531.2462-2-geert+renesas@glider.be>
References: <20190220150531.2462-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220150531.2462-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
/sys/class/iommus/, but their "devices" subdirectories are empty.
Likewise, devices tied to an IOMMU do not have an "iommu" backlink.

Make sure all links are created, on both arm32 and arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9a380c10655e182d..9f2b781e20a0eba6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 
 static int ipmmu_add_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
+	int ret;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
-	if (!to_ipmmu(dev))
+	if (!mmu)
 		return -ENODEV;
 
-	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
-		return ipmmu_init_arm_mapping(dev);
+	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
+		ret = ipmmu_init_arm_mapping(dev);
+		if (ret)
+			return ret;
+	} else {
+		group = iommu_group_get_for_dev(dev);
+		if (IS_ERR(group))
+			return PTR_ERR(group);
 
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+		iommu_group_put(group);
+	}
 
-	iommu_group_put(group);
+	iommu_device_link(&mmu->iommu, dev);
 	return 0;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+
+	iommu_device_unlink(&mmu->iommu, dev);
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 }
-- 
2.17.1
