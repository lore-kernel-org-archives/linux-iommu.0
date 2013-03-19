From: Kyle McMartin <kmcmarti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] amd_iommu: initialize table->lock for lockdep
Date: Tue, 19 Mar 2013 19:41:52 -0400
Message-ID: <20130319234151.GC7456@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Lockdep complains about uninitialized spinlocks, squelch that by calling
spin_lock_init to initialize the lockdep fields.

Signed-off-by: Kyle McMartin <kyle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3949,6 +3949,8 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	if (!table)
 		goto out;
 
+	spin_lock_init(&table->lock);
+
 	if (ioapic)
 		/* Keep the first 32 indexes free for IOAPIC interrupts */
 		table->min_index = 32;
