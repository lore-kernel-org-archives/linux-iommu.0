From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/4] iommu/arm-smmu: add devices attached to the SMMU to an
	IOMMU group
Date: Fri, 29 Nov 2013 12:15:47 +0000
Message-ID: <1385727350-20032-2-git-send-email-will.deacon@arm.com>
References: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1385727350-20032-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>

IOMMU groups are expected by certain users of the IOMMU API,
e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
group to satisfy those users.

Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e46a88700b68..879da20617fb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1494,6 +1494,13 @@ static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *child, *parent, *smmu;
 	struct arm_smmu_master *master = NULL;
+	struct iommu_group *group;
+	int ret;
+
+	if (dev->archdata.iommu) {
+		dev_warn(dev, "IOMMU driver already assigned to device\n");
+		return -EINVAL;
+	}
 
 	spin_lock(&arm_smmu_devices_lock);
 	list_for_each_entry(parent, &arm_smmu_devices, list) {
@@ -1526,13 +1533,23 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!master)
 		return -ENODEV;
 
+	group = iommu_group_alloc();
+	if (IS_ERR(group)) {
+		dev_err(dev, "Failed to allocate IOMMU group\n");
+		return PTR_ERR(group);
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
 	dev->archdata.iommu = smmu;
-	return 0;
+
+	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
 {
 	dev->archdata.iommu = NULL;
+	iommu_group_remove_device(dev);
 }
 
 static struct iommu_ops arm_smmu_ops = {
-- 
1.8.2.2
