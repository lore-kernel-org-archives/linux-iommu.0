From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/s390: Use iommu_group_get_for_dev() in
	s390_iommu_add_device()
Date: Thu, 15 Jun 2017 15:11:51 +0200
Message-ID: <1497532312-30470-2-git-send-email-joro@8bytes.org>
References: <1497532312-30470-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1497532312-30470-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The iommu_group_get_for_dev() function also attaches the
device to its group, so this code doesn't need to be in the
iommu driver.

Further by using this function the driver can make use of
default domains in the future.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/s390-iommu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 179e636..8788640 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -165,20 +165,14 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 
 static int s390_iommu_add_device(struct device *dev)
 {
-	struct iommu_group *group;
-	int rc;
+	struct iommu_group *group = iommu_group_get_for_dev(dev);
 
-	group = iommu_group_get(dev);
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group))
-			return PTR_ERR(group);
-	}
+	if (IS_ERR(group))
+		return PTR_ERR(group);
 
-	rc = iommu_group_add_device(group, dev);
 	iommu_group_put(group);
 
-	return rc;
+	return 0;
 }
 
 static void s390_iommu_remove_device(struct device *dev)
@@ -344,6 +338,7 @@ static struct iommu_ops s390_iommu_ops = {
 	.iova_to_phys = s390_iommu_iova_to_phys,
 	.add_device = s390_iommu_add_device,
 	.remove_device = s390_iommu_remove_device,
+	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 };
 
-- 
2.7.4
