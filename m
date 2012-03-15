From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/9] iommu/vt-d: Convert free_irte into a remap_ops callback
Date: Thu, 15 Mar 2012 18:39:49 +0100
Message-ID: <1331833191-25779-8-git-send-email-joerg.roedel@amd.com>
References: <1331833191-25779-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1331833191-25779-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The operation for releasing a remapping entry is iommu
specific too.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/include/asm/intr_remapping.h |    2 ++
 arch/x86/kernel/apic/io_apic.c        |    2 +-
 drivers/iommu/intel_intr_remapping.c  |    3 ++-
 drivers/iommu/intr_remapping.c        |    8 ++++++++
 drivers/iommu/intr_remapping.h        |    3 +++
 include/linux/dmar.h                  |    5 -----
 6 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/intr_remapping.h b/arch/x86/include/asm/intr_remapping.h
index ae933ec..a195b7d 100644
--- a/arch/x86/include/asm/intr_remapping.h
+++ b/arch/x86/include/asm/intr_remapping.h
@@ -43,6 +43,7 @@ extern int intr_setup_ioapic_entry(int irq,
 extern int intr_set_affinity(struct irq_data *data,
 			     const struct cpumask *mask,
 			     bool force);
+extern void intr_free_irq(int irq);
 
 #else  /* CONFIG_IRQ_REMAP */
 
@@ -68,6 +69,7 @@ static inline int intr_set_affinity(struct irq_data *data,
 {
 	return 0;
 }
+static inline void intr_free_irq(int irq) { }
 #endif /* CONFIG_IRQ_REMAP */
 
 #endif /* __X86_INTR_REMAPPING_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 101090a..e194b78 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2981,7 +2981,7 @@ void destroy_irq(unsigned int irq)
 	irq_set_status_flags(irq, IRQ_NOREQUEST|IRQ_NOPROBE);
 
 	if (irq_remapped(cfg))
-		free_irte(irq);
+		intr_free_irq(irq);
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	__clear_irq_vector(irq, cfg);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
diff --git a/drivers/iommu/intel_intr_remapping.c b/drivers/iommu/intel_intr_remapping.c
index 25372c1..44a6e04 100644
--- a/drivers/iommu/intel_intr_remapping.c
+++ b/drivers/iommu/intel_intr_remapping.c
@@ -253,7 +253,7 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
-int free_irte(int irq)
+static int free_irte(int irq)
 {
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
 	unsigned long flags;
@@ -964,4 +964,5 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.enable_faulting	= enable_drhd_fault_handling,
 	.setup_ioapic_entry	= intel_setup_ioapic_entry,
 	.set_affinity		= intel_ioapic_set_affinity,
+	.free_irq		= free_irte,
 };
diff --git a/drivers/iommu/intr_remapping.c b/drivers/iommu/intr_remapping.c
index 2f4f27f..a68d304 100644
--- a/drivers/iommu/intr_remapping.c
+++ b/drivers/iommu/intr_remapping.c
@@ -119,3 +119,11 @@ int intr_set_affinity(struct irq_data *data, const struct cpumask *mask,
 
 	return remap_ops->set_affinity(data, mask, force);
 }
+
+void intr_free_irq(int irq)
+{
+	if (!remap_ops || !remap_ops->free_irq)
+		return;
+
+	remap_ops->free_irq(irq);
+}
diff --git a/drivers/iommu/intr_remapping.h b/drivers/iommu/intr_remapping.h
index e0bc6e0..5748553 100644
--- a/drivers/iommu/intr_remapping.h
+++ b/drivers/iommu/intr_remapping.h
@@ -60,6 +60,9 @@ struct irq_remap_ops {
 	/* Set the CPU affinity of a remapped interrupt */
 	int (*set_affinity)(struct irq_data *data, const struct cpumask *mask,
 			    bool force);
+
+	/* Free an IRQ */
+	int (*free_irq)(int);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f2bd87f..7a207a3 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -121,7 +121,6 @@ extern int alloc_irte(struct intel_iommu *iommu, int irq, u16 count);
 extern int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index,
    			u16 sub_handle);
 extern int map_irq_to_irte_handle(int irq, u16 *sub_handle);
-extern int free_irte(int irq);
 
 extern struct intel_iommu *map_dev_to_ir(struct pci_dev *dev);
 extern struct intel_iommu *map_ioapic_to_ir(int apic);
@@ -138,10 +137,6 @@ static inline int modify_irte(int irq, struct irte *irte_modified)
 {
 	return -1;
 }
-static inline int free_irte(int irq)
-{
-	return -1;
-}
 static inline int map_irq_to_irte_handle(int irq, u16 *sub_handle)
 {
 	return -1;
-- 
1.7.5.4
