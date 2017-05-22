From: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 2/3] PCI: Add support for PCI inbound windows resources
Date: Mon, 22 May 2017 22:09:41 +0530
Message-ID: <1495471182-12490-3-git-send-email-oza.oza@broadcom.com>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495471182-12490-1-git-send-email-oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for inbound memory window
for PCI RC drivers.

It defines new function pci_create_root_bus2 which
takes inbound resources as an argument and fills in the
memory resource to PCI internal host bridge structure
as inbound_windows.

Legacy RC driver could continue to use pci_create_root_bus,
but any RC driver who wants to reseve IOVAS for their
inbound memory holes, should use new API pci_create_root_bus2.

Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..a95b9bb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -531,6 +531,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->inbound_windows);
 
 	return bridge;
 }
@@ -726,6 +727,7 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *b;
 	resource_size_t offset;
 	LIST_HEAD(resources);
+	LIST_HEAD(inbound_resources);
 	struct resource *res;
 	char addr[64], *fmt;
 	const char *name;
@@ -739,6 +741,8 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	/* temporarily move resources off the list */
 	list_splice_init(&bridge->windows, &resources);
+	list_splice_init(&bridge->inbound_windows, &inbound_resources);
+
 	bus->sysdata = bridge->sysdata;
 	bus->msi = bridge->msi;
 	bus->ops = bridge->ops;
@@ -794,6 +798,10 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	else
 		pr_info("PCI host bridge to bus %s\n", name);
 
+	/* Add inbound mem resource. */
+	resource_list_for_each_entry_safe(window, n, &inbound_resources)
+		list_move_tail(&window->node, &bridge->inbound_windows);
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		list_move_tail(&window->node, &bridge->windows);
@@ -2300,7 +2308,8 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 
 static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata,
-		struct list_head *resources, struct msi_controller *msi)
+		struct list_head *resources, struct list_head *in_res,
+		struct msi_controller *msi)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -2313,6 +2322,9 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	list_splice_init(resources, &bridge->windows);
+	if (in_res)
+		list_splice_init(in_res, &bridge->inbound_windows);
+
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
@@ -2329,11 +2341,20 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	return NULL;
 }
 
+struct pci_bus *pci_create_root_bus2(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources,
+		struct list_head *in_res)
+{
+	return pci_create_root_bus_msi(parent, bus, ops, sysdata,
+				       resources, in_res, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_create_root_bus2);
+
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
-	return pci_create_root_bus_msi(parent, bus, ops, sysdata, resources,
-				       NULL);
+	return pci_create_root_bus_msi(parent, bus, ops, sysdata,
+				       resources, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
@@ -2415,7 +2436,8 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 			break;
 		}
 
-	b = pci_create_root_bus_msi(parent, bus, ops, sysdata, resources, msi);
+	b = pci_create_root_bus_msi(parent, bus, ops, sysdata,
+				    resources, NULL, msi);
 	if (!b)
 		return NULL;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33c2b0b..d2df107 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -432,6 +432,7 @@ struct pci_host_bridge {
 	void *sysdata;
 	int busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head inbound_windows;	/* inbound memory */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	struct msi_controller *msi;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
