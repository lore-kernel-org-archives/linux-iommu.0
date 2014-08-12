From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 16/20] arm/iop13xx/MSI: Use msi_chip instead of arch func
	to configure MSI/MSI-X
Date: Tue, 12 Aug 2014 15:26:09 +0800
Message-ID: <1407828373-24322-17-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "H.
	Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wuyun <wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Introduce a new struct msi_chip iop13xx_msi_chip instead of weak arch
functions to configure MSI/MSI-X. And associate the pci bus with msi_chip
in pcibios_add_bus().

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-iop13xx/include/mach/pci.h |    2 ++
 arch/arm/mach-iop13xx/iq81340mc.c        |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c        |    1 +
 arch/arm/mach-iop13xx/msi.c              |   14 ++++++++++++--
 arch/arm/mach-iop13xx/pci.c              |    6 ++++++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/pci.h b/arch/arm/mach-iop13xx/include/mach/pci.h
index 59f42b5..7a073cb 100644
--- a/arch/arm/mach-iop13xx/include/mach/pci.h
+++ b/arch/arm/mach-iop13xx/include/mach/pci.h
@@ -10,6 +10,8 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *);
 void iop13xx_atu_select(struct hw_pci *plat_pci);
 void iop13xx_pci_init(void);
 void iop13xx_map_pci_memory(void);
+void iop13xx_add_bus(struct pci_bus *bus);
+extern struct msi_chip iop13xx_msi_chip;
 
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 9cd07d3..19d47cb 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -59,6 +59,7 @@ static struct hw_pci iq81340mc_pci __initdata = {
 	.map_irq	= iq81340mc_pcix_map_irq,
 	.scan		= iop13xx_scan_bus,
 	.preinit	= iop13xx_pci_init,
+	.add_bus	= iop13xx_add_bus;
 };
 
 static int __init iq81340mc_pci_init(void)
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index b3ec11c..4d56993 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -61,6 +61,7 @@ static struct hw_pci iq81340sc_pci __initdata = {
 	.scan		= iop13xx_scan_bus,
 	.map_irq	= iq81340sc_atux_map_irq,
 	.preinit	= iop13xx_pci_init
+	.add_bus	= iop13xx_add_bus;
 };
 
 static int __init iq81340sc_pci_init(void)
diff --git a/arch/arm/mach-iop13xx/msi.c b/arch/arm/mach-iop13xx/msi.c
index e7730cf..59a9f8f 100644
--- a/arch/arm/mach-iop13xx/msi.c
+++ b/arch/arm/mach-iop13xx/msi.c
@@ -132,7 +132,7 @@ static struct irq_chip iop13xx_msi_chip = {
 	.irq_unmask = unmask_msi_irq,
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+int iop13xx_setup_msi_irq(struct device *dev, struct msi_desc *desc)
 {
 	int id, irq = irq_alloc_desc_from(IRQ_IOP13XX_MSI_0, -1);
 	struct msi_msg msg;
@@ -159,7 +159,17 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	return 0;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void iop13xx_teardown_msi_irq(unsigned int irq)
 {
 	irq_free_desc(irq);
 }
+
+struct msi_chip iop13xx_chip = {
+	.setup_irq = iop13xx_setup_msi_irq,
+	.teardown_irq = iop13xx_teardown_msi_irq,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &iop13xx_chip;
+}
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 9082b84..f498800 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -962,6 +962,12 @@ void __init iop13xx_atu_select(struct hw_pci *plat_pci)
 	}
 }
 
+void iop13xx_add_bus(struct pci_bus *bus)
+{
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		bus->msi = &iop13xx_msi_chip;
+}
+
 void __init iop13xx_pci_init(void)
 {
 	/* clear pre-existing south bridge errors */
-- 
1.7.1
