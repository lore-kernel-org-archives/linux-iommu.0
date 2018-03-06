From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Subject: [RFC 4/5] iommu/of: Reserve IOMMU DMA regions using DT
Date: Tue,  6 Mar 2018 10:29:27 +0530
Message-ID: <1520312368-7068-5-git-send-email-jitendra.bhivare@broadcom.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

iPROC SoC provides restricted windows to access sparsed memory as per ARM
memory map to the devices sitting behind IOMMU. The windows cover enough
DDR space but not the entire 40-bit 1TB space used by IOMMU code as per
the DMA mask set.

Current IOMMU code does not provide a hook to reserve these holes. Use
defined but unused of_get_dma_window to get reserved DMA regions from DT.

To reserve the regions for IOVA allocation, ranges can be specified in DT
as <busno prot bus_addr size>. These regions are marked as
IOMMU_RESV_RESERVED when device behind SMMU gets added and
arm_smmu_get_resv_regions gets called.

This provision is also used in reserving region for GICv3 ITS using
IOMMU_RESV_DIRECT as it falls in special device window.

Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
---
 drivers/iommu/dma-iommu.c |   6 +++
 drivers/iommu/of_iommu.c  | 100 ++++++++++++++++++++++++----------------------
 include/linux/iommu.h     |   3 ++
 include/linux/of_iommu.h  |  25 +++++++++---
 4 files changed, 81 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 25914d3..433d427 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -173,6 +174,7 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
+	struct device_node *np;
 
 	if (!dev_is_pci(dev))
 		return;
@@ -195,6 +197,10 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 
 		list_add_tail(&region->list, list);
 	}
