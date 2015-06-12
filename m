From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 6/6] hw/arm/sysbus-fdt: add smmu masters in device tree
Date: Fri, 12 Jun 2015 16:20:10 +0200
Message-ID: <1434118810-28219-7-git-send-email-b.reynal@virtualopensystems.com>
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
Cc: tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds a function to bind a device as an SMMU master in the
device tree. Currently, only one device is supported.

A device can be set as SMMU master by using the "x-iommu" argument on
the command line:

-device pl330,x-iommu=true

Signed-off-by: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 hw/arm/sysbus-fdt.c             | 35 +++++++++++++++++++++++++++++++++++
 hw/vfio/platform.c              |  1 +
 include/hw/vfio/vfio-platform.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 67f4425..356f644 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -101,6 +101,38 @@ static const NodeCreationPair add_fdt_node_functions[] = {
     {"", NULL}, /* last element */
 };
 
+static int add_smmu_master(SysBusDevice *sbdev, void *opaque)
+{
+    if (object_dynamic_cast(OBJECT(sbdev), TYPE_VFIO_PLATFORM) &&
+	    VFIO_PLATFORM_DEVICE(sbdev)->iommu_master) {
+        int master[2];
+        char *smmu_nodename, *master_nodename;
+        uint64_t mmio_base;
+        PlatformBusFDTData *data = opaque;
+        PlatformBusDevice *pbus = data->pbus;
+        void *fdt = data->fdt;
+        VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+        VFIODevice *vbasedev = &vdev->vbasedev;
+        const char *parent_node = data->pbus_node_name;
+
+        smmu_nodename = g_strdup_printf("/smmu@%" PRIx64, vsmmu->base);
+        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+
+        master_nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
+                vbasedev->name,
+                mmio_base);
+
+        master[0] = cpu_to_be32(qemu_fdt_get_phandle(fdt, master_nodename));
+        master[1] = cpu_to_be32(vbasedev->group->groupid);
+
+        qemu_fdt_setprop(fdt, smmu_nodename, "mmu-masters",
+                master, 2*sizeof(int));
+
+    }
+
+    return 0;
+}
+
 /**
  * add_fdt_node - add the device tree node of a dynamic sysbus device
  *
@@ -193,6 +225,9 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
 
     /* Loop through all dynamic sysbus devices and create their node */
     foreach_dynamic_sysbus_device(add_fdt_node, &data);
+    if (vsmmu) {
+        foreach_dynamic_sysbus_device(add_smmu_master, &data);
+    }
 
     g_free(node);
 }
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 6192458..d4ea297 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -585,6 +585,7 @@ static Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_BOOL("x-mmap", VFIOPlatformDevice, vbasedev.allow_mmap, true),
     DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
                        mmap_timeout, 1100),
+    DEFINE_PROP_BOOL("x-iommu", VFIOPlatformDevice, iommu_master, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index 26b2ad6..8f5d980 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -57,6 +57,7 @@ typedef struct VFIOPlatformDevice {
     uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
     QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
     QemuMutex intp_mutex; /* protect the intp_list IRQ state */
+    bool iommu_master; /* is the device a master to the vSMMU ? */
 } VFIOPlatformDevice;
 
 typedef struct VFIOPlatformDeviceClass {
-- 
2.4.3
