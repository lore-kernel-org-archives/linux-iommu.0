From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 02/20] MSI: Clean up struct msi_chip argument
Date: Tue, 12 Aug 2014 15:25:55 +0800
Message-ID: <1407828373-24322-3-git-send-email-wangyijing@huawei.com>
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
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "H.
	Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wuyun <wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "David S. Miller" <davem>
List-Id: iommu@lists.linux-foundation.org

Msi_chip functions setup_irq/teardown_irq/check_device rarely
use msi_chip argument. We can get msi_chip pointer from the
device pointer or irq number, so clean up msi_chip arguments.
This patch is also preparation for using msi_chip in all
platforms to setup/teardown MSI irqs.

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
CC: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
CC: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/irqchip/irq-armada-370-xp.c |   12 +++++-------
 drivers/pci/host/pci-tegra.c        |    8 +++++---
 drivers/pci/host/pcie-designware.c  |    4 ++--
 drivers/pci/host/pcie-rcar.c        |    8 +++++---
 drivers/pci/msi.c                   |    6 +++---
 include/linux/msi.h                 |    8 +++-----
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index c887e6e..ee1f0ba 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -129,9 +129,8 @@ static void armada_370_xp_free_msi(int hwirq)
 	mutex_unlock(&msi_used_lock);
 }
 
-static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
-				       struct pci_dev *pdev,
-				       struct msi_desc *desc)
+static int armada_370_xp_setup_msi_irq(struct pci_dev *pdev,
+		struct msi_desc *desc)
 {
 	struct msi_msg msg;
 	int virq, hwirq;
@@ -156,8 +155,7 @@ static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
 	return 0;
 }
 
-static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
-					   unsigned int irq)
+static void armada_370_xp_teardown_msi_irq(unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
 	unsigned long hwirq = d->hwirq;
@@ -166,8 +164,8 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 	armada_370_xp_free_msi(hwirq);
 }
 
-static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
-					  int nvec, int type)
+static int armada_370_xp_check_msi_device(struct pci_dev *dev,
+		int nvec, int type)
 {
 	/* We support MSI, but not MSI-X */
 	if (type == PCI_CAP_ID_MSI)
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 869a921..3872bc0 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1192,9 +1192,10 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
+static int tegra_msi_setup_irq(struct pci_dev *pdev,
 			       struct msi_desc *desc)
 {
+	struct msi_chip *chip = pdev->bus->msi;
 	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct msi_msg msg;
 	unsigned int irq;
@@ -1220,10 +1221,11 @@ static int tegra_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	return 0;
 }
 
-static void tegra_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
+static void tegra_msi_teardown_irq(unsigned int irq)
 {
-	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct irq_data *d = irq_get_irq_data(irq);
+	struct msi_chip *chip = irq_get_chip_data(irq);
+	struct tegra_msi *msi = to_tegra_msi(chip);
 
 	tegra_msi_free(msi, d->hwirq);
 }
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 52bd3a1..2204456 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -342,7 +342,7 @@ static void clear_irq(unsigned int irq)
 	msi->msi_attrib.multiple = 0;
 }
 
-static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
+static int dw_msi_setup_irq(struct pci_dev *pdev,
 			struct msi_desc *desc)
 {
 	int irq, pos, msgvec;
@@ -384,7 +384,7 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	return 0;
 }
 
-static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
+static void dw_msi_teardown_irq(unsigned int irq)
 {
 	clear_irq(irq);
 }
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4884ee5..647bc9f 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -615,9 +615,10 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int rcar_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
+static int rcar_msi_setup_irq(struct pci_dev *pdev,
 			      struct msi_desc *desc)
 {
+	struct msi_chip *chip = pdev->bus->msi;
 	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
 	struct msi_msg msg;
@@ -645,10 +646,11 @@ static int rcar_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	return 0;
 }
 
-static void rcar_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
+static void rcar_msi_teardown_irq(unsigned int irq)
 {
-	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct irq_data *d = irq_get_irq_data(irq);
+	struct msi_chip *chip = irq_get_chip_data(irq);
+	struct rcar_msi *msi = to_rcar_msi(chip);
 
 	rcar_msi_free(msi, d->hwirq);
 }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index bff25df..782b242 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -37,7 +37,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (!chip || !chip->setup_irq)
 		return -EINVAL;
 
-	err = chip->setup_irq(chip, dev, desc);
+	err = chip->setup_irq(dev, desc);
 	if (err < 0)
 		return err;
 
@@ -53,7 +53,7 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 	if (!chip || !chip->teardown_irq)
 		return;
 
-	chip->teardown_irq(chip, irq);
+	chip->teardown_irq(irq);
 }
 
 int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
@@ -63,7 +63,7 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (!chip || !chip->check_device)
 		return 0;
 
-	return chip->check_device(chip, dev, nvec, type);
+	return chip->check_device(dev, nvec, type);
 }
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 78e6b6e..a510d25 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -72,11 +72,9 @@ struct msi_chip {
 	struct device_node *of_node;
 	struct list_head list;
 
-	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
-			 struct msi_desc *desc);
-	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
-	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
-			    int nvec, int type);
+	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
+	void (*teardown_irq)(unsigned int irq);
+	int (*check_device)(struct pci_dev *dev, int nvec, int type);
 };
 
 #endif /* LINUX_MSI_H */
-- 
1.7.1
