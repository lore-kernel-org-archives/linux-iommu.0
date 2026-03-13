Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D813A8759
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414498; cv=none; b=Qws4Wxa7wug9eDM/2EHhBELHNFdzG3NYNgE0wLUKoDRK6gJsI69UZ3YFPZFhfOd21UF6BaqObnIOVwB7/Ao/IJ0ZGOLem5XbNeTeo68SMO/rwlXIyABmPJvvoHJ5DGwmH8rVRdIU7lLTyRug5XcxfJIBHsxs4AXg5gSHA6PKL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414498; c=relaxed/simple;
	bh=415QeymUE5SmY7dXt8oQM9rtzP5wJkBAbH2H7BY6nIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=u703rS5qDXEfAgjppt5ZaMl69hMSyD+k6ES5inqdJ7J5UHAE9vLRH9jKFFdd4z6WBm0AUhxYwrQdrX0VIoiEGAjxWrpDr1/l64bjYWrtTCusTCdIFXXHnsXYn3VGMCUBjuQDOD5d08+0Xgdq3odFiXZTlnP8t4n0K/djSCTXyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M+Ahlbkt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M+Ahlbkt"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260313150814euoutp02f5188153cb08498a72cb4fd310ddfbca~cbxZHbiKu0098300983euoutp02_
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260313150814euoutp02f5188153cb08498a72cb4fd310ddfbca~cbxZHbiKu0098300983euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773414494;
	bh=cNRB2bVdaO0e0Tm9fiFGo+z5sEqF/mw7wNSwebObrUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+AhlbktAAP6vXnQqOHdc6IrEP9wUOjgwkSn5Pxeg6L74TN7ffySVmi01+RS41u8q
	 uf9mYtDtvr71K1GQyR0jojt9AWBWV0irDY/YbTRIpSWwECB7m+qCGa0g0DvFpSQBJG
	 YMxq9zd/ny6Q9VOKji09HbvsaFE8SntHxgSUhUIc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150814eucas1p14203b667c73825e16a3d5d6430e5e7b6~cbxY39fhn2140221402eucas1p1Z;
	Fri, 13 Mar 2026 15:08:14 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150813eusmtip117becfbcee6e6475d5e56b0134cdcd73~cbxYTOPyE0187001870eusmtip1H;
	Fri, 13 Mar 2026 15:08:13 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 7/7] of: reserved_mem: rework fdt_init_reserved_mem_node()
Date: Fri, 13 Mar 2026 16:08:02 +0100
Message-Id: <20260313150802.1121442-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313150802.1121442-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313150814eucas1p14203b667c73825e16a3d5d6430e5e7b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260313150814eucas1p14203b667c73825e16a3d5d6430e5e7b6
X-EPHeader: CA
X-CMS-RootMailID: 20260313150814eucas1p14203b667c73825e16a3d5d6430e5e7b6
References: <20260313150802.1121442-1-m.szyprowski@samsung.com>
	<CGME20260313150814eucas1p14203b667c73825e16a3d5d6430e5e7b6@eucas1p1.samsung.com>

Move the content of fdt_reserved_mem_save_node() to
fdt_init_reserved_mem_node() function. Initialization is no longer
performed in two steps as it was initially, so
fdt_reserved_mem_save_node() name is a bit misleading and that function
actually perform full initialization of the reserved memory region.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 58 ++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 229573d6dacb..7146c1ba6ae1 100644
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
@@ -316,12 +293,14 @@ void __init fdt_scan_reserved_mem_late(void)
 
 		if (size) {
 			uname = fdt_get_name(fdt, child, NULL);
-			fdt_reserved_mem_save_node(child, uname, base, size);
+			fdt_init_reserved_mem_node(child, uname, base, size);
 		}
 	}
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
+
+
 }
 
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
@@ -515,9 +494,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	}
 
 	fdt_fixup_reserved_mem_node(node, base, size);
+	fdt_init_reserved_mem_node(node, uname, base, size);
 
-	/* Save region in the reserved_mem array */
-	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -590,21 +568,31 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 	return ret;
 }
 
-
 /**
  * fdt_init_reserved_mem_node() - Initialize a reserved memory region
- * @rmem: reserved_mem struct of the memory region to be initialized.
  * @node: fdt node of the initialized region
  *
  * This function is used to call the region specific initialization
- * function for a reserved memory region.
+ * function for a reserved memory region save all region specific data to
+ * reserved_mem array to let of_reserved_mem_lookup() function find it.
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
@@ -614,6 +602,7 @@ static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 			memblock_clear_nomap(rmem->base, rmem->size);
 		else
 			memblock_phys_free(rmem->base, rmem->size);
+		return;
 	} else {
 		phys_addr_t end = rmem->base + rmem->size - 1;
 		bool reusable =
@@ -624,7 +613,10 @@ static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem,
 			nomap ? "nomap" : "map",
 			reusable ? "reusable" : "non-reusable",
 			rmem->name ? rmem->name : "unknown");
+
 	}
+
+	reserved_mem_count++;
 }
 
 struct rmem_assigned_device {
-- 
2.34.1

