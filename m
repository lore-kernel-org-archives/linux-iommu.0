Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A5301468
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429234; cv=none; b=NT5F1BXSYU3MT5s+IbnlPN3xn6mtVUPcpCXQhL5CqKNLhR8jU+0Eq4etILFmrjWSecjHpYHG5IrAi0y+7l/AiXsuXo+eoqTfuFlPFSz2HvdnmTlXlkkDh5bwL07bdsjokJ8wZ2iyMGP5b6knzChmbUmZVSA+VjdL6d6llSej3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429234; c=relaxed/simple;
	bh=CPcTlIJgIyK5T1j0XTj81N/5/UyvrLhYjXjqTIrrO1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Xvl4HkyiJ0ZAL0KJ+6mnqe7i4OhJnY8YxvCQOttgD4IoJlsG1qcMBFxHec+XBpHQzTPLgRLoGmScpLTGt5HRJCP0gKwqAF32L0RUPEeqVhuij79OBktoEVbdNT+sN8IvhFsJLnEk76//OdREOMm8AC6HrlUnsHr+2ltT6Tj0HDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FY5iUkMt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FY5iUkMt"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260325090031euoutp02eaaf175b5c7e2addbb9fe3884909dbcc~gCfwhN4EP0097400974euoutp02J
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:00:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260325090031euoutp02eaaf175b5c7e2addbb9fe3884909dbcc~gCfwhN4EP0097400974euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774429231;
	bh=qDkZBH8D9QGZmacGWO/wLlPET8ve8kNAHImwlz5MpvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FY5iUkMtR9ARTfG7/tVvrcKFos/ZapigxegUHHHt0vVky5lQ6qCjTliLvuGask1oQ
	 21IwycinJ4E1/p2/flJXeKCCStkMrEvvF8uaS2bNbvl9sZI5ui9VowP/SNvPuwSh2c
	 8+0fWXCDgF7ZVqkiXWdFAzAcncbLr7/irtU2PxMc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260325090031eucas1p185465a9f6f2a06a4b1d0cb2b13a92aef~gCfwMvlkl0601006010eucas1p13;
	Wed, 25 Mar 2026 09:00:31 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260325090030eusmtip1a3370e43b1c03e214df9fdc959e30922~gCfvqWu7e0170001700eusmtip1S;
	Wed, 25 Mar 2026 09:00:30 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 2/7] of: reserved_mem: use -ENODEV instead of -ENOENT
Date: Wed, 25 Mar 2026 10:00:18 +0100
Message-Id: <20260325090023.3175348-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325090023.3175348-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260325090031eucas1p185465a9f6f2a06a4b1d0cb2b13a92aef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325090031eucas1p185465a9f6f2a06a4b1d0cb2b13a92aef
X-EPHeader: CA
X-CMS-RootMailID: 20260325090031eucas1p185465a9f6f2a06a4b1d0cb2b13a92aef
References: <20260325090023.3175348-1-m.szyprowski@samsung.com>
	<CGME20260325090031eucas1p185465a9f6f2a06a4b1d0cb2b13a92aef@eucas1p1.samsung.com>

When given reserved memory region doesn't really support given node,
return -ENODEV instead of -ENOENT. Then fix __reserved_mem_init_node()
function to properly propagate error code different from -ENODEV instead
of silently ignoring it.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 7 ++++---
 kernel/dma/coherent.c        | 2 +-
 kernel/dma/contiguous.c      | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6705b7afebf0..9aff460a0420 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -488,9 +488,10 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 {
 	extern const struct of_device_id __reservedmem_of_table[];
 	const struct of_device_id *i;
-	int ret = -ENOENT;
+	int ret = -ENODEV;
 
-	for (i = __reservedmem_of_table; i < &__rmem_of_table_sentinel; i++) {
+	for (i = __reservedmem_of_table; ret == -ENODEV &&
+	     i < &__rmem_of_table_sentinel; i++) {
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
@@ -574,7 +575,7 @@ static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
 	err = __reserved_mem_init_node(rmem, node);
-	if (err != 0 && err != -ENOENT) {
+	if (err != 0 && err != -ENODEV) {
 		pr_info("node %s compatible matching fail\n", rmem->name);
 		if (nomap)
 			memblock_clear_nomap(rmem->base, rmem->size);
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 34621acbd3c5..64f9ba618e19 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -370,7 +370,7 @@ static const struct reserved_mem_ops rmem_dma_ops = {
 static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 {
 	if (of_get_flat_dt_prop(node, "reusable", NULL))
-		return -EINVAL;
+		return -ENODEV;
 
 #ifdef CONFIG_ARM
 	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 81a2fa4971ee..e6fc6906b5c0 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -483,7 +483,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
-		return -EINVAL;
+		return -ENODEV;
 
 	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
-- 
2.34.1

