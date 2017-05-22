From: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 1/3] OF/PCI: Export inbound memory interface to PCI RC drivers.
Date: Mon, 22 May 2017 22:09:40 +0530
Message-ID: <1495471182-12490-2-git-send-email-oza.oza@broadcom.com>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495471182-12490-1-git-send-email-oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The patch exports interface to PCIe RC drivers so that,
Drivers can get their inbound memory configuration.

It provides basis for IOVA reservations for inbound memory
holes, if RC is not capable of addressing all the host memory,
Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
could be allocated.

It handles multiple inbound windows, and returns resources,
and is left to the caller, how it wants to use them.

Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index c9d4d3a..20cf527 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -283,6 +283,102 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
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
+ * This function will parse the "dma-ranges" property of a
+ * PCI host bridge device node and setup the resource mapping based
+ * on its content.
+ *
+ * It returns zero if the range parsing has been successful or a standard error
+ * value if it failed.
+ */
+
+int of_pci_get_dma_ranges(struct device_node *dn, struct list_head *resources)
+{
+	struct device_node *node = of_node_get(dn);
+	int rlen;
+	int pna = of_n_addr_cells(node);
+	const int na = 3, ns = 2;
+	int np = pna + na + ns;
+	int ret = 0;
+	struct resource *res;
+	const u32 *dma_ranges;
+	struct of_pci_range range;
+
+	if (!node)
+		return -EINVAL;
+
+	while (1) {
+		dma_ranges = of_get_property(node, "dma-ranges", &rlen);
+
+		/* Ignore empty ranges, they imply no translation required. */
+		if (dma_ranges && rlen > 0)
+			break;
+
+		/* no dma-ranges, they imply no translation required. */
+		if (!dma_ranges)
+			break;
+
+		node = of_get_next_parent(node);
+
+		if (!node)
+			break;
+	}
+
+	if (!dma_ranges) {
+		pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
+			  dn->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	while ((rlen -= np * 4) >= 0) {
+		range.pci_space = be32_to_cpup((const __be32 *) &dma_ranges[0]);
+		range.pci_addr = of_read_number(dma_ranges + 1, ns);
+		range.cpu_addr = of_translate_dma_address(node,
+							dma_ranges + na);
+		range.size = of_read_number(dma_ranges + pna + na, ns);
+		range.flags = IORESOURCE_MEM;
+
+		dma_ranges += np;
+
+		/*
+		 * If we failed translation or got a zero-sized region
+		 * then skip this range.
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
+		ret = of_pci_range_to_resource(&range, dn, res);
+		if (ret) {
+			kfree(res);
+			continue;
+		}
+
+		pci_add_resource_offset(resources, res,
+					res->start - range.pci_addr);
+	}
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
 
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 518c8d2..0eafe86 100644
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
@@ -83,6 +84,12 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 {
 	return -EINVAL;
 }
+
+static inline int of_pci_get_dma_ranges(struct device_node *np,
+					struct list_head *resources)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
