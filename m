From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/27] x86/irq: Introduce irq_cfg->remapped
Date: Wed, 11 Jul 2012 15:38:47 +0200
Message-ID: <1342013952-10174-3-git-send-email-joerg.roedel@amd.com>
References: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342013952-10174-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This flag will show whether the interrupt is remapped in a
way that works for VT-d and AMD-Vi.

Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/include/asm/hw_irq.h       |    1 +
 arch/x86/kernel/apic/io_apic.c      |    2 +-
 drivers/iommu/intel_irq_remapping.c |    4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index b6171e6..71bb327 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -132,6 +132,7 @@ struct irq_cfg {
 	u8			vector;
 	u8			move_in_progress : 1;
 #ifdef CONFIG_IRQ_REMAP
+	bool			remapped;
 	union irq_remap_info    irq_remap_info;
 #endif
 };
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 08f666c..d5bccc0 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -72,7 +72,7 @@
 static void irq_remap_modify_chip_defaults(struct irq_chip *chip);
 static inline bool irq_remapped(struct irq_cfg *cfg)
 {
-	return cfg->irq_remap_info.irq_2_iommu.iommu != NULL;
+	return cfg->remapped;
 }
 #else
 static inline bool irq_remapped(struct irq_cfg *cfg)
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index e4e4334..29411ed 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -68,6 +68,7 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 {
 	struct ir_table *table = iommu->ir_table;
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
+	struct irq_cfg *cfg = irq_get_chip_data(irq);
 	u16 index, start_index;
 	unsigned int mask = 0;
 	unsigned long flags;
@@ -115,6 +116,7 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 	for (i = index; i < index + count; i++)
 		table->base[i].present = 1;
 
+	cfg->remapped = true;
 	irq_iommu->iommu = iommu;
 	irq_iommu->irte_index =  index;
 	irq_iommu->sub_handle = 0;
@@ -155,6 +157,7 @@ static int map_irq_to_irte_handle(int irq, u16 *sub_handle)
 static int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index, u16 subhandle)
 {
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
+	struct irq_cfg *cfg = irq_get_chip_data(irq);
 	unsigned long flags;
 
 	if (!irq_iommu)
@@ -162,6 +165,7 @@ static int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index, u16 subha
 
 	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
 
+	cfg->remapped = true;
 	irq_iommu->iommu = iommu;
 	irq_iommu->irte_index = index;
 	irq_iommu->sub_handle = subhandle;
-- 
1.7.9.5
