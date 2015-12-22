From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/6] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Tue, 22 Dec 2015 13:19:17 -0600
Message-ID: <1450811957-1511-7-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1450811957-1511-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450811957-1511-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The current amd_iommu_pc_get_set_reg_val() does not support muli-IOMMU
system. This patch replace amd_iommu_pc_get_set_reg_val() with
amd_iommu_pc_set_reg_val() and amd_iommu_pc_[set|get]_cnt_vals().

This implementation makes an assumption that the counters on all IOMMUs
will be programmed the same way (i.e with the same events).

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/kernel/cpu/perf_event_amd_iommu.c | 80 +++++++++++++++++----------
 drivers/iommu/amd_iommu_init.c             | 87 ++++++++++++++++++++++++++----
 include/linux/perf/perf_event_amd_iommu.h  |  8 ++-
 3 files changed, 136 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
index 8af7149..9c60eb3 100644
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
+++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
@@ -264,44 +264,46 @@ static void perf_iommu_enable_event(struct perf_event *ev)
 	u64 reg = 0ULL;
 
 	reg = csource;
-	amd_iommu_pc_get_set_reg_val(devid,
+	amd_iommu_pc_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+			 IOMMU_PC_COUNTER_SRC_REG, &reg);
 
 	reg = 0ULL | devid | (_GET_DEVID_MASK(ev) << 32);
 	if (reg)
 		reg |= (1UL << 31);
-	amd_iommu_pc_get_set_reg_val(devid,
+	amd_iommu_pc_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DEVID_MATCH_REG, &reg, true);
+			 IOMMU_PC_DEVID_MATCH_REG, &reg);
 
 	reg = 0ULL | _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
 	if (reg)
 		reg |= (1UL << 31);
-	amd_iommu_pc_get_set_reg_val(devid,
+	amd_iommu_pc_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_PASID_MATCH_REG, &reg, true);
+			 IOMMU_PC_PASID_MATCH_REG, &reg);
 
 	reg = 0ULL | _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
 	if (reg)
 		reg |= (1UL << 31);
-	amd_iommu_pc_get_set_reg_val(devid,
+	amd_iommu_pc_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DOMID_MATCH_REG, &reg, true);
+			 IOMMU_PC_DOMID_MATCH_REG, &reg);
 }
 
 static void perf_iommu_disable_event(struct perf_event *event)
 {
 	u64 reg = 0ULL;
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
+	amd_iommu_pc_set_reg_val(_GET_DEVID(event),
 			_GET_BANK(event), _GET_CNTR(event),
-			IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+			IOMMU_PC_COUNTER_SRC_REG, &reg);
 }
 
 static void perf_iommu_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct perf_amd_iommu *perf_iommu =
+			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
 	pr_debug("perf: amd_iommu:perf_iommu_start\n");
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
@@ -311,10 +313,19 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	if (flags & PERF_EF_RELOAD) {
-		u64 prev_raw_count =  local64_read(&hwc->prev_count);
-		amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &prev_raw_count, true);
+		int i;
+
+		for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
+			int index = get_iommu_bnk_cnt_evt_idx(perf_iommu, i,
+					  _GET_BANK(event), _GET_CNTR(event));
+
+			perf_iommu_cnts[i] = local64_read(
+						&perf_iommu->prev_cnts[index]);
+		}
+
+		amd_iommu_pc_set_cnt_vals(_GET_BANK(event), _GET_CNTR(event),
+					  amd_iommu_get_num_iommus(),
+					  perf_iommu_cnts);
 	}
 
 	perf_iommu_enable_event(event);
@@ -324,29 +335,42 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 
 static void perf_iommu_read(struct perf_event *event)
 {
-	u64 count = 0ULL;
+	int i;
 	u64 prev_raw_count = 0ULL;
 	u64 delta = 0ULL;
 	struct hw_perf_event *hwc = &event->hw;
+	struct perf_amd_iommu *perf_iommu =
+			container_of(event->pmu, struct perf_amd_iommu, pmu);
+
 	pr_debug("perf: amd_iommu:perf_iommu_read\n");
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &count, false);
+	if (amd_iommu_pc_get_cnt_vals(_GET_BANK(event), _GET_CNTR(event),
+				      amd_iommu_get_num_iommus(),
+				      perf_iommu_cnts))
+		return;
+
+	local64_set(&hwc->prev_count, 0);
+	for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
+		int index = get_iommu_bnk_cnt_evt_idx(perf_iommu, i,
+					  _GET_BANK(event), _GET_CNTR(event));
 
-	/* IOMMU pc counter register is only 48 bits */
-	count &= 0xFFFFFFFFFFFFULL;
+		/* IOMMU pc counter register is only 48 bits */
+		perf_iommu_cnts[i] &= 0xFFFFFFFFFFFFULL;
 
