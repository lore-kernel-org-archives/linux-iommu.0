From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/5] iommu/tegra: smmu: Add DMA window parser, of_get_dma_window()
Date: Wed, 20 Jun 2012 10:16:56 +0300
Message-ID: <1340176620-13012-1-git-send-email-hdoyu@nvidia.com>
References: <20120521124707.GC2604@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120521124707.GC2604-5C7GfCeVMHo@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This code was based on:
    "arch/microblaze/kernel/prom_parse.c"
    "arch/powerpc/kernel/prom_parse.c"

Can be promoted as a global function for general use to replace
"of_parse_dma_window()" in the above. This supports different formats
flexibly. "prefix" can be configured if any. "busno" and "index" are
optionally specified. Set NULL and 0 if not used.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Based on the discussion:
http://marc.info/?l=linux-tegra&m=133732046606458&w=2
---
 drivers/iommu/tegra-smmu.c |   70 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ecd6790..6f87ae4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/iommu.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
@@ -858,6 +859,75 @@ static struct iommu_ops smmu_iommu_ops = {
 	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
 };
 
+/**
+ * of_get_dma_window - Parse *dma-window property and returns 0 if found.
+ *
+ * @dn: device node
+ * @prefix: prefix for property name if any
+ * @index: index to start to parse
+ * @busno: Returns busno if supported. Otherwise pass NULL
+ * @addr: Returns address that DMA starts
+ * @size: Returns the range that DMA can handle
+ *
+ * This supports different formats flexibly. "prefix" can be
+ * configured if any. "busno" and "index" are optionally
+ * specified. Set 0(or NULL) if not used.
+ */
+static int of_get_dma_window(struct device_node *dn,
+			const char *prefix, int index,
+			unsigned long *busno,
+			dma_addr_t *addr, size_t *size)
+{
+	const __be32 *dma_window, *end;
+	int bytes, cur_index = 0;
+	char propname[NAME_MAX], addrname[NAME_MAX], sizename[NAME_MAX];
+	const char *s = "";
+
+	if (!dn || !addr || !size)
+		return -EINVAL;
+
+	if (prefix)
+		s = prefix;
+	snprintf(propname, sizeof(propname), "%sdma-window", s);
+	snprintf(addrname, sizeof(addrname), "%s#dma-address-cells", s);
+	snprintf(sizename, sizeof(sizename), "%s#dma-size-cells", s);
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
+		/* busno is one cell if supported */
+		if (busno)
+			*busno = be32_to_cpup(dma_window++);
+
+		prop = of_get_property(dn, addrname, NULL);
+		if (!prop)
+			prop = of_get_property(dn, "#address-cells", NULL);
+
+		cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
+		if (!cells)
+			return -EINVAL;
+		*addr = of_read_number(dma_window, cells);
+		dma_window += cells;
+
+		prop = of_get_property(dn, sizename, NULL);
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
+
 static int tegra_smmu_suspend(struct device *dev)
 {
 	struct smmu_device *smmu = dev_get_drvdata(dev);
-- 
1.7.5.4
