From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 3/4] iommu: Add event tracing feature to iommu - amd_iommu driver trace events
Date: Thu, 25 Jul 2013 07:15:04 -0600
Message-ID: <647a953ffac9a572cc580118c6ca27a706b7c4f2.1374711464.git.shuah.kh@samsung.com>
References: <cover.1374711464.git.shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1374711464.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1374711464.git.shuah.kh@samsung.com>
References: <cover.1374711464.git.shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, alex.williamson@redhat.com, Varun.Sethi@freescale.com, aik@ozlabs.ru, joe@perches.com, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, tony@atomide.com, ohad@wizery.com, andreas.herrmann@calxeda.com, will.deacon@arm.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

Add tracing feature to iommu driver to report various iommu events. Classes
iommu_group, iommu_device, iommu_map_unmap, and iommu_amd_event are defined.

iommu_group class events can be enabled to trigger when devices get added
to and removed from an iommu group. Trace information includes iommu group
id and device name.

iommu:add_device_to_group
iommu:remove_device_from_group

iommu_device class events can be enabled to trigger when devices are attached
to and detached from a domain. Trace information includes device name.

iommu:attach_device_to_domain
iommu:detach_device_from_domain

iommu_map_unmap class events can be enabled to trigger when iommu map and
unmap iommu ops complete. Trace information includes iova, physical address
(map event only), and size.

iommu:unmap
iommu:map

iommu_amd_event class can be enabled to trigger when AMD IOMMU driver finds
events when it polls the IOMMU Event Log. Trace information includes the
event string derived from the event type in human friendly form, event type,
id of the domain the device is placed in, device (bus number, slot number,
and function number), address associated with the event, and flags.

iommu:amd_event

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/iommu/amd_iommu.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6dc6594..10ac042 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -42,6 +42,7 @@
 #include <asm/iommu.h>
 #include <asm/gart.h>
 #include <asm/dma.h>
+#include <trace/events/iommu.h>
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
@@ -659,6 +660,8 @@ retry:
 		       "address=0x%016llx flags=0x%04x]\n",
 		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address, flags);
+		trace_amd_event("ILLEGAL_DEV_TABLE_ENTRY", type, domid,
+				      devid, address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_IO_FAULT:
@@ -666,41 +669,57 @@ retry:
 		       "domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       domid, address, flags);
+		trace_amd_event("IO_PAGE_FAULT", type, domid,
+				      devid, address, flags);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
 		printk("DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
 		       "address=0x%016llx flags=0x%04x]\n",
 		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address, flags);
+		trace_amd_event("DEV_TAB_HARDWARE_ERROR", type, domid,
+				      devid, address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
 		printk("PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
 		       "domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       domid, address, flags);
+		trace_amd_event("PAGE_TAB_HARDWARE_ERROR", type, domid,
+				      devid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
 		printk("ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		trace_amd_event("ILLEGAL_COMMAND_ERROR", type, domid,
+				      devid, address, flags);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
 		printk("COMMAND_HARDWARE_ERROR address=0x%016llx "
 		       "flags=0x%04x]\n", address, flags);
+		trace_amd_event("COMMAND_HARDWARE_ERROR", type, domid,
+				      devid, address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
 		printk("IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
 		       "address=0x%016llx]\n",
 		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address);
+		trace_amd_event("IOTLB_INV_TIMEOUT", type, domid,
+				      devid, address, flags);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
 		printk("INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
 		       "address=0x%016llx flags=0x%04x]\n",
 		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 		       address, flags);
+		trace_amd_event("INVALID_DEVICE_REQUEST", type, domid,
+				      devid, address, flags);
 		break;
 	default:
 		printk(KERN_ERR "UNKNOWN type=0x%02x]\n", type);
+		trace_amd_event("UNKNOWN", type, domid,
+				      devid, address, flags);
 	}
 
 	memset(__evt, 0, 4 * sizeof(u32));
-- 
1.7.10.4
