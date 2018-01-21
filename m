From: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] iommu/amd: Avoid get_irq_table() from atomic context
Date: Sun, 21 Jan 2018 03:28:53 -0600
Message-ID: <20180121092854.28290-1-swood@redhat.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

get_irq_table() acquires amd_iommu_devtable_lock which is not a raw lock,
and thus cannot be acquired from atomic context on PREEMPT_RT.  Many
calls to modify_irte*() come from atomic context due to the IRQ
desc->lock, as does amd_iommu_update_ga() due to the preemption disabling
in vcpu_load/put().

The only difference between calling get_irq_table() and reading from
irq_lookup_table[] directly, other than the lock acquisition and
amd_iommu_rlookup_table[] check, is if the table entry is unpopulated,
which should never happen when looking up a devid that came from an
irq_2_irte struct, as get_irq_table() would have already been called on
that devid during irq_remapping_alloc().

The lock acquisition is not needed in these cases because entries in
irq_lookup_table[] never change once non-NULL -- nor would the
amd_iommu_devtable_lock usage in get_irq_table() provide meaningful
protection if they did, since it's released before using the looked up
table in the get_irq_table() caller.

The amd_iommu_rlookup_table[] check is not needed because
irq_lookup_table[devid] should never be non-NULL if
amd_iommu_rlookup_table[devid] is NULL.

Signed-off-by: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index dc4b73833419..8ead1b296d09 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3732,7 +3732,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = irq_lookup_table[devid];
 	if (!table)
 		return -ENOMEM;
 
@@ -3765,7 +3765,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = irq_lookup_table[devid];
 	if (!table)
 		return -ENOMEM;
 
@@ -3789,7 +3789,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid, false);
+	table = irq_lookup_table[devid];
 	if (!table)
 		return;
 
@@ -4392,7 +4392,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	irt = get_irq_table(devid, false);
+	irt = irq_lookup_table[devid];
 	if (!irt)
 		return -ENODEV;
 
-- 
1.8.3.1
