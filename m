From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v2 3/4] iommu/amd: Remove local PCI_BUS() define and use
	PCI_BUS_NUM() from pci
Date: Wed, 27 Feb 2013 17:07:19 -0700
Message-ID: <1362010039.2808.36.camel@lorien2>
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

Change to remove local PCI_BUS() define and use the new PCI_BUS_NUM()
interface from pci.

Signed-off-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |   12 ++++++------
 drivers/iommu/amd_iommu_init.c  |   34 +++++++++++++++++-----------------
 drivers/iommu/amd_iommu_types.h |    4 +---
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98f555d..2a50fbe 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -649,26 +649,26 @@ retry:
 	case EVENT_TYPE_ILL_DEV:
 		printk("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
 		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_IO_FAULT:
 		printk("IO_PAGE_FAULT device=%02x:%02x.%x "
 		       "domain=0x%04x address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       domid, address, flags);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
 		printk("DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
 		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
 		printk("PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
 		       "domain=0x%04x address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       domid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
@@ -682,13 +682,13 @@ retry:
 	case EVENT_TYPE_IOTLB_INV_TO:
 		printk("IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
 		       "address=0x%016llx]\n",
-		       PCI_BUS(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
 		printk("INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
 		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address, flags);
 		break;
 	default:
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b6ecddb..f8ed6f1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -423,7 +423,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 	p += sizeof(*h);
 	end += h->length;
 
-	find_last_devid_on_pci(PCI_BUS(h->devid),
+	find_last_devid_on_pci(PCI_BUS_NUM(h->devid),
 			PCI_SLOT(h->devid),
 			PCI_FUNC(h->devid),
 			h->cap_ptr);
@@ -784,10 +784,10 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_ALL\t\t\t first devid: %02x:%02x.%x"
 				    " last device %02x:%02x.%x flags: %02x\n",
-				    PCI_BUS(iommu->first_device),
+				    PCI_BUS_NUM(iommu->first_device),
 				    PCI_SLOT(iommu->first_device),
 				    PCI_FUNC(iommu->first_device),
-				    PCI_BUS(iommu->last_device),
+				    PCI_BUS_NUM(iommu->last_device),
 				    PCI_SLOT(iommu->last_device),
 				    PCI_FUNC(iommu->last_device),
 				    e->flags);
@@ -801,7 +801,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_SELECT\t\t\t devid: %02x:%02x.%x "
 				    "flags: %02x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -813,7 +813,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_SELECT_RANGE_START\t "
 				    "devid: %02x:%02x.%x flags: %02x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -827,11 +827,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_ALIAS\t\t\t devid: %02x:%02x.%x "
 				    "flags: %02x devid_to: %02x:%02x.%x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags,
-				    PCI_BUS(e->ext >> 8),
+				    PCI_BUS_NUM(e->ext >> 8),
 				    PCI_SLOT(e->ext >> 8),
 				    PCI_FUNC(e->ext >> 8));
 
@@ -846,11 +846,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
 				    "devid: %02x:%02x.%x flags: %02x "
 				    "devid_to: %02x:%02x.%x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags,
-				    PCI_BUS(e->ext >> 8),
+				    PCI_BUS_NUM(e->ext >> 8),
 				    PCI_SLOT(e->ext >> 8),
 				    PCI_FUNC(e->ext >> 8));
 
@@ -864,7 +864,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %02x:%02x.%x "
 				    "flags: %02x ext: %08x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -877,7 +877,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
 				    "%02x:%02x.%x flags: %02x ext: %08x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -890,7 +890,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_RANGE_END:
 
 			DUMP_printk("  DEV_RANGE_END\t\t devid: %02x:%02x.%x\n",
-				    PCI_BUS(e->devid),
+				    PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
 
@@ -924,7 +924,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %02x:%02x.%x\n",
 				    var, (int)handle,
-				    PCI_BUS(devid),
+				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
@@ -1086,7 +1086,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 
 			DUMP_printk("device: %02x:%02x.%01x cap: %04x "
 				    "seg: %d flags: %01x info %04x\n",
-				    PCI_BUS(h->devid), PCI_SLOT(h->devid),
+				    PCI_BUS_NUM(h->devid), PCI_SLOT(h->devid),
 				    PCI_FUNC(h->devid), h->cap_ptr,
 				    h->pci_seg, h->flags, h->info);
 			DUMP_printk("       mmio-addr: %016llx\n",
@@ -1116,7 +1116,7 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	int cap_ptr = iommu->cap_ptr;
 	u32 range, misc, low, high;
 
-	iommu->dev = pci_get_bus_and_slot(PCI_BUS(iommu->devid),
+	iommu->dev = pci_get_bus_and_slot(PCI_BUS_NUM(iommu->devid),
 					  iommu->devid & 0xff);
 	if (!iommu->dev)
 		return -ENODEV;
@@ -1388,8 +1388,8 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 
 	DUMP_printk("%s devid_start: %02x:%02x.%x devid_end: %02x:%02x.%x"
 		    " range_start: %016llx range_end: %016llx flags: %x\n", s,
-		    PCI_BUS(e->devid_start), PCI_SLOT(e->devid_start),
-		    PCI_FUNC(e->devid_start), PCI_BUS(e->devid_end),
+		    PCI_BUS_NUM(e->devid_start), PCI_SLOT(e->devid_start),
+		    PCI_FUNC(e->devid_start), PCI_BUS_NUM(e->devid_end),
 		    PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
 		    e->address_start, e->address_end, m->flags);
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e38ab43..a07882f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -315,9 +316,6 @@
 
 #define MAX_DOMAIN_ID 65536
 
-/* FIXME: move this macro to <linux/pci.h> */
-#define PCI_BUS(x) (((x) >> 8) & 0xff)
-
 /* Protection domain flags */
 #define PD_DMA_OPS_MASK		(1UL << 0) /* domain used for dma_ops */
 #define PD_DEFAULT_MASK		(1UL << 1) /* domain is a default dma_ops
-- 
1.7.9.5
