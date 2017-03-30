From: Oza Pawandeep via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [RFC PATCH 1/2] of/pci: implement inbound dma-ranges for PCI
Date: Thu, 30 Mar 2017 15:29:45 +0530
Message-ID: <1490867986-5675-1-git-send-email-oza.oza@broadcom.com>
Reply-To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

current device frmework and of framework integration assumes dma-ranges
in a way where memory-mapped devices define their dma-ranges.
dma-ranges: (child-bus-address, parent-bus-address, length).

but iproc based SOCs and other SOCs(rcar) have PCI world dma-ranges.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;

of_dma_configure is specifically witten to take care of memory mapped devices.
but no implementation exists for pci to take care of pcie based memory ranges.
in fact pci world doesnt seem to define standard dma-ranges

this exposes intrface not only to the pci host driver, but also
it aims to provide an interface to callers such as of_dma_configure.
so then the returned size get best possible (largest) dma_mask.
for e.g.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
we should get dev->coherent_dma_mask=0x7fffffffff.

also this patch intends to handle multiple inbound windows and dma-ranges.
it is left to the caller, how it wants to use them.

Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 0ee42c3..5299438 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -283,6 +283,80 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
+/**
+ * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
+ * @np: device node of the host bridge having the dma-ranges property
+ * @resources: list where the range of resources will be added after DT parsing
+ *
+ * It is the caller's job to free the @resources list.
+ *
+ * This function will parse the "dma-ranges" property of a PCI host bridge device
+ * node and setup the resource mapping based on its content.
+ *
+ * It returns zero if the range parsing has been successful or a standard error
+ * value if it failed.
+ */
+
+int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources)
+{
+	struct device_node *node = of_node_get(np);
+	int rlen;
+	int ret = 0;
+	const int na = 3, ns = 2;
+	struct resource *res;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+
+	if (!node)
+		return -EINVAL;
+
+	parser.node = node;
+	parser.pna = of_n_addr_cells(node);
+	parser.np = parser.pna + na + ns;
+
+	parser.range = of_get_property(node, "dma-ranges", &rlen);
+
+	if (!parser.range) {
+		pr_debug("pcie device has no dma-ranges defined for node(%s)\n", np->full_name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	parser.end = parser.range + rlen / sizeof(__be32);
+
+	for_each_of_pci_range(&parser, &range) {
+		/*
+		 * If we failed translation or got a zero-sized region
+		 * then skip this range
+		 */
+		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
+			continue;
+
+		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		if (!res) {
+			ret = -ENOMEM;
+			goto parse_failed;
+		}
+
+		ret = of_pci_range_to_resource(&range, np, res);
+		if (ret) {
+			kfree(res);
+			continue;
+		}
+
+		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
+        }
+
+	return ret;
+
+parse_failed:
+	pci_free_resource_list(resources);
+out:
+	of_node_put(node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
 #endif /* CONFIG_OF_ADDRESS */
 
 #ifdef CONFIG_PCI_MSI
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 0e0974e..8509e3d 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }
 int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
+int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources);
 #else
 static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
@@ -83,6 +84,11 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 {
 	return -EINVAL;
 }
+
+static inline int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
-- 
1.9.1
