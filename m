From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 06/20] VFIO: add new notifier for binding PASID table
Date: Wed, 26 Apr 2017 18:06:36 +0800
Message-ID: <1493201210-14357-7-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch includes the following items:

* add vfio_register_notifier() for vfio notifier initialization
* add new notifier flag IOMMU_NOTIFIER_SVM_PASIDT_BIND = 0x4
* add vfio_iommu_bind_pasid_tbl_notify() to link guest pasid table
  to host

This patch doesn't register new notifier in vfio memory region listener
region_add callback. The reason is as below:

On VT-d, when virtual intel_iommu is exposed to guest, the vfio memory
listener listens to address_space_memory. When guest Intel IOMMU driver
enables address translation, vfio memory listener may switch to listen
to vtd_address_space. But there is special case. If virtual intel_iommu
reports ecap.PT=1 to guest and meanwhile guest Intel IOMMU driver sets
"pt" mode for the assigned, vfio memory listener would keep listen to
address_space_memory to make sure there is GPA->HPA mapping in pIOMMU.
Thus region_add would not be triggered. While for the newly added
notifier, it requires to be registered once virtual intel_iommu is
exposed to guest.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c              | 37 +++++++++++++++++++++++-------
 hw/vfio/pci.c                 | 53 ++++++++++++++++++++++++++++++++++++++++++-
 include/exec/memory.h         |  8 +++++++
 include/hw/vfio/vfio-common.h |  5 ++++
 4 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 14473f1..e270255 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -294,6 +294,25 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
            section->offset_within_address_space & (1ULL << 63);
 }
 
+VFIOGuestIOMMU *vfio_register_notifier(VFIOContainer *container,
+                                       MemoryRegion *mr,
+                                       hwaddr offset,
+                                       IOMMUNotifier *n)
+{
+    VFIOGuestIOMMU *giommu;
+
+    giommu = g_malloc0(sizeof(*giommu));
+    giommu->iommu = mr;
+    giommu->iommu_offset = offset;
+    giommu->container = container;
+    giommu->n = *n;
+
+    QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+    memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
+
+    return giommu;
+}
+
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
                            bool *read_only)
@@ -466,6 +485,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
 
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
+        IOMMUNotifier n;
+        hwaddr iommu_offset;
 
         trace_vfio_listener_region_add_iommu(iova, end);
         /*
@@ -474,21 +495,21 @@ static void vfio_listener_region_add(MemoryListener *listener,
          * would be the right place to wire that up (tell the KVM
          * device emulation the VFIO iommu handles to use).
          */
-        giommu = g_malloc0(sizeof(*giommu));
-        giommu->iommu = section->mr;
-        giommu->iommu_offset = section->offset_within_address_space -
-                               section->offset_within_region;
-        giommu->container = container;
+        iommu_offset = section->offset_within_address_space -
+                       section->offset_within_region;
         llend = int128_add(int128_make64(section->offset_within_region),
                            section->size);
         llend = int128_sub(llend, int128_one());
-        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
+        iommu_notifier_init(&n, vfio_iommu_map_notify,
                             IOMMU_NOTIFIER_ALL,
                             section->offset_within_region,
                             int128_get64(llend));
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
-        memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
+        giommu = vfio_register_notifier(container,
+                                        section->mr,
+                                        iommu_offset,
+                                        &n);
+
         memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
 
         return;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 332f41d..9e13472 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2594,11 +2594,38 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static void vfio_iommu_bind_pasid_tbl_notify(IOMMUNotifier *n, void *data)
+{
+    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
+    VFIOContainer *container = giommu->container;
+    IOMMUNotifierData *iommu_data = (IOMMUNotifierData *) data;
+    struct vfio_device_svm *vfio_svm;
+    int argsz;
+
+    argsz = sizeof(*vfio_svm) + iommu_data->payload_size;
+    vfio_svm = g_malloc0(argsz);
+    vfio_svm->argsz = argsz;
+    vfio_svm->flags = VFIO_SVM_BIND_PASIDTBL;
+    vfio_svm->length = iommu_data->payload_size;
+    memcpy(&vfio_svm->data, iommu_data->payload,
+                         iommu_data->payload_size);
+
+    rcu_read_lock();
+    if (ioctl(container->fd, VFIO_IOMMU_SVM_BIND_TASK, vfio_svm) != 0) {
+        error_report("vfio_iommu_bind_pasid_tbl_notify:"
+                     " bind failed, contanier: %p", container);
+    }
+    rcu_read_unlock();
+    g_free(vfio_svm);
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
+    AddressSpace *as;
+    MemoryRegion *subregion;
     char *tmp, group_path[PATH_MAX], *group_name;
     Error *err = NULL;
     ssize_t len;
@@ -2650,7 +2677,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     trace_vfio_realize(vdev->vbasedev.name, groupid);
 
-    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
+    as = pci_device_iommu_address_space(pdev);
+    group = vfio_get_group(groupid, as, errp);
     if (!group) {
         goto error;
     }
@@ -2833,6 +2861,29 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    /* Check if vIOMMU exists */
+    QTAILQ_FOREACH(subregion, &as->root->subregions, subregions_link) {
+        if (memory_region_is_iommu(subregion)) {
+            IOMMUNotifier n1;
+
+            /*
+             FIXME: current iommu notifier is actually designed for
+             IOMMUTLB MAP/UNMAP. However, vIOMMU emulator may need
+             notifiers other than MAP/UNMAP, so it'll be better to
+             split the non-IOMMUTLB notifier from the current IOMMUTLB
+             notifier framewrok.
+             */
+            iommu_notifier_init(&n1, vfio_iommu_bind_pasid_tbl_notify,
+                                IOMMU_NOTIFIER_SVM_PASIDT_BIND,
+                                0,
+                                0);
+            vfio_register_notifier(group->container,
+                                   subregion,
+                                   0,
+                                   &n1);
+        }
+    }
+
     return;
 
 out_teardown:
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1faca3b..d2f24cc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -65,6 +65,12 @@ struct IOMMUTLBEntry {
     IOMMUAccessFlags perm;
 };
 
+struct IOMMUNotifierData {
+    uint64_t payload_size;
+    uint8_t *payload;
+};
+typedef struct IOMMUNotifierData IOMMUNotifierData;
+
 /*
  * Bitmap for different IOMMUNotifier capabilities. Each notifier can
  * register with one or multiple IOMMU Notifier capability bit(s).
@@ -75,6 +81,8 @@ typedef enum {
     IOMMU_NOTIFIER_UNMAP = 0x1,
     /* Notify entry changes (newly created entries) */
     IOMMU_NOTIFIER_MAP = 0x2,
+    /* Notify PASID Table Binding */
+    IOMMU_NOTIFIER_SVM_PASIDT_BIND = 0x4,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de1..195795c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -160,6 +160,11 @@ void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
+VFIOGuestIOMMU *vfio_register_notifier(VFIOContainer *container,
+                                       MemoryRegion *mr,
+                                       hwaddr offset,
+                                       IOMMUNotifier *n);
+
 extern const MemoryRegionOps vfio_region_ops;
 extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
 extern QLIST_HEAD(vfio_as_head, VFIOAddressSpace) vfio_address_spaces;
-- 
1.9.1
