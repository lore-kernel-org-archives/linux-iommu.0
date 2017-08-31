From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFT] iommu/arm-smmu-v3: Use burst-polling for sync completion
Date: Thu, 31 Aug 2017 14:44:29 +0100
Message-ID: <7cd12324a5c67138bc79fef0e778bfbd39703197.1504182142.git.robin.murphy@arm.com>
References: <cover.1504182142.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1504182142.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

While CMD_SYNC is unlikely to complete immediately such that we never go
round the polling loop, with a lightly-loaded queue it may still do so
long before the delay period is up. If we have no better completion
notifier, use similar logic as we have for SMMUv2 to spin a number of
times before each backoff, so that we have more chance of catching syncs
which complete relatively quickly and avoid delaying unnecessarily.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

This is mostly here for theoretical completeness - unless it proves to
actually give a measurable benefit (I have no idea), I'd be inclined
not to consider it for merging.

 drivers/iommu/arm-smmu-v3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f5c5da553803..b92cd65f43f8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -418,6 +418,7 @@
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	100
 #define ARM_SMMU_SYNC_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_SYNC_SPIN_COUNT	10
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -998,7 +999,7 @@ static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
 	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_SYNC_TIMEOUT_US);
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
-	unsigned int delay = 1;
+	unsigned int delay = 1, spin_cnt = 0;
 
 	do {
 		queue_sync_cons(q);
@@ -1022,10 +1023,13 @@ static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
 
 		if (wfe) {
 			wfe();
-		} else {
+		} else if (++spin_cnt < ARM_SMMU_SYNC_SPIN_COUNT) {
 			cpu_relax();
+			continue;
+		} else {
 			udelay(delay);
 			delay *= 2;
+			spin_cnt = 0;
 		}
 	} while (ktime_before(ktime_get(), timeout));
 
-- 
2.13.4.dirty
