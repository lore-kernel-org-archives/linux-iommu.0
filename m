From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V6 1/7] perf/amd/iommu: Misc fix up perf_iommu_read
Date: Fri, 23 Dec 2016 20:38:44 +0700
Message-ID: <1482500330-5606-2-git-send-email-Suravee.Suthikulpanit@amd.com>
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

This patch contains the following minor fixup:
  * Fixed overflow handling since u64 delta would lose the MSB sign bit.
  * Remove unnecessary local64_set().
  * Coding style and make use of GENMASK_ULL macro.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b28200d..f387baf 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -319,29 +319,30 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 
 static void perf_iommu_read(struct perf_event *event)
 {
-	u64 count = 0ULL;
-	u64 prev_raw_count = 0ULL;
-	u64 delta = 0ULL;
+	u64 cnt, prev;
+	s64 delta;
 	struct hw_perf_event *hwc = &event->hw;
 	pr_debug("perf: amd_iommu:perf_iommu_read\n");
 
 	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
 				_GET_BANK(event), _GET_CNTR(event),
-				IOMMU_PC_COUNTER_REG, &count, false);
+				IOMMU_PC_COUNTER_REG, &cnt, false);
 
 	/* IOMMU pc counter register is only 48 bits */
-	count &= 0xFFFFFFFFFFFFULL;
+	cnt &= GENMASK_ULL(48, 0);
 
-	prev_raw_count =  local64_read(&hwc->prev_count);
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					count) != prev_raw_count)
-		return;
+	prev = local64_read(&hwc->prev_count);
 
-	/* Handling 48-bit counter overflowing */
-	delta = (count << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
+	/*
+	 * Since we do not enable counter overflow interrupts,
+	 * we do not have to worry about prev_count changing on us.
+	 */
+	local64_set(&hwc->prev_count, cnt);
+
+	/* Handle 48-bit counter overflow */
+	delta = (cnt << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
 	delta >>= COUNTER_SHIFT;
 	local64_add(delta, &event->count);
-
 }
 
 static void perf_iommu_stop(struct perf_event *event, int flags)
-- 
1.8.3.1
