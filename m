From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 08/10] iommu/ipmmu-vmsa: Remove platform data support
Date: Tue, 16 Dec 2014 15:44:15 +0200
Message-ID: <1418737457-22042-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

No board file instantiates the IPMMU using platform data. Now that we
have DT support, get rid of platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c               | 24 ------------------------
 include/linux/platform_data/ipmmu-vmsa.h | 24 ------------------------
 2 files changed, 48 deletions(-)
 delete mode 100644 include/linux/platform_data/ipmmu-vmsa.h

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b6a11f82259f..3560e4d975b1 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -17,7 +17,6 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_data/ipmmu-vmsa.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -30,7 +29,6 @@ struct ipmmu_vmsa_device {
 	void __iomem *base;
 	struct list_head list;
 
-	const struct ipmmu_vmsa_platform_data *pdata;
 	unsigned int num_utlbs;
 
 	struct dma_iommu_mapping *mapping;
@@ -1015,27 +1013,6 @@ static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device *dev,
 	unsigned int i;
 	int count;
 
-	if (mmu->pdata) {
-		const struct ipmmu_vmsa_master *master = mmu->pdata->masters;
-		const char *devname = dev_name(dev);
-		unsigned int i;
-
-		for (i = 0; i < mmu->pdata->num_masters; ++i, ++master) {
-			if (strcmp(master->name, devname) == 0) {
-				utlbs = kmalloc(sizeof(*utlbs), GFP_KERNEL);
-				if (!utlbs)
-					return -ENOMEM;
-
-				utlbs[0] = master->utlb;
-
-				*_utlbs = utlbs;
-				return 1;
-			}
-		}
-
-		return -EINVAL;
-	}
-
 	count = of_count_phandle_with_args(dev->of_node, "iommus",
 					   "#iommu-cells");
 	if (count < 0)
@@ -1245,7 +1222,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 	}
 
 	mmu->dev = &pdev->dev;
-	mmu->pdata = pdev->dev.platform_data;
 	mmu->num_utlbs = 32;
 
 	/* Map I/O memory and request IRQ. */
diff --git a/include/linux/platform_data/ipmmu-vmsa.h b/include/linux/platform_data/ipmmu-vmsa.h
deleted file mode 100644
index 5275b3ac6d37..000000000000
--- a/include/linux/platform_data/ipmmu-vmsa.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * IPMMU VMSA Platform Data
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- */
-
-#ifndef __IPMMU_VMSA_H__
-#define __IPMMU_VMSA_H__
-
-struct ipmmu_vmsa_master {
-	const char *name;
-	unsigned int utlb;
-};
-
-struct ipmmu_vmsa_platform_data {
-	const struct ipmmu_vmsa_master *masters;
-	unsigned int num_masters;
-};
-
-#endif /* __IPMMU_VMSA_H__ */
-- 
2.0.4

