From: Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
Subject: [PATCH] drivers: iommu: Use of add_device()/remove_device() outside
	of IOMMU groups
Date: Tue, 15 Jan 2013 19:10:52 +0900
Message-ID: <1358244652-12728-1-git-send-email-dhobsong@igel.co.jp>
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We've recently been thinking about the best way to attach platform devices in
an IOMMU in a generic way without having to have every platform device
register itself at probe time.  We've seen that at least on the tegra IOMMU,
using the platform_bus notifier seems like a viable option (http://lists.linuxfoundation.org/pipermail/iommu/2012-December/004954.html). We also noticed that
the IOMMU ops add_device() function is called (indirectly) from a similar bus
notifier and we're thinking that using the bus notifier in the common code
would be better than us rolling our own to do basically the same thing.

The problem, however, is that add_device() seems to be intended for use with
IOMMU groups.  i.e. After calling add_device() on a device that is should be
in a group, dev->iommu_group should have some meaningful value.
I think though, that if the IOMMU groups requirement can be removed, it should
be more versatile.

I believe that removing the IOMMU groups dependency can be achieved with the
patch below. Currently the intel-iommu seems to be the only implementation
using these callbacks.

Signed-off-by: Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |    3 ++-
 drivers/iommu/iommu.c       |    2 +-
 include/linux/iommu.h       |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b9d0911..a763872 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4217,7 +4217,8 @@ root_bus:
 
 static void intel_iommu_remove_device(struct device *dev)
 {
-	iommu_group_remove_device(dev);
+	if (dev->iommu_group)
+		iommu_group_remove_device(dev);
 }
 
 static struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ddbdaca..a6046c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,7 +510,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 		if (ops->add_device)
 			return ops->add_device(dev);
 	} else if (action == BUS_NOTIFY_DEL_DEVICE) {
-		if (ops->remove_device && dev->iommu_group) {
+		if (ops->remove_device) {
 			ops->remove_device(dev);
 			return 0;
 		}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f3b99e1..2715592 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -74,8 +74,8 @@ enum iommu_attr {
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @domain_has_cap: domain capabilities query
- * @add_device: add device to iommu grouping
- * @remove_device: remove device from iommu grouping
+ * @add_device: add device to iommu grouping or domain
+ * @remove_device: remove device from iommu grouping or domain
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
  * @pgsize_bitmap: bitmap of supported page sizes
-- 
1.7.5.4
