From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/9] iommu/amd: Simplify allocation in irq_remapping_alloc()
Date: Thu, 13 Aug 2015 19:33:48 +0200
Message-ID: <1439487236-14098-2-git-send-email-joro@8bytes.org>
References: <1439487236-14098-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439487236-14098-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Allocate the irq data only in the loop.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 658ee39..a158579 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3947,11 +3947,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret < 0)
 		return ret;
 
-	ret = -ENOMEM;
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		goto out_free_parent;
-
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		if (get_irq_table(devid, true))
 			index = info->ioapic_pin;
@@ -3962,7 +3957,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	}
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
-		kfree(data);
 		goto out_free_parent;
 	}
 
@@ -3974,17 +3968,18 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 			goto out_free_data;
 		}
 
-		if (i > 0) {
-			data = kzalloc(sizeof(*data), GFP_KERNEL);
-			if (!data)
-				goto out_free_data;
-		}
+		ret = -ENOMEM;
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			goto out_free_data;
+
 		irq_data->hwirq = (devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
 		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
+
 	return 0;
 
 out_free_data:
-- 
1.9.1
