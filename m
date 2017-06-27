From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 5/9] iommu: Introduce fault notifier API
Date: Tue, 27 Jun 2017 12:47:59 -0700
Message-ID: <1498592883-56224-6-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Traditionally, device specific faults are detected and handled within
their own device drivers. When IOMMU is enabled, faults such as DMA
related transactions are detected by IOMMU. There is no generic
reporting mechanism to report faults back to the in-kernel device
driver or the guest OS in case of assigned devices.

Faults detected by IOMMU is based on the transaction's source ID which
can be reported at per device basis, regardless of the device type is a
PCI device or not.

The fault types includes recoverable (e.g. page request) and
unrecoverable faults(e.g. invalid context). In most cases, faults can be
handled by IOMMU drivers. However, there are use cases that require
fault processing outside IOMMU driver, e.g.

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

This patchset is intended to create a generic fault notification API such
that it can scale as follows:
- all IOMMU types
- PCI and non-PCI devices
- recoverable and unrecoverable faults
- VFIO and other other in kernel users
- DMA & IRQ remapping (TBD)

The event data contains both generic and raw architectural data
such that performance is not compromised as the data propagation may
involve many layers.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h      | 23 +++++++++++++++++++++++
 include/uapi/linux/iommu.h | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d973555..07cfd92 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,7 @@ struct iommu_group {
 	struct list_head devices;
 	struct mutex mutex;
 	struct blocking_notifier_head notifier;
+	struct blocking_notifier_head fault_notifier;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
 	char *name;
@@ -345,6 +346,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&group->fault_notifier);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -790,6 +792,48 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
 /**
+ * iommu_register_fault_notifier - Register a notifier for fault reporting
+ * @group: device's iommu group to notify fault events
+ * @nb: notifier block to signal
+ *
+ */
+int iommu_register_fault_notifier(struct iommu_group *group,
+				struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&group->fault_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(iommu_register_fault_notifier);
+
+/**
+ * iommu_unregister_fault_notifier - Unregister a notifier for fault reporting
+ * @domain: the domain to watch
+ * @nb: notifier block to signal
+ *
+ */
+int iommu_unregister_fault_notifier(struct iommu_group *group,
+				  struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&group->fault_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(iommu_unregister_fault_notifier);
+
+int iommu_fault_notifier_call_chain(struct iommu_fault_event *event)
+{
+	int ret;
+	struct iommu_group *group = iommu_group_get(event->dev);
+
+	if (!group)
+		return -EINVAL;
+	/* caller provide generic data related to the event, TBD */
+	ret = (blocking_notifier_call_chain(&group->fault_notifier, 0, (void *)event)
+		== NOTIFY_BAD) ? -EINVAL : 0;
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL(iommu_fault_notifier_call_chain);
+
+/**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
  *
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fbc08ae..ed2f804 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -342,6 +342,12 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_register_fault_notifier(struct iommu_group *group,
+					 struct notifier_block *nb);
+extern int iommu_unregister_fault_notifier(struct iommu_group *group,
+					 struct notifier_block *nb);
+extern int iommu_fault_notifier_call_chain(struct iommu_fault_event *event);
+
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -574,6 +580,23 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 	return 0;
 }
 
+static inline int iommu_register_fault_notifier(struct device *dev,
+						  struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int iommu_unregister_fault_notifier(struct device *dev,
+						  struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int iommu_fault_notifier_call_chain(struct iommu_fault_event *event)
+{
+	return 0;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index f077353..a8e3d7f 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -48,4 +48,38 @@ struct tlb_invalidate_info {
 	__u8	opaque[];
 };
 
+/*
+ * Generic fault event notification data, used by all IOMMU models
+ *
+ * - PCI and non-PCI devices
+ * - Recoverable faults (e.g. page request) & un-recoverable faults
+ * - DMA remapping and IRQ remapping faults
+ *
+ * @dev The device which faults are reported by IOMMU
+ * @addr tells the offending address
+ * @pasid contains process address space ID, used in shared virtual memory (SVM)
+ * @prot page access protection flag, e.g. IOMMU_READ, IOMMU_WRITE
+ * @flags contains fault type, etc.
+ * @length tells the size of the buf in bytes
+ * @buf contains any raw or arch specific data
+ *
+ */
+struct iommu_fault_event {
+	struct device *dev;
+	__u64 addr;
+	__u32 pasid;
+	__u32 prot;
+	__u32 flags;
+/* page request as result of recoverable translation fault */
+#define IOMMU_FAULT_PAGE_REQ	BIT(0)
+/* unrecoverable fault, e.g. invalid device context  */
+#define IOMMU_FAULT_UNRECOV	BIT(1)
+/* unrecoverable fault related to interrupt remapping */
+#define IOMMU_FAULT_IRQ_REMAP	BIT(2)
+/* unrecoverable fault on invalidation of translation caches */
+#define IOMMU_FAULT_INVAL	BIT(3)
+	__u32 length;
+	__u8  buf[];
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4
