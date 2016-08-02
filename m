From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 02/11] genirq/msi: msi_compose wrapper
Date: Tue,  2 Aug 2016 17:23:28 +0000
Message-ID: <1470158617-7022-3-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently the MSI message is composed by directly calling
irq_chip_compose_msi_msg and erased by setting the memory to zero.

On some platforms, we will need to complexify this composition to
properly handle MSI emission through IOMMU. Also we will need to track
when the MSI message is erased.

We propose to introduce a common wrapper for actual composition and
erasure, msi_compose.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v4 -> v5:
- just introduce the msi-compose wrapper without adding new
  functionalities

v3 -> v4:
- that code was formely in irq-gic-common.c
  "irqchip/gicv2m/v3-its-pci-msi: IOMMU map the MSI frame when needed"
  also the [un]mapping was done in irq_write_msi_msg; now done on compose

v2 -> v3:
- protect iova/addr manipulation with CONFIG_ARCH_DMA_ADDR_T_64BIT and
  CONFIG_PHYS_ADDR_T_64BIT
- only expose gic_pci_msi_domain_write_msg in case CONFIG_IOMMU_API &
  CONFIG_PCI_MSI_IRQ_DOMAIN are set.
- gic_set/unset_msi_addr duly become static
---
 kernel/irq/msi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9b0ba4a..72bf4d6 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -55,6 +55,19 @@ static inline void irq_chip_write_msi_msg(struct irq_data *data,
 	data->chip->irq_write_msi_msg(data, msg);
 }
 
+static int msi_compose(struct irq_data *irq_data,
+		       struct msi_msg *msg, bool erase)
+{
+	int ret = 0;
+
+	if (erase)
+		memset(msg, 0, sizeof(*msg));
+	else
+		ret = irq_chip_compose_msi_msg(irq_data, msg);
+
+	return ret;
+}
+
 /**
  * msi_domain_set_affinity - Generic affinity setter function for MSI domains
  * @irq_data:	The irq data associated to the interrupt
@@ -73,7 +86,7 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
+		BUG_ON(msi_compose(irq_data, &msg, false));
 		irq_chip_write_msi_msg(irq_data, &msg);
 	}
 
@@ -85,7 +98,7 @@ static void msi_domain_activate(struct irq_domain *domain,
 {
 	struct msi_msg msg;
 
-	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
+	BUG_ON(msi_compose(irq_data, &msg, false));
 	irq_chip_write_msi_msg(irq_data, &msg);
 }
 
@@ -94,7 +107,7 @@ static void msi_domain_deactivate(struct irq_domain *domain,
 {
 	struct msi_msg msg;
 
-	memset(&msg, 0, sizeof(msg));
+	msi_compose(irq_data, &msg, true);
 	irq_chip_write_msi_msg(irq_data, &msg);
 }
 
-- 
1.9.1
