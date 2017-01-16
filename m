From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v8 7/9] perf/amd/iommu: Check return value when set and get counter value
Date: Mon, 16 Jan 2017 01:23:34 -0600
Message-ID: <1484551416-5440-8-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, bp@alien8.de, peterz@infradead.org, mingo@redhat.com, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In, perf_iommu_start(), we need to check the return value from
amd_iommu_set_reg(). In case of failure, we should not enable the PMU.

Also, in perf_iommu_read(), we need to check the return value from
amd_iommu_get_reg() before using the value.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/events/amd/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 200d2e8..cc7bea4 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -284,6 +284,7 @@ static void perf_iommu_disable_event(struct perf_event *event)
 
 static void perf_iommu_start(struct perf_event *event, int flags)
 {
+	u64 val;
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
@@ -292,15 +293,16 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
-	if (flags & PERF_EF_RELOAD) {
-		u64 prev_raw_count =  local64_read(&hwc->prev_count);
-		amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
-				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
-	}
+	if (!(flags & PERF_EF_RELOAD))
+		return;
+
+	val = local64_read(&hwc->prev_count) & GENMASK_ULL(48, 0);
+	if (amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
+				   IOMMU_PC_COUNTER_REG, &val))
+		return;
 
 	perf_iommu_enable_event(event);
 	perf_event_update_userpage(event);
-
 }
 
 static void perf_iommu_read(struct perf_event *event)
@@ -309,8 +311,9 @@ static void perf_iommu_read(struct perf_event *event)
 	s64 delta;
 	struct hw_perf_event *hwc = &event->hw;
 
-	amd_iommu_pc_get_reg(0, _GET_BANK(event), _GET_CNTR(event),
-			     IOMMU_PC_COUNTER_REG, &count);
+	if (amd_iommu_pc_get_reg(0, _GET_BANK(event), _GET_CNTR(event),
+				 IOMMU_PC_COUNTER_REG, &count))
+		return;
 
 	/* IOMMU pc counter register is only 48 bits */
 	count &= GENMASK_ULL(48, 0);
-- 
1.8.3.1
