From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V6 3/7] perf/amd/iommu: Modify IOMMU API to allow specifying
	IOMMU index
Date: Fri, 23 Dec 2016 20:38:46 +0700
Message-ID: <1482500330-5606-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1482500330-5606-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1482500330-5606-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The current amd_iommu_pc_get_set_reg_val() cannot support multi-IOMMU.
It is also confusing since it is trying to support set and get in
one function.

So, this patch breaks it down to amd_iommu_pc_[get|set]_counter(),
and modifies them to allow callers to specify IOMMU index. This prepares
the driver for supporting multi-IOMMU in subsequent patch.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c     | 45 +++++++++++-------------
 arch/x86/events/amd/iommu.h     |  8 +++--
 drivers/iommu/amd_iommu_init.c  | 77 +++++++++++++++++++++++++++++++----------
 drivers/iommu/amd_iommu_proto.h | 10 ++++--
 4 files changed, 93 insertions(+), 47 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index cf94f48..9744dc8 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -248,46 +248,44 @@ static void perf_iommu_enable_event(struct perf_event *ev)
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
+	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+			     IOMMU_PC_COUNTER_SRC_REG, &reg);
 
 	reg = 0ULL | devid | (_GET_DEVID_MASK(ev) << 32);
 	if (reg)
 		reg |= (1UL << 31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DEVID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+			     IOMMU_PC_DEVID_MATCH_REG, &reg);
 
 	reg = 0ULL | _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
 	if (reg)
 		reg |= (1UL << 31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_PASID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+			     IOMMU_PC_PASID_MATCH_REG, &reg);
 
 	reg = 0ULL | _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
 	if (reg)
 		reg |= (1UL << 31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DOMID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+			     IOMMU_PC_DOMID_MATCH_REG, &reg);
 }
 
 static void perf_iommu_disable_event(struct perf_event *event)
 {
 	u64 reg = 0ULL;
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-			_GET_BANK(event), _GET_CNTR(event),
-			IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+	amd_iommu_pc_set_reg(0, _GET_DEVID(event), _GET_BANK(event),
+			     _GET_CNTR(event), IOMMU_PC_COUNTER_SRC_REG, &reg);
 }
 
 static void perf_iommu_start(struct perf_event *event, int flags)
 {
+	u64 val;
 	struct hw_perf_event *hwc = &event->hw;
 
 	pr_debug("perf: amd_iommu:perf_iommu_start\n");
@@ -297,13 +295,13 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
-	if (flags & PERF_EF_RELOAD) {
-		u64 prev_raw_count =  local64_read(&hwc->prev_count);
-		amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &prev_raw_count, true);
-	}
+	if (!(flags & PERF_EF_RELOAD))
+		goto enable;
+
+	val = local64_read(&hwc->prev_count);
 
+	amd_iommu_pc_set_counter(0, _GET_BANK(event), _GET_CNTR(event), &val);
+enable:
 	perf_iommu_enable_event(event);
 	perf_event_update_userpage(event);
 
@@ -316,9 +314,8 @@ static void perf_iommu_read(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	pr_debug("perf: amd_iommu:perf_iommu_read\n");
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &cnt, false);
+	if (amd_iommu_pc_get_counter(0, _GET_BANK(event), _GET_CNTR(event), &cnt))
+		return;
 
 	/* IOMMU pc counter register is only 48 bits */
 	cnt &= GENMASK_ULL(48, 0);
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 0ce8c91..71ec9d7 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -31,7 +31,11 @@
 
 extern u8 amd_iommu_pc_get_max_counters(uint devid);
 
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
-			u8 fxn, u64 *value, bool is_write);
+extern int amd_iommu_pc_set_reg(uint idx, u16 devid, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value);
+
+extern int amd_iommu_pc_set_counter(uint idx, u8 bank, u8 cntr, u64 *value);
+
+extern int amd_iommu_pc_get_counter(uint idx, u8 bank, u8 cntr, u64 *value);
 
 #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index a7e756b..c993c77 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -251,10 +251,6 @@ enum iommu_init_state {
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
-static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
-				    u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write);
-
 static inline void update_last_devid(u16 devid)
 {
 	if (devid > amd_iommu_last_bdf)
@@ -1474,6 +1470,8 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
@@ -1485,8 +1483,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* Check if the performance counters can be written to */
-	if ((0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val, true)) ||
-	    (0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val2, false)) ||
+	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) != 0) ||
+	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) != 0) ||
 	    (val != val2)) {
 		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
@@ -2754,15 +2752,18 @@ u8 amd_iommu_pc_get_max_counters(uint idx)
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
+	if (WARN_ON((iommu == NULL) || (fxn > 0x28) || (fxn & 7)))
 		return -ENODEV;
 
 	offset = (u32)(((0x40|bank) << 12) | (cntr << 8) | fxn);
@@ -2785,17 +2786,55 @@ static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_set_reg_val);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write)
+int amd_iommu_pc_set_reg(uint idx, u16 devid, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value)
 {
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = get_amd_iommu(idx);
 
-	/* Make sure the IOMMU PC resource is available */
-	if (!amd_iommu_pc_present || iommu == NULL)
-		return -ENODEV;
+	if (!iommu)
+		return -EINVAL;
+
+	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
+}
+EXPORT_SYMBOL(amd_iommu_pc_set_reg);
+
+int amd_iommu_pc_set_counter(uint idx, u8 bank, u8 cntr, u64 *value)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+
+	if (!iommu)
+		return -EINVAL;
 
-	return iommu_pc_get_set_reg_val(iommu, bank, cntr, fxn,
-					value, is_write);
+	return iommu_pc_get_set_reg(iommu, bank, cntr,
+				    IOMMU_PC_COUNTER_REG,
+				    value, true);
+}
+EXPORT_SYMBOL(amd_iommu_pc_set_counter);
+
+int amd_iommu_pc_get_counter(uint idx, u8 bank, u8 cntr, u64 *value)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+	int ret;
+	u64 tmp;
+
+	if (!value || !iommu)
+		return -EINVAL;
+	/*
+	 * Here, we read the specified counters on all IOMMUs,
+	 * which should have been programmed the same way and
+	 * aggregate the counter values.
+	 */
+
+	ret = iommu_pc_get_set_reg(iommu, bank, cntr,
+				   IOMMU_PC_COUNTER_REG,
+				   &tmp, false);
+	if (ret)
+		return ret;
+
+	/* IOMMU pc counter register is only 48 bits */
+	*value = tmp & GENMASK_ULL(48, 0);
+
+	return 0;
 }
+EXPORT_SYMBOL(amd_iommu_pc_get_counter);
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 1f10b3f..1df3ff7 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -57,11 +57,17 @@ extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
 
 /* IOMMU Performance Counter functions */
+#ifndef IOMMU_PC_COUNTER_REG
+#define IOMMU_PC_COUNTER_REG			0x00
+#endif
+
 extern bool amd_iommu_pc_supported(void);
 extern u8 amd_iommu_pc_get_max_banks(uint devid);
 extern u8 amd_iommu_pc_get_max_counters(uint devid);
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write);
+extern int amd_iommu_pc_set_reg(uint idx, u16 devid, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value);
+extern int amd_iommu_pc_set_counter(uint idx, u8 bank, u8 cntr, u64 *value);
+extern int amd_iommu_pc_get_counter(uint idx, u8 bank, u8 cntr, u64 *value);
 
 #ifdef CONFIG_IRQ_REMAP
 extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
-- 
1.8.3.1
