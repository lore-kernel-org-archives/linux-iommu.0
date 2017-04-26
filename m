From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 09/20] Memory: introduce iommu_ops->record_device
Date: Wed, 26 Apr 2017 18:06:39 +0800
Message-ID: <1493201210-14357-10-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

With vIOMMU exposed to guest, vIOMMU emulator needs to do translation
between host and guest. e.g. a device-selective TLB flush, vIOMMU
emulator needs to replace guest SID with host SID so that to limit
the invalidation. This patch introduces a new callback
iommu_ops->record_device() to notify vIOMMU emulator to record necessary
information about the assigned device.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 include/exec/memory.h | 11 +++++++++++
 memory.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7bd13ab..49087ef 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -203,6 +203,8 @@ struct MemoryRegionIOMMUOps {
                                 IOMMUNotifierFlag new_flags);
     /* Set this up to provide customized IOMMU replay function */
     void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
+    void (*record_device)(MemoryRegion *iommu,
+                          void *device_info);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -708,6 +710,15 @@ void memory_region_notify_iommu(MemoryRegion *mr,
 void memory_region_notify_one(IOMMUNotifier *notifier,
                               IOMMUTLBEntry *entry);
 
+/*
+ * memory_region_notify_device_record: notify IOMMU to record assign
+ * device.
+ * @mr: the memory region to notify
+ * @ device_info: device information
+ */
+void memory_region_notify_device_record(MemoryRegion *mr,
+                                        void *info);
+
 /**
  * memory_region_register_iommu_notifier: register a notifier for changes to
  * IOMMU translation entries.
diff --git a/memory.c b/memory.c
index 0728e62..45ef069 100644
--- a/memory.c
+++ b/memory.c
@@ -1600,6 +1600,18 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
     mr->iommu_notify_flags = flags;
 }
 
+void memory_region_notify_device_record(MemoryRegion *mr,
+                                        void *info)
+{
+    assert(memory_region_is_iommu(mr));
+
+    if (mr->iommu_ops->record_device) {
+        mr->iommu_ops->record_device(mr, info);
+    }
+
+    return;
+}
+
 void memory_region_register_iommu_notifier(MemoryRegion *mr,
                                            IOMMUNotifier *n)
 {
-- 
1.9.1
