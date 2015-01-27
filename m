From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 4/8] PCI: add helper functions
	pci_get[put]_host_bridge_device()
Date: Tue, 27 Jan 2015 16:00:01 -0500
Message-ID: <1422392405-32196-5-git-send-email-m-karicheri2@ti.com>
References: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422392405-32196-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add a helper function to get/put the root bus's host bridge device.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
---
 drivers/pci/host-bridge.c |   14 ++++++++++++++
 include/linux/pci.h       |    3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 0e5f3c9..f58e05b 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -23,6 +23,20 @@ static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 	return to_pci_host_bridge(root_bus->bridge);
 }
 
+struct device *pci_get_host_bridge_device(struct pci_dev *dev)
+{
+	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
+	struct device *bridge = root_bus->bridge;
+
+	kobject_get(&bridge->kobj);
+	return bridge;
+}
+
+void  pci_put_host_bridge_device(struct device *dev)
+{
+	kobject_put(&dev->kobj);
+}
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9603094..d677c66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -513,6 +513,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+struct device *pci_get_host_bridge_device(struct pci_dev *dev);
+void pci_put_host_bridge_device(struct device *dev);
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
1.7.9.5
