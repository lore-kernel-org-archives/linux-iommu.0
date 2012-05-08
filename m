From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Tue, 8 May 2012 08:09:42 +0200
Message-ID: <20120508.090942.37726149036881660.hdoyu@nvidia.com>
References: <4FA410DD.3090105@wwwdotorg.org><20120507.144758.1558303336683449254.hdoyu@nvidia.com><4FA7F316.7070904@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA7F316.7070904-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Cc: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Mon, 7 May 2012 18:06:46 +0200
Message-ID: <4FA7F316.7070904-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

> On 05/07/2012 05:47 AM, Hiroshi Doyu wrote:
> > Stephen Warren wrote at Fri, 4 May 2012 19:24:45 +0200:
> ...
> >> Perhaps the simplest way is to represent those chunks as separate reg
> >> entries:
> >>
> >>     mc@7000f010 {
> >>         compatible = "nvidia,tegra30-mc";
> >>         reg = <0x7000f010 0x1d4 0x70000228 0xd4>;
> >>     };
> >>
> >>     smmu@0x70000050 {
> >>         compatible = "nvidia,tegra30-smmu";
> >>         reg = <0x70000010 0x2c 0x70000228 0x5c>;
> >>     };
> ...
> > Ok, let's start with the simplest way, and improve later with nice
> > framework.
> 
> Uggh. So that patch is for the SMMU, but this thread is about the GART.
> Also, attaching patches makes it more difficult to review them, since
> them may not appear inline when reading the mail, and certainly don't
> when replying. Anyway...
> 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> 
> > +#include <mach/tegra-ahb.h>
> 
> Note that this patch therefor depends on the AHB series that you just
> posted, and isn't applied anywhere yet.
> 
> > +static int get_reg_bank(u32 offset)
> >  {
> > -	writel(val, smmu->regs + offs);
> > +	int i;
> > +	const struct smmu_reg_bank {
> > +		u32 start;
> > +		size_t size;
> > +	} r[] = {
> > +		{
> > +			.start = 0x10,
> > +			.size = 0x2c,
> > +		},
> > +		{
> > +			.start = 0x1f0,
> > +			.size = 0x10,
> > +		},
> > +		{
> > +			.start = 0x228,
> > +			.size = 0x5c,
> > +		},
> > +	};
> > +
> > +	for (i = 0; i < ARRAY_SIZE(r); i++) {
> > +		BUG_ON(offset < r[i].start);
> > +		if (offset < r[i].start + r[i].size)
> > +			return i;
> > +	}
> > +	BUG();
> > +	return 0; /* Never reach here */
> >  }
> 
> While stylistically nice, I'm not sure that will be as likely to
> optimize out as the simple if/else code I gave as an example. I suppose
> it's not a big deal though.
> 
> >  static int tegra_smmu_probe(struct platform_device *pdev)
> 
> > +	err = of_get_dma_window(dev->of_node, "dma-window", 0, NULL,
> > +				&base, &size);
> 
> So this also relies on the generic DMA window parsing patch too. I don't
> think that's checked in anywhere yet right?

Hi Grant and Rob,

Any chance to reivew the following patch?

  http://article.gmane.org/gmane.linux.ports.tegra/4603

Attached the same one as below.

>From e9975c75f3de6902b2e76f3ad69f62bb85f3d684 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 18 Apr 2012 12:09:03 +0300
Subject: [PATCH 1/1] dt: Add general DMA window parser

This code was based on:
	"arch/microblaze/kernel/prom_parse.c"
	"arch/powerpc/kernel/prom_parse.c"

"ibm," prefix could be supported with some modification.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 drivers/of/Kconfig         |    4 ++
 drivers/of/Makefile        |    1 +
 drivers/of/of_dma.c        |   70 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_address.h |   13 ++++++++
 4 files changed, 88 insertions(+), 0 deletions(-)

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
index 0000000..a89fe61
--- /dev/null
+++ b/drivers/of/of_dma.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Based on:
+ *	"arch/microblaze/kernel/prom_parse.c"
+ *	"arch/powerpc/kernel/prom_parse.c"
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/export.h>
+#include <linux/of_address.h>
+
+int of_get_dma_window(struct device_node *dn,
+			const char *propname, int index,
+			unsigned long *busno,
+			dma_addr_t *addr, size_t *size)
+{
+	const __be32 *dma_window, *end;
+	int bytes, cur_index = 0;
+
+	if (!dn || !addr || !size)
+		return -EINVAL;
+
+	if (!propname)
+		propname = "dma-window";
+
+	dma_window = of_get_property(dn, propname, &bytes);
+	if (!dma_window)
+		return -ENODEV;
+	end = dma_window + bytes / sizeof(*dma_window);
+
+	while (dma_window < end) {
+		u32 cells;
+		const void *prop;
+
+		/* busno is always one cell */
+		if (busno)
+			*busno = be32_to_cpup(dma_window++);
+
+		prop = of_get_property(dn, "#dma-address-cells", NULL);
+		if (!prop)
+			prop = of_get_property(dn, "#address-cells", NULL);
+
+		cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
+		if (!cells)
+			return -EINVAL;
+		*addr = of_read_number(dma_window, cells);
+		dma_window += cells;
+
+		prop = of_get_property(dn, "#dma-size-cells", NULL);
+		cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
+		if (!cells)
+			return -EINVAL;
+		*size = of_read_number(dma_window, cells);
+		dma_window += cells;
+
+		if (cur_index++ == index)
+			break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(of_get_dma_window);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 01b925a..9d9da9d 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -21,6 +21,11 @@ extern void __iomem *of_iomap(struct device_node *device, int index);
 extern const u32 *of_get_address(struct device_node *dev, int index,
 			   u64 *size, unsigned int *flags);
 
+extern int of_get_dma_window(struct device_node *dev,
+			       const char *propname, int index,
+			       unsigned long *busno,
+			       dma_addr_t *phys, size_t *size);
+
 #ifndef pci_address_to_pio
 static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 #define pci_address_to_pio pci_address_to_pio
@@ -48,6 +53,14 @@ static inline const u32 *of_get_address(struct device_node *dev, int index,
 {
 	return NULL;
 }
+
+extern int of_get_dma_window(struct device_node *dev,
+			       const char *propname, int index,
+			       unsigned long *busno,
+			       dma_addr_t *phys, size_t *size)
+{
+	return 0;
+}
 #endif /* CONFIG_OF_ADDRESS */
 
 
-- 
1.7.5.4
