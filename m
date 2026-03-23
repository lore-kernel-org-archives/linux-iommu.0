Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E538B148
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260560; cv=none; b=qXufjPokFADF/e2JM3ohVJE9S0jWEEJipIlmeMONmeS+uDDj2w5KyfTLuGUGPXyyyWb8fFo6hsUiqCogb48elCrIYzB7gjh9jOgvS++KMMs3dru/7CUeyOt/SzQB7dOhFK19l7UwzhV5rIilznfGID0e3H+EAZBUQoL5jAjFFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260560; c=relaxed/simple;
	bh=kjWSOU5uvl5Oo9bVZ1CjKZvhEeWS2XHHpc42+L9hpms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=OBSLs6c099xK6wEm1NqeFD/rSnBC6VlhI/KiQBstBHe+agdsKeiwIMZOHDQDd6IO/4OxiI2WRvLWofPZZjyPd97hVeGC7uRm/aI3O71h05KcBnWn/omRCFY1OOtwvzrx/5khJNjbhwWpjVmtwfU/eqsYPxd5ypxP9qfjvdYqrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I4/DFDhI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I4/DFDhI"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260323100911euoutp01c98e82ea9cbd270dfac6f0a34c233808~fcJIkSY_B1424614246euoutp01h
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260323100911euoutp01c98e82ea9cbd270dfac6f0a34c233808~fcJIkSY_B1424614246euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774260551;
	bh=oOH6y278hBlhXpW5TgFEFamleQgzNhyjv0GT6zDAD3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4/DFDhIKlsKuldMs5IIuMJfXiA+dzSWZHnVm9QQ1pQeCxxV1w8hy+YkQ0TQW3KqM
	 P97vtNzCAiYHEdsV4yq8LOBd1JbdZHsoJNogvTM910KocUv9glQtRKGYv1XcvElfNn
	 XHtThNKdsFjHxQ6ZP6COdpRzDqiIGUHlxS/SFjeY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260323100910eucas1p1efe6ee90c38f4261f6eae2a81a25717a~fcJIN3oVG0576205762eucas1p1I;
	Mon, 23 Mar 2026 10:09:10 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100910eusmtip2e62a495bc8823ea856879b6e0bc097aa~fcJHqGIed0975509755eusmtip2m;
	Mon, 23 Mar 2026 10:09:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 4/7] of: reserved_mem: replace CMA quirks by generic
 methods
Date: Mon, 23 Mar 2026 11:08:58 +0100
Message-Id: <20260323100901.4079171-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323100901.4079171-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260323100910eucas1p1efe6ee90c38f4261f6eae2a81a25717a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323100910eucas1p1efe6ee90c38f4261f6eae2a81a25717a
X-EPHeader: CA
X-CMS-RootMailID: 20260323100910eucas1p1efe6ee90c38f4261f6eae2a81a25717a
References: <20260323100901.4079171-1-m.szyprowski@samsung.com>
	<CGME20260323100910eucas1p1efe6ee90c38f4261f6eae2a81a25717a@eucas1p1.samsung.com>

Add optional reserved memory callbacks to perform region verification and
early fixup, then move all CMA related code in of_reserved_mem.c to them.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c    | 118 ++++++++++++++++++++++----------
 include/linux/cma.h             |  10 ---
 include/linux/dma-map-ops.h     |   3 -
 include/linux/of_reserved_mem.h |   3 +
 kernel/dma/contiguous.c         |  70 ++++++++++++++-----
 5 files changed, 137 insertions(+), 67 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index d67864db3019..61ef148add68 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,8 +24,6 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
-#include <linux/cma.h>
-#include <linux/dma-map-ops.h>
 
 #include "of_private.h"
 
@@ -106,6 +104,11 @@ static void __init alloc_reserved_mem_array(void)
 
 static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 					      unsigned long node);
