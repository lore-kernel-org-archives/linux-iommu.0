From: sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2] iommu/arm-smmu-v3: Increase CMDQ drain timeout value
Date: Fri,  5 May 2017 16:47:46 +0530
Message-ID: <1493983066-28202-1-git-send-email-sunil.kovvuri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Processing queue full of TLB invalidation commands might
take more time on some platforms than current timeout
of 100us. So increased drain timeout value.

Also now udelay time is increased exponentially for each poll.

Signed-off-by: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---

v2
- Addressed Will's and Robin's comments i.e
  increased poll timeout only for drain case and removed spin loop
  whose logic anyway is screwed up.
- Also changed commit subject and message as this patch no longer
  exactly reflects what is done in SMMU driver i.e
  8513c8930069 iommu/arm-smmu: Poll for TLB sync completion more effectively

 drivers/iommu/arm-smmu-v3.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d412bdd..cbc8309 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -379,6 +379,8 @@
 #define CMDQ_SYNC_0_CS_NONE		(0UL << CMDQ_SYNC_0_CS_SHIFT)
 #define CMDQ_SYNC_0_CS_SEV		(2UL << CMDQ_SYNC_0_CS_SHIFT)
 
+#define CMDQ_DRAIN_TIMEOUT_US		1000
+
 /* Event queue */
 #define EVTQ_ENT_DWORDS			4
 #define EVTQ_MAX_SZ_SHIFT		7
@@ -737,7 +739,12 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
  */
 static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
 {
-	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
+	ktime_t timeout;
+	unsigned int delay = 1;
+
+	/* Wait longer if it's queue drain */
+	timeout = ktime_add_us(ktime_get(), drain ? CMDQ_DRAIN_TIMEOUT_US :
+						    ARM_SMMU_POLL_TIMEOUT_US);
 
 	while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
@@ -747,7 +754,11 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
 			wfe();
 		} else {
 			cpu_relax();
-			udelay(1);
+			udelay(delay);
+			/* No point in sleeping for fixed time,
+			 * if cons isn't moving fast.
+			 */
+			delay *= 2;
 		}
 	}
 
-- 
2.7.4
