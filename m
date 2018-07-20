From: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] iommu/amd: Remove redundant WARN_ON()
Date: Fri, 20 Jul 2018 10:45:45 +0200
Message-ID: <20180720084545.3284-1-anna-maria@linutronix.de>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The WARN_ON() was introduced in commit 272e4f99e966 ("iommu/amd: WARN
when __[attach|detach]_device are called with irqs enabled") to ensure
that the domain->lock is taken in proper irqs disabled context. This
is required, because the domain->lock is taken as well in irq
context.

The proper context check by the WARN_ON() is redundant, because it is
already covered by LOCKDEP. When working with locks and changing
context, a run with LOCKDEP is required anyway and would detect the
wrong lock context.

Furthermore all callers for those functions are within the same file
and all callers acquire another lock which already disables interrupts.

Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c50051..b5f39bffd684 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1944,12 +1944,6 @@ static int __attach_device(struct iommu_dev_data *dev_data,
 {
 	int ret;
 
-	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
-	 */
-	WARN_ON(!irqs_disabled());
-
 	/* lock domain */
 	spin_lock(&domain->lock);
 
@@ -2115,12 +2109,6 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 {
 	struct protection_domain *domain;
 
-	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
-	 */
-	WARN_ON(!irqs_disabled());
-
 	domain = dev_data->domain;
 
 	spin_lock(&domain->lock);
-- 
2.18.0
