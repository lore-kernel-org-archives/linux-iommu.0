Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6E38F63C
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414494; cv=none; b=hNza6G/Dkl/NHyHV2gCWP+qBAc9qAUfUb1s4cjycQJESZi5u0b7/qROTYaLk0SKqSo0dPe81v/MMEucavhbiMMpt4IY3qJL1SkdkKnsjTALPADCL2fSHdc8UinSQC76VXS3toxEST/w/6ps6r8D14M9vk0xVt/c8aV3y2liER84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414494; c=relaxed/simple;
	bh=JXWNJLqpuFrFJj+RYTjGPd9fc76RzcAEVUEprzX8JJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QOnwVIinJVwfpcDOfW2CBedz3x09SQaIagV9eCetS4BjyzKJLndt9B0AQBFgIsSldwDMvxGbMdrzLA57v0p5bH5Bba6ZqSvuJOQa0w3bZDL74NRaB249QUp9VkkQqX7gCYwlaFMKblT5REGfhG8M+4d6cPugzTnz5/L2YZ90Fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rW4s6P50; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rW4s6P50"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260313150810euoutp01580a2ba79eee82c7b86ca88ff218ba38~cbxVN-4fo2419324193euoutp01B
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260313150810euoutp01580a2ba79eee82c7b86ca88ff218ba38~cbxVN-4fo2419324193euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773414490;
	bh=/6WjlAYerVq6d8qF1cWBAuX5UyfsvgD0ELY2Xcbrhso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rW4s6P50INwREzpBu26IiQwHDj9/QG2gy8UXhXggQ+JvTb5trxzzfEt0LVMj13ebe
	 yrhraeKI6APXLPizdsCmchIpDUoRuiLvONtWViDS9A07bF+SEBw9eW+ZDCDAWAvIk0
	 vLWWw+gxRGwPTbN5heJ+xjcN7Rb76FuzhT3LV/lw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150810eucas1p1ecbbe597c5df8aaa2effa3b65c07c6db~cbxU36qoz2822628226eucas1p1-;
	Fri, 13 Mar 2026 15:08:10 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150809eusmtip1cf30c32354975e25d44ed1dc4e50cb86~cbxUTC-DF1821718217eusmtip1a;
	Fri, 13 Mar 2026 15:08:09 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/7] of: reserved_mem: remove fdt node from the structure
Date: Fri, 13 Mar 2026 16:07:56 +0100
Message-Id: <20260313150802.1121442-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313150802.1121442-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313150810eucas1p1ecbbe597c5df8aaa2effa3b65c07c6db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260313150810eucas1p1ecbbe597c5df8aaa2effa3b65c07c6db
X-EPHeader: CA
X-CMS-RootMailID: 20260313150810eucas1p1ecbbe597c5df8aaa2effa3b65c07c6db
References: <20260313150802.1121442-1-m.szyprowski@samsung.com>
	<CGME20260313150810eucas1p1ecbbe597c5df8aaa2effa3b65c07c6db@eucas1p1.samsung.com>

FDT node is not needed for anything besides the initialization, so it can
be simply passed as an argument to the reserved memory region init
function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/memory/tegra/tegra210-emc-table.c |  3 ++-
 drivers/of/of_reserved_mem.c              | 25 ++++++++++-------------
 include/linux/of_reserved_mem.h           |  4 ++--
 kernel/dma/coherent.c                     |  4 +---
 kernel/dma/contiguous.c                   |  3 +--
 kernel/dma/swiotlb.c                      |  5 ++---
 6 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/memory/tegra/tegra210-emc-table.c b/drivers/memory/tegra/tegra210-emc-table.c
index 34a8785d2861..ac1d1e13482a 100644
--- a/drivers/memory/tegra/tegra210-emc-table.c
+++ b/drivers/memory/tegra/tegra210-emc-table.c
@@ -75,7 +75,8 @@ static const struct reserved_mem_ops tegra210_emc_table_ops = {
 	.device_release = tegra210_emc_table_device_release,
 };
 
