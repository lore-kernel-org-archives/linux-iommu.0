Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE432D0F5
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429238; cv=none; b=qtIbXbwQmlttVhydbg/QicriEmgFPOlyVxxEo69ZVOiJ/fvhiyuqSsAmn2+NtXp6dcZGtgn5FcW1LwtcxmhdS6XLSKnEwVcyKdfoHpU/red8C/ZtbShOfQ7zV1SO00Ok/DqOpEeI8Hi756GgN4MolNQJok5t8PxRe9M2YLS8yPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429238; c=relaxed/simple;
	bh=nsgAlWuKaSJxQgydmdcmYOzjIpY72npbYNgK+fAINDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BgoW9bA8b+5P2oew1Bl42hnrPaPctTAjVFHvApIHQmetx0wqEDZPgI3L1TlFIGnISf3IWABfpYdUgbr1kCaESSEhn1PiAqzESro7wrQ2gGVyVIF3dsqTKzJq5IyEx257ZjK/VdcCZwxpamPV47GdasktHZva9b5D6fXGSgiXQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O+R8hPse; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O+R8hPse"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260325090034euoutp01c137341762c1aa312afb9d5f4ff6f0f3~gCfzA0kGJ2584925849euoutp01S
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260325090034euoutp01c137341762c1aa312afb9d5f4ff6f0f3~gCfzA0kGJ2584925849euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774429234;
	bh=d+89c32tU4lTTTppNlFl+vXaQCaUGhisq2Ypb82nMCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+R8hPsenLyzl0FkSCF0zsxaWOjqsB2sn2m6zYEGWn/RoU523pfK0Y3UReyR8ZDsS
	 /hlkReXM02nvJGlnVmWxD2aAhCXNrdZpnHs7Ry1BaYLzK2bvm6mfADxMTsxKamcUVu
	 Y4xy2NwxGgtKwF/E3Z9Y+pacgHdsL/OIF4Q/nEuo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260325090034eucas1p17e2eefa714bbc8cd4828a7e88c2dbfd3~gCfytXeNy1762717627eucas1p1k;
	Wed, 25 Mar 2026 09:00:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260325090033eusmtip154597783022f9c979a4fa8fc7bb4a0d4~gCfyKkZO_0170001700eusmtip1T;
	Wed, 25 Mar 2026 09:00:33 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 6/7] of: reserved_mem: clarify fdt_scan_reserved_mem*()
 functions
Date: Wed, 25 Mar 2026 10:00:22 +0100
Message-Id: <20260325090023.3175348-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325090023.3175348-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260325090034eucas1p17e2eefa714bbc8cd4828a7e88c2dbfd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325090034eucas1p17e2eefa714bbc8cd4828a7e88c2dbfd3
X-EPHeader: CA
X-CMS-RootMailID: 20260325090034eucas1p17e2eefa714bbc8cd4828a7e88c2dbfd3
References: <20260325090023.3175348-1-m.szyprowski@samsung.com>
	<CGME20260325090034eucas1p17e2eefa714bbc8cd4828a7e88c2dbfd3@eucas1p1.samsung.com>

Rename fdt_scan_reserved_mem_reg_nodes() to fdt_scan_reserved_mem_late()
to clearly show how it differs from fdt_scan_reserved_mem() and update
description of both functions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 24 +++++++++++++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 2967e4aff807..104e697bee7b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1295,7 +1295,7 @@ void __init unflatten_device_tree(void)
 	void *fdt = initial_boot_params;
 
 	/* Save the statically-placed regions in the reserved_mem array */
-	fdt_scan_reserved_mem_reg_nodes();
+	fdt_scan_reserved_mem_late();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index df0bb00349e0..0ae16da066e2 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -186,7 +186,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void __init fdt_scan_reserved_mem_reg_nodes(void);
+void __init fdt_scan_reserved_mem_late(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f9b6d3ebcc20..037e3d74dde1 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -265,16 +265,15 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
- * reserved memory regions.
+ * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
+ * memory regions.
  *
- * This function is used to scan through the DT and store the
- * information for the reserved memory regions that are defined using
- * the "reg" property. The region node number, name, base address, and
- * size are all stored in the reserved_mem array by calling the
- * fdt_reserved_mem_save_node() function.
+ * This function is used to scan again through the DT and initialize the
+ * "static" reserved memory regions, that are defined using the "reg"
+ * property. Each such region is then initialized with its specific init
+ * function and stored in the global reserved_mem array.
  */
-void __init fdt_scan_reserved_mem_reg_nodes(void)
+void __init fdt_scan_reserved_mem_late(void)
 {
 	const void *fdt = initial_boot_params;
 	phys_addr_t base, size;
@@ -328,7 +327,14 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 /*
- * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
+ * fdt_scan_reserved_mem() - reserve and allocate memory occupied by
+ * reserved memory regions.
+ *
+ * This function is used to scan through the FDT and mark memory occupied
+ * by all static (defined by the "reg" property) reserved memory regions.
+ * Then memory for all dynamic regions (defined by size & alignment) is
+ * allocated, a region specific init function is called and region information
+ * is stored in the reserved_mem array.
  */
 int __init fdt_scan_reserved_mem(void)
 {
-- 
2.34.1

