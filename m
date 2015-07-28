From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 1/1] iommu: Detach device from domain when removed from
	group
Date: Tue, 28 Jul 2015 19:55:56 +0200
Message-ID: <1438106156-51847-2-git-send-email-gerald.schaefer@de.ibm.com>
References: <1438106156-51847-1-git-send-email-gerald.schaefer@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438106156-51847-1-git-send-email-gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds a call to __iommu_detach_device() to the
iommu_group_remove_device() function, which will trigger a missing
detach_dev callback in (at least) the following scenario:

When a user completes the VFIO_SET_IOMMU ioctl for a vfio-pci device,
and the corresponding device is removed thereafter (before any other
ioctl like VFIO_GROUP_GET_DEVICE_FD), then the detach_dev callback of
the underlying IOMMU API is never called.

This also fixes an asymmetry with iommu_group_add_device() and
iommu_group_remove_device(), where the former did an "attach_dev" but
the latter did no "detach_dev".

Signed-off-by: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f286090..82ac8b3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -447,6 +447,9 @@ rename:
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
 
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev);
+
 /**
  * iommu_group_remove_device - remove a device from it's current group
  * @dev: device to be removed
@@ -466,6 +469,8 @@ void iommu_group_remove_device(struct device *dev)
 				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
 
 	mutex_lock(&group->mutex);
+	if (group->domain)
+		__iommu_detach_device(group->domain, dev);
 	list_for_each_entry(tmp_device, &group->devices, list) {
 		if (tmp_device->dev == dev) {
 			device = tmp_device;
-- 
2.3.8
