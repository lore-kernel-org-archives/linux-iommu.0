From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3 4/5] perf/amd/iommu: Introduce get_iommu_bnk_cnt_evt_idx
Date: Tue, 9 Feb 2016 16:53:54 -0600
Message-ID: <1455058435-8716-5-git-send-email-Suravee.Suthikulpanit@amd.com>
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

Introduce a helper function to calculate bit-index for assigning
performance counter assignment.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/kernel/cpu/perf_event_amd_iommu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
index 2d59e20..791bbcf 100644
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
+++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
@@ -145,18 +145,28 @@ static struct attribute_group amd_iommu_cpumask_group = {
 
 /*---------------------------------------------*/
 
+static inline
+int get_iommu_bnk_cnt_evt_idx(struct perf_amd_iommu *perf_iommu,
+				  int iommu_index, int bank_index,
+				  int cntr_index)
+{
+	int cntrs_per_iommu = perf_iommu->max_banks * perf_iommu->max_counters;
+	int index = (perf_iommu->max_counters * bank_index) + cntr_index;
+
+	return (cntrs_per_iommu * iommu_index) + index;
+}
+
 static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
 {
 	unsigned long flags;
 	int shift, bank, cntr, retval;
-	int max_banks = perf_iommu->max_banks;
-	int max_cntrs = perf_iommu->max_counters;
 
 	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
 
-	for (bank = 0, shift = 0; bank < max_banks; bank++) {
-		for (cntr = 0; cntr < max_cntrs; cntr++) {
-			shift = bank + (bank*3) + cntr;
+	for (bank = 0, shift = 0; bank < perf_iommu->max_banks; bank++) {
+		for (cntr = 0; cntr < perf_iommu->max_counters; cntr++) {
+			shift = get_iommu_bnk_cnt_evt_idx(perf_iommu,
+							      0, bank, cntr);
 			if (perf_iommu->cntr_assign_mask & (1ULL<<shift)) {
 				continue;
 			} else {
-- 
2.5.0
