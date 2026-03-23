Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F538A718
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260552; cv=none; b=fpqwe4czK1kz7EFdO5CvR2k9BTNZpl/qAjIY/GAGfGE5mj5HCjcTGmkXAvzaj2UWI26D0Wx12NOgWxiSkIYGnCVn5VFEDVJkkODc36qOo/fnZua1bjrPI7szuey8bcpOeWyoXgV0WQh0NBU10kJ7ObNFeCO+TdziWQD1TMUk31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260552; c=relaxed/simple;
	bh=CPcTlIJgIyK5T1j0XTj81N/5/UyvrLhYjXjqTIrrO1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=oCWuACMpCmHQ5o+dJGyODn3/xbpqbGpFoZnE895csRRykNx6FMKT236CkvpKIZl6RChhnJ8DD5aYt1K3lk1iBs80KROsr/23pCtqXGy1COdmvmf6RfynqxHbwIboHDyJMlRQKr1w0THGV+drXCLaSGJUxV1QvtmxB6pOhPNuHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HXS3Oey5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HXS3Oey5"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260323100909euoutp02bd1dfd03b45b6da956178d73447cd472~fcJHMNtAa2330323303euoutp02X
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260323100909euoutp02bd1dfd03b45b6da956178d73447cd472~fcJHMNtAa2330323303euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774260549;
	bh=qDkZBH8D9QGZmacGWO/wLlPET8ve8kNAHImwlz5MpvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXS3Oey5TnA5+rQRTdN/cvH6JSjyqwrxn7HA6CSMVtlsIh67qFvs6orY9mc7fvpLg
	 CINXsR5iNEkk+42ywSN77jcAcfdlaHeN+Rh+1uKmH7jShM11Ssq9esrNEu+/eRDFtc
	 oaKNcsLiM1Sd8G6f20Z0SRRFsRFEHJugn5hUcseQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100909eucas1p20e3bae57f851ea402506f7dbee7ffe3f~fcJG7ohgB3050530505eucas1p2V;
	Mon, 23 Mar 2026 10:09:09 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100908eusmtip2f7188445ed61b2d39d08c30101273f88~fcJGZFtr60953009530eusmtip2t;
	Mon, 23 Mar 2026 10:09:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 2/7] of: reserved_mem: use -ENODEV instead of -ENOENT
Date: Mon, 23 Mar 2026 11:08:56 +0100
Message-Id: <20260323100901.4079171-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323100901.4079171-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260323100909eucas1p20e3bae57f851ea402506f7dbee7ffe3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323100909eucas1p20e3bae57f851ea402506f7dbee7ffe3f
X-EPHeader: CA
X-CMS-RootMailID: 20260323100909eucas1p20e3bae57f851ea402506f7dbee7ffe3f
References: <20260323100901.4079171-1-m.szyprowski@samsung.com>
	<CGME20260323100909eucas1p20e3bae57f851ea402506f7dbee7ffe3f@eucas1p2.samsung.com>

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