-	prev_raw_count =  local64_read(&hwc->prev_count);
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					count) != prev_raw_count)
-		return;
+		prev_raw_count = local64_read(&perf_iommu->prev_cnts[index]);
+		if (prev_raw_count != local64_cmpxchg(
+					&perf_iommu->prev_cnts[index],
+					prev_raw_count, perf_iommu_cnts[i]))
+			return;
 
-	/* Handling 48-bit counter overflowing */
-	delta = (count << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
-	delta >>= COUNTER_SHIFT;
-	local64_add(delta, &event->count);
+		local64_add(prev_raw_count, &hwc->prev_count);
 
+		/* Handling 48-bit counter overflowing */
+		delta = (perf_iommu_cnts[i] << COUNTER_SHIFT) -
+				(prev_raw_count << COUNTER_SHIFT);
+		delta >>= COUNTER_SHIFT;
+		local64_add(delta, &event->count);
+	}
 }
 
 static void perf_iommu_stop(struct perf_event *event, int flags)
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9c62613..86b09ec 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1133,6 +1133,9 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
+static int _amd_iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
+					 u8 bank, u8 cntr, u8 fxn,
+					 u64 *value, bool is_write);
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
@@ -1144,8 +1147,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* Check if the performance counters can be written to */
-	if ((0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val, true)) ||
-	    (0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val2, false)) ||
+	if ((_amd_iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val, true)) ||
+	    (_amd_iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
 		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
@@ -2305,10 +2308,10 @@ u8 amd_iommu_pc_get_max_counters(void)
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write)
+static int _amd_iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
+					 u8 bank, u8 cntr, u8 fxn,
+					 u64 *value, bool is_write)
 {
-	struct amd_iommu *iommu;
 	u32 offset;
 	u32 max_offset_lim;
 
@@ -2316,9 +2319,6 @@ int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 	if (!amd_iommu_pc_present)
 		return -ENODEV;
 
-	/* Locate the iommu associated with the device ID */
-	iommu = amd_iommu_rlookup_table[devid];
-
 	/* Check for valid iommu and pc register indexing */
 	if (WARN_ON((iommu == NULL) || (fxn > 0x28) || (fxn & 7)))
 		return -ENODEV;
@@ -2343,4 +2343,73 @@ int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_set_reg_val);
+
+int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		int ret = _amd_iommu_pc_get_set_reg_val(iommu, bank, cntr,
+							fxn, value, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(amd_iommu_pc_set_reg_val);
+
+int amd_iommu_pc_set_cnt_vals(u8 bank, u8 cntr, int num, u64 *value)
+{
+	struct amd_iommu *iommu;
+	int i = 0;
+
+	if (num > amd_iommu_cnt)
+		return -EINVAL;
+
+	for_each_iommu(iommu) {
+		int ret = _amd_iommu_pc_get_set_reg_val(iommu, bank, cntr,
+							IOMMU_PC_COUNTER_REG,
+							&value[i], true);
+		if (ret)
+			return ret;
+		if (i++ == amd_iommu_cnt)
+			break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(amd_iommu_pc_set_cnt_vals);
+
+int amd_iommu_pc_get_cnt_vals(u8 bank, u8 cntr, int num, u64 *value)
+{
+	struct amd_iommu *iommu;
+	int i = 0, ret;
+
+	if (!num)
+		return -EINVAL;
+
+	/*
+	 * Here, we read the specified counters on all IOMMU,
+	 * which should have been programmed the same way.
+	 * and aggregate the counter values.
+	 */
+	for_each_iommu(iommu) {
+		u64 tmp;
+
+		if (i >= num)
+			return -EINVAL;
+
+		ret = _amd_iommu_pc_get_set_reg_val(iommu, bank, cntr,
+							IOMMU_PC_COUNTER_REG,
+							&tmp, false);
+		if (ret)
+			return ret;
+
+		/* IOMMU pc counter register is only 48 bits */
+		value[i] = tmp & 0xFFFFFFFFFFFFULL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(amd_iommu_pc_get_cnt_vals);
diff --git a/include/linux/perf/perf_event_amd_iommu.h b/include/linux/perf/perf_event_amd_iommu.h
index cb820c2..be1a17d 100644
--- a/include/linux/perf/perf_event_amd_iommu.h
+++ b/include/linux/perf/perf_event_amd_iommu.h
@@ -33,7 +33,11 @@ extern u8 amd_iommu_pc_get_max_banks(void);
 
 extern u8 amd_iommu_pc_get_max_counters(void);
 
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
-			u8 fxn, u64 *value, bool is_write);
+extern int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
+				    u64 *value);
+
+extern int amd_iommu_pc_set_cnt_vals(u8 bank, u8 cntr, int num, u64 *value);
+
+extern int amd_iommu_pc_get_cnt_vals(u8 bank, u8 cntr, int num, u64 *value);
 
 #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
-- 
1.9.1
