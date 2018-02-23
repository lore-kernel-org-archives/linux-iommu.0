From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 10/10] iommu/amd: make amd_iommu_devtable_lock a spin_lock
Date: Fri, 23 Feb 2018 23:27:36 +0100
Message-ID: <20180223222736.18542-11-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180223222736.18542-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Before commit 0bb6e243d7fb ("iommu/amd: Support IOMMU_DOMAIN_DMA type
allocation") amd_iommu_devtable_lock had a read_lock() user but now
there are none. In fact, after the mentioned commit we had only
write_lock() user of the lock. Since there is no reason to keep it as
writer lock, change its type to a spin_lock.
I *think* that we might even be able to remove the lock because all its
current user seem to have their own protection.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 04b7d263523f..cabb02cf6d42 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -80,7 +80,7 @@
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
 
-static DEFINE_RWLOCK(amd_iommu_devtable_lock);
+static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 static DEFINE_RAW_SPINLOCK(iommu_table_lock);
 
@@ -2096,9 +2096,9 @@ static int attach_device(struct device *dev,
 	}
 
 skip_ats_check:
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	ret = __attach_device(dev_data, domain);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
 	/*
 	 * We might boot into a crash-kernel here. The crashed kernel
@@ -2148,9 +2148,9 @@ static void detach_device(struct device *dev)
 	domain   = dev_data->domain;
 
 	/* lock device table */
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	__detach_device(dev_data);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
 	if (!dev_is_pci(dev))
 		return;
@@ -2813,7 +2813,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	struct iommu_dev_data *entry;
 	unsigned long flags;
 
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
@@ -2821,7 +2821,7 @@ static void cleanup_domain(struct protection_domain *domain)
 		__detach_device(entry);
 	}
 
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
-- 
2.16.1