-static int tegra210_emc_table_init(struct reserved_mem *rmem)
+static int tegra210_emc_table_init(unsigned long node,
+				   struct reserved_mem *rmem)
 {
 	pr_debug("Tegra210 EMC table at %pa, size %lu bytes\n", &rmem->base,
 		 (unsigned long)rmem->size);
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1fd28f805610..6705b7afebf0 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -104,7 +104,8 @@ static void __init alloc_reserved_mem_array(void)
 	reserved_mem = new_array;
 }
 
-static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem);
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
+					      unsigned long node);
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -118,13 +119,12 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 		return;
 	}
 
-	rmem->fdt_node = node;
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
 
 	/* Call the region specific initialization function */
-	fdt_init_reserved_mem_node(rmem);
+	fdt_init_reserved_mem_node(rmem, node);
 
 	reserved_mem_count++;
 }
@@ -483,7 +483,8 @@ static const struct of_device_id __rmem_of_table_sentinel
 /*
  * __reserved_mem_init_node() - call region specific reserved memory init code
  */
-static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
+static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
+					   unsigned long node)
 {
 	extern const struct of_device_id __reservedmem_of_table[];
 	const struct of_device_id *i;
@@ -493,10 +494,10 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
-		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
+		if (!of_flat_dt_is_compatible(node, compat))
 			continue;
 
-		ret = initfn(rmem);
+		ret = initfn(node, rmem);
 		if (ret == 0) {
 			pr_info("initialized node %s, compatible id %s\n",
 				rmem->name, compat);
@@ -526,11 +527,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
-	if (ra->fdt_node < rb->fdt_node)
-		return -1;
-	if (ra->fdt_node > rb->fdt_node)
-		return 1;
-
 	return 0;
 }
 
@@ -564,19 +560,20 @@ static void __init __rmem_check_for_overlap(void)
 /**
  * fdt_init_reserved_mem_node() - Initialize a reserved memory region
  * @rmem: reserved_mem struct of the memory region to be initialized.
+ * @node: fdt node of the initialized region
  *
  * This function is used to call the region specific initialization
  * function for a reserved memory region.
  */
-static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem)
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
+					      unsigned long node)
 {
-	unsigned long node = rmem->fdt_node;
 	int err = 0;
 	bool nomap;
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-	err = __reserved_mem_init_node(rmem);
+	err = __reserved_mem_init_node(rmem, node);
 	if (err != 0 && err != -ENOENT) {
 		pr_info("node %s compatible matching fail\n", rmem->name);
 		if (nomap)
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index f573423359f4..5159938bfe03 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -11,7 +11,6 @@ struct resource;
 
 struct reserved_mem {
 	const char			*name;
-	unsigned long			fdt_node;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;
 	phys_addr_t			size;
@@ -25,7 +24,8 @@ struct reserved_mem_ops {
 				  struct device *dev);
 };
 
-typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
+typedef int (*reservedmem_of_init_fn)(unsigned long node,
+				      struct reserved_mem *rmem);
 
 #ifdef CONFIG_OF_RESERVED_MEM
 
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 1147497bc512..34621acbd3c5 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -367,10 +367,8 @@ static const struct reserved_mem_ops rmem_dma_ops = {
 	.device_release	= rmem_dma_device_release,
 };
 
-static int __init rmem_dma_setup(struct reserved_mem *rmem)
+static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
-
 	if (of_get_flat_dt_prop(node, "reusable", NULL))
 		return -EINVAL;
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index c56004d314dc..81a2fa4971ee 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -475,9 +475,8 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 	.device_release = rmem_cma_device_release,
 };
 
-static int __init rmem_cma_setup(struct reserved_mem *rmem)
+static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
 	int err;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d8e6f1d889d5..f3a12e15a951 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1860,10 +1860,9 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 	.device_release = rmem_swiotlb_device_release,
 };
 
-static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
+static int __init rmem_swiotlb_setup(unsigned long node,
+				     struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
-
 	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
 	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
-- 
2.34.1

