From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] iommu/amd: Add proper error check in two functions
Date: Thu, 16 Jun 2016 07:57:04 -0400
Message-ID: <1466078224-3155-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

This patch is to do the following:

1. Add error check for caller of iommu_device_create.

2. Add error check for caller of iommu_device_link and
move 'iommu = amd_iommu_rlookup_table[dev_data->devid]' out of
iommuv2 capability condition that make iommu_device_link also
use the 'iommu' to make code more clear and no more than 80
characters.

Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
---
Changes from v1:

Don't fail the iommu_init_device() function when the iommu_device_link returned
an error,just print a warning message.
---
 drivers/iommu/amd_iommu.c      | 11 +++++------
 drivers/iommu/amd_iommu_init.c |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 634f636..dbdcaeb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -476,6 +476,7 @@ out:
 static int iommu_init_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu;
 	int devid;
 
 	if (dev->archdata.iommu)
@@ -491,17 +492,15 @@ static int iommu_init_device(struct device *dev)
 
 	dev_data->alias = get_alias(dev);
 
-	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		struct amd_iommu *iommu;
+	iommu = amd_iommu_rlookup_table[dev_data->devid];
 
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
+	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev)))
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
-	}
 
 	dev->archdata.iommu = dev_data;
 
-	iommu_device_link(amd_iommu_rlookup_table[dev_data->devid]->iommu_dev,
-			  dev);
+	if (iommu_device_link(iommu->iommu_dev, dev))
+		dev_warn(dev, "Creating iommu device link failed in sysfs.\n");
 
 	return 0;
 }
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9e00341..73fa986 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1526,6 +1526,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	iommu->iommu_dev = iommu_device_create(&iommu->dev->dev, iommu,
 					       amd_iommu_groups, "ivhd%d",
 					       iommu->index);
+	if (IS_ERR(iommu->iommu_dev))
+		return PTR_ERR(iommu->iommu_dev);
 
 	return pci_enable_device(iommu->dev);
 }
-- 
1.9.1
