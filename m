From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [RESEND PATCH v2 3/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have
	capability of IRQ remapping
Date: Thu,  2 Jun 2016 14:10:00 +0800
Message-ID: <1464847803-22756-4-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464847803-22756-1-git-send-email-xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The capability of IRQ remapping is abstracted on IOMMU side on
some archs. There is a existing flag IOMMU_CAP_INTR_REMAP for this.

To have a universal flag to test this capability for different
archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
when IOMMU_CAP_INTR_REMAP is set.

Signed-off-by: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 drivers/pci/probe.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2b9e3ba..15a33e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -16,6 +16,7 @@
 #include <linux/aer.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
+#include <linux/iommu.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -2160,6 +2161,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	pci_set_bus_of_node(b);
 	pci_set_bus_msi_domain(b);
 
+	if (iommu_capable(&pci_bus_type, IOMMU_CAP_INTR_REMAP))
+		b->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+
 	if (!parent)
 		set_dev_node(b->bridge, pcibus_to_node(b));
 
-- 
1.7.9.5
