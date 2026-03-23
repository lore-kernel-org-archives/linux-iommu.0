Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D738B129
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260559; cv=none; b=d1p8UmYohtPKmnUMXOguNviVhbBIt8g+yaFMG73h1IwS4ggwCXOmQVywDiVrGlNDi5lMXJnfZ7wBup4tdcoWk1Vof3TUXYhlKXJbH+7O5ws3Liq7r20k7H7FYdAHgM/By7j6/Lon8iHCfx9lF5C7IWLYwvd/fjRLKI5FizhmnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260559; c=relaxed/simple;
	bh=ei6MF0hUYGibQ2dVwjDxg8lKDxfQaGY8DF3gxUpHxwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nN5sUbp8sIEl+5RIcW+lIYLDGrKV/TRjEjFWlG/9aENVKCUDHZUUuT4vU82eD1mSyggLV/BzoaHvyG3AVBsUQvEg8MbZAAk31grd023h8uvy5a7aUA3py9q6IkuCiIm9J7ahpp8gdTAnSaJ3yOOzYP5ox72vkbA8eACBqKrtkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aRyk+qdg; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aRyk+qdg"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260323100910euoutp01435b759dea28296a5cf68d2375996698~fcJH4OXch1314013140euoutp01a
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260323100910euoutp01435b759dea28296a5cf68d2375996698~fcJH4OXch1314013140euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774260550;
	bh=vAQ/TZu2vjjYASs/E4HF4m+c+RDaNT7+pt0zKRFLNe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRyk+qdg47p6NVlVYeV/71DAj5jnwkVjcIFfIlSLEIJTZ3X6PjVRtBnj1U5ZgbDME
	 ySGJpNMWkS8t5PZX7sAwIg86i2vkN/RWnUnzZm3ZTF8prs4ZMir5V129nVP7lAPWUB
	 R1iC4+/4r4eUBDnv3CfSpEdX2MlXjIcs5O2BpmC0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100910eucas1p2926c5ad3c6dbb3b4cbad1c53a55a6f63~fcJHkTeFe1105911059eucas1p2G;
	Mon, 23 Mar 2026 10:09:10 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100909eusmtip2514f11e62e99322cb957386f3c5f41ec~fcJHBjup60975809758eusmtip2l;
	Mon, 23 Mar 2026 10:09:09 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 3/7] of: reserved_mem: switch to ops based OF_DECLARE()
Date: Mon, 23 Mar 2026 11:08:57 +0100
Message-Id: <20260323100901.4079171-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323100901.4079171-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260323100910eucas1p2926c5ad3c6dbb3b4cbad1c53a55a6f63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323100910eucas1p2926c5ad3c6dbb3b4cbad1c53a55a6f63
X-EPHeader: CA
X-CMS-RootMailID: 20260323100910eucas1p2926c5ad3c6dbb3b4cbad1c53a55a6f63
References: <20260323100901.4079171-1-m.szyprowski@samsung.com>
	<CGME20260323100910eucas1p2926c5ad3c6dbb3b4cbad1c53a55a6f63@eucas1p2.samsung.com>

Move init function from OF_DECLARE() argument to the given reserved
memory region ops structure and then pass that structure to the
OF_DECLARE() initializer. This makes it possible in the future to add
more functions called by the generic code before given memory region is
initialized and rmem object created.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/memory/tegra/tegra210-emc-table.c | 16 ++++++++--------
 drivers/of/of_reserved_mem.c              | 17 +++++++++++++----
 include/linux/of_reserved_mem.h           | 15 ++++++++-------
 kernel/dma/coherent.c                     | 13 +++++++------
 kernel/dma/contiguous.c                   | 15 ++++++++-------
 kernel/dma/swiotlb.c                      | 14 +++++++-------
 6 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/memory/tegra/tegra210-emc-table.c b/drivers/memory/tegra/tegra210-emc-table.c
index ac1d1e13482a..4b3c478b2743 100644
--- a/drivers/memory/tegra/tegra210-emc-table.c
+++ b/drivers/memory/tegra/tegra210-emc-table.c
@@ -70,20 +70,20 @@ static void tegra210_emc_table_device_release(struct reserved_mem *rmem,
 	memunmap(timings);
 }
 
-static const struct reserved_mem_ops tegra210_emc_table_ops = {
-	.device_init = tegra210_emc_table_device_init,
-	.device_release = tegra210_emc_table_device_release,
-};
-
 static int tegra210_emc_table_init(unsigned long node,
 				   struct reserved_mem *rmem)
 {
 	pr_debug("Tegra210 EMC table at %pa, size %lu bytes\n", &rmem->base,
 		 (unsigned long)rmem->size);
 
-	rmem->ops = &tegra210_emc_table_ops;
-
 	return 0;
 }
+
+static const struct reserved_mem_ops tegra210_emc_table_ops = {
+	.node_init = tegra210_emc_table_init,
+	.device_init = tegra210_emc_table_device_init,
+	.device_release = tegra210_emc_table_device_release,
+};
+
 RESERVEDMEM_OF_DECLARE(tegra210_emc_table, "nvidia,tegra210-emc-table",
-		       tegra210_emc_table_init);
+		       &tegra210_emc_table_ops);
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9aff460a0420..d67864db3019 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -480,8 +480,16 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 static const struct of_device_id __rmem_of_table_sentinel
 	__used __section("__reservedmem_of_table_end");
 
