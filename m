From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 07/13] PCI: Export pci_find_host_bridge()
Date: Tue, 18 Aug 2015 14:04:03 -0500
Message-ID: <1439924649-29698-8-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Return the struct pci_host_bridge corresponding to the given
struct pci_bus.

Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/host-bridge.c | 19 ++-----------------
 include/linux/pci.h       |  7 +++++++
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 5f4a2e0..6c2c82a 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -8,25 +8,10 @@
 
 #include "pci.h"
 
-static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
-{
-	while (bus->parent)
-		bus = bus->parent;
-
-	return bus;
-}
-
-struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
-{
-	struct pci_bus *root_bus = find_pci_root_bus(bus);
-
-	return to_pci_host_bridge(root_bus->bridge);
-}
-
 struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 {
-	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
-	struct device *bridge = root_bus->bridge;
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+	struct device *bridge = &host_bridge->dev;
 
 	kobject_get(&bridge->kobj);
 	return bridge;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..d58063e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -512,6 +512,13 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+static inline struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
+{
+	while (bus->parent)
+		bus = bus->parent;
+	return to_pci_host_bridge(bus->bridge);
+}
+
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
-- 
2.5.0
