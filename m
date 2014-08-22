From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: [RFC 4/5] vfio: amba: VFIO support for AMBA devices
Date: Fri, 22 Aug 2014 11:01:27 +0200
Message-ID: <1408698088-5349-5-git-send-email-a.motakis@virtualopensystems.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: kvm-owner@vger.kernel.org
To: alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org
Cc: tech@virtualopensystems.com, a.rigo@virtualopensystems.com, kvm@vger.kernel.org, christoffer.dall@linaro.org, will.deacon@arm.com, kim.phillips@freescale.com, stuart.yoder@freescale.com, eric.auger@linaro.org, marc.zyngier@arm.com, Antonios Motakis <a.motakis@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org

Add support for discovering AMBA devices with VFIO and handle them
similarly to Linux platform devices.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_amba.c | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 drivers/vfio/platform/vfio_amba.c

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
new file mode 100644
index 0000000..9fc0ae6
--- /dev/null
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2013 - Virtual Open Systems
+ * Author: Antonios Motakis <a.motakis@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/amba/bus.h>
+
+#include "vfio_platform_private.h"
+
+#define DRIVER_VERSION  "0.6"
+#define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
+#define DRIVER_DESC     "VFIO for AMBA devices - User Level meta-driver"
+
+/* probing devices from the AMBA bus */
+
+static struct resource* get_amba_resource(struct vfio_platform_device *vdev,
+						int i)
+{
+	struct amba_device *adev = (struct amba_device *) vdev->opaque;
+
+	if (i == 0)
+		return &adev->res;
+	else
+		return NULL;
+}
+
+static int get_amba_irq(struct vfio_platform_device *vdev, int i)
+{
+	struct amba_device *adev = (struct amba_device *) vdev->opaque;
+
+	if (i < AMBA_NR_IRQS)
+		return adev->irq[i];
+	else
+		return 0;
+}
+
+static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
+{
+
+	struct vfio_platform_device *vdev;
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(&adev->dev);
+	if (!group) {
+		pr_err("VFIO: No IOMMU group for amba device with id%d\n",
+				adev->periphid);
+		return -EINVAL;
+	}
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev) {
+		iommu_group_put(group);
+		return -ENOMEM;
+	}
+
+	vdev->opaque = (void *) adev;
+	vdev->get_resource = get_amba_resource;
+	vdev->get_irq = get_amba_irq;
+	vdev->name = "AMBA device";
+
+	ret = vfio_add_group_dev(&adev->dev, &vfio_platform_ops, vdev);
+	if (ret) {
+		iommu_group_put(group);
+		kfree(vdev);
+	}
+
+	return ret;
+}
+
+static int vfio_amba_remove(struct amba_device *adev)
+{
+
+	struct vfio_platform_device *vdev;
+
+	vdev = vfio_del_group_dev(&adev->dev);
+	if (!vdev)
+		return -EINVAL;
+
+	iommu_group_put(adev->dev.iommu_group);
+	kfree(vdev);
+
+	return 0;
+}
+
+static struct amba_id pl330_ids[] = {
+	{ 0, 0 },
+};
+
+MODULE_DEVICE_TABLE(amba, pl330_ids);
+
+static struct amba_driver vfio_amba_driver = {
+	.probe = vfio_amba_probe,
+	.remove = vfio_amba_remove,
+	.id_table = pl330_ids,
+	.drv = {
+		.name = "vfio-amba",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_amba_driver(vfio_amba_driver);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
-- 
1.8.3.2

