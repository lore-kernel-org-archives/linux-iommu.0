Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12852350A1B
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429239; cv=none; b=aXK1758lStmqIVskNA4lc6RpVDezpSlNAdrp9ol9yBSdxrgAgvI749VtUPw1oLsM/LStHGyYtfEct9iYRDmRUjJd81dwRzEzWHAEvxTisGU2oeAtx9p6xpJLNs/UIbC4dpgsS6/PoHMMk5hGXLnmveXuX77OEEqazOA4lYwvY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429239; c=relaxed/simple;
	bh=P3AMQcGHZ8YR9ZVybND3kBp0O9Gr5HyF4BZhB4a6bUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kvDBMAkFyUfGVFVpUmdWtW4ZUKvW1BD+31kduUz2GLkMDqqe5mgRy4/xoE7WCfXLdmkaXTZWUCicFhPU2i1Ujxv/ZxwC5w7Sq9Jexrzd6EgW/1sqqKUAWjBktVy2vwZZEJSYzJiLGrhqSVXrwJPzKf9OqklJsiuSs9Zc2D9kvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ivAGQBxD; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ivAGQBxD"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260325090034euoutp024e61f7925c7c157cff7b150b11108da9~gCfzh7ZB-0326903269euoutp02g
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260325090034euoutp024e61f7925c7c157cff7b150b11108da9~gCfzh7ZB-0326903269euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774429234;
	bh=VJvoL7Svez6wRSfUGCmBuRi8m+f/G0Wc/DykecDJV2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivAGQBxDvj1e/LcGA0Bnu3dhxJuZBzp4M50oH5+6E4DArMz/uHngUdD86AE9LeJHH
	 OXmv5T08PnWBDe8tdbqg5gTg2SnZvZqDytFG6Kss0aytHGJ6g34RCOiYvl2bJo6kgv
	 5E2uKEWqIPu7qiux7fKT1zXT+dcmMuXs6s0Ee/zE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260325090034eucas1p2fb10744edcc6cf8550e9855973492a00~gCfzU3Jn23169331693eucas1p2i;
	Wed, 25 Mar 2026 09:00:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260325090034eusmtip15244f1412a032a5a834b55e8229409f2~gCfyy4X3J0318403184eusmtip1m;
	Wed, 25 Mar 2026 09:00:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 7/7] of: reserved_mem: rework
 fdt_init_reserved_mem_node()
Date: Wed, 25 Mar 2026 10:00:23 +0100
Message-Id: <20260325090023.3175348-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325090023.3175348-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260325090034eucas1p2fb10744edcc6cf8550e9855973492a00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325090034eucas1p2fb10744edcc6cf8550e9855973492a00
X-EPHeader: CA
X-CMS-RootMailID: 20260325090034eucas1p2fb10744edcc6cf8550e9855973492a00
References: <20260325090023.3175348-1-m.szyprowski@samsung.com>
	<CGME20260325090034eucas1p2fb10744edcc6cf8550e9855973492a00@eucas1p2.samsung.com>

Move the content of fdt_reserved_mem_save_node() to
fdt_init_reserved_mem_node() function. Initialization is no longer
performed in two steps as it was initially, so
fdt_reserved_mem_save_node() name is a bit misleading and that function
now performs full initialization of the reserved memory region.

This also fixes the problem of keeping pointers to the regions, which
failed to initialize, what might cause issues when such region is
assigned to the device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 62 ++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 037e3d74dde1..8d5777cb5d1b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -102,36 +102,13 @@ static void __init alloc_reserved_mem_array(void)
 	reserved_mem = new_array;
 }
 
-static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
-					      unsigned long node);
+static void fdt_init_reserved_mem_node(unsigned long node, const char *uname,
+				       phys_addr_t base, phys_addr_t size);
 static int fdt_validate_reserved_mem_node(unsigned long node,
 					  phys_addr_t *align);
 static int fdt_fixup_reserved_mem_node(unsigned long node,
 				       phys_addr_t base, phys_addr_t size);
 
-/*
- * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
- */
-static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-					      phys_addr_t base, phys_addr_t size)
-{
-	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
-
-	if (reserved_mem_count == total_reserved_mem_cnt) {
-		pr_err("not enough space for all defined regions.\n");
-		return;
-	}
-
-	rmem->name = uname;
-	rmem->base = base;
-	rmem->size = size;
-
-	/* Call the region specific initialization function */
-	fdt_init_reserved_mem_node(rmem, node);
-
-	reserved_mem_count++;
-}
-
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
 					       phys_addr_t size, bool nomap)
 {
@@ -316,7 +293,7 @@ void __init fdt_scan_reserved_mem_late(void)
 
 		if (size) {
 			uname = fdt_get_name(fdt, child, NULL);
-			fdt_reserved_mem_save_node(child, uname, base, size);
+			fdt_init_reserved_mem_node(child, uname, base, size);
 		}
 	}
 
@@ -515,9 +492,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	}
 
 	fdt_fixup_reserved_mem_node(node, base, size);
+	fdt_init_reserved_mem_node(node, uname, base, size);
 
-	/* Save region in the reserved_mem array */
-	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -619,30 +595,46 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 	return ret;
 }
 
-
 /**
  * fdt_init_reserved_mem_node() - Initialize a reserved memory region
- * @rmem: reserved_mem struct of the memory region to be initialized.
  * @node: fdt node of the initialized region
+ * @uname: name of the reserved memory node
+ * @base: base address of the reserved memory region
+ * @size: size of the reserved memory region
  *
- * This function is used to call the region specific initialization
- * function for a reserved memory region.
+ * This function calls the region-specific initialization function for a
+ * reserved memory region and saves all region-specific data to the
+ * reserved_mem array to allow of_reserved_mem_lookup() to find it.
  */
-static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
-					      unsigned long node)
+static void __init fdt_init_reserved_mem_node(unsigned long node, const char *uname,
+					      phys_addr_t base, phys_addr_t size)
 {
 	int err = 0;
 	bool nomap;
 
+	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
+
+	if (reserved_mem_count == total_reserved_mem_cnt) {
+		pr_err("not enough space for all defined regions.\n");
+		return;
+	}
+
+	rmem->name = uname;
+	rmem->base = base;
+	rmem->size = size;
+
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
 	err = __reserved_mem_init_node(rmem, node);
 	if (err != 0 && err != -ENODEV) {
 		pr_info("node %s compatible matching fail\n", rmem->name);
+		rmem->name = NULL;
+
 		if (nomap)
 			memblock_clear_nomap(rmem->base, rmem->size);
 		else
 			memblock_phys_free(rmem->base, rmem->size);
+		return;
 	} else {
 		phys_addr_t end = rmem->base + rmem->size - 1;
 		bool reusable =
@@ -654,6 +646,8 @@ static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 			reusable ? "reusable" : "non-reusable",
 			rmem->name ? rmem->name : "unknown");
 	}
+
+	reserved_mem_count++;
 }
 
 struct rmem_assigned_device {
-- 
2.34.1

