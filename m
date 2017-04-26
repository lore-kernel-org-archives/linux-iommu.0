From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 17/20] Memory: Add func to fire TLB invalidate notifier
Date: Wed, 26 Apr 2017 18:06:47 +0800
Message-ID: <1493201210-14357-18-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds a separate function to fire IOMMU TLB invalidate notifier.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 include/exec/memory.h |  9 +++++++++
 memory.c              | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index af15351..0155bad 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -707,6 +707,15 @@ void memory_region_notify_iommu(MemoryRegion *mr,
 void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
                                          void *data);
 
+/*
+ * memory_region_notify_iommu_invalidate: notify IOMMU
+ * TLB invalidation passdown.
+ *
+ * @mr: the memory region of IOMMU
+ * @data: IOMMU SVM data
+ */
+void memory_region_notify_iommu_invalidate(MemoryRegion *mr,
+                                           void *data);
 
 /**
  * memory_region_notify_one: notify a change in an IOMMU translation
diff --git a/memory.c b/memory.c
index ce0b0ff..8c572d5 100644
--- a/memory.c
+++ b/memory.c
@@ -1750,6 +1750,24 @@ void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
     }
 }
 
+void memory_region_notify_iommu_invalidate(MemoryRegion *mr,
+                                           void *data)
+{
+    IOMMUNotifier *iommu_notifier;
+    IOMMUNotifierFlag request_flags;
+
+    assert(memory_region_is_iommu(mr));
+
+    request_flags = IOMMU_NOTIFIER_IOMMU_TLB_INV;
+
+    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+        if (iommu_notifier->notifier_flags & request_flags) {
+            iommu_notifier->notify(iommu_notifier, data);
+            break;
+        }
+    }
+}
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask = 1 << client;
-- 
1.9.1
