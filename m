From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv7 4/6] arm: dma-mapping: add {map,unmap}_resource for iommu ops
Date: Wed,  1 Jun 2016 17:22:27 +0200
Message-ID: <1464794549-6601-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: hch@infradead.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: iommu@lists.linux-foundation.org

Add methods to map/unmap device resources addresses for dma_map_ops tha=
t
are IOMMU aware. This is needed to map a device MMIO register from a
physical address.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c | 63 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ff7ed56..8f12ec8 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1951,6 +1951,63 @@ static void arm_iommu_unmap_page(struct device *=
dev, dma_addr_t handle,
 	__free_iova(mapping, iova, len);
 }
=20
+/**
+ * arm_iommu_map_resource - map a device resource for DMA
+ * @dev: valid struct device pointer
+ * @phys_addr: physical address of resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static dma_addr_t arm_iommu_map_resource(struct device *dev,
+		phys_addr_t phys_addr, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
+	dma_addr_t dma_addr;
+	int ret, prot;
+	phys_addr_t addr =3D phys_addr & PAGE_MASK;
+	int offset =3D phys_addr & ~PAGE_MASK;
+	int len =3D PAGE_ALIGN(size + offset);
+
+	dma_addr =3D __alloc_iova(mapping, size);
+	if (dma_addr =3D=3D DMA_ERROR_CODE)
+		return dma_addr;
+
+	prot =3D __dma_direction_to_prot(dir) | IOMMU_MMIO;
+
+	ret =3D iommu_map(mapping->domain, dma_addr, addr, len, prot);
+	if (ret < 0)
+		goto fail;
+
+	return dma_addr + offset;
+fail:
+	__free_iova(mapping, dma_addr, size);
+	return DMA_ERROR_CODE;
+}
+
+/**
+ * arm_iommu_unmap_resource - unmap a device DMA resource
+ * @dev: valid struct device pointer
+ * @dma_handle: DMA address to resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dm=
a_handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
+	dma_addr_t iova =3D dma_handle & PAGE_MASK;
+	int offset =3D dma_handle & ~PAGE_MASK;
+	int len =3D PAGE_ALIGN(size + offset);
+
+	if (!iova)
+		return;
+
+	iommu_unmap(mapping->domain, iova, len);
+	__free_iova(mapping, iova, len);
+}
+
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -1994,6 +2051,9 @@ struct dma_map_ops iommu_ops =3D {
 	.unmap_sg		=3D arm_iommu_unmap_sg,
 	.sync_sg_for_cpu	=3D arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	=3D arm_iommu_sync_sg_for_device,
+
+	.map_resource		=3D arm_iommu_map_resource,
+	.unmap_resource		=3D arm_iommu_unmap_resource,
 };
=20
 struct dma_map_ops iommu_coherent_ops =3D {
@@ -2007,6 +2067,9 @@ struct dma_map_ops iommu_coherent_ops =3D {
=20
 	.map_sg		=3D arm_coherent_iommu_map_sg,
 	.unmap_sg	=3D arm_coherent_iommu_unmap_sg,
+
+	.map_resource	=3D arm_iommu_map_resource,
+	.unmap_resource	=3D arm_iommu_unmap_resource,
 };
=20
 /**
--=20
2.8.2
