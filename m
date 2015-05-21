From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v6 1/8] iommu: Add new member capability to struct irq_remap_ops
Date: Thu, 21 May 2015 14:59:08 +0800
Message-ID: <1432191555-3516-2-git-send-email-feng.wu@intel.com>
References: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432191555-3516-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds a new member capability to struct irq_remap_ops,
this new function ops can be used to check whether some
features are supported, such as VT-d Posted-Interrupts.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h | 4 ++++
 drivers/iommu/irq_remapping.h        | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 78974fb..0953723 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -31,6 +31,10 @@ struct irq_alloc_info;
 
 #ifdef CONFIG_IRQ_REMAP
 
+enum irq_remap_cap {
+	IRQ_POSTING_CAP = 0,
+};
+
 extern void set_irq_remapping_broken(void);
 extern int irq_remapping_prepare(void);
 extern int irq_remapping_enable(void);
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 91d5a11..b6ca30d 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -35,6 +35,9 @@ extern int no_x2apic_optout;
 extern int irq_remapping_enabled;
 
 struct irq_remap_ops {
+	/* The supported capabilities */
+	int capability;
+
 	/* Initializes hardware and makes it ready for remapping interrupts */
 	int  (*prepare)(void);
 
-- 
2.1.0
