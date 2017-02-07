From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v9 2/8] perf/amd/iommu: Clean up bitwise operations
Date: Tue, 7 Feb 2017 02:40:30 -0600
Message-ID: <1486456836-17428-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

Clean up register initialization and make use of BIT_ULL(x)
where appropriate. This should not affect logic and functionality.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 44638d0..85b634e 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -164,11 +164,11 @@ static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
 	for (bank = 0, shift = 0; bank < max_banks; bank++) {
 		for (cntr = 0; cntr < max_cntrs; cntr++) {
 			shift = bank + (bank*3) + cntr;
-			if (perf_iommu->cntr_assign_mask & (1ULL<<shift)) {
+			if (perf_iommu->cntr_assign_mask & BIT_ULL(shift)) {
 				continue;
 			} else {
-				perf_iommu->cntr_assign_mask |= (1ULL<<shift);
-				retval = ((u16)((u16)bank<<8) | (u8)(cntr));
+				perf_iommu->cntr_assign_mask |= BIT_ULL(shift);
+				retval = ((bank & 0xFF) << 8) | (cntr & 0xFF);
 				goto out;
 			}
 		}
@@ -265,23 +265,23 @@ static void perf_iommu_enable_event(struct perf_event *ev)
 			_GET_BANK(ev), _GET_CNTR(ev) ,
 			 IOMMU_PC_COUNTER_SRC_REG, &reg, true);
 
-	reg = 0ULL | devid | (_GET_DEVID_MASK(ev) << 32);
+	reg = devid | (_GET_DEVID_MASK(ev) << 32);
 	if (reg)
-		reg |= (1UL << 31);
+		reg |= BIT(31);
 	amd_iommu_pc_get_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
 			 IOMMU_PC_DEVID_MATCH_REG, &reg, true);
 
-	reg = 0ULL | _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
+	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
 	if (reg)
-		reg |= (1UL << 31);
+		reg |= BIT(31);
 	amd_iommu_pc_get_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
 			 IOMMU_PC_PASID_MATCH_REG, &reg, true);
 
-	reg = 0ULL | _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
+	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
 	if (reg)
-		reg |= (1UL << 31);
+		reg |= BIT(31);
 	amd_iommu_pc_get_set_reg_val(devid,
 			_GET_BANK(ev), _GET_CNTR(ev) ,
 			 IOMMU_PC_DOMID_MATCH_REG, &reg, true);
-- 
1.8.3.1
