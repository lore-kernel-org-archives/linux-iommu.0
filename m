From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v2 1/4] pci: Add PCI_BUS_NUM() and PCI_DEVID() interfaces to
	return bus number and device id
Date: Wed, 27 Feb 2013 17:06:45 -0700
Message-ID: <1362010005.2808.34.camel@lorien2>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: jiang.liu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org, paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linasvepstas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

pci defines PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() interfaces, however,
it doesn't have interfaces to return PCI bus and PCI device id. Drivers
(AMD IOMMU, and AER) implement module specific definitions for PCI_BUS()
and AMD_IOMMU driver also has a module specific interface to calculate PCI
device id from bus number and devfn.

Add PCI_BUS_NUM and PCI_DEVID interfaces to return PCI bus number and PCI
device id respectively to avoid the need for duplicate definitions in other
modules. AER driver code and AMD IOMMU driver define PCI_BUS. AMD IOMMU driver
defines an interface to calculate device id from bus number, and devfn pair.

PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() interfaces are exported to user-space
via uapi/linux/pci.h. However, in the interest to keep the new interfaces as
kernel only and not export them to user-space unnecessarily, added them to
linux/pci.h instead.

Signed-off-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
---
 include/linux/pci.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 15472d6..95c105a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -35,6 +35,21 @@
 /* Include the ID list */
 #include <linux/pci_ids.h>
 
+/*
+ * The PCI interface treats multi-function devices as independent
+ * devices.  The slot/function address of each device is encoded
+ * in a single byte as follows:
+ *
+ *	7:3 = slot
+ *	2:0 = function
+ * PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() are defined uapi/linux/pci.h
+ * In the interest of not exposing interfaces to user-space unnecessarily,
+ * the following kernel only defines are being added here.
+ */
+#define PCI_DEVID(bus, devfn)  ((((u16)bus) << 8) | devfn)
+/* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
+#define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus *bus;		/* The bus this slot is on */
-- 
1.7.9.5
