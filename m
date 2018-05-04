From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/9] iommu/vt-d: Global PASID name space
Date: Fri,  4 May 2018 09:41:16 +0800
Message-ID: <1525398084-28815-2-git-send-email-baolu.lu@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This adds the system wide PASID name space for the PASID
allocation. Currently we are using per IOMMU PASID name
spaces which are not suitable for some use cases. For an
example, one application (associated with a PASID) might
talk to two physical devices simultaneously while the two
devices could reside behind two different IOMMU units.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Suggested-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/Makefile      |  2 +-
 drivers/iommu/intel-iommu.c | 13 ++++++++++
 drivers/iommu/intel-pasid.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 30 +++++++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb6958..0a190b4 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f2..98c5ae9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -53,6 +53,7 @@
 #include <asm/iommu.h>
 
 #include "irq_remapping.h"
+#include "intel-pasid.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -3265,6 +3266,18 @@ static int __init init_dmars(void)
 	}
 
 	for_each_active_iommu(iommu, drhd) {
+		/*
+		 * Find the max pasid size of all IOMMU's in the system.
+		 * we need to ensure the system pasid table is no bigger
+		 * than the smallest supported.
+		 */
+		if (pasid_enabled(iommu)) {
+			u32 temp = 2 << ecap_pss(iommu->ecap);
+
+			intel_pasid_max_id = min_t(u32, temp,
+						   intel_pasid_max_id);
+		}
+
 		g_iommus[iommu->seq_id] = iommu;
 
 		intel_iommu_init_qi(iommu);
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
new file mode 100644
index 0000000..0690f39
--- /dev/null
+++ b/drivers/iommu/intel-pasid.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * intel-pasid.c - PASID idr, table and entry manipulation
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/dmar.h>
+#include <linux/intel-iommu.h>
+#include <linux/iommu.h>
+#include <linux/memory.h>
+#include <linux/spinlock.h>
+
+#include "intel-pasid.h"
+
+/*
+ * Intel IOMMU global PASID pool:
+ */
+static DEFINE_SPINLOCK(pasid_lock);
+u32 intel_pasid_max_id = PASID_MAX;
+static DEFINE_IDR(pasid_idr);
+
+int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
+{
+	int ret, min, max;
+
+	min = max_t(int, start, PASID_MIN);
+	max = min_t(int, end, intel_pasid_max_id);
+
+	WARN_ON(in_interrupt());
+	idr_preload(gfp);
+	spin_lock(&pasid_lock);
+	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
+	spin_unlock(&pasid_lock);
+	idr_preload_end();
+
+	return ret;
+}
+
+void intel_pasid_free_id(int pasid)
+{
+	spin_lock(&pasid_lock);
+	idr_remove(&pasid_idr, pasid);
+	spin_unlock(&pasid_lock);
+}
+
+void *intel_pasid_lookup_id(int pasid)
+{
+	void *p;
+
+	spin_lock(&pasid_lock);
+	p = idr_find(&pasid_idr, pasid);
+	spin_unlock(&pasid_lock);
+
+	return p;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
new file mode 100644
index 0000000..0c36af0
--- /dev/null
+++ b/drivers/iommu/intel-pasid.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * intel-pasid.h - PASID idr, table and entry header
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+ */
+
+#ifndef __INTEL_PASID_H
+#define __INTEL_PASID_H
+
+/*
+ * Eventually I'm promised we will get a multi-level PASID table
+ * and it won't have to be physically contiguous. Until then,
+ * limit the size because 8MiB contiguous allocations can be hard
+ * to come by. The limit of 0x20000, which is 1MiB for each of
+ * the PASID and PASID-state tables, is somewhat arbitrary.
+ *
+ * PASID 0 is reserved in caching mode (virtualised IOMMU).
+ */
+#define PASID_MIN			0x1
+#define PASID_MAX			0x20000
+
+extern u32 intel_pasid_max_id;
+int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
+void intel_pasid_free_id(int pasid);
+void *intel_pasid_lookup_id(int pasid);
+
+#endif /* __INTEL_PASID_H */
-- 
2.7.4
