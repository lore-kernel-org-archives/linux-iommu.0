From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3 1/5] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Tue, 9 Feb 2016 16:53:51 -0600
Message-ID: <1455058435-8716-2-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch consolidates "arch/x86/kernel/cpu/perf_event_amd_iommu.h" and
"drivers/iommu/amd_iommu_proto.h", which contain duplicate function
declarations, into "include/linux/perf/perf_event_amd_iommu.h"

Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/kernel/cpu/perf_event_amd_iommu.c |  2 +-
 arch/x86/kernel/cpu/perf_event_amd_iommu.h | 40 ------------------------------
 drivers/iommu/amd_iommu_init.c             |  2 ++
 drivers/iommu/amd_iommu_proto.h            |  7 ------
 include/linux/perf/perf_event_amd_iommu.h  | 40 ++++++++++++++++++++++++++++++
 5 files changed, 43 insertions(+), 48 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommu.h
 create mode 100644 include/linux/perf/perf_event_amd_iommu.h

diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
index 97242a9..d44525e 100644
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
+++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
@@ -12,12 +12,12 @@
  */
 
 #include <linux/perf_event.h>
+#include <linux/perf/perf_event_amd_iommu.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/slab.h>
 
 #include "perf_event.h"
-#include "perf_event_amd_iommu.h"
 
 #define COUNTER_SHIFT		16
 
diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.h b/arch/x86/kernel/cpu/perf_event_amd_iommu.h
deleted file mode 100644
index 845d173..0000000
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (C) 2013 Advanced Micro Devices, Inc.
- *
- * Author: Steven Kinney <Steven.Kinney-5C7GfCeVMHo@public.gmane.org>
- * Author: Suravee Suthikulpanit <Suraveee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _PERF_EVENT_AMD_IOMMU_H_
-#define _PERF_EVENT_AMD_IOMMU_H_
-
-/* iommu pc mmio region register indexes */
-#define IOMMU_PC_COUNTER_REG			0x00
-#define IOMMU_PC_COUNTER_SRC_REG		0x08
-#define IOMMU_PC_PASID_MATCH_REG		0x10
-#define IOMMU_PC_DOMID_MATCH_REG		0x18
-#define IOMMU_PC_DEVID_MATCH_REG		0x20
-#define IOMMU_PC_COUNTER_REPORT_REG		0x28
-
-/* maximun specified bank/counters */
-#define PC_MAX_SPEC_BNKS			64
-#define PC_MAX_SPEC_CNTRS			16
-
-/* iommu pc reg masks*/
-#define IOMMU_BASE_DEVID			0x0000
-
-/* amd_iommu_init.c external support functions */
-extern bool amd_iommu_pc_supported(void);
-
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
-
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
-
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
-			u8 fxn, u64 *value, bool is_write);
-
-#endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..b6d684c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -27,6 +27,8 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/perf/perf_event_amd_iommu.h>
+
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 0bd9eb3..ac2da91 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -55,13 +55,6 @@ extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
 extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
 
-/* IOMMU Performance Counter functions */
-extern bool amd_iommu_pc_supported(void);
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write);
-
 #ifdef CONFIG_IRQ_REMAP
 extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/include/linux/perf/perf_event_amd_iommu.h b/include/linux/perf/perf_event_amd_iommu.h
new file mode 100644
index 0000000..845d173
--- /dev/null
+++ b/include/linux/perf/perf_event_amd_iommu.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2013 Advanced Micro Devices, Inc.
+ *
+ * Author: Steven Kinney <Steven.Kinney-5C7GfCeVMHo@public.gmane.org>
+ * Author: Suravee Suthikulpanit <Suraveee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _PERF_EVENT_AMD_IOMMU_H_
+#define _PERF_EVENT_AMD_IOMMU_H_
+
+/* iommu pc mmio region register indexes */
+#define IOMMU_PC_COUNTER_REG			0x00
+#define IOMMU_PC_COUNTER_SRC_REG		0x08
+#define IOMMU_PC_PASID_MATCH_REG		0x10
+#define IOMMU_PC_DOMID_MATCH_REG		0x18
+#define IOMMU_PC_DEVID_MATCH_REG		0x20
+#define IOMMU_PC_COUNTER_REPORT_REG		0x28
+
+/* maximun specified bank/counters */
+#define PC_MAX_SPEC_BNKS			64
+#define PC_MAX_SPEC_CNTRS			16
+
+/* iommu pc reg masks*/
+#define IOMMU_BASE_DEVID			0x0000
+
+/* amd_iommu_init.c external support functions */
+extern bool amd_iommu_pc_supported(void);
+
+extern u8 amd_iommu_pc_get_max_banks(u16 devid);
+
+extern u8 amd_iommu_pc_get_max_counters(u16 devid);
+
+extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
+			u8 fxn, u64 *value, bool is_write);
+
+#endif /*_PERF_EVENT_AMD_IOMMU_H_*/
-- 
2.5.0
