From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 5/9] iommu: Introduce fault notifier API
Date: Wed, 14 Jun 2017 15:22:59 -0700
Message-ID: <1497478983-77580-6-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1497478983-77580-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
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

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c786370..04c73f3 100644
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
@@ -790,6 +792,67 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
 /**
+ * iommu_register_fault_notifier - Register a notifier for fault reporting
+ * @dev: device to notify fault events
+ * @nb: notifier block to signal
+ *
+ */
+int iommu_register_fault_notifier(struct device *dev,
+				struct notifier_block *nb)
+{
+	int ret;
+	struct iommu_group *group = iommu_group_get(dev);
+
+	if (!group)
+		return -EINVAL;
+
+	ret = blocking_notifier_chain_register(&group->fault_notifier, nb);
+	iommu_group_put(group);
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(iommu_register_fault_notifier);
+
+/**
+ * iommu_unregister_fault_notifier - Unregister a notifier for fault reporting
+ * @domain: the domain to watch
+ * @nb: notifier block to signal
+ *
+ */
+int iommu_unregister_fault_notifier(struct device *dev,
+				  struct notifier_block *nb)
+{
+	int ret;
+	struct iommu_group *group = iommu_group_get(dev);
+
+	if (!group)
+		return -EINVAL;
+
+	ret = blocking_notifier_chain_unregister(&group->fault_notifier, nb);
+	iommu_group_put(group);
+
+	return ret;
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
index 2cdbaa3..fe89e88 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
+#define IOMMU_EXEC	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
@@ -97,6 +98,36 @@ struct iommu_domain {
 	void *iova_cookie;
 };
 
+/*
+ * Generic fault event notification data, used by all IOMMU architectures.
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
+ * @length tells the size of the buf
+ * @buf contains any raw or arch specific data
+ *
+ */
+struct iommu_fault_event {
+	struct device *dev;
+	__u64 addr;
+	__u32 pasid;
+	__u32 prot;
+	__u32 flags;
+#define IOMMU_FAULT_PAGE_REQ	BIT(0)
+#define IOMMU_FAULT_UNRECOV	BIT(1)
+#define IOMMU_FAULT_IRQ_REMAP	BIT(2)
+#define IOMMU_FAULT_INVAL	BIT(3)
+	__u32 length;
+	__u8  buf[];
+};
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
@@ -341,6 +372,12 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_register_fault_notifier(struct device *dev,
+					 struct notifier_block *nb);
+extern int iommu_unregister_fault_notifier(struct device *dev,
+					 struct notifier_block *nb);
+extern int iommu_fault_notifier_call_chain(struct iommu_fault_event *event);
+
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -573,6 +610,23 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
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
-- 
2.7.4
