From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 5/4] iommu/arm-smmu: Poll for TLB sync completion more
	effectively
Date: Thu, 23 Mar 2017 17:59:40 +0000
Message-ID: <67da197b56bb8763623fc215176b86ab04b1799e.1490291854.git.robin.murphy@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1488907474.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On relatively slow development platforms and software models, the
inefficiency of our TLB sync loop tends not to show up - for instance on
a Juno r1 board I typically see the TLBI has completed of its own accord
by the time we get to the sync, such that the latter finishes instantly.

However, on larger systems doing real I/O, it's less realistic for the
TLBs to go idle immediately, and at that point falling into the 1MHz
polling loop turns out to throw away performance drastically. Let's
strike a balance by polling more than once between pauses, such that we
have much more chance of catching normal operations completing before
committing to the fixed delay, but also backing off exponentially, since
if a sync really hasn't completed within one or two "reasonable time"
periods, it becomes increasingly unlikely that it ever will.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7411109670f..aa17f3d937a0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -162,6 +162,7 @@
 #define ARM_SMMU_GR0_sTLBGSTATUS	0x74
 #define sTLBGSTATUS_GSACTIVE		(1 << 0)
 #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
+#define TLB_SPIN_COUNT			10
 
 /* Stream mapping registers */
 #define ARM_SMMU_GR0_SMR(n)		(0x800 + ((n) << 2))
@@ -574,18 +575,17 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
 				void __iomem *sync, void __iomem *status)
 {
-	int count = 0;
+	unsigned int spin_count, delay;
 
 	writel_relaxed(0, sync);
-	while (readl_relaxed(status) & sTLBGSTATUS_GSACTIVE) {
-		cpu_relax();
-		if (++count == TLB_LOOP_TIMEOUT) {
-			dev_err_ratelimited(smmu->dev,
-			"TLB sync timed out -- SMMU may be deadlocked\n");
-			return;
-		}
-		udelay(1);
+	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
+		for (spin_count = TLB_SPIN_COUNT; spin_count > 0; spin_count--)
+			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
+				return;
+		udelay(delay);
 	}
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n");
 }
 
 static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
-- 
2.11.0.dirty
