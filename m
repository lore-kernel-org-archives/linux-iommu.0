From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch V1 8/9] iommu/irq_remapping: Normailize the way to detect
	whether IR is enabled
Date: Wed, 10 Dec 2014 14:47:50 +0800
Message-ID: <1418194071-13785-9-git-send-email-jiang.liu@linux.intel.com>
References: <1418194071-13785-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418194071-13785-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Refine code by normailizing the way to detect whether IR is enabled.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/irq_remapping.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index fbd585e49ebd..c7ef51a2555a 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -112,22 +112,16 @@ int __init irq_remapping_enable(void)
 
 void irq_remapping_disable(void)
 {
-	if (!irq_remapping_enabled ||
-	    !remap_ops ||
-	    !remap_ops->disable)
-		return;
-
-	remap_ops->disable();
+	if (irq_remapping_enabled && remap_ops->disable)
+		remap_ops->disable();
 }
 
 int irq_remapping_reenable(int mode)
 {
-	if (!irq_remapping_enabled ||
-	    !remap_ops ||
-	    !remap_ops->reenable)
-		return 0;
+	if (irq_remapping_enabled && remap_ops->reenable)
+		return remap_ops->reenable(mode);
 
-	return remap_ops->reenable(mode);
+	return 0;
 }
 
 int __init irq_remap_enable_fault_handling(void)
@@ -135,7 +129,7 @@ int __init irq_remap_enable_fault_handling(void)
 	if (!irq_remapping_enabled)
 		return 0;
 
-	if (!remap_ops || !remap_ops->enable_faulting)
+	if (!remap_ops->enable_faulting)
 		return -ENODEV;
 
 	return remap_ops->enable_faulting();
@@ -176,10 +170,10 @@ void irq_remapping_print_chip(struct irq_data *data, struct seq_file *p)
 struct irq_domain *
 irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
 {
-	if (!remap_ops || !remap_ops->get_ir_irq_domain)
-		return NULL;
+	if (irq_remapping_enabled && remap_ops->get_ir_irq_domain)
+		return remap_ops->get_ir_irq_domain(info);
 
-	return remap_ops->get_ir_irq_domain(info);
+	return NULL;
 }
 
 /**
@@ -194,8 +188,8 @@ irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
 struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
-	if (!remap_ops || !remap_ops->get_irq_domain)
-		return NULL;
+	if (irq_remapping_enabled && remap_ops->get_irq_domain)
+		return remap_ops->get_irq_domain(info);
 
-	return remap_ops->get_irq_domain(info);
+	return NULL;
 }
-- 
1.7.10.4
