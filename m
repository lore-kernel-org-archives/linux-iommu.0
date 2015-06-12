From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 3/6] hw/core/platform-bus: add base_address field
Date: Fri, 12 Jun 2015 16:20:07 +0200
Message-ID: <1434118810-28219-4-git-send-email-b.reynal@virtualopensystems.com>
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
Cc: tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add base_address field to platform_bus structure and initialize it.

As the platform devices addresses are relative to the platform bus, we
need it to get the absolute address of a device.

Signed-off-by: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 hw/arm/virt.c             | 4 ++++
 include/hw/platform-bus.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1b1cc71..33361c5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -740,6 +740,7 @@ static void create_platform_bus(VirtBoardInfo *vbi, qemu_irq *pic)
 {
     DeviceState *dev;
     SysBusDevice *s;
+    PlatformBusDevice *pbus;
     int i;
     ARMPlatformBusFDTParams *fdt_params = g_new(ARMPlatformBusFDTParams, 1);
     MemoryRegion *sysmem = get_system_memory();
@@ -766,6 +767,9 @@ static void create_platform_bus(VirtBoardInfo *vbi, qemu_irq *pic)
         platform_bus_params.platform_bus_size);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
+    pbus = PLATFORM_BUS_DEVICE(dev);
+
+    pbus->base_address = vbi->memmap[VIRT_PLATFORM_BUS].base;
 
     for (i = 0; i < platform_bus_params.platform_bus_num_irqs; i++) {
         int irqn = platform_bus_params.platform_bus_first_irq + i;
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 3c3f96b..13efc82 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -41,6 +41,8 @@ struct PlatformBusDevice {
     bool done_gathering;
 
     /*< public >*/
+    hwaddr base_address;
+
     uint32_t mmio_size;
     MemoryRegion mmio;
 
-- 
2.4.3
