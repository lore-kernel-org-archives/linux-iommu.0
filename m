From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/5] powerpc/iommu: Use device_iommu_mapped()
Date: Tue,  4 Dec 2018 18:25:03 +0100
Message-ID: <20181204172504.19708-5-joro@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the new function to replace the open-coded iommu check.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell Currey <ruscur@russell.cc>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/powerpc/kernel/eeh.c   | 2 +-
 arch/powerpc/kernel/iommu.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6cae6b56ffd6..23fe62f11486 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1472,7 +1472,7 @@ static int dev_has_iommu_table(struct device *dev, void *data)
 	if (!dev)
 		return 0;
 
-	if (dev->iommu_group) {
+	if (device_iommu_mapped(dev)) {
 		*ppdev = pdev;
 		return 1;
 	}
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index f0dc680e659a..48d58d1dcac2 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1086,7 +1086,7 @@ int iommu_add_device(struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENOENT;
 
-	if (dev->iommu_group) {
+	if (device_iommu_mapped(dev)) {
 		pr_debug("%s: Skipping device %s with iommu group %d\n",
 			 __func__, dev_name(dev),
 			 iommu_group_id(dev->iommu_group));
@@ -1129,7 +1129,7 @@ void iommu_del_device(struct device *dev)
 	 * and we needn't detach them from the associated
 	 * IOMMU groups
 	 */
-	if (!dev->iommu_group) {
+	if (!device_iommu_mapped(dev)) {
 		pr_debug("iommu_tce: skipping device %s with no tbl\n",
 			 dev_name(dev));
 		return;
@@ -1148,7 +1148,7 @@ static int tce_iommu_bus_notifier(struct notifier_block *nb,
         case BUS_NOTIFY_ADD_DEVICE:
                 return iommu_add_device(dev);
         case BUS_NOTIFY_DEL_DEVICE:
-                if (dev->iommu_group)
+                if (device_iommu_mapped(dev))
                         iommu_del_device(dev);
                 return 0;
         default:
-- 
2.17.1