+static int fdt_validate_reserved_mem_node(unsigned long node,
+					  phys_addr_t *align);
+static int fdt_fixup_reserved_mem_node(unsigned long node,
+				       phys_addr_t base, phys_addr_t size);
+
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -154,21 +157,19 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 					     const char *uname)
 {
 	phys_addr_t base, size;
-	int i, len;
+	int i, len, err;
 	const __be32 *prop;
-	bool nomap, default_cma;
+	bool nomap;
 
 	prop = of_flat_dt_get_addr_size_prop(node, "reg", &len);
 	if (!prop)
 		return -ENOENT;
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-	default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 
-	if (default_cma && cma_skip_dt_default_reserved_mem()) {
-		pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
-		return -EINVAL;
-	}
+	err = fdt_validate_reserved_mem_node(node, NULL);
+	if (err && err != -ENODEV)
+		return err;
 
 	for (i = 0; i < len; i++) {
 		u64 b, s;
@@ -179,10 +180,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		size = s;
 
 		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
-			/* Architecture specific contiguous memory fixup. */
-			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
-			    of_get_flat_dt_prop(node, "reusable", NULL))
-				dma_contiguous_early_fixup(base, size);
+			fdt_fixup_reserved_mem_node(node, base, size);
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
 		} else {
@@ -253,17 +251,19 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
-		bool default_cma = of_get_flat_dt_prop(child, "linux,cma-default", NULL);
 		u64 b, s;
+		int ret;
 
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
-		if (default_cma && cma_skip_dt_default_reserved_mem())
-			continue;
 
 		if (!of_flat_dt_get_addr_size(child, "reg", &b, &s))
 			continue;
 
+		ret = fdt_validate_reserved_mem_node(child, NULL);
+		if (ret && ret != -ENODEV)
+			continue;
+
 		base = b;
 		size = s;
 
@@ -397,7 +397,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	phys_addr_t base = 0, align = 0, size;
 	int i, len;
 	const __be32 *prop;
-	bool nomap, default_cma;
+	bool nomap;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -421,19 +421,10 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-	default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 
-	if (default_cma && cma_skip_dt_default_reserved_mem()) {
-		pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
-		return -EINVAL;
-	}
-
-	/* Need adjust the alignment to satisfy the CMA requirement */
-	if (IS_ENABLED(CONFIG_CMA)
-	    && of_flat_dt_is_compatible(node, "shared-dma-pool")
-	    && of_get_flat_dt_prop(node, "reusable", NULL)
-	    && !nomap)
-		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+	ret = fdt_validate_reserved_mem_node(node, &align);
+	if (ret && ret != -ENODEV)
+		return ret;
 
 	prop = of_flat_dt_get_addr_size_prop(node, "alloc-ranges", &len);
 	if (prop) {
@@ -468,18 +459,76 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	/* Architecture specific contiguous memory fixup. */
-	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
-	    of_get_flat_dt_prop(node, "reusable", NULL))
-		dma_contiguous_early_fixup(base, size);
+
+	fdt_fixup_reserved_mem_node(node, base, size);
+
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
+extern const struct of_device_id __reservedmem_of_table[];
 static const struct of_device_id __rmem_of_table_sentinel
 	__used __section("__reservedmem_of_table_end");
 
+/**
+ * fdt_fixup_reserved_mem_node() - call fixup function for a reserved memory node
+ * @node: FDT node to fixup
+ * @base: base address of the reserved memory region
+ * @size: size of the reserved memory region
+ *
+ * This function iterates through the reserved memory drivers and calls
+ * the node_fixup callback for the compatible entry matching the node.
+ *
+ * Return: 0 on success, -ENODEV if no compatible match found
+ */
+static int __init fdt_fixup_reserved_mem_node(unsigned long node,
+					phys_addr_t base, phys_addr_t size)
+{
+	const struct of_device_id *i;
+	int ret = -ENODEV;
+
+	for (i = __reservedmem_of_table; ret == -ENODEV &&
+	     i < &__rmem_of_table_sentinel; i++) {
+		const struct reserved_mem_ops *ops = i->data;
+
+		if (!of_flat_dt_is_compatible(node, i->compatible))
+			continue;
+
+		if (ops->node_fixup)
+			ret = ops->node_fixup(node, base, size);
+	}
+	return ret;
+}
+
+/**
+ * fdt_validate_reserved_mem_node() - validate a reserved memory node
+ * @node: FDT node to validate
+ * @align: pointer to store the validated alignment (may be modified by callback)
+ *
+ * This function iterates through the reserved memory drivers and calls
+ * the node_validate callback for the compatible entry matching the node.
+ *
+ * Return: 0 on success, -ENODEV if no compatible match found
+ */
+static int __init fdt_validate_reserved_mem_node(unsigned long node, phys_addr_t *align)
+{
+	const struct of_device_id *i;
+	int ret = -ENODEV;
+
+	for (i = __reservedmem_of_table; ret == -ENODEV &&
+	     i < &__rmem_of_table_sentinel; i++) {
+		const struct reserved_mem_ops *ops = i->data;
+
+		if (!of_flat_dt_is_compatible(node, i->compatible))
+			continue;
+
+		if (ops->node_validate)
+			ret = ops->node_validate(node, align);
+	}
+	return ret;
+}
+
 /**
  * __reserved_mem_init_node() - initialize a reserved memory region
  * @rmem: reserved_mem structure to initialize
@@ -494,7 +543,6 @@ static const struct of_device_id __rmem_of_table_sentinel
 static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 					   unsigned long node)
 {
-	extern const struct of_device_id __reservedmem_of_table[];
 	const struct of_device_id *i;
 	int ret = -ENODEV;
 
@@ -511,7 +559,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 			rmem->ops = ops;
 			pr_info("initialized node %s, compatible id %s\n",
 				rmem->name, compat);
-			break;
+			return ret;
 		}
 	}
 	return ret;
diff --git a/include/linux/cma.h b/include/linux/cma.h
index d0793eaaadaa..8555d38a97b1 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -61,14 +61,4 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
-
-#ifdef CONFIG_DMA_CMA
-extern bool cma_skip_dt_default_reserved_mem(void);
-#else
-static inline bool cma_skip_dt_default_reserved_mem(void)
-{
-	return false;
-}
-#endif
-
 #endif
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 60b63756df82..55ecd2934225 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -147,9 +147,6 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 {
 	__free_pages(page, get_order(size));
 }
-static inline void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
-{
-}
 #endif /* CONFIG_DMA_CMA*/
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 320ac8929a28..ecca1eaac4ec 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -18,6 +18,9 @@ struct reserved_mem {
 };
 
 struct reserved_mem_ops {
+	int	(*node_validate)(unsigned long fdt_node, phys_addr_t *align);
+	int	(*node_fixup)(unsigned long fdt_node, phys_addr_t base,
+			      phys_addr_t size);
 	int	(*node_init)(unsigned long fdt_node, struct reserved_mem *rmem);
 	int	(*device_init)(struct reserved_mem *rmem,
 			       struct device *dev);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index efeebda92537..65d216663e81 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -91,16 +91,6 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
-/*
- * cma_skip_dt_default_reserved_mem - This is called from the
- * reserved_mem framework to detect if the default cma region is being
- * set by the "cma=" kernel parameter.
- */
-bool __init cma_skip_dt_default_reserved_mem(void)
-{
-	return size_cmdline != -1;
-}
-
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
@@ -470,25 +460,65 @@ static void rmem_cma_device_release(struct reserved_mem *rmem,
 	dev->cma_area = NULL;
 }
 
+static int __init __rmem_cma_verify_node(unsigned long node)
+{
+	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -ENODEV;
+
+	if (size_cmdline != -1 &&
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL)) {
+		pr_err("Skipping dt linux,cma-default node in favor for \"cma=\" kernel param.\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int __init rmem_cma_validate(unsigned long node, phys_addr_t *align)
+{
+	int ret = __rmem_cma_verify_node(node);
+
+	if (ret)
+		return ret;
+
+	if (align)
+		*align = max_t(phys_addr_t, *align, CMA_MIN_ALIGNMENT_BYTES);
+
+	return 0;
+}
+
+static int __init rmem_cma_fixup(unsigned long node, phys_addr_t base,
+				    phys_addr_t size)
+{
+	int ret = __rmem_cma_verify_node(node);
+
+	if (ret)
+		return ret;
+
+	/* Architecture specific contiguous memory fixup. */
+	dma_contiguous_early_fixup(base, size);
+	return 0;
+}
+
 static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 {
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
-	int err;
+	int ret;
 
-	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "no-map", NULL))
-		return -ENODEV;
+	ret = __rmem_cma_verify_node(node);
+	if (ret)
+		return ret;
 
 	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
 	}
 
-	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
-	if (err) {
+	ret = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	if (ret) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
-		return err;
+		return ret;
 	}
 
 	if (default_cma)
@@ -499,14 +529,16 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
 
-	err = dma_heap_cma_register_heap(cma);
-	if (err)
+	ret = dma_heap_cma_register_heap(cma);
+	if (ret)
 		pr_warn("Couldn't register CMA heap.");
 
 	return 0;
 }
 
 static const struct reserved_mem_ops rmem_cma_ops = {
+	.node_validate  = rmem_cma_validate,
+	.node_fixup	= rmem_cma_fixup,
 	.node_init	= rmem_cma_setup,
 	.device_init	= rmem_cma_device_init,
 	.device_release = rmem_cma_device_release,
-- 
2.34.1

