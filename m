From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 4/6] hw/vfio: vsmmu device
Date: Fri, 12 Jun 2015 16:20:08 +0200
Message-ID: <1434118810-28219-5-git-send-email-b.reynal@virtualopensystems.com>
References: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434118810-28219-1-git-send-email-b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
Cc: tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patches introduces support for ARM virtual SMMU, enabling two stages
address translation.

The vSMMU device can be instantiated from the command line using following
option:

-device vsmmu,x-group=1

Signed-off-by: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 hw/vfio/Makefile.objs       |   1 +
 hw/vfio/common.c            |   8 ++-
 hw/vfio/platform.c          |   1 +
 hw/vfio/smmu.c              | 157 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-smmu.h |  50 ++++++++++++++
 5 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/smmu.c
 create mode 100644 include/hw/vfio/vfio-smmu.h

diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index d540c9d..4b91901 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -3,4 +3,5 @@ obj-$(CONFIG_SOFTMMU) += common.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_SOFTMMU) += platform.o
 obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
+obj-$(CONFIG_SOFTMMU) += smmu.o
 endif
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b1045da..a3ee72f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -676,8 +676,12 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as)
             goto free_container_exit;
         }
 
-        ret = ioctl(fd, VFIO_SET_IOMMU,
-                    v2 ? VFIO_TYPE1v2_IOMMU : VFIO_TYPE1_IOMMU);
+        if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_NESTING_IOMMU)) {
+            ret = ioctl(fd, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
+        } else {
+            ret = ioctl(fd, VFIO_SET_IOMMU,
+			    v2 ? VFIO_TYPE1v2_IOMMU : VFIO_TYPE1_IOMMU);
+        }
         if (ret) {
             error_report("vfio: failed to set iommu for container: %m");
             ret = -errno;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 9382bb7..6192458 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -475,6 +475,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev)
         error_report("vfio: failed to get group %d", groupid);
         return -ENOENT;
     }
+    vbasedev->group = group;
 
     g_snprintf(path, sizeof(path), "%s", vbasedev->name);
 
