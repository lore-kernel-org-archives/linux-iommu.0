From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v8 6/9] perf/amd/iommu: Modify amd_iommu_pc_get_set_reg_val() API to allow specifying IOMMU index
Date: Mon, 16 Jan 2017 01:23:33 -0600
Message-ID: <1484551416-5440-7-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, bp@alien8.de, peterz@infradead.org, mingo@redhat.com, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The current amd_iommu_pc_get_set_reg_val() cannot support multiple IOMMUs
It is also confusing since it is trying to support set and get in
one function.

So break it down to amd_iommu_pc_[get|set]_reg(),
and modifies them to allow callers to specify IOMMU index. This prepares
the driver for supporting multi-IOMMU in subsequent patch.

Also remove unnecessary function declarations in amd_iommu_proto.h.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/x86/events/amd/iommu.c     | 34 ++++++++++----------------
 arch/x86/events/amd/iommu.h     |  7 ++++--
 drivers/iommu/amd_iommu_init.c  | 53 ++++++++++++++++++++++++++---------------
 drivers/iommu/amd_iommu_proto.h |  5 ----
 4 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index ec7e873..200d2e8 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -250,42 +250,36 @@ static void perf_iommu_enable_event(struct perf_event *ev)
 {
 	u8 csource = _GET_CSOURCE(ev);
 	u16 devid = _GET_DEVID(ev);
+	u8 bank = _GET_BANK(ev);
+	u8 cntr = _GET_CNTR(ev);
 	u64 reg = 0ULL;
 
 	reg = csource;
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, bank, cntr,
+			     IOMMU_PC_COUNTER_SRC_REG, &reg);
 
 	reg = devid | (_GET_DEVID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DEVID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, bank, cntr, IOMMU_PC_DEVID_MATCH_REG, &reg);
 
 	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_PASID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, bank, cntr, IOMMU_PC_PASID_MATCH_REG, &reg);
 
 	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DOMID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, bank, cntr, IOMMU_PC_DOMID_MATCH_REG, &reg);
 }
 
 static void perf_iommu_disable_event(struct perf_event *event)
 {
 	u64 reg = 0ULL;
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-			_GET_BANK(event), _GET_CNTR(event),
-			IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
+			     IOMMU_PC_COUNTER_SRC_REG, &reg);
 }
 
 static void perf_iommu_start(struct perf_event *event, int flags)
@@ -300,9 +294,8 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 
 	if (flags & PERF_EF_RELOAD) {
 		u64 prev_raw_count =  local64_read(&hwc->prev_count);
-		amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &prev_raw_count, true);
+		amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
+				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
 	}
 
 	perf_iommu_enable_event(event);
@@ -316,9 +309,8 @@ static void perf_iommu_read(struct perf_event *event)
 	s64 delta;
 	struct hw_perf_event *hwc = &event->hw;
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &count, false);
+	amd_iommu_pc_get_reg(0, _GET_BANK(event), _GET_CNTR(event),
+			     IOMMU_PC_COUNTER_REG, &count);
 
 	/* IOMMU pc counter register is only 48 bits */
 	count &= GENMASK_ULL(48, 0);
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index cf3dd05..cd70921 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -33,7 +33,10 @@
 
 extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
 
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
-			u8 fxn, u64 *value, bool is_write);
+extern int amd_iommu_pc_set_reg(unsigned int idx, u8 bank, u8 cntr,
+				u8 fxn, u64 *value);
+
+extern int amd_iommu_pc_get_reg(unsigned int idx, u8 bank, u8 cntr,
+				u8 fxn, u64 *value);
 
 #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index ed21307d..5b7fb6c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -253,10 +253,6 @@ enum iommu_init_state {
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
-static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
-				    u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write);
-
 static inline void update_last_devid(u16 devid)
 {
 	if (devid > amd_iommu_last_bdf)
@@ -1481,6 +1477,14 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
+#define iommu_pc_get_reg(i, b, c, f, v) \
+	iommu_pc_get_set_reg(i, b, c, f, v, false)
+
+#define iommu_pc_set_reg(i, b, c, f, v) \
+	iommu_pc_get_set_reg(i, b, c, f, v, true)
+
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
@@ -1492,8 +1496,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* Check if the performance counters can be written to */
-	if ((0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val, true)) ||
-	    (0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val2, false)) ||
+	if ((iommu_pc_set_reg(iommu, 0, 0, 0, &val)) ||
+	    (iommu_pc_get_reg(iommu, 0, 0, 0, &val2)) ||
 	    (val != val2)) {
 		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
@@ -2762,15 +2766,18 @@ u8 amd_iommu_pc_get_max_counters(unsigned int idx)
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
 
-static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
-				    u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write)
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write)
 {
 	u32 offset;
 	u32 max_offset_lim;
 
+	/* Make sure the IOMMU PC resource is available */
+	if (!amd_iommu_pc_present)
+		return -ENODEV;
+
 	/* Check for valid iommu and pc register indexing */
-	if (WARN_ON((fxn > 0x28) || (fxn & 7)))
+	if (WARN_ON(!iommu || (fxn > 0x28) || (fxn & 7)))
 		return -ENODEV;
 
 	offset = (u32)(((0x40|bank) << 12) | (cntr << 8) | fxn);
@@ -2793,17 +2800,25 @@ static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_set_reg_val);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write)
+int amd_iommu_pc_get_reg(unsigned int idx, u8 bank, u8 cntr, u8 fxn, u64 *value)
 {
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = get_amd_iommu(idx);
 
-	/* Make sure the IOMMU PC resource is available */
-	if (!amd_iommu_pc_present || iommu == NULL)
-		return -ENODEV;
+	if (!iommu)
+		return -EINVAL;
+
+	return iommu_pc_get_reg(iommu, bank, cntr, fxn, value);
+}
+EXPORT_SYMBOL(amd_iommu_pc_get_reg);
+
+int amd_iommu_pc_set_reg(unsigned int idx, u8 bank, u8 cntr, u8 fxn, u64 *value)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+
+	if (!iommu)
+		return -EINVAL;
 
-	return iommu_pc_get_set_reg_val(iommu, bank, cntr, fxn,
-					value, is_write);
+	return iommu_pc_set_reg(iommu, bank, cntr, fxn, value);
 }
+EXPORT_SYMBOL(amd_iommu_pc_set_reg);
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index cd2257e..466260f 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -57,11 +57,6 @@ extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
 extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
 
-/* IOMMU Performance Counter functions */
-extern bool amd_iommu_pc_supported(void);
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write);
-
 #ifdef CONFIG_IRQ_REMAP
 extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
-- 
1.8.3.1
