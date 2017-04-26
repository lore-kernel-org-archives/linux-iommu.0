From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 11/20] intel_iommu: provide iommu_ops->record_device
Date: Wed, 26 Apr 2017 18:06:41 +0800
Message-ID: <1493201210-14357-12-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch provides iommu_ops->record_device implementation for
intel_iommu. It records the host sid in the IntelIOMMUNotifierNode for
further virtualization usage. e.g. guest sid -> host sid translation
during propagating 1st level cache invalidation from guest to host.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c         | 19 +++++++++++++++++++
 include/hw/i386/intel_iommu.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ba1e7eb..0c412d2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2407,6 +2407,24 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
     }
 }
 
+static void vtd_iommu_record_device(MemoryRegion *iommu,
+                                    void *device_info)
+{
+    VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    IntelIOMMUNotifierNode *node = NULL;
+    IntelIOMMUNotifierNode *next_node = NULL;
+    PCIHostDeviceAddress *host = (PCIHostDeviceAddress *) device_info;
+
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->vtd_as == vtd_as) {
+            node->host_sid = ((host->bus & 0xffUL) << 8)
+                           | ((host->slot & 0x1f) << 3)
+                           | (host->function & 0x7);
+        }
+    }
+}
+
 static const VMStateDescription vtd_vmstate = {
     .name = "iommu-intel",
     .version_id = 1,
@@ -2940,6 +2958,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->iommu_ops.translate = vtd_iommu_translate;
     s->iommu_ops.notify_flag_changed = vtd_iommu_notify_flag_changed;
     s->iommu_ops.replay = vtd_iommu_replay;
+    s->iommu_ops.record_device = vtd_iommu_record_device;
     s->root = 0;
     s->root_extended = false;
     s->dmar_enabled = false;
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 8981615..a4ce5c3 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -252,6 +252,7 @@ struct VTD_MSIMessage {
 
 struct IntelIOMMUNotifierNode {
     VTDAddressSpace *vtd_as;
+    uint16_t host_sid;
     QLIST_ENTRY(IntelIOMMUNotifierNode) next;
 };
 
-- 
1.9.1