diff --git a/hw/vfio/smmu.c b/hw/vfio/smmu.c
new file mode 100644
index 0000000..467abbe
--- /dev/null
+++ b/hw/vfio/smmu.c
@@ -0,0 +1,157 @@
+/*
+ * support for vsmmu interface to use it with vfio devices
+ *
+ * Copyright (C) 2015 - Virtual Open Systems
+ *
+ * Author: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-smmu.h"
+#include "sysemu/kvm.h"
+#include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
+#include "hw/platform-bus.h"
+#include "hw/vfio/vfio.h"
+#include "hw/vfio/vfio-common.h"
+
+static void vsmmu_notify(Notifier *notifier, void *data)
+{
+    SmmuNotifierParams *p = DO_UPCAST(SmmuNotifierParams,
+                                                notifier, notifier);
+
+    DeviceState *dev;
+    PlatformBusDevice *pbus;
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(p->vsmmu);
+
+    dev = qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_BUS_DEVICE);
+    pbus = PLATFORM_BUS_DEVICE(dev);
+    assert(pbus->done_gathering);
+
+    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    base += pbus->base_address;
+
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_ARM_SMMU_V2_CFG,
+        .attr = KVM_DEV_ARM_SMMU_V2_CFG_INIT,
+        .addr = (uint64_t)(unsigned long) &base,
+    };
+
+    if (ioctl(p->vsmmu->kvm_device, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_report("Error during vSMMU initialization: %m.\n");
+    } else {
+        p->vsmmu->base = base;
+    }
+}
+
+static void smmu_realize(DeviceState *dev, Error **errp)
+{
+    VFIOSmmuDevice *vsmmu = VFIO_SMMU_DEVICE(dev);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
+    VFIOGroup *group;
+    int ret;
+    const char *name = "smmu memory";
+
+    group = vfio_get_group(vsmmu->group, &address_space_memory);
+    if (!group) {
+        error_report("vfio: failed to get group %d", vsmmu->group);
+        goto fail;
+    }
+
+    /* Create ARM_SMMU_V2 */
+    struct kvm_create_device cd = {
+        .type = KVM_DEV_TYPE_ARM_SMMU_V2,
+    };
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
+    if (ret < 0) {
+        error_report("vfio: error creating vSMMU: %m");
+        goto fail;
+    };
+    vsmmu->kvm_device = cd.fd;
+
+    /* Add group */
+    struct arm_smmu_v2_vfio_group_sid group_sid = {
+        .fd = group->fd,
+        .sid = group->groupid,
+    };
+
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_ARM_SMMU_V2_VFIO,
+        .attr = KVM_DEV_ARM_SMMU_V2_VFIO_GROUP_ADD,
+        .addr = (uint64_t)(unsigned long) &group_sid,
+    };
+
+    if (ioctl(cd.fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_report("Failed to add group %d to vSMMU: %m",
+                 group->groupid);
+        goto fail;
+    }
+
+    /* Initialize the virtual device */
+    /* Get vSMMU size for allocation */
+    int size;
+
+    attr.group = KVM_DEV_ARM_SMMU_V2_CFG;
+    attr.attr = KVM_DEV_ARM_SMMU_V2_CFG_SIZE;
+    attr.addr = (uint64_t)(unsigned long) &size;
+
+    ret = ioctl(cd.fd, KVM_GET_DEVICE_ATTR, &attr);
+
+    if (ret) {
+        error_report("Failed to get vSMMU size: %m");
+        goto fail;
+    }
+
+    vsmmu->size = size;
+
+    memory_region_init_reservation(&vsmmu->mem, OBJECT(vsmmu), name, size);
+    sysbus_init_mmio(sbdev, &vsmmu->mem);
+
+    /* Register a machine init done notifier to initialize the
+     * vSMMU at the right address */
+    SmmuNotifierParams *p = g_new(SmmuNotifierParams, 1);
+    p->vsmmu = vsmmu;
+    p->notifier.notify = vsmmu_notify;
+    qemu_add_platform_bus_link_done_notifier(&p->notifier);
+fail:
+    return;
+}
+
+static const VMStateDescription vfio_platform_vmstate = {
+    .name = TYPE_VFIO_SMMU,
+    .unmigratable = 1,
+};
+
+static Property vfio_smmu_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-group", VFIOSmmuDevice,
+                       group, -1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vfio_smmu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = smmu_realize;
+    dc->desc = "VFIO SMMU";
+    dc->props = vfio_smmu_dev_properties;
+}
+
+static const TypeInfo vfio_smmu_dev_info = {
+    .name = TYPE_VFIO_SMMU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VFIOSmmuDevice),
+    .class_init = vfio_smmu_class_init,
+    .class_size = sizeof(VFIOSmmuDeviceClass),
+};
+
+static void register_smmu_dev_type(void)
+{
+    type_register_static(&vfio_smmu_dev_info);
+}
+
+type_init(register_smmu_dev_type)
diff --git a/include/hw/vfio/vfio-smmu.h b/include/hw/vfio/vfio-smmu.h
new file mode 100644
index 0000000..c14ff8e
--- /dev/null
+++ b/include/hw/vfio/vfio-smmu.h
@@ -0,0 +1,50 @@
+/*
+ * support for vsmmu interface to use it with vfio devices
+ *
+ * Copyright (C) 2015 - Virtual Open Systems
+ *
+ * Author: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VFIO_SMMU_H
+#define HW_VFIO_SMMU_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_VFIO_SMMU "vfio-smmu"
+
+typedef struct VFIOSmmuDevice {
+    SysBusDevice sbdev;
+    int kvm_device;
+    int size;
+    hwaddr base;
+
+    MemoryRegion mem;
+
+    uint32_t group;
+} VFIOSmmuDevice;
+
+typedef struct SmmuNotifierParams {
+    Notifier notifier;
+    VFIOSmmuDevice *vsmmu;
+} SmmuNotifierParams;
+
+typedef struct VFIOSmmuDeviceClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+} VFIOSmmuDeviceClass;
+
+#define VFIO_SMMU_DEVICE(obj) \
+     OBJECT_CHECK(VFIOSmmuDevice, (obj), TYPE_VFIO_SMMU)
+#define VFIO_SMMU_DEVICE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(VFIOSmmuDeviceClass, (klass), \
+                        TYPE_VFIO_SMMU)
+#define VFIO_SMMU_DEVICE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(VFIOSmmuDeviceClass, (obj), \
+                        TYPE_VFIO_SMMU)
+
+#endif
-- 
2.4.3
