Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915670;
	b=qz6kPGvXnNOdn6JMQT/QNEKx1DlXwRwywmbFgz9ynKIC3d1NAJeH09/+hWl07J0Tk2FQ
	 Wd5YbW9cE2zDCQWQxLWXRIc4n9QilUhk1qWgjTI8k15pWOL153r36GHG/CnuXNfyF22UT
	 yitBoVYy7jjkvFbzlSEl7s2hav4pTn7JAiSLmxCRvF3hsXWf/jUuu0CVh3+YGtcPlGrTH
	 NPVIlqgHy2M6Rq6kdj/9DYq0Bo50yMpQm2roo0BQas4lhACYmRohssaJWA/NMso+q1PCZ
	 +JxVSYmfpO+ETPHSbisti21AakJGiOC3SDJ8NVQYPZbxsbbD1DcNY2ByJ3tAesHgmjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915670;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=2ol6+m56kU5BZ1rsmwMrAbZ8hh4/UwFlIZDM7a259+Y=;
	b=pR0UqhxGq4jGK+O2zfC//HpJCVS/8IZqIMbxCf+jMd3xiItE2bblw7DDMq/37vO15OFN
	 5K/Rdkcn0ltOl2rySd5y4X7vZOZOdZloAZlaYcERGeJrzw+IpBAi/UzvuTWvb9Luu+hDZ
	 E2PMEFWNZsSg5XLvUV/PQR1LFg6Vcr/9eldIr+Fe0BztulBvzAE347uh8FbDkqilPCqUZ
	 Kx5jSxVfqw+RJ4lAxyufQbMeAntpEXsxi0iLP/8aqd1xACMzEYQoAqDTU/Ezta1LLi6wW
	 0uHGrfOH8fc7PrRUt4cVIzup5/ArfT5IpAOwi7nz1CQgK4ER3k4y4c6yFl2rr0jP26w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SkGmJB4V;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E5606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 21:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SkGmJB4V
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261105215426euoutp0126136eb46b0fbb84155df4a238ffcce6~lRMtIdRKf2653426534euoutp01h
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 21:54:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261105215426euoutp0126136eb46b0fbb84155df4a238ffcce6~lRMtIdRKf2653426534euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793915666;
	bh=2ol6+m56kU5BZ1rsmwMrAbZ8hh4/UwFlIZDM7a259+Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SkGmJB4VdslJR4K3sHiGiGXg9TvBaL5QrHp5E1omsT8ubQyCvUVaNieGBsX3N9HAC
	 PT4FgafiOzh7NBIChb+mk9jGFt+nK3k6iGPV6qBEQQ7LwL6lHcwr3YaJfIdyb/UlIN
	 YG2/IFa1Y6VZFL7pJvHiOG9iRjdVCRuckJEW2JT0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261105215426eucas1p1fb2de3113bd185a84e1d0925e14fc4fc~lRMsxTYYv1130511305eucas1p1z;
	Thu,  5 Nov 2026 21:54:26 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261105215425eusmtip16c52ef5ad8ec8f92c6299c16dd82c051~lRMsaHRNt0137901379eusmtip1D;
	Thu,  5 Nov 2026 21:54:25 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: [PATCH] of: reserved_mem: Drop node_fixup, CMA can handle it
 internally again
Date: Thu,  5 Nov 2026 22:54:11 +0100
Message-ID: <20261105215413.1439745-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261105215426eucas1p1fb2de3113bd185a84e1d0925e14fc4fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261105215426eucas1p1fb2de3113bd185a84e1d0925e14fc4fc
X-EPHeader: CA
X-CMS-RootMailID: 20261105215426eucas1p1fb2de3113bd185a84e1d0925e14fc4fc
References: <CGME20261105215426eucas1p1fb2de3113bd185a84e1d0925e14fc4fc@eucas1p1.samsung.com>

