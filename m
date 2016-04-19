From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 5/8] genirq/irq: introduce msi_doorbell's structs and
	related callback
Date: Tue, 19 Apr 2016 17:13:07 +0000
Message-ID: <1461085990-2547-6-git-send-email-eric.auger@linaro.org>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461085990-2547-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The purpose is to be able to retrieve the MSI doorbells of an irqchip.
This is now needed since on some platforms those doorbells must be
iommu mapped (in case the MSIs transit through an IOMMU that do not
bypass those transactions).

The assumption is there is a maximum of one doorbell region per cpu.
The number of doorbells for the whole irqchip is stored in nb_doorbells.

A doorbell region is characterized by its physical address base, size and
IOMMU protection flag.

irq_chip msi_doorbell_info callback enables to retrieve the doorbells of
the irqchip.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

---

v7: creation
---
 include/linux/irq.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c4de623..fdad8c1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -312,9 +312,25 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 	return d->hwirq;
 }
 
-/**
- * struct irq_chip - hardware interrupt chip descriptor
- *
+/* MSI doorbell region */
+struct irq_chip_msi_doorbell {
+	phys_addr_t base;
+	size_t size;
+	int prot; /* iommu protection flag */
+};
+
+/*
+ * Describe all the MSI doorbell regions for an irqchip.
+ * A single doorbell region per cpu is assumed.
+ * In case a single doorbell is supported for the whole irqchip,
+ * the region is described in as cpu #0's one
+ */
+struct irq_chip_msi_doorbell_info {
+	struct irq_chip_msi_doorbell __percpu *percpu_doorbells;
+	int nb_doorbells; /* overall number of doorbells */
+};
+
+/** * struct irq_chip - hardware interrupt chip descriptor *
  * @name:		name for /proc/interrupts
  * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
  * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
@@ -349,6 +365,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_get_irqchip_state:	return the internal state of an interrupt
  * @irq_set_irqchip_state:	set the internal state of a interrupt
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
+ * @msi_doorbell_info:	return the MSI doorbell info
  * @ipi_send_single:	send a single IPI to destination cpus
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @flags:		chip specific flags
@@ -394,7 +411,8 @@ struct irq_chip {
 	int		(*irq_set_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool state);
 
 	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
-
+	const struct irq_chip_msi_doorbell_info *(*msi_doorbell_info)(
+							struct irq_data *data);
 	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
 	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
 
-- 
1.9.1
