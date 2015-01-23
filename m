From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 4/6] of/pci: add of_pci_dma_configure() update dma
	configuration
Date: Fri, 23 Jan 2015 17:32:37 -0500
Message-ID: <1422052359-12384-5-git-send-email-m-karicheri2@ti.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422052359-12384-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add of_pci_dma_configure() to allow updating the dma configuration
of the pci device using the configuration from DT of the parent of
the root bridge device.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
---
 drivers/of/of_pci.c    |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h |   12 ++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 88471d3..34878c9 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 
@@ -229,6 +230,44 @@ parse_failed:
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
+/**
+ * of_get_pci_root_bridge_parent - get the OF node of the root bridge's parent
+ * @dev: ptr to pci_dev struct of the pci device
+ *
+ * This function will traverse the bus up to the root bus starting with
+ * the child and return the OF node ptr to root bridge device's parent device.
+ */
+struct device_node *of_get_pci_root_bridge_parent(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct device *bridge;
+
+	while (!pci_is_root_bus(bus))
+		bus = bus->parent;
+	bridge = bus->bridge;
+
+	return bridge->parent->of_node;
+}
+EXPORT_SYMBOL_GPL(of_get_pci_root_bridge_parent);
+
+/**
+ * of_pci_dma_configure - Setup DMA configuration
+ * @dev: ptr to pci_dev struct of the pci device
+ *
+ * Function to update PCI devices's DMA configuration using the same
+ * info from the OF node of root host bridge's parent.
+ */
+void of_pci_dma_configure(struct pci_dev *pci_dev)
+{
+	struct device *dev = &pci_dev->dev;
+	struct device_node *parent_np;
+
+	parent_np = of_get_pci_root_bridge_parent(pci_dev);
+	of_dma_configure(dev, parent_np);
+}
+EXPORT_SYMBOL_GPL(of_pci_dma_configure);
+
 #endif /* CONFIG_OF_ADDRESS */
 
 #ifdef CONFIG_PCI_MSI
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index ce0e5ab..0465a2a 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -16,6 +16,8 @@ int of_pci_get_devfn(struct device_node *np);
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
+struct device_node *of_get_pci_root_bridge_parent(struct pci_dev *dev);
+void of_pci_dma_configure(struct pci_dev *pci_dev);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -50,6 +52,16 @@ of_get_pci_domain_nr(struct device_node *node)
 {
 	return -1;
 }
+
+static inline struct device_node
+*of_get_pci_root_bridge_parent(struct pci_dev *dev)
+{
+	return NULL;
+}
+
+static inline void of_pci_dma_configure(struct pci_dev *pci_dev)
+{
+}
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-- 
1.7.9.5
