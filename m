From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 07/10] iommu/amd: use `table' instead `irt' as variable name
	in amd_iommu_update_ga()
Date: Fri, 16 Mar 2018 21:18:33 +0100
Message-ID: <20180316201836.7864-8-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180316201836.7864-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The variable of type struct irq_remap_table is always named `table'
except in amd_iommu_update_ga() where it is called `irt'. Make it
consistent and name it also `table'.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e1628ff5f6bd..6ee8ef22ad51 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4390,7 +4390,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 {
 	unsigned long flags;
 	struct amd_iommu *iommu;
-	struct irq_remap_table *irt;
+	struct irq_remap_table *table;
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	int devid = ir_data->irq_2_irte.devid;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4404,11 +4404,11 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	irt = get_irq_table(devid);
-	if (!irt)
+	table = get_irq_table(devid);
+	if (!table)
 		return -ENODEV;
 
-	raw_spin_lock_irqsave(&irt->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	if (ref->lo.fields_vapic.guest_mode) {
 		if (cpu >= 0)
@@ -4417,7 +4417,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 		barrier();
 	}
 
-	raw_spin_unlock_irqrestore(&irt->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
-- 
2.16.2
