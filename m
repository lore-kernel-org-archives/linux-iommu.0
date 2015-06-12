From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 2/6] hw/core/platform-bus: initialization notifier
Date: Fri, 12 Jun 2015 16:20:06 +0200
Message-ID: <1434118810-28219-3-git-send-email-b.reynal@virtualopensystems.com>
References: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434118810-28219-1-git-send-email-b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
Cc: tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add a platform_bus_link_done_notifier for devices to be notified once
the platform bus is initialized. Address and IRQs for platform devices
are unknown at device realization, we need to notify the device once
the platform bus gathered all devices, i.e. when those resources are
ready. This is required for some device initialization
(e.g. the vSMMU base address needs to be set on the KVM device).

Signed-off-by: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 hw/core/platform-bus.c    | 13 +++++++++++++
 include/hw/platform-bus.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 0f052b3..8642dfc 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -24,6 +24,18 @@
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 
+static NotifierList platform_bus_link_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(platform_bus_link_done_notifiers);
+
+void qemu_add_platform_bus_link_done_notifier(Notifier *notify)
+{
+    notifier_list_add(&platform_bus_link_done_notifiers, notify);
+}
+
+static void qemu_run_platform_bus_link_done_notifiers(void)
+{
+    notifier_list_notify(&platform_bus_link_done_notifiers, NULL);
+}
 
 /*
  * Returns the PlatformBus IRQ number for a SysBusDevice irq number or -1 if
@@ -196,6 +208,7 @@ static void platform_bus_init_notify(Notifier *notifier, void *data)
     plaform_bus_refresh_irqs(pb);
 
     foreach_dynamic_sysbus_device(link_sysbus_device, pb);
+    qemu_run_platform_bus_link_done_notifiers();
 }
 
 static void platform_bus_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index bd42b83..3c3f96b 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -53,5 +53,6 @@ int platform_bus_get_irqn(PlatformBusDevice *platform_bus, SysBusDevice *sbdev,
                           int n);
 hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
                                   int n);
+void qemu_add_platform_bus_link_done_notifier(Notifier *notify);
 
 #endif /* !HW_PLATFORM_BUS_H */
-- 
2.4.3
