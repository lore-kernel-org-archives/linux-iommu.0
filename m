From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/7] of/irq: Break out msi-map lookup (again)
Date: Fri,  3 Jun 2016 18:15:38 +0100
Message-ID: <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The PCI msi-map code is already doing double-duty translating IDs and
retrieving MSI parents, which unsurprisingly is the same functionality
we need for the identically-formatted PCI iommu-map property. Drag the
core parsing routine up yet another layer into the general OF-PCI code,
and further generalise it for either kind of lookup in either flavour
of map property.

CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: No change.

 drivers/of/irq.c       |  70 ++-------------------------------
 drivers/of/of_pci.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h |   8 ++++
 3 files changed, 114 insertions(+), 66 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e7bfc175b8e1..0c9118d849ee 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_pci.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -586,13 +587,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 			    u32 rid_in)
 {
 	struct device *parent_dev;
-	struct device_node *msi_controller_node;
-	struct device_node *msi_np = *np;
-	u32 map_mask, masked_rid, rid_base, msi_base, rid_len, phandle;
-	int msi_map_len;
-	bool matched;
 	u32 rid_out = rid_in;
-	const __be32 *msi_map = NULL;
 
 	/*
 	 * Walk up the device parent links looking for one with a
@@ -602,71 +597,14 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 		if (!parent_dev->of_node)
 			continue;
 
-		msi_map = of_get_property(parent_dev->of_node,
-					  "msi-map", &msi_map_len);
-		if (!msi_map)
+		if (!of_property_read_bool(parent_dev->of_node, "msi-map"))
 			continue;
 
-		if (msi_map_len % (4 * sizeof(__be32))) {
-			dev_err(parent_dev, "Error: Bad msi-map length: %d\n",
-				msi_map_len);
-			return rid_out;
-		}
 		/* We have a good parent_dev and msi_map, let's use them. */
+		of_pci_map_rid(parent_dev->of_node, "msi-map", rid_in, np,
+			       &rid_out);
 		break;
 	}
-	if (!msi_map)
-		return rid_out;
-
-	/* The default is to select all bits. */
-	map_mask = 0xffffffff;
-
-	/*
-	 * Can be overridden by "msi-map-mask" property.  If
-	 * of_property_read_u32() fails, the default is used.
-	 */
-	of_property_read_u32(parent_dev->of_node, "msi-map-mask", &map_mask);
-
-	masked_rid = map_mask & rid_in;
-	matched = false;
-	while (!matched && msi_map_len >= 4 * sizeof(__be32)) {
-		rid_base = be32_to_cpup(msi_map + 0);
-		phandle = be32_to_cpup(msi_map + 1);
-		msi_base = be32_to_cpup(msi_map + 2);
-		rid_len = be32_to_cpup(msi_map + 3);
-
-		if (rid_base & ~map_mask) {
-			dev_err(parent_dev,
-				"Invalid msi-map translation - msi-map-mask (0x%x) ignores rid-base (0x%x)\n",
-				map_mask, rid_base);
-			return rid_out;
-		}
-
-		msi_controller_node = of_find_node_by_phandle(phandle);
-
-		matched = (masked_rid >= rid_base &&
-			   masked_rid < rid_base + rid_len);
-		if (msi_np)
-			matched &= msi_np == msi_controller_node;
-
-		if (matched && !msi_np) {
-			*np = msi_np = msi_controller_node;
-			break;
-		}
-
-		of_node_put(msi_controller_node);
-		msi_map_len -= 4 * sizeof(__be32);
-		msi_map += 4;
-	}
-	if (!matched)
-		return rid_out;
-
-	rid_out = masked_rid - rid_base + msi_base;
-	dev_dbg(dev,
-		"msi-map at: %s, using mask %08x, rid-base: %08x, msi-base: %08x, length: %08x, rid: %08x -> %08x\n",
-		dev_name(parent_dev), map_mask, rid_base, msi_base,
-		rid_len, rid_in, rid_out);
-
 	return rid_out;
 }
 
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 13f4fed38048..20bf5a0c57fd 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -306,3 +306,105 @@ struct msi_controller *of_pci_find_msi_chip_by_node(struct device_node *of_node)
 EXPORT_SYMBOL_GPL(of_pci_find_msi_chip_by_node);
 
 #endif /* CONFIG_PCI_MSI */
