Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282938A73D
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260557; cv=none; b=R81jRaPKxzios09mSH62xZXzao81aGRGIFz4FY+vUJqzGzi8M6BkIU5XEo33jRAxqb0eV7ahBHl64U3W6PpjGDBOaPxofAZ3h+OVw7neI7tUrcxyx4SUidHrha0ucOvD/YR0mzJ+ftgP0ximYBgVqhbzeKEgKKWCv1o0Km3sejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260557; c=relaxed/simple;
	bh=iByLlERWMi84pzf4bnyBGpGXQxAdR8qksLE2GMzDhr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Nf0hehQ91yrHvF9beoKJ+x7WWYZXd0mlbTCEIP2o/Xdv4eSD2IANLRBdcO2y2fBs84rpzVHvNmppgMj5xfXpYWW7WInQl6ZbCUaoAue+cqMDyy34tGg302dlcVpia85LsCCDv8f3u8P9Ius7mS4dLCwInF5IDTwTm1yP19ANfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CKfa4HmP; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CKfa4HmP"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260323100914euoutp010e1b965a03a7536ccf51d7f98c4a8852~fcJLSOZ_X1424614246euoutp01n
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260323100914euoutp010e1b965a03a7536ccf51d7f98c4a8852~fcJLSOZ_X1424614246euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774260554;
	bh=Zbv558l0JXbA/evotEn7j2Yp5sFsNk7kEVzz156NoGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKfa4HmPLdhrTKj9GAspBvrBdZaibIjlc7dUnoD561qJf5/RTtdU/sTy1rczsDI+R
	 Leqf8l2WKtGdnQCymPl7H89+cf2fGRfVc0Gmp3a0BMoo+7dWtguHdJUZNBPTcI/aLJ
	 tTYxSkfX/ofWAYEZFiLJlVPLmphBJ7jgJdRScHiY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260323100912eucas1p1aadb718d2c0eea3404aa5be379ae21c1~fcJKGQmYG2578125781eucas1p1t;
	Mon, 23 Mar 2026 10:09:12 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100912eusmtip20108a44eb532b22a6560aefbc89b4f9a~fcJJjxuTO0899908999eusmtip2j;
	Mon, 23 Mar 2026 10:09:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 7/7] of: reserved_mem: rework
 fdt_init_reserved_mem_node()
Date: Mon, 23 Mar 2026 11:09:01 +0100
Message-Id: <20260323100901.4079171-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323100901.4079171-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260323100912eucas1p1aadb718d2c0eea3404aa5be379ae21c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323100912eucas1p1aadb718d2c0eea3404aa5be379ae21c1
X-EPHeader: CA
X-CMS-RootMailID: 20260323100912eucas1p1aadb718d2c0eea3404aa5be379ae21c1
References: <20260323100901.4079171-1-m.szyprowski@samsung.com>
	<CGME20260323100912eucas1p1aadb718d2c0eea3404aa5be379ae21c1@eucas1p1.samsung.com>

Move the content of fdt_reserved_mem_save_node() to
fdt_init_reserved_mem_node() function. Initialization is no longer
performed in two steps as it was initially, so fdt_reserved_mem_save_node()
name is a bit misleading and that function now performs full initialization
of the reserved memory region.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 60 ++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 801451d034fa..661116034692 100644
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
 
@@ -619,21 +595,34 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
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
@@ -643,6 +632,7 @@ static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 			memblock_clear_nomap(rmem->base, rmem->size);
 		else
 			memblock_phys_free(rmem->base, rmem->size);
+		return;
 	} else {
 		phys_addr_t end = rmem->base + rmem->size - 1;
 		bool reusable =
@@ -654,6 +644,8 @@ static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 			reusable ? "reusable" : "non-reusable",
 			rmem->name ? rmem->name : "unknown");
 	}
+
+	reserved_mem_count++;
 }
 
 struct rmem_assigned_device {
-- 
2.34.1