The separate fixup step was needed because node initialization used to
run too late, after paging_init(). Since commit aa05faf81583 ("of:
reserved_mem: allocate and map the reserved_mem array early") node_init
runs early enough again, so dma_contiguous_early_fixup() can be called
directly from rmem_cma_setup() once the CMA region has been successfully
initialized, as it was before commit 2c223f7239f37 ("of: reserved_mem:
Restructure call site for dma_contiguous_early_fixup()").

Drop the now unused node_fixup callback and its helper. This also fixes
the premature call to fixup when region fails to initialize.

Closes: https://sashiko.dev/#/bug/linux-61818eaa-5dc1-4457-bd21-3a9be2ed4d6d
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c    | 34 ---------------------------------
 include/linux/of_reserved_mem.h |  2 --
 kernel/dma/contiguous.c         | 17 +++--------------
 3 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 0fd1683cba01..e7764f57438b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -86,8 +86,6 @@ static void fdt_init_reserved_mem_node(unsigned long node, const char *uname,
 				       phys_addr_t base, phys_addr_t size);
 static int fdt_validate_reserved_mem_node(unsigned long node,
 					  phys_addr_t *align);
-static int fdt_fixup_reserved_mem_node(unsigned long node,
-				       phys_addr_t base, phys_addr_t size);
 
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
 					       phys_addr_t size, bool nomap)
@@ -139,7 +137,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	size = s;
 
 	if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
-		fdt_fixup_reserved_mem_node(node, base, size);
 		pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 			 uname, &base, (unsigned long)(size / SZ_1M));
 	} else {
@@ -305,7 +302,6 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		return -ENOMEM;
 	}
 
-	fdt_fixup_reserved_mem_node(node, base, size);
 	fdt_init_reserved_mem_node(node, uname, base, size);
 
 	return 0;
@@ -494,36 +490,6 @@ extern const struct of_device_id __reservedmem_of_table[];
 static const struct of_device_id __rmem_of_table_sentinel
 	__used __section("__reservedmem_of_table_end");
 
-/**
- * fdt_fixup_reserved_mem_node() - call fixup function for a reserved memory node
- * @node: FDT node to fixup
- * @base: base address of the reserved memory region
- * @size: size of the reserved memory region
- *
- * This function iterates through the reserved memory drivers and calls
- * the node_fixup callback for the compatible entry matching the node.
- *
- * Return: 0 on success, -ENODEV if no compatible match found
- */
-static int __init fdt_fixup_reserved_mem_node(unsigned long node,
-					phys_addr_t base, phys_addr_t size)
-{
-	const struct of_device_id *i;
-	int ret = -ENODEV;
-
-	for (i = __reservedmem_of_table; ret == -ENODEV &&
-	     i < &__rmem_of_table_sentinel; i++) {
-		const struct reserved_mem_ops *ops = i->data;
-
-		if (!of_flat_dt_is_compatible(node, i->compatible))
-			continue;
-
-		if (ops->node_fixup)
-			ret = ops->node_fixup(node, base, size);
-	}
-	return ret;
-}
-
 /**
  * fdt_validate_reserved_mem_node() - validate a reserved memory node
  * @node: FDT node to validate
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 49da515859f2..7a940d1815b6 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -19,8 +19,6 @@ struct reserved_mem {
 
 struct reserved_mem_ops {
 	int	(*node_validate)(unsigned long fdt_node, phys_addr_t *align);
-	int	(*node_fixup)(unsigned long fdt_node, phys_addr_t base,
-			      phys_addr_t size);
 	int	(*node_init)(unsigned long fdt_node, struct reserved_mem *rmem);
 	int	(*device_init)(struct reserved_mem *rmem,
 			       struct device *dev);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..9acb092ab7d6 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -529,19 +529,6 @@ static int __init rmem_cma_validate(unsigned long node, phys_addr_t *align)
 	return 0;
 }
 
-static int __init rmem_cma_fixup(unsigned long node, phys_addr_t base,
-				    phys_addr_t size)
-{
-	int ret = __rmem_cma_verify_node(node);
-
-	if (ret)
-		return ret;
-
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(base, size);
-	return 0;
-}
-
 static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 {
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
@@ -563,6 +550,9 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		return ret;
 	}
 
+	/* Architecture specific contiguous memory fixup. */
+	dma_contiguous_early_fixup(rmem->base, rmem->size);
+
 	if (default_cma)
 		dma_contiguous_default_area = cma;
 
@@ -580,7 +570,6 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 
 static const struct reserved_mem_ops rmem_cma_ops = {
 	.node_validate  = rmem_cma_validate,
-	.node_fixup	= rmem_cma_fixup,
 	.node_init	= rmem_cma_setup,
 	.device_init	= rmem_cma_device_init,
 	.device_release = rmem_cma_device_release,
-- 
2.43.0

