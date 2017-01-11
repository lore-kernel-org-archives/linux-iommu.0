From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v8 14/18] irqdomain: irq_domain_check_msi_remap
Date: Wed, 11 Jan 2017 09:41:50 +0000
Message-ID: <1484127714-3263-15-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com, gpkulkarni@gmail.com, shankerd@codeaurora.org, bharat.bhushan@nxp.com, geethasowjanya.akula@gmail.com
List-Id: iommu@lists.linux-foundation.org

This new function checks whether all MSI irq domains
implement IRQ remapping. This is useful to understand
whether VFIO passthrough is safe with respect to interrupts.

On ARM typically an MSI controller can sit downstream
to the IOMMU without preventing VFIO passthrough.
As such any assigned device can write into the MSI doorbell.
In case the MSI controller implements IRQ remapping, assigned
devices will not be able to trigger interrupts towards the
host. On the contrary, the assignment must be emphasized as
unsafe with respect to interrupts.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

---
v7 -> v8:
- remove goto in irq_domain_check_msi_remap
- Added Marc's R-b

v5 -> v6:
- use irq_domain_hierarchical_is_msi_remap()
- comment rewording

v4 -> v5:
- Handle DOMAIN_BUS_FSL_MC_MSI domains
- Check parents
---
 include/linux/irqdomain.h |  1 +
 kernel/irq/irqdomain.c    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bc2f571..188eced 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -222,6 +222,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 void *host_data);
 extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
+extern bool irq_domain_check_msi_remap(void);
 extern void irq_set_default_host(struct irq_domain *host);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 876e131..d889751 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -278,6 +278,28 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
 
 /**
+ * irq_domain_check_msi_remap - Check whether all MSI
+ * irq domains implement IRQ remapping
+ */
+bool irq_domain_check_msi_remap(void)
+{
+	struct irq_domain *h;
+	bool ret = true;
+
+	mutex_lock(&irq_domain_mutex);
+	list_for_each_entry(h, &irq_domain_list, link) {
+		if (irq_domain_is_msi(h) &&
+		    !irq_domain_hierarchical_is_msi_remap(h)) {
+			ret = false;
+			break;
+		}
+	}
+	mutex_unlock(&irq_domain_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(irq_domain_check_msi_remap);
+
+/**
  * irq_set_default_host() - Set a "default" irq domain
  * @domain: default domain pointer
  *
-- 
1.9.1
