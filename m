From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [patch 10/55] x86/msi: Provide new iommu irqdomain interface
Date: Tue, 20 Jun 2017 01:37:10 +0200
Message-ID: <20170619235443.986661206@linutronix.de>
References: <20170619233700.547167146@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline;
	filename=x86-msi--Provide-new-iommu-irqdomain-interface.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Provide a new interface for creating the iommu remapping domains, so that
the caller can supply a name and a id in order to create named irqdomains.

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
---
 arch/x86/include/asm/irq_remapping.h |    2 ++
 arch/x86/kernel/apic/msi.c           |   15 +++++++++++++++
 2 files changed, 17 insertions(+)

--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -56,6 +56,8 @@ irq_remapping_get_irq_domain(struct irq_
 
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
 extern struct irq_domain *arch_create_msi_irq_domain(struct irq_domain *parent);
+extern struct irq_domain *
+arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int id);
 
 /* Get parent irqdomain for interrupt remapping irqdomain */
 static inline struct irq_domain *arch_get_ir_parent_domain(void)
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -167,10 +167,25 @@ static struct msi_domain_info pci_msi_ir
 	.handler_name	= "edge",
 };
 
+struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
+						    const char *name, int id)
+{
+	struct fwnode_handle *fn;
+	struct irq_domain *d;
+
+	fn = irq_domain_alloc_named_id_fwnode(name, id);
+	if (!fn)
+		return NULL;
+	d = pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
+	kfree(fn);
+	return d;
+}
+
 struct irq_domain *arch_create_msi_irq_domain(struct irq_domain *parent)
 {
 	return pci_msi_create_irq_domain(NULL, &pci_msi_ir_domain_info, parent);
 }
+
 #endif
 
 #ifdef CONFIG_DMAR_TABLE
