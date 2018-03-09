From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] iommu/amd - Use dev_err to send events to the system log
Date: Thu, 08 Mar 2018 18:34:41 -0600
Message-ID: <152055568151.107515.8442872081731932876.stgit@sosxen2.amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Remove printk and use a more preferable error logging function.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   55 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7389cc15d97a..7f4e82aed6a0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -547,6 +547,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
+	struct device *dev = iommu->iommu.dev;
 	int type, devid, domid, flags;
 	volatile u32 *event = __evt;
 	int count = 0;
@@ -573,53 +574,53 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		amd_iommu_report_page_fault(devid, domid, address, flags);
 		return;
 	} else {
-		printk(KERN_ERR "AMD-Vi: Event logged [");
+		dev_err(dev, "AMD-Vi: Event logged [");
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		printk("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
-		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address, flags);
+		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
+			"address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		printk("DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address, flags);
+		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+			"address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		printk("PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-		       "domain=0x%04x address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       domid, address, flags);
+		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+			"domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			domid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
-		printk("ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		printk("COMMAND_HARDWARE_ERROR address=0x%016llx "
-		       "flags=0x%04x]\n", address, flags);
+		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx "
+			"flags=0x%04x]\n", address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		printk("IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
-		       "address=0x%016llx]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address);
+		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
+			"address=0x%016llx]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		printk("INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
-		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address, flags);
+		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
+			"address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address, flags);
 		break;
 	default:
-		printk(KERN_ERR "UNKNOWN type=0x%02x event[0]=0x%08x "
-		       "event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
-		       type, event[0], event[1], event[2], event[3]);
+		dev_err(dev, KERN_ERR "UNKNOWN event[0]=0x%08x event[1]=0x%08x "
+			"event[2]=0x%08x event[3]=0x%08x\n",
+			event[0], event[1], event[2], event[3]);
 	}
 
 	memset(__evt, 0, 4 * sizeof(u32));
