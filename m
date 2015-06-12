From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 5/6] hw/arm/sysbus-fdt: enable vsmmu dynamic instantiation
Date: Fri, 12 Jun 2015 16:20:09 +0200
Message-ID: <1434118810-28219-6-git-send-email-b.reynal@virtualopensystems.com>
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

This patch adds the device tree node creation for the vSMMU.

Signed-off-by: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 hw/arm/sysbus-fdt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 3038b94..67f4425 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -26,6 +26,10 @@
 #include "sysemu/device_tree.h"
 #include "hw/platform-bus.h"
 #include "sysemu/sysemu.h"
+#include "hw/vfio/vfio-platform.h"
+#include "hw/vfio/vfio-smmu.h"
+
+#include <libfdt.h>
 
 /*
  * internal struct that contains the information to create dynamic
@@ -53,8 +57,47 @@ typedef struct NodeCreationPair {
     int (*add_fdt_node_fn)(SysBusDevice *sbdev, void *opaque);
 } NodeCreationPair;
 
+VFIOSmmuDevice *vsmmu = NULL;
+
+static int add_arm_smmu_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    vsmmu = VFIO_SMMU_DEVICE(sbdev);
+    void *fdt = data->fdt;
+    const char *nodename;
+    uint32_t reg_attr[4], irq_attr[3];
+    uint32_t gint = 0;
+
+    nodename = g_strdup_printf("/smmu@%" PRIx64, vsmmu->base);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop(fdt, nodename, "compatible", "arm,smmu-v2", 12);
+
+    reg_attr[0] = 0;
+    reg_attr[1] = cpu_to_be32(vsmmu->base);
+    reg_attr[2] = 0;
+    reg_attr[3] = cpu_to_be32(vsmmu->size);
+
+    qemu_fdt_setprop(fdt, nodename, "reg",
+            reg_attr, 4*sizeof(uint32_t));
+
+    /* Add dummy interrupt */
+    irq_attr[0] = 0;
+    irq_attr[1] = 0;
+    irq_attr[2] = 0;
+
+    qemu_fdt_setprop(fdt, nodename, "interrupts",
+            irq_attr, 3*sizeof(uint32_t));
+
+    qemu_fdt_setprop(fdt, nodename, "#global-interrupts", &gint,
+            sizeof(uint32_t));
+
+    return 0;
+}
+
 /* list of supported dynamic sysbus devices */
 static const NodeCreationPair add_fdt_node_functions[] = {
+    {TYPE_VFIO_SMMU, add_arm_smmu_fdt_node},
     {"", NULL}, /* last element */
 };
 
-- 
2.4.3
