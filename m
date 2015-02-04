From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Update my email address
Date: Wed,  4 Feb 2015 16:17:55 +0100
Message-ID: <1423063075-28803-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, jroedel@suse.de, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The AMD address is dead for a long time already, replace it
with a working one.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c       | 2 +-
 drivers/iommu/amd_iommu_init.c  | 2 +-
 drivers/iommu/amd_iommu_proto.h | 2 +-
 drivers/iommu/amd_iommu_types.h | 2 +-
 drivers/iommu/amd_iommu_v2.c    | 6 +++---
 drivers/iommu/iommu.c           | 2 +-
 drivers/iommu/irq_remapping.h   | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9802485..6b6dc72 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2007-2010 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *         Leo Duran <leo.duran@amd.com>
  *
  * This program is free software; you can redistribute it and/or modify it
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b0522f1..e93eb8c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2007-2010 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *         Leo Duran <leo.duran@amd.com>
  *
  * This program is free software; you can redistribute it and/or modify it
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 95ed6de..b62ff54 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009-2010 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index cec51a8..c4fffb7 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2007-2010 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *         Leo Duran <leo.duran@amd.com>
  *
  * This program is free software; you can redistribute it and/or modify it
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 90f70d0..d3a3caf 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2010-2012 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published
@@ -31,7 +31,7 @@
 #include "amd_iommu_proto.h"
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Joerg Roedel <joerg.roedel@amd.com>");
+MODULE_AUTHOR("Joerg Roedel <jroedel@suse.de>");
 
 #define MAX_DEVICES		0x10000
 #define PRI_QUEUE_SIZE		512
@@ -921,7 +921,7 @@ static int __init amd_iommu_v2_init(void)
 {
 	int ret;
 
-	pr_info("AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel@amd.com>\n");
+	pr_info("AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>\n");
 
 	if (!amd_iommu_v2_supported()) {
 		pr_info("AMD IOMMUv2 functionality not available on this system\n");
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e0dcdb..72e683d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2007-2008 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index fde250f..a2b7501 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2012 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <joerg.roedel@amd.com>
+ * Author: Joerg Roedel <jroedel@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published
-- 
1.8.4.5
