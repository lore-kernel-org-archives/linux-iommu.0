From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 13/20] IOMMU: add pasid_table_info for guest pasid table
Date: Wed, 26 Apr 2017 18:06:43 +0800
Message-ID: <1493201210-14357-14-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds iommu.h to define some generic definition for IOMMU.

Here defines "struct pasid_table_info" for guest pasid table bind.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 linux-headers/linux/iommu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 linux-headers/linux/iommu.h

diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000..4519dcf
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2017 Intel Corporation.
+ * Author: Yi Liu <yi.l.liu@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef __LINUX_IOMMU_H
+#define __LINUX_IOMMU_H
+
+#include <linux/errno.h>
+
+struct pasid_table_info {
+	__u64  ptr;	/* PASID table ptr */
+	__u64  size;	/* PASID table size*/
+	__u32  model;	/* magic number */
+#define	INTEL_IOMMU	(1 << 0)
+#define	ARM_SMMU	(1 << 1)
+	__u8   opaque[];/* IOMMU-specific details */
+};
+
+#endif /* __LINUX_IOMMU_H */
-- 
1.9.1
