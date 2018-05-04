From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 2/3] iommu/amd: Cleanup locking in __attach/detach_device()
Date: Fri,  4 May 2018 18:22:32 +0200
Message-ID: <20180504162233.11283-3-bigeasy@linutronix.de>
References: <20180504162233.11283-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180504162233.11283-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Since introduction of the pd_bitmap_lock in commit 2bc001808904
("iommu/amd: Split domain id out of amd_iommu_devtable_lock")
amd_iommu_devtable_lock is only taken around __detach_device() and
__attach_device() calls.

The lock is not protecting anything as all operations are domain specific
and protected by domain->lock in __detach_device() and __attach_device(),
so amd_iommu_devtable_lock has no real purpose anymore.

Lock domain->lock before calling into __detach_device() and
__attach_device() and simplify the implementation of those functions. Add
lockdep checks where appropriate.

Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 70 +++++++++------------------------------
 1 file changed, 15 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e484275a4c69..f66a5d0b7c62 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -81,7 +81,6 @@
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
 
-static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 
 /* List of all available dev_data structures */
@@ -1886,6 +1885,8 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	u16 alias;
 	bool ats;
 
+	lockdep_assert_held(&domain->lock);
+
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 	alias = dev_data->alias;
 	ats   = dev_data->ats.enabled;
@@ -1906,11 +1907,13 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	device_flush_dte(dev_data);
 }
 
-static void do_detach(struct iommu_dev_data *dev_data)
+static void __detach_device(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
 	u16 alias;
 
+	lockdep_assert_held(&dev_data->domain->lock);
+
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 	alias = dev_data->alias;
 
@@ -1936,32 +1939,13 @@ static void do_detach(struct iommu_dev_data *dev_data)
 static int __attach_device(struct iommu_dev_data *dev_data,
 			   struct protection_domain *domain)
 {
-	int ret;
-
-	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
-	 */
-	WARN_ON(!irqs_disabled());
-
-	/* lock domain */
-	spin_lock(&domain->lock);
-
-	ret = -EBUSY;
 	if (dev_data->domain != NULL)
-		goto out_unlock;
+		return -EBUSY;
 
 	/* Attach alias group root */
 	do_attach(dev_data, domain);
 
-	ret = 0;
-
-out_unlock:
-
-	/* ready */
-	spin_unlock(&domain->lock);
-
-	return ret;
+	return 0;
 }
 
 
@@ -2088,9 +2072,10 @@ static int attach_device(struct device *dev,
 	}
 
 skip_ats_check:
-	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
+
+	spin_lock_irqsave(&domain->lock, flags);
 	ret = __attach_device(dev_data, domain);
-	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	/*
 	 * We might boot into a crash-kernel here. The crashed kernel
@@ -2103,29 +2088,7 @@ static int attach_device(struct device *dev,
 }
 
 /*
- * Removes a device from a protection domain (unlocked)
- */
-static void __detach_device(struct iommu_dev_data *dev_data)
-{
-	struct protection_domain *domain;
-
-	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
-	 */
-	WARN_ON(!irqs_disabled());
-
-	domain = dev_data->domain;
-
-	spin_lock(&domain->lock);
-
-	do_detach(dev_data);
-
-	spin_unlock(&domain->lock);
-}
-
-/*
- * Removes a device from a protection domain (with devtable_lock held)
+ * Removes a device from a protection domain
  */
 static void detach_device(struct device *dev)
 {
@@ -2145,10 +2108,9 @@ static void detach_device(struct device *dev)
 	if (WARN_ON(!dev_data->domain))
 		return;
 
-	/* lock device table */
-	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&domain->lock, flags);
 	__detach_device(dev_data);
-	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	if (!dev_is_pci(dev))
 		return;
@@ -2785,16 +2747,14 @@ static void cleanup_domain(struct protection_domain *domain)
 	struct iommu_dev_data *entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
-
+	spin_lock_irqsave(&domain->lock, flags);
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		BUG_ON(!entry->domain);
 		__detach_device(entry);
 	}
-
-	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
-- 
2.17.0
