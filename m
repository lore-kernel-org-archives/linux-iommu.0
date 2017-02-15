From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v10 7/9] perf/amd/iommu: Modify amd_iommu_pc_get_set_reg_val()
	to allow specifying IOMMU
Date: Wed, 15 Feb 2017 14:56:23 -0600
Message-ID: <1487192185-31272-8-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1487192185-31272-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1487192185-31272-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

The current amd_iommu_pc_get_set_reg_val() cannot support multiple IOMMUs.
So, modify it to allow callers to specify IOMMU. This prepares the driver
for supporting multi-IOMMU in subsequent patch.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c     | 38 ++++++++++++++++--------------------
 arch/x86/events/amd/iommu.h     |  9 +++++++--
 drivers/iommu/amd_iommu_init.c  | 43 +++++++++++++++++++++++------------------
 drivers/iommu/amd_iommu_proto.h |  5 -----
 4 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 2394950..b771914 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -248,49 +248,45 @@ static int perf_iommu_event_init(struct perf_event *event)
 
 static void perf_iommu_enable_event(struct perf_event *ev)
 {
+	struct amd_iommu *iommu = get_amd_iommu(0);
 	u8 csource = _GET_CSOURCE(ev);
 	u16 devid = _GET_DEVID(ev);
+	u8 bank = _GET_BANK(ev);
+	u8 cntr = _GET_CNTR(ev);
 	u64 reg = 0ULL;
 
 	reg = csource;
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_COUNTER_SRC_REG, &reg);
 
 	reg = devid | (_GET_DEVID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DEVID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_DEVID_MATCH_REG, &reg);
 
 	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_PASID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_PASID_MATCH_REG, &reg);
 
 	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_get_set_reg_val(devid,
-			_GET_BANK(ev), _GET_CNTR(ev) ,
-			 IOMMU_PC_DOMID_MATCH_REG, &reg, true);
+	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_DOMID_MATCH_REG, &reg);
 }
 
 static void perf_iommu_disable_event(struct perf_event *event)
 {
+	struct amd_iommu *iommu = get_amd_iommu(0);
 	u64 reg = 0ULL;
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-			_GET_BANK(event), _GET_CNTR(event),
-			IOMMU_PC_COUNTER_SRC_REG, &reg, true);
+	amd_iommu_pc_set_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
+			     IOMMU_PC_COUNTER_SRC_REG, &reg);
 }
 
 static void perf_iommu_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct amd_iommu *iommu = get_amd_iommu(0);
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -300,9 +296,8 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 
 	if (flags & PERF_EF_RELOAD) {
 		u64 prev_raw_count =  local64_read(&hwc->prev_count);
-		amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &prev_raw_count, true);
+		amd_iommu_pc_set_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
+				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
 	}
 
 	perf_iommu_enable_event(event);
@@ -314,10 +309,11 @@ static void perf_iommu_read(struct perf_event *event)
 {
 	u64 count, prev, delta;
 	struct hw_perf_event *hwc = &event->hw;
+	struct amd_iommu *iommu = get_amd_iommu(0);
 
-	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
-				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &count, false);
+	if (amd_iommu_pc_get_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
+				 IOMMU_PC_COUNTER_REG, &count))
+		return;
 
 	/* IOMMU pc counter register is only 48 bits */
 	count &= GENMASK_ULL(47, 0);
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index b775107..62e0702 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -24,6 +24,8 @@
 #define PC_MAX_SPEC_BNKS			64
 #define PC_MAX_SPEC_CNTRS			16
 
+struct amd_iommu;
+
 /* amd_iommu_init.c external support functions */
 extern int amd_iommu_get_num_iommus(void);
 
@@ -33,8 +35,11 @@
 
 extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
 
-extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
-			u8 fxn, u64 *value, bool is_write);
+extern int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value);
+
+extern int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value);
 
 extern struct amd_iommu *get_amd_iommu(int idx);
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d5ee17f2..8104d2c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -254,10 +254,6 @@ enum iommu_init_state {
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
-static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
-				    u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write);
-
 static inline void update_last_devid(u16 devid)
 {
 	if (devid > amd_iommu_last_bdf)
@@ -1482,6 +1478,8 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
@@ -1493,8 +1491,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* Check if the performance counters can be written to */
-	if ((0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val, true)) ||
-	    (0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val2, false)) ||
+	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
+	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
 		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
@@ -2762,15 +2760,18 @@ u8 amd_iommu_pc_get_max_counters(unsigned int idx)
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
 
 	offset = (u32)(((0x40 | bank) << 12) | (cntr << 8) | fxn);
@@ -2796,17 +2797,21 @@ static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
 
 	return 0;
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_set_reg_val);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
-				    u64 *value, bool is_write)
+int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
 {
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	if (!iommu)
+		return -EINVAL;
 
-	/* Make sure the IOMMU PC resource is available */
-	if (!amd_iommu_pc_present || iommu == NULL)
-		return -ENODEV;
+	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, false);
+}
+EXPORT_SYMBOL(amd_iommu_pc_get_reg);
+
+int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
+{
+	if (!iommu)
+		return -EINVAL;
 
-	return iommu_pc_get_set_reg_val(iommu, bank, cntr, fxn,
-					value, is_write);
+	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
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
