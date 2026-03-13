Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D539B95D
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414494; cv=none; b=fwgSECbNdXxaWPMXqmlbO+gXH7DCskoABup9OCA07mcp896P7lhDJsHnLPavledy3Zni1HG54DTTJXF5uYiDdDOfEuMcL9IiZgOjLfzmbZfgv2n522QEJWodt5LGbQ0uwaBkStgJgVM0LPT5yQu+B+L/YAbx3NWBAZMlLotUM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414494; c=relaxed/simple;
	bh=CPcTlIJgIyK5T1j0XTj81N/5/UyvrLhYjXjqTIrrO1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DqWcD746xTspDRGH6O+HW8OGqNaMPLF8U6OhSIxteoyCnpdMNJyLQrkOq2uc0ZhrxH4yH9qM06FpPbs5w9KUMcbafKmjUc1uXlhDsSZPviUaWhwDD6lim1G1tDeR/45FCDQuG251SJvexQlgzSEJzvp7/K2JA/DpmWmqoWe8NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qsxMxaoh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qsxMxaoh"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260313150811euoutp0261a1a3810ce468458c1477ac40c1ea7d~cbxV1Yy0S0455204552euoutp02C
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260313150811euoutp0261a1a3810ce468458c1477ac40c1ea7d~cbxV1Yy0S0455204552euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773414491;
	bh=qDkZBH8D9QGZmacGWO/wLlPET8ve8kNAHImwlz5MpvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsxMxaohi0gLjHE3laixqacIZ/KENT0VJwNmI622XWnXL2T6H9jKpbfrnT6ZoKKpU
	 tEFgavNWi/yb3Y8biio81k6ycv0mmK9aQgFGrAAfdHHwSAFnFKjPZqDKz5RDyWKxVU
	 z5YbChQyAqqsph3070AcRq5D9EN+2BjxNjXX8Eog=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260313150810eucas1p26191d7bb4791b75bb9f3cc9cf116b1a2~cbxVjAbdh2075420754eucas1p2A;
	Fri, 13 Mar 2026 15:08:10 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150810eusmtip1ed078da71156dfc982e63b6cf3500d4b~cbxU_rpHh0224902249eusmtip1N;
	Fri, 13 Mar 2026 15:08:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/7] of: reserved_mem: use -ENODEV instead of -ENOENT
Date: Fri, 13 Mar 2026 16:07:57 +0100
Message-Id: <20260313150802.1121442-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313150802.1121442-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313150810eucas1p26191d7bb4791b75bb9f3cc9cf116b1a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260313150810eucas1p26191d7bb4791b75bb9f3cc9cf116b1a2
X-EPHeader: CA
X-CMS-RootMailID: 20260313150810eucas1p26191d7bb4791b75bb9f3cc9cf116b1a2
References: <20260313150802.1121442-1-m.szyprowski@samsung.com>
	<CGME20260313150810eucas1p26191d7bb4791b75bb9f3cc9cf116b1a2@eucas1p2.samsung.com>

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

