From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 10/16] iommu: introduce device fault report API
Date: Thu,  5 Oct 2017 16:03:38 -0700
Message-ID: <1507244624-39189-11-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Traditionally, device specific faults are detected and handled within
their own device drivers. When IOMMU is enabled, faults such as DMA
related transactions are detected by IOMMU. There is no generic
reporting mechanism to report faults back to the in-kernel device
driver or the guest OS in case of assigned devices.

Faults detected by IOMMU is based on the transaction's source ID which
can be reported at per device basis, regardless of the device type is a
PCI device or not.

The fault types include recoverable (e.g. page request) and
unrecoverable faults(e.g. access error). In most cases, faults can be
handled by IOMMU drivers internally. The primary use cases are as
follows:
1. page request fault originated from an SVM capable device that is
assigned to guest via vIOMMU. In this case, the first level page tables
are owned by the guest. Page request must be propagated to the guest to
let guest OS fault in the pages then send page response. In this
mechanism, the direct receiver of IOMMU fault notification is VFIO,
which can relay notification events to QEMU or other user space
software.

2. faults need more subtle handling by device drivers. Other than
simply invoke reset function, there are needs to let device driver
handle the fault with a smaller impact.

This patchset is intended to create a generic fault report API such
that it can scale as follows:
- all IOMMU types
- PCI and non-PCI devices
- recoverable and unrecoverable faults
- VFIO and other other in kernel users
- DMA & IRQ remapping (TBD)
The original idea was brought up by David Woodhouse and discussions
summarized at https://lwn.net/Articles/608914/.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h | 23 +++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5a14154..0b058e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -554,9 +554,15 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	device->dev = dev;
 
+	dev->iommu_fault_param = kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
+	if (!dev->iommu_fault_param) {
+		ret = -ENOMEM;
+		goto err_free_device;
+	}
+
 	ret = sysfs_create_link(&dev->kobj, &group->kobj, "iommu_group");
 	if (ret)
-		goto err_free_device;
+		goto err_free_device_iommu_fault_param;
 
 	device->name = kasprintf(GFP_KERNEL, "%s", kobject_name(&dev->kobj));
 rename:
@@ -615,6 +621,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	kfree(device->name);
 err_remove_link:
 	sysfs_remove_link(&dev->kobj, "iommu_group");
+err_free_device_iommu_fault_param:
+	kfree(dev->iommu_fault_param);
 err_free_device:
 	kfree(device);
 	pr_err("Failed to add device %s to group %d: %d\n", dev_name(dev), group->id, ret);
@@ -791,6 +799,52 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
+int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler)
+{
+	if (dev->iommu_fault_param)
+		return -EBUSY;
+	get_device(dev);
+	dev->iommu_fault_param =
+		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
+	if (!dev->iommu_fault_param)
+		return -ENOMEM;
+	dev->iommu_fault_param->dev_fault_handler = handler;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
+
+int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	if (!dev->iommu_fault_param)
+		return -EINVAL;
+
+	kfree(dev->iommu_fault_param);
+	dev->iommu_fault_param = NULL;
+	put_device(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
+
+
+int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	/* we only report device fault if there is a handler registered */
+	if (!dev->iommu_fault_param ||
+		!dev->iommu_fault_param->dev_fault_handler)
+		return -ENOSYS;
+	if (evt->type == IOMMU_FAULT_PAGE_REQ &&
+		!dev->iommu_fault_param->pasid_tbl_bound) {
+		dev_warn(dev, "PRQ not propaged, PASID table not bound\n");
+		return -EPERM;
+	}
+
+	return dev->iommu_fault_param->dev_fault_handler(dev, evt);
+}
+EXPORT_SYMBOL_GPL(iommu_report_device_fault);
+
 /**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3f9b367..44d2ada 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -416,6 +416,13 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler);
+
+extern int iommu_unregister_device_fault_handler(struct device *dev);
+
+extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
+
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -699,6 +706,22 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 	return 0;
 }
 
+static inline int iommu_register_device_fault_handler(struct device *dev,
+						iommu_dev_fault_handler_t handler)
+{
+	return 0;
+}
+
+static inline int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	return 0;
+}
+
+static inline int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	return 0;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4
