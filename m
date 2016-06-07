From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv8 2/6] dma-debug: add support for resource mappings
Date: Tue,  7 Jun 2016 09:54:09 +0200
Message-ID: <1465286053-27258-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1465286053-27258-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1465286053-27258-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk
Cc: hch@infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: iommu@lists.linux-foundation.org

A MMIO mapped resource can not be represented by a struct page so a new
debug type is needed to handle this. This patch add such type and
functionality to add/remove entries and how to translate them to a
physical address.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 include/linux/dma-debug.h | 19 +++++++++++++++++
 lib/dma-debug.c           | 52 +++++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index fe8cb61..c7d844f 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -56,6 +56,13 @@ extern void debug_dma_alloc_coherent(struct device *=
dev, size_t size,
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 				    void *virt, dma_addr_t addr);
=20
+extern void debug_dma_map_resource(struct device *dev, phys_addr_t add=
r,
+				   size_t size, int direction,
+				   dma_addr_t dma_addr);
+
+extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t dm=
a_addr,
+				     size_t size, int direction);
+
 extern void debug_dma_sync_single_for_cpu(struct device *dev,
 					  dma_addr_t dma_handle, size_t size,
 					  int direction);
@@ -141,6 +148,18 @@ static inline void debug_dma_free_coherent(struct =
device *dev, size_t size,
 {
 }
=20
+static inline void debug_dma_map_resource(struct device *dev, phys_add=
r_t addr,
+					  size_t size, int direction,
+					  dma_addr_t dma_addr)
+{
+}
+
+static inline void debug_dma_unmap_resource(struct device *dev,
+					    dma_addr_t dma_addr, size_t size,
+					    int direction)
+{
+}
+
 static inline void debug_dma_sync_single_for_cpu(struct device *dev,
 						 dma_addr_t dma_handle,
 						 size_t size, int direction)
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 51a76af..ce75fba 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -43,6 +43,7 @@ enum {
 	dma_debug_page,
 	dma_debug_sg,
 	dma_debug_coherent,
+	dma_debug_resource,
 };
=20
 enum map_err_types {
@@ -150,8 +151,9 @@ static const char *const maperr2str[] =3D {
 	[MAP_ERR_CHECKED] =3D "dma map error checked",
 };
=20
-static const char *type2name[4] =3D { "single", "page",
-				    "scather-gather", "coherent" };
+static const char *type2name[5] =3D { "single", "page",
+				    "scather-gather", "coherent",
+				    "resource" };
=20
 static const char *dir2name[4] =3D { "DMA_BIDIRECTIONAL", "DMA_TO_DEVI=
CE",
 				   "DMA_FROM_DEVICE", "DMA_NONE" };
@@ -397,6 +399,9 @@ static void hash_bucket_del(struct dma_debug_entry =
*entry)
=20
 static unsigned long long phys_addr(struct dma_debug_entry *entry)
 {
+	if (entry->type =3D=3D dma_debug_resource)
+		return __pfn_to_phys(entry->pfn) + entry->offset;
+
 	return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
 }
=20
@@ -1493,6 +1498,49 @@ void debug_dma_free_coherent(struct device *dev,=
 size_t size,
 }
 EXPORT_SYMBOL(debug_dma_free_coherent);
=20
+void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size=
_t size,
+			    int direction, dma_addr_t dma_addr)
+{
+	struct dma_debug_entry *entry;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	entry =3D dma_entry_alloc();
+	if (!entry)
+		return;
+
+	entry->type		=3D dma_debug_resource;
+	entry->dev		=3D dev;
+	entry->pfn		=3D __phys_to_pfn(addr);
+	entry->offset		=3D offset_in_page(addr);
+	entry->size		=3D size;
+	entry->dev_addr		=3D dma_addr;
+	entry->direction	=3D direction;
+	entry->map_err_type	=3D MAP_ERR_NOT_CHECKED;
+
+	add_dma_entry(entry);
+}
+EXPORT_SYMBOL(debug_dma_map_resource);
+
+void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
+			      size_t size, int direction)
+{
+	struct dma_debug_entry ref =3D {
+		.type           =3D dma_debug_resource,
+		.dev            =3D dev,
+		.dev_addr       =3D dma_addr,
+		.size           =3D size,
+		.direction      =3D direction,
+	};
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_unmap(&ref);
+}
+EXPORT_SYMBOL(debug_dma_unmap_resource);
+
 void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_=
handle,
 				   size_t size, int direction)
 {
--=20
2.8.2
