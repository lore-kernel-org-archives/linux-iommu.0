From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 01/20] iommu/vt-d: use dedicated bitmap to track
	remapping entry allocation status
Date: Mon,  6 Jan 2014 14:18:08 +0800
Message-ID: <1388989107-4795-2-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently Intel interrupt remapping drivers uses the "present" flag bit
in remapping entry to track whether an entry is allocated or not.
It works as follow:
1) allocate a remapping entry and set its "present" flag bit to 1
2) compose other fields for the entry
3) update the remapping entry with the composed value

The remapping hardware may access the entry between step 1 and step 3,
which then observers an entry with the "present" flag set but random
values in all other fields.

This patch introduces a dedicated bitmap to track remapping entry
allocation status instead of sharing the "present" flag with hardware,
thus eliminate the race window. It also simplifies the implementation.

Tested-and-reviewed-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |   55 +++++++++++++++++------------------
 include/linux/intel-iommu.h         |    1 +
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index bab10b1..deef3d4 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -72,7 +72,6 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 	u16 index, start_index;
 	unsigned int mask = 0;
 	unsigned long flags;
-	int i;
 
 	if (!count || !irq_iommu)
 		return -1;
@@ -96,32 +95,17 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 	}
 
 	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
-	do {
-		for (i = index; i < index + count; i++)
-			if  (table->base[i].present)
-				break;
-		/* empty index found */
-		if (i == index + count)
-			break;
-
-		index = (index + count) % INTR_REMAP_TABLE_ENTRIES;
-
-		if (index == start_index) {
-			raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
-			printk(KERN_ERR "can't allocate an IRTE\n");
-			return -1;
-		}
-	} while (1);
-
-	for (i = index; i < index + count; i++)
-		table->base[i].present = 1;
-
-	cfg->remapped = 1;
-	irq_iommu->iommu = iommu;
-	irq_iommu->irte_index =  index;
-	irq_iommu->sub_handle = 0;
-	irq_iommu->irte_mask = mask;
-
+	index = bitmap_find_free_region(table->bitmap,
+					INTR_REMAP_TABLE_ENTRIES, mask);
+	if (index < 0) {
+		pr_warn("IR%d: can't allocate an IRTE\n", iommu->seq_id);
+	} else {
+		cfg->remapped = 1;
+		irq_iommu->iommu = iommu;
+		irq_iommu->irte_index =  index;
+		irq_iommu->sub_handle = 0;
+		irq_iommu->irte_mask = mask;
+	}
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
 	return index;
@@ -254,6 +238,8 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 		set_64bit(&entry->low, 0);
 		set_64bit(&entry->high, 0);
 	}
+	bitmap_release_region(iommu->ir_table->bitmap, index,
+			      irq_iommu->irte_mask);
 
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
@@ -453,6 +439,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu, int mode)
 {
 	struct ir_table *ir_table;
 	struct page *pages;
+	unsigned long *bitmap;
 
 	ir_table = iommu->ir_table = kzalloc(sizeof(struct ir_table),
 					     GFP_ATOMIC);
@@ -464,13 +451,23 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu, int mode)
 				 INTR_REMAP_PAGE_ORDER);
 
 	if (!pages) {
-		printk(KERN_ERR "failed to allocate pages of order %d\n",
-		       INTR_REMAP_PAGE_ORDER);
+		pr_err("IR%d: failed to allocate pages of order %d\n",
+		       iommu->seq_id, INTR_REMAP_PAGE_ORDER);
 		kfree(iommu->ir_table);
 		return -ENOMEM;
 	}
 
+	bitmap = kcalloc(BITS_TO_LONGS(INTR_REMAP_TABLE_ENTRIES),
+			 sizeof(long), GFP_ATOMIC);
+	if (bitmap == NULL) {
+		pr_err("IR%d: failed to allocate bitmap\n", iommu->seq_id);
+		__free_pages(pages, INTR_REMAP_PAGE_ORDER);
+		kfree(ir_table);
+		return -ENOMEM;
+	}
+
 	ir_table->base = page_address(pages);
+	ir_table->bitmap = bitmap;
 
 	iommu_set_irq_remapping(iommu, mode);
 	return 0;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d380c5e..de1e5e9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -288,6 +288,7 @@ struct q_inval {
 
 struct ir_table {
 	struct irte *base;
+	unsigned long *bitmap;
 };
 #endif
 
-- 
1.7.10.4