+	/* check platform device representing bridge for reserved DMA windows */
+	np = bridge->dev.parent->of_node;
+	if (np)
+		of_iommu_resv_dma_regions(np, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 50947eb..cebcbaa 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -31,72 +31,78 @@ static const struct of_device_id __iommu_of_table_sentinel
 	__used __section(__iommu_of_table_end);
 
 /**
- * of_get_dma_window - Parse *dma-window property and returns 0 if found.
+ * of_get_resv_region - Parse reserved-*-region property and returns 0 if found.
  *
  * @dn: device node
- * @prefix: prefix for property name if any
+ * @region: region for property name if any
  * @index: index to start to parse
- * @busno: Returns busno if supported. Otherwise pass NULL
- * @addr: Returns address that DMA starts
- * @size: Returns the range that DMA can handle
+ * @of_region: returns read of_iommu_resv_region <busno prot bus_addr size>
  *
- * This supports different formats flexibly. "prefix" can be
- * configured if any. "busno" and "index" are optionally
- * specified. Set 0(or NULL) if not used.
+ * This supports different formats using "region" configured if any.
  */
-int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
-		      unsigned long *busno, dma_addr_t *addr, size_t *size)
+int of_get_resv_region(struct device_node *dn, const char *region, int *index,
+		      struct of_iommu_resv_region *of_region)
 {
-	const __be32 *dma_window, *end;
-	int bytes, cur_index = 0;
-	char propname[NAME_MAX], addrname[NAME_MAX], sizename[NAME_MAX];
+	char propname[NAME_MAX];
+	int na, ns, len, pos;
+	const __be32 *prop;
 
-	if (!dn || !addr || !size)
+	if (!dn || !of_region || !index)
 		return -EINVAL;
 
-	if (!prefix)
-		prefix = "";
+	if (!region)
+		region = "";
 
-	snprintf(propname, sizeof(propname), "%sdma-window", prefix);
-	snprintf(addrname, sizeof(addrname), "%s#dma-address-cells", prefix);
-	snprintf(sizename, sizeof(sizename), "%s#dma-size-cells", prefix);
+	prop = of_get_property(dn, "#region-address-cells", NULL);
+	na = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
+	prop = of_get_property(dn, "#region-size-cells", NULL);
+	ns = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
 
-	dma_window = of_get_property(dn, propname, &bytes);
-	if (!dma_window)
-		return -ENODEV;
-	end = dma_window + bytes / sizeof(*dma_window);
+	snprintf(propname, sizeof(propname), "reserved-%s-region", region);
+	prop = of_get_property(dn, propname, &len);
+	if (!prop)
+		return -ENOENT;
 
-	while (dma_window < end) {
-		u32 cells;
-		const void *prop;
-
-		/* busno is one cell if supported */
-		if (busno)
-			*busno = be32_to_cpup(dma_window++);
+	len /= sizeof(*prop);
+	pos = *index;
+	/* prot and busno takes one cell each */
+	if (pos >= len || (len - pos) % (na + ns + 2))
+		return -EINVAL;
 
-		prop = of_get_property(dn, addrname, NULL);
-		if (!prop)
-			prop = of_get_property(dn, "#address-cells", NULL);
+	memset(of_region, 0, sizeof(*of_region));
+	of_region->busno = be32_to_cpup(prop + pos++);
+	of_region->prot = be32_to_cpup(prop + pos++);
+	if (of_region->prot && !(of_region->prot & IOMMU_PROT_FLAGS))
+		return -EINVAL;
 
-		cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
-		if (!cells)
-			return -EINVAL;
-		*addr = of_read_number(dma_window, cells);
-		dma_window += cells;
+	of_region->bus_addr = of_read_number(prop + pos, na);
+	pos += na;
+	of_region->size = of_read_number(prop + pos, ns);
+	pos += ns;
+	*index = pos;
+	return 0;
 
-		prop = of_get_property(dn, sizename, NULL);
-		cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
-		if (!cells)
-			return -EINVAL;
-		*size = of_read_number(dma_window, cells);
-		dma_window += cells;
+}
+EXPORT_SYMBOL_GPL(of_get_resv_region);
 
-		if (cur_index++ == index)
+void of_iommu_resv_dma_regions(struct device_node *np, struct list_head *list)
+{
+	struct of_iommu_resv_region of_region;
+	struct iommu_resv_region *region;
+	int index = 0;
+
+	while (!of_get_resv_region(np, "dma", &index, &of_region)) {
+		region = iommu_alloc_resv_region(of_region.bus_addr,
+						 of_region.size,
+						 of_region.prot,
+						 IOMMU_RESV_RESERVED);
+		if (!region)
 			break;
+
+		list_add_tail(&region->list, list);
 	}
-	return 0;
 }
-EXPORT_SYMBOL_GPL(of_get_dma_window);
+EXPORT_SYMBOL_GPL(of_iommu_resv_dma_regions);
 
 static bool of_iommu_driver_present(struct device_node *np)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..56bf906 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,9 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
+#define IOMMU_PROT_FLAGS (IOMMU_READ | IOMMU_WRITE | \
+			  IOMMU_CACHE | IOMMU_NOEXEC | IOMMU_MMIO)
+
 
 struct iommu_ops;
 struct iommu_group;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index cddfaff..b891bac 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -6,20 +6,27 @@
 #include <linux/iommu.h>
 #include <linux/of.h>
 
+struct of_iommu_resv_region {
+	u32 busno;
+	u32 prot;
+	u64 bus_addr;
+	u64 size;
+};
+
 #ifdef CONFIG_OF_IOMMU
 
-extern int of_get_dma_window(struct device_node *dn, const char *prefix,
-			     int index, unsigned long *busno, dma_addr_t *addr,
-			     size_t *size);
+int of_get_resv_region(struct device_node *dn, const char *region, int *index,
+		      struct of_iommu_resv_region *of_region);
 
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
+void of_iommu_resv_dma_regions(struct device_node *np, struct list_head *list);
+
 #else
 
-static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
-			    int index, unsigned long *busno, dma_addr_t *addr,
-			    size_t *size)
+static inline int of_get_resv_region(struct device_node *dn, const char *region,
+			int *index, struct of_iommu_resv_region *of_region)
 {
 	return -EINVAL;
 }
@@ -30,6 +37,12 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+static inline int of_iommu_resv_dma_regions(struct device_node *np,
+					    struct list_head *list)
+{
+	return -EINVAL;
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 extern struct of_device_id __iommu_of_table;
-- 
2.7.4
