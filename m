From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V5 07/10] perf/amd/iommu: Clean up
	get_next_available_iommu_bnk_cntr
Date: Tue, 23 Feb 2016 08:12:41 -0600
Message-ID: <1456236764-1569-8-git-send-email-Suravee.Suthikulpanit@amd.com>
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

This patch cleans up the coding style of this function.
This should not affect the logic and functionality.

Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 1a678b9..d5e4d39 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -150,25 +150,23 @@ static struct attribute_group amd_iommu_cpumask_group = {
 static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
 {
 	unsigned long flags;
-	int shift, bank, cntr, retval;
-	int max_banks = perf_iommu->max_banks;
-	int max_cntrs = perf_iommu->max_counters;
+	int bank, cntr, retval = -ENOSPC;
 
 	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
 
-	for (bank = 0, shift = 0; bank < max_banks; bank++) {
-		for (cntr = 0; cntr < max_cntrs; cntr++) {
-			shift = bank + (bank*3) + cntr;
-			if (perf_iommu->cntr_assign_mask & (1ULL<<shift)) {
+	for (bank = 0; bank < perf_iommu->max_banks; bank++) {
+		for (cntr = 0; cntr < perf_iommu->max_counters; cntr++) {
+			int shift = (perf_iommu->max_counters * bank) + cntr;
+
+			if (perf_iommu->cntr_assign_mask & (1ULL << shift)) {
 				continue;
 			} else {
-				perf_iommu->cntr_assign_mask |= (1ULL<<shift);
-				retval = ((u16)((u16)bank<<8) | (u8)(cntr));
+				perf_iommu->cntr_assign_mask |= (1ULL << shift);
+				retval = ((u16)((u16)bank << 8) | (u8)(cntr));
 				goto out;
 			}
 		}
 	}
-	retval = -ENOSPC;
 out:
 	raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
 	return retval;
-- 
1.9.1
