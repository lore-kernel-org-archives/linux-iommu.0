From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 09/13] PCI: Add pci_peer_traffic_supported()
Date: Tue, 18 Aug 2015 14:04:05 -0500
Message-ID: <1439924649-29698-10-git-send-email-wdavis@nvidia.com>
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
Cc: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Davis <WillDaviswdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Will Davis <Will Davis wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add checks for topology and ACS configuration to determine whether or not
peer traffic should be supported between two PCI devices.

Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/pci.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  3 ++
 2 files changed, 102 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..b8ba0f0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
+#include <linux/iommu.h>
 #include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
 #include "pci.h"
@@ -4302,6 +4303,104 @@ void pci_ignore_hotplug(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 
+bool pci_peer_traffic_supported(struct pci_dev *dev, struct pci_dev *peer)
+{
+	struct pci_host_bridge *dev_host_bridge;
+	struct pci_host_bridge *peer_host_bridge;
+
+	/*
+	 * Disallow the peer-to-peer traffic if the devices do not share a
+	 * host bridge. The PCI specifications does not make any guarantees
+	 * about P2P capabilities between devices under separate domains.
+	 *
+	 * PCI Local Bus Specification Revision 3.0, section 3.10:
+	 *    "Peer-to-peer transactions crossing multiple host bridges
+	 *     PCI host bridges may, but are not required to, support PCI
+	 *     peer-to-peer transactions that traverse multiple PCI host
+	 *     bridges."
+	 */
+	dev_host_bridge = pci_find_host_bridge(dev->bus);
+	peer_host_bridge = pci_find_host_bridge(peer->bus);
+	if (dev_host_bridge != peer_host_bridge)
+		return false;
+
+	if (pci_is_pcie(dev) && pci_is_pcie(peer)) {
+		/*
+		 * Access Control Services (ACS) Checks
+		 *
+		 * ACS has a capability bit for P2P Request Redirects (RR),
+		 * but unfortunately it doesn't tell us much about the real
+		 * capabilities of the hardware.
+		 *
+		 * PCI Express Base Specification Revision 3.0, section
+		 * 6.12.1.1:
+		 *    "ACS P2P Request Redirect: must be implemented by Root
+		 *     Ports that support peer-to-peer traffic with other
+		 *     Root Ports; [80]"
+		 * but
+		 *    "[80] Root Port indication of ACS P2P Request Redirect
+		 *     or ACS P2P Completion Redirect support does not imply
+		 *     any particular level of peer-to-peer support by the
+		 *     Root Complex, or that peer-to-peer traffic is
+		 *     supported at all"
+		 */
+		struct pci_dev *rpdev = dev->bus->self;
+		struct pci_dev *rppeer = peer->bus->self;
+		struct pci_dev *common_upstream;
+		int pos;
+		u16 cap;
+
+		while ((rpdev) && (pci_is_pcie(rpdev)) &&
+		       (pci_pcie_type(rpdev) != PCI_EXP_TYPE_ROOT_PORT))
+			rpdev = rpdev->bus->self;
+
+		while ((rppeer) && (pci_is_pcie(rppeer)) &&
+		       (pci_pcie_type(rppeer) != PCI_EXP_TYPE_ROOT_PORT))
+			rppeer = rppeer->bus->self;
+
+		common_upstream = pci_find_common_upstream_dev(dev, peer);
+
+		/*
+		 * If ACS is not implemented, we have no idea about P2P
+		 * support. Optimistically allow this if there is a common
+		 * upstream device.
+		 */
+		pos = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ACS);
+		if (!pos)
+			return common_upstream != NULL;
+
+		/*
+		 * If the devices are under the same root port and have a common
+		 * upstream device, allow if the root port is further upstream
+		 * from the common upstream device and the common upstream
+		 * device has Upstream Forwarding disabled, or if the root port
+		 * is the common upstream device and ACS is not implemented.
+		 */
+		pci_read_config_word(rpdev, pos + PCI_ACS_CAP, &cap);
+		if ((rpdev == rppeer && common_upstream) &&
+		    (((common_upstream != rpdev) &&
+		      !pci_acs_enabled(common_upstream, PCI_ACS_UF)) ||
+		     ((common_upstream == rpdev) && ((cap & PCI_ACS_RR) == 0))))
+			return true;
+
+		/*
+		 * If ACS RR is implemented and disabled, allow only if the
+		 * devices are under the same root port.
+		 */
+		if (cap & PCI_ACS_RR && !pci_acs_enabled(rpdev, PCI_ACS_RR))
+			return rpdev == rppeer;
+
+		/*
+		 * If ACS RR is not implemented, or is implemented and enabled,
+		 * only allow if there's a translation agent enabled to do the
+		 * redirect.
+		 */
+		return iommu_present(&pci_bus_type);
+	}
+
+	return false;
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8262b9e..46939f7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1914,4 +1914,7 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
 	return bus->self && bus->self->ari_enabled;
 }
+
+bool pci_peer_traffic_supported(struct pci_dev *dev, struct pci_dev *peer);
+
 #endif /* LINUX_PCI_H */
-- 
2.5.0
