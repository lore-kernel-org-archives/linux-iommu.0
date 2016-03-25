From: cn_wyl2003@126.com
Subject: [PATCH] iommu: change generic_device_group function
Date: Fri, 25 Mar 2016 20:06:51 +0800
Message-ID: <1458907611-19694-1-git-send-email-cn_wyl2003@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, alex.williamson@redhat.com, renesas@opensource.se, yalin.wang2010@gmail.com, nicolas.iooss_linux@m4x.org, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: yalin wang <yalin.wang2010@gmail.com>

change this function to return only iommu_group* pointer or
PTR_ERR(), never return NULL when failed.
The caller of this function only check IS_ERR() for its return value.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/iommu/iommu.c | 15 ---------------
 include/linux/iommu.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfd4f7c..4984108 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -728,21 +728,6 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
 }
 
 /*
- * Generic device_group call-back function. It just allocates one
- * iommu-group per device.
- */
-struct iommu_group *generic_device_group(struct device *dev)
-{
-	struct iommu_group *group;
-
-	group = iommu_group_alloc();
-	if (IS_ERR(group))
-		return NULL;
-
-	return group;
-}
-
-/*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
  */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..462280b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -327,8 +327,14 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
-/* Generic device grouping function */
-extern struct iommu_group *generic_device_group(struct device *dev);
+/*
+ * Generic device_group call-back function. It just allocates one
+ * iommu-group per device.
+ */
+static inline struct iommu_group *generic_device_group(struct device *dev)
+{
+	return iommu_group_alloc();
+}
 
 #else /* CONFIG_IOMMU_API */
 
-- 
1.9.1
