From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Tue, 23 Feb 2016 08:12:36 -0600
Message-ID: <1456236764-1569-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

First, this patch move arch/x86/events/amd/iommu.h to
arch/x86/include/asm/perf/amd/iommu.h so that we easily include
it in both perf-amd-iommu and amd-iommu drivers.

Then, we consolidate declaration of AMD IOMMU performance counter
APIs into one file.

Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c           |  2 +-
 arch/x86/events/amd/iommu.h           | 40 ---------------------------------
 arch/x86/include/asm/perf/amd/iommu.h | 42 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c        |  2 ++
 drivers/iommu/amd_iommu_proto.h       |  7 ------
 5 files changed, 45 insertions(+), 48 deletions(-)
 delete mode 100644 arch/x86/events/amd/iommu.h
 create mode 100644 arch/x86/include/asm/perf/amd/iommu.h

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 9da0d16..fb4aa7b 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -15,9 +15,9 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/slab.h>
+#include <asm/perf/amd/iommu.h>
 
 #include "../../kernel/cpu/perf_event.h"
-#include "iommu.h"
 
 #define COUNTER_SHIFT		16
 
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
deleted file mode 100644
index 845d173..0000000
--- a/arch/x86/events/amd/iommu.h
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
diff --git a/arch/x86/include/asm/perf/amd/iommu.h b/arch/x86/include/asm/perf/amd/iommu.h
new file mode 100644
index 0000000..72f64b7
--- /dev/null
+++ b/arch/x86/include/asm/perf/amd/iommu.h
@@ -0,0 +1,42 @@
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
+/* maximum specified bank/counters */
+#define PC_MAX_SPEC_BNKS			64
+#define PC_MAX_SPEC_CNTRS			16
+
+/* iommu pc reg masks*/
+#define IOMMU_BASE_DEVID			0x0000
+
+/* amd_iommu_init.c external support functions */
+bool amd_iommu_pc_supported(void);
+
+u8 amd_iommu_pc_get_max_banks(u16 devid);
+
+u8 amd_iommu_pc_get_max_counters(u16 devid);
+
+int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value);
+
+int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
+				 u64 *value, bool is_write);
+
+#endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..d30f4b2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -27,6 +27,8 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <asm/perf/amd/iommu.h>
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
-- 
1.9.1
