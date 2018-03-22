From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 04/10] iommu/amd: split irq_lookup_table out of the
	amd_iommu_devtable_lock
Date: Thu, 22 Mar 2018 16:22:36 +0100
Message-ID: <20180322152242.12705-5-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180322152242.12705-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The function get_irq_table() reads/writes irq_lookup_table while holding
the amd_iommu_devtable_lock. It also modifies
amd_iommu_dev_table[].data[2].
set_dte_entry() is using amd_iommu_dev_table[].data[0|1] (under the
domain->lock) so it should be okay. The access to the iommu is
serialized with its own (iommu's) lock.

So split out get_irq_table() out of amd_iommu_devtable_lock's lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fcfdce70707d..a87d2fee68db 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -82,6 +82,7 @@
 
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
+static DEFINE_SPINLOCK(iommu_table_lock);
 
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -3623,7 +3624,7 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
 	unsigned long flags;
 	u16 alias;
 
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&iommu_table_lock, flags);
 
 	iommu = amd_iommu_rlookup_table[devid];
 	if (!iommu)
@@ -3688,7 +3689,7 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
 	iommu_completion_wait(iommu);
 
 out_unlock:
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	return table;
 }
-- 
2.16.2
