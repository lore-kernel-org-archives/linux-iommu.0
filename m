From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V5 04/10] perf/amd/iommu: Modify IOMMU API to allow specifying
	IOMMU index
Date: Tue, 23 Feb 2016 08:12:38 -0600
Message-ID: <1456236764-1569-5-git-send-email-Suravee.Suthikulpanit@amd.com>
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

The current amd_iommu_pc_set_reg_val() cann not support multi-IOMMU.
So, this patch rename and modifies them to allow callers to specify
IOMMU index.

The function amd_iommu_pc_get_set_reg_val() is too confusing,
and does not support multi-IOMMU. So, this patch breaks it down
to amd_iommu_pc_[get|set]_counter(), and modifies them to allow
callers to specify IOMMU index.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c           | 45 +++++++++++------------
 arch/x86/include/asm/perf/amd/iommu.h |  8 +++--
 drivers/iommu/amd_iommu_init.c        | 67 ++++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 36 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 67ff3f1..8a29754 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -243,46 +243,44 @@ static void perf_iommu_enable_event(struct perf_event *ev)
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
@@ -292,13 +290,13 @@ static void perf_iommu_start(struct perf_event *event, int flags)
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
 
@@ -311,9 +309,8 @@ static void perf_iommu_read(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	pr_debug("perf: amd_iommu:perf_iommu_read\n");
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &count, false);
+	if (amd_iommu_pc_get_counter(0, _GET_BANK(event), _GET_CNTR(event), &cnt))
+		return;
 
 	/* IOMMU pc counter register is only 48 bits */
 	cnt &= GENMASK_ULL(48, 0);
diff --git a/arch/x86/include/asm/perf/amd/iommu.h b/arch/x86/include/asm/perf/amd/iommu.h
index 466be63..60ddfb6 100644
--- a/arch/x86/include/asm/perf/amd/iommu.h
+++ b/arch/x86/include/asm/perf/amd/iommu.h
@@ -31,9 +31,11 @@ u8 amd_iommu_pc_get_max_banks(int idx);
 
 u8 amd_iommu_pc_get_max_counters(int idx);
 
-int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value);
+int amd_iommu_pc_set_reg(int idx, u16 devid, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				 u64 *value, bool is_write);
+int amd_iommu_pc_set_counter(int idx, u8 bank, u8 cntr, u64 *value);
+
+int amd_iommu_pc_get_counter(int idx, u8 bank, u8 cntr, u64 *value);
 
 #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index dde960f..b68a2d6 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1133,6 +1133,8 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
@@ -1144,8 +1146,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* Check if the performance counters can be written to */
-	if ((0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val, true)) ||
-	    (0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val2, false)) ||
+	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
+	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
 		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
@@ -2292,10 +2294,9 @@ u8 amd_iommu_pc_get_max_counters(int idx)
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write)
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write)
 {
-	struct amd_iommu *iommu;
 	u32 offset;
 	u32 max_offset_lim;
 
@@ -2303,9 +2304,6 @@ int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 	if (!amd_iommu_pc_present)
 		return -ENODEV;
 
-	/* Locate the iommu associated with the device ID */
-	iommu = amd_iommu_rlookup_table[devid];
-
 	/* Check for valid iommu and pc register indexing */
 	if (WARN_ON((iommu == NULL) || (fxn > 0x28) || (fxn & 7)))
 		return -ENODEV;
@@ -2330,4 +2328,55 @@ int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_set_reg_val);
+
+int amd_iommu_pc_set_reg(int idx, u16 devid, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+
+	if (!iommu)
+		return -EINVAL;
+
+	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
+}
+EXPORT_SYMBOL(amd_iommu_pc_set_reg);
+
+int amd_iommu_pc_set_counter(int idx, u8 bank, u8 cntr, u64 *value)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+
+	if (!iommu)
+		return -EINVAL;
+
+	return iommu_pc_get_set_reg(iommu, bank, cntr,
+				    IOMMU_PC_COUNTER_REG,
+				    value, true);
+}
+EXPORT_SYMBOL(amd_iommu_pc_set_counter);
+
+int amd_iommu_pc_get_counter(int idx, u8 bank, u8 cntr, u64 *value)
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
+}
+EXPORT_SYMBOL(amd_iommu_pc_get_counter);
-- 
1.9.1
