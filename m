From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] dt: Add general DMA window parser
Date: Wed, 18 Apr 2012 12:19:07 +0200
Message-ID: <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
References: <201204180731.54064.arnd@arndb.de><20120418.121824.1894043789811063795.hdoyu@nvidia.com><20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418092613.GA8632-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

Try again with fixing Thierry's commnets, Thanks.

>From 9a632c24949e46df197a216ca95f684edd1db693 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 18 Apr 2012 12:09:03 +0300
Subject: [PATCH 1/1] dt: Add general DMA window parser

This code was stolen from:
	"arch/microblaze/kernel/prom_parse.c"
	"arch/powerpc/kernel/prom_parse.c"

Once "ibm," prefix is removed from dts file. This generic one could
replace the originals.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/of/Kconfig         |    4 ++++
 drivers/of/Makefile        |    1 +
 drivers/of/of_dma.c        |   35 +++++++++++++++++++++++++++++++++++
 include/linux/of_address.h |   10 ++++++++++
 4 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dfba3e6..3b0298b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -83,4 +83,8 @@ config OF_MTD
 	depends on MTD
 	def_bool y
 
+config OF_DMA
+	depends on HAS_DMA
+	def_bool y
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e027f44..711ff5b 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
+obj-$(CONFIG_OF_DMA)	+= of_dma.o
diff --git a/drivers/of/of_dma.c b/drivers/of/of_dma.c
new file mode 100644
index 0000000..a34db5a
--- /dev/null
+++ b/drivers/of/of_dma.c
@@ -0,0 +1,35 @@
+/*
+ * Stolen from:
+ *	"arch/microblaze/kernel/prom_parse.c"
+ *	"arch/powerpc/kernel/prom_parse.c"
+ */
+
+#include <linux/of_address.h>
+
+void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
+		unsigned long *busno, unsigned long *phys, unsigned long *size)
+{
+	const __be32 *dma_window;
+	u32 cells;
+	const unsigned char *prop;
+
+	dma_window = dma_window_prop;
+
+	/* busno is always one cell */
+	if (busno)
+		*busno = be32_to_cpup(dma_window++);
+
+	prop = of_get_property(dn, "#dma-address-cells", NULL);
+	if (!prop)
+		prop = of_get_property(dn, "#address-cells", NULL);
+
+	cells = prop ? *(__be32 *)prop : of_n_addr_cells(dn);
+	*phys = of_read_number(dma_window, cells);
+
+	dma_window += cells;
+
+	prop = of_get_property(dn, "#dma-size-cells", NULL);
+	cells = prop ? *(__be32 *)prop : of_n_size_cells(dn);
+	*size = of_read_number(dma_window, cells);
+}
+
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 01b925a..2a0f7c6 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -21,6 +21,10 @@ extern void __iomem *of_iomap(struct device_node *device, int index);
 extern const u32 *of_get_address(struct device_node *dev, int index,
 			   u64 *size, unsigned int *flags);
 
+extern void of_parse_dma_window(struct device_node *dn,
+		       const void *dma_window_prop, unsigned long *busno,
+			       unsigned long *phys, unsigned long *size);
+
 #ifndef pci_address_to_pio
 static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 #define pci_address_to_pio pci_address_to_pio
@@ -48,6 +52,12 @@ static inline const u32 *of_get_address(struct device_node *dev, int index,
 {
 	return NULL;
 }
+
+static inline void of_parse_dma_window(struct device_node *dn,
+		       const void *dma_window_prop, unsigned long *busno,
+			       unsigned long *phys, unsigned long *size)
+{
+}
 #endif /* CONFIG_OF_ADDRESS */
 
 
-- 
1.7.5.4
