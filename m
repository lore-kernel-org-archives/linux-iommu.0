From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 1/9] arm64: mm: change IOMMU notifier action to attach DMA ops
Date: Tue, 28 Jun 2016 16:48:20 +0100
Message-ID: <06d430a86f5d7f461308a9278bf25f40fb50d93c.1467123945.git.robin.murphy@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1467123945.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

Current bus notifier in ARM64 (__iommu_attach_notifier)
attempts to attach dma_ops to a device on BUS_NOTIFY_ADD_DEVICE
action notification.

This will cause issues on ACPI based systems, where PCI devices
can be added before the IOMMUs the devices are attached to
had a chance to be probed, causing failures on attempts to
attach dma_ops in that the domain for the respective IOMMU
may not be set-up yet by the time the bus notifier is run.

Devices dma_ops do not require to be set-up till the matching
device drivers are probed. This means that instead of running
the notifier attaching dma_ops to devices (__iommu_attach_notifier)
on BUS_NOTIFY_ADD_DEVICE action, it can be run just before the
device driver is bound to the device in question (on action
BUS_NOTIFY_BIND_DRIVER) so that it is certain that its IOMMU
group and domain are set-up accordingly at the time the
notifier is triggered.

This patch changes the notifier action upon which dma_ops
are attached to devices and defer it to driver binding time,
so that IOMMU devices have a chance to be probed and to register
their bus notifiers before the dma_ops attach sequence for a
device is actually carried out.

As a result we also no longer need worry about racing with
iommu_bus_notifier(), or about retrying the queue in case devices
were added too early on DT-based systems, so clean up the notifier
itself plus the additional workaround from 722ec35f7fae ("arm64:
dma-mapping: fix handling of devices registered before arch_initcall")

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
[rm: get rid of other now-redundant bits]
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v3: New, co-opted from http://article.gmane.org/gmane.linux.kernel.iommu/13991

 arch/arm64/mm/dma-mapping.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c566ec83719f..e384b76203cc 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -848,15 +848,16 @@ static int __iommu_attach_notifier(struct notifier_block *nb,
 {
 	struct iommu_dma_notifier_data *master, *tmp;
 
-	if (action != BUS_NOTIFY_ADD_DEVICE)
+	if (action != BUS_NOTIFY_BIND_DRIVER)
 		return 0;
 
 	mutex_lock(&iommu_dma_notifier_lock);
 	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
-		if (do_iommu_attach(master->dev, master->ops,
-				master->dma_base, master->size)) {
+		if (data == master->dev && do_iommu_attach(master->dev,
+				master->ops, master->dma_base, master->size)) {
 			list_del(&master->list);
 			kfree(master);
+			break;
 		}
 	}
 	mutex_unlock(&iommu_dma_notifier_lock);
@@ -870,17 +871,8 @@ static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
 
 	if (!nb)
 		return -ENOMEM;
-	/*
-	 * The device must be attached to a domain before the driver probe
-	 * routine gets a chance to start allocating DMA buffers. However,
-	 * the IOMMU driver also needs a chance to configure the iommu_group
-	 * via its add_device callback first, so we need to make the attach
-	 * happen between those two points. Since the IOMMU core uses a bus
-	 * notifier with default priority for add_device, do the same but
-	 * with a lower priority to ensure the appropriate ordering.
-	 */
+
 	nb->notifier_call = __iommu_attach_notifier;
-	nb->priority = -100;
 
 	ret = bus_register_notifier(bus, nb);
 	if (ret) {
@@ -904,10 +896,6 @@ static int __init __iommu_dma_init(void)
 	if (!ret)
 		ret = register_iommu_dma_ops_notifier(&pci_bus_type);
 #endif
-
-	/* handle devices queued before this arch_initcall */
-	if (!ret)
-		__iommu_attach_notifier(NULL, BUS_NOTIFY_ADD_DEVICE, NULL);
 	return ret;
 }
 arch_initcall(__iommu_dma_init);
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