+
+#define MASK_NAME_LEN	32	/* Safely longer than "iommu-map-mask" */
+
+/**
+ * of_pci_map_rid - Translate a requester ID through a downstream mapping.
+ * @np: root complex device node.
+ * @map_name: property name of the map to use.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Given a PCI requester ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. @target or @id_out may
+ * be NULL if not required. If @target points to a device node pointer, only
+ * entries targeting that node will be matched; if it points to a NULL
+ * value, it will receive the device node for the first matching target entry,
+ * with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_pci_map_rid(struct device_node *np, const char *map_name, u32 rid_in,
+		   struct device_node **target, u32 *rid_out)
+{
+	u32 map_mask, masked_rid;
+	int map_len;
+	const __be32 *map = NULL;
+	char mask_name[MASK_NAME_LEN];
+
+	if (!np || !map_name || (!target && !rid_out))
+		return -EINVAL;
+
+	map = of_get_property(np, map_name, &map_len);
+	if (!map) {
+		if (target)
+			return -ENODEV;
+		/* Otherwise, no map implies no translation */
+		*rid_out = rid_in;
+		return 0;
+	}
+
+	if (!map_len || map_len % (4 * sizeof(*map))) {
+		pr_err("%s: Error: Bad %s length: %d\n", np->full_name,
+			map_name, map_len);
+		return -EINVAL;
+	}
+
+	/* The default is to select all bits. */
+	map_mask = 0xffffffff;
+
+	/*
+	 * Can be overridden by "{iommu,msi}-map-mask" property.
+	 * If of_property_read_u32() fails, the default is used.
+	 */
+	snprintf(mask_name, MASK_NAME_LEN, "%s-mask", map_name);
+	of_property_read_u32(np, mask_name, &map_mask);
+
+	masked_rid = map_mask & rid_in;
+	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+		struct device_node *phandle_node;
+		u32 rid_base = be32_to_cpup(map + 0);
+		u32 phandle = be32_to_cpup(map + 1);
+		u32 out_base = be32_to_cpup(map + 2);
+		u32 rid_len = be32_to_cpup(map + 3);
+
+		if (rid_base & ~map_mask) {
+			pr_err("%s: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+				np->full_name, map_name, map_name,
+				map_mask, rid_base);
+			return -EINVAL;
+		}
+
+		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+			continue;
+
+		phandle_node = of_find_node_by_phandle(phandle);
+		if (!phandle_node)
+			return -ENODEV;
+
+		if (target) {
+			if (*target)
+				of_node_put(phandle_node);
+			else
+				*target = phandle_node;
+
+			if (*target != phandle_node)
+				continue;
+		}
+
+		if (rid_out)
+			*rid_out = masked_rid - rid_base + out_base;
+
+		pr_debug("%s: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
+			np->full_name, map_name, map_mask, rid_base, out_base,
+			rid_len, rid_in, *rid_out);
+		return 0;
+	}
+
+	pr_err("%s: Invalid %s translation - no match for rid 0x%x on %s\n",
+		np->full_name, map_name, rid_in,
+		target && *target ? (*target)->full_name : "any target");
+	return -EINVAL;
+}
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index f6e9e85164e8..070f8835780b 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -17,6 +17,8 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 void of_pci_check_probe_only(void);
+int of_pci_map_rid(struct device_node *np, const char *map_name, u32 rid_in,
+		   struct device_node **target, u32 *rid_out);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -52,6 +54,12 @@ of_get_pci_domain_nr(struct device_node *node)
 	return -1;
 }
 
+static inline int of_pci_map_rid(struct device_node *np, const char *map_name,
+			u32 rid_in, struct device_node **target, u32 *rid_out)
+{
+	return -EINVAL;
+}
+
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