-/*
- * __reserved_mem_init_node() - call region specific reserved memory init code
+/**
+ * __reserved_mem_init_node() - initialize a reserved memory region
+ * @rmem: reserved_mem structure to initialize
+ * @node: FDT node describing the reserved memory region
+ *
+ * This function iterates through the reserved memory drivers and calls the
+ * node_init callback for the compatible entry matching the node. On success,
+ * the operations pointer is stored in the reserved_mem structure.
+ *
+ * Return: 0 on success, -ENODEV if no compatible match found
  */
 static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 					   unsigned long node)
@@ -492,14 +500,15 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 
 	for (i = __reservedmem_of_table; ret == -ENODEV &&
 	     i < &__rmem_of_table_sentinel; i++) {
-		reservedmem_of_init_fn initfn = i->data;
+		const struct reserved_mem_ops *ops = i->data;
 		const char *compat = i->compatible;
 
 		if (!of_flat_dt_is_compatible(node, compat))
 			continue;
 
-		ret = initfn(node, rmem);
+		ret = ops->node_init(node, rmem);
 		if (ret == 0) {
+			rmem->ops = ops;
 			pr_info("initialized node %s, compatible id %s\n",
 				rmem->name, compat);
 			break;
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 5159938bfe03..320ac8929a28 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -18,19 +18,20 @@ struct reserved_mem {
 };
 
 struct reserved_mem_ops {
+	int	(*node_init)(unsigned long fdt_node, struct reserved_mem *rmem);
 	int	(*device_init)(struct reserved_mem *rmem,
 			       struct device *dev);
 	void	(*device_release)(struct reserved_mem *rmem,
 				  struct device *dev);
 };
 
-typedef int (*reservedmem_of_init_fn)(unsigned long node,
-				      struct reserved_mem *rmem);
-
 #ifdef CONFIG_OF_RESERVED_MEM
 
-#define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
-	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
+#define RESERVEDMEM_OF_DECLARE(name, compat, ops)			\
+	static const struct of_device_id __of_table_##name		\
+		__used __section("__reservedmem_of_table")		\
+		__aligned(__alignof__(struct of_device_id))		\
+		 = { .compatible = compat, .data = ops }
 
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
@@ -48,8 +49,8 @@ int of_reserved_mem_region_count(const struct device_node *np);
 
 #else
 
-#define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
-	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
+#define RESERVEDMEM_OF_DECLARE(name, compat, ops)			\
+	_OF_DECLARE_STUB(reservedmem, name, compat, ops, void *)
 
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 64f9ba618e19..bcdc0f76d2e8 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -362,10 +362,6 @@ static void rmem_dma_device_release(struct reserved_mem *rmem,
 		dev->dma_mem = NULL;
 }
 
-static const struct reserved_mem_ops rmem_dma_ops = {
-	.device_init	= rmem_dma_device_init,
-	.device_release	= rmem_dma_device_release,
-};
 
 static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 {
@@ -388,7 +384,6 @@ static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 	}
 #endif
 
-	rmem->ops = &rmem_dma_ops;
 	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
 	return 0;
@@ -405,5 +400,11 @@ static int __init dma_init_reserved_memory(void)
 core_initcall(dma_init_reserved_memory);
 #endif /* CONFIG_DMA_GLOBAL_POOL */
 
-RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
+static const struct reserved_mem_ops rmem_dma_ops = {
+	.node_init	= rmem_dma_setup,
+	.device_init	= rmem_dma_device_init,
+	.device_release	= rmem_dma_device_release,
+};
+
+RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", &rmem_dma_ops);
 #endif
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index e6fc6906b5c0..efeebda92537 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -470,11 +470,6 @@ static void rmem_cma_device_release(struct reserved_mem *rmem,
 	dev->cma_area = NULL;
 }
 
-static const struct reserved_mem_ops rmem_cma_ops = {
-	.device_init	= rmem_cma_device_init,
-	.device_release = rmem_cma_device_release,
-};
-
 static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 {
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
@@ -499,7 +494,6 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 	if (default_cma)
 		dma_contiguous_default_area = cma;
 
-	rmem->ops = &rmem_cma_ops;
 	rmem->priv = cma;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
@@ -511,5 +505,12 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 
 	return 0;
 }
-RESERVEDMEM_OF_DECLARE(cma, "shared-dma-pool", rmem_cma_setup);
+
+static const struct reserved_mem_ops rmem_cma_ops = {
+	.node_init	= rmem_cma_setup,
+	.device_init	= rmem_cma_device_init,
+	.device_release = rmem_cma_device_release,
+};
+
+RESERVEDMEM_OF_DECLARE(cma, "shared-dma-pool", &rmem_cma_ops);
 #endif
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f3a12e15a951..44b566d20e04 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1855,11 +1855,6 @@ static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
 	dev->dma_io_tlb_mem = &io_tlb_default_mem;
 }
 
-static const struct reserved_mem_ops rmem_swiotlb_ops = {
-	.device_init = rmem_swiotlb_device_init,
-	.device_release = rmem_swiotlb_device_release,
-};
-
 static int __init rmem_swiotlb_setup(unsigned long node,
 				     struct reserved_mem *rmem)
 {
@@ -1869,11 +1864,16 @@ static int __init rmem_swiotlb_setup(unsigned long node,
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	rmem->ops = &rmem_swiotlb_ops;
 	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
 	return 0;
 }
 
-RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", rmem_swiotlb_setup);
+static const struct reserved_mem_ops rmem_swiotlb_ops = {
+	.node_init = rmem_swiotlb_setup,
+	.device_init = rmem_swiotlb_device_init,
+	.device_release = rmem_swiotlb_device_release,
+};
+
+RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", &rmem_swiotlb_ops);
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
-- 
2.34.1

