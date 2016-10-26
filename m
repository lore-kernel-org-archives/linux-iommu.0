From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/5] PCI: Extract link retraining from
	pcie_aspm_configure_common_clock()
Date: Wed, 26 Oct 2016 12:01:28 -0600
Message-ID: <20161026180128.23495.19403.stgit@gimli.home>
References: <20161026175156.23495.12980.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161026175156.23495.12980.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/pci.c       |   29 +++++++++++++++++++++++++++++
 drivers/pci/pcie/aspm.c |   17 +----------------
 include/linux/pci.h     |    1 +
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d6cf89..4d327d4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4729,6 +4729,35 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
+int pcie_retrain_link(struct pci_dev *dev)
+{
+	int ret;
+	u16 lnksta;
+	unsigned long timeout;
+
+	/* Can only retrain from downstream ports */
+	if (!pci_is_pcie(dev) ||
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM &&
+	     pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT))
+		return -EINVAL;
+
+	ret = pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
+	if (ret)
+		return ret;
+
+	timeout = jiffies + HZ; /* Retraining timeout */
+	for (;;) {
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (!(lnksta & PCI_EXP_LNKSTA_LT) ||
+		    time_after(jiffies, timeout))
+			break;
+		msleep(1);
+	}
+
+	return (lnksta & PCI_EXP_LNKSTA_LT) ? -EBUSY : 0;
+}
+EXPORT_SYMBOL(pcie_retrain_link);
+
 int pcie_get_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 		  enum pcie_link_width *width)
 {
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0ec649d..482d60c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -91,8 +91,6 @@ struct pcie_link_state {
 	[POLICY_POWERSAVE] = "powersave"
 };
 
-#define LINK_RETRAIN_TIMEOUT HZ
-
 static int policy_to_aspm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -222,20 +220,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
 	/* Retrain link */
-	reg16 |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
-
-	/* Wait for link training end. Break out after waiting for timeout */
-	start_jiffies = jiffies;
-	for (;;) {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
-			break;
-		msleep(1);
-	}
-	if (!(reg16 & PCI_EXP_LNKSTA_LT))
+	if (!pcie_retrain_link(parent))
 		return;
 
 	/* Training failed. Restore common clock configurations */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fbfbb40..eb0e9be 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1024,6 +1024,7 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_readrq(struct pci_dev *dev, int rq);
 int pcie_get_mps(struct pci_dev *dev);
 int pcie_set_mps(struct pci_dev *dev, int mps);
+int pcie_retrain_link(struct pci_dev *dev);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 int pcie_get_link(struct pci_dev *dev, enum pci_bus_speed *speed,
