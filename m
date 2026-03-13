Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733463AC0D0
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414497; cv=none; b=Siu8UtofVEJ44dodMXgBvz9YzZcyHA+A58aUTUoCYAi5IgDYvD+zQY4bdlygCeW/g2EzuHNgdyhLTOzGVyUK2NObAmYG8EoLmbYGU/fz3sL1r54RdNGVvszEuQ8xybOR7VLkEXpoje+kz7fCUuqPERWYDuVinfNRdw63YOPGr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414497; c=relaxed/simple;
	bh=Q8g621Scc8o4sekXP6R790Mg+F3zpyA5JJ2zH4/kIio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=glHFJ5VniudfXUTxNsMWxFoLQw0TDevutJoWPAg761j/a0+S+1Qo9UjdQs2fmML/0GKAMJztoH6qojsf/5R6bUR2mMB37Iz3BNQH9iJ6xDsnxjAcTv50JI43R2Pz5MTPf/hkZRWahwmtXhRSmsnASwSlq8c5A7N7lvsbSZwW9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fKPW/S6+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fKPW/S6+"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260313150814euoutp02f22b5092fb540ab68a2f922d2c9c22e5~cbxYjnLJm0455304553euoutp02F
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260313150814euoutp02f22b5092fb540ab68a2f922d2c9c22e5~cbxYjnLJm0455304553euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773414494;
	bh=rktRrrVukWEfNnrdm/R8KEtwrP6KWG+D26ZM/qAdblU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKPW/S6+kFIGl7cXPWpT7l9ATPs3Yyz8LWlnjiGSJHPq3Rm4cxYSoh+4ndkTJ0B6a
	 2AYD5Z9CGaGU2rk7yQfMyS/liBfc0CaPCZcFkB+PkUvlartOwfPJft5ioPzrxsWmsq
	 sfgDoJrOlswdoerCICXXlzDi3SZ1/T+CJyjR+ZtQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260313150813eucas1p275aa47663c75455fbec8f6a315c03f38~cbxYNSt030094900949eucas1p2X;
	Fri, 13 Mar 2026 15:08:13 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150813eusmtip161eb6110ea66f1653196ef72d58ae921~cbxXpGXW91821718217eusmtip1b;
	Fri, 13 Mar 2026 15:08:13 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 6/7] of: reserved_mem: clarify fdt_scan_reserved_mem*()
 functions
Date: Fri, 13 Mar 2026 16:08:01 +0100
Message-Id: <20260313150802.1121442-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313150802.1121442-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313150813eucas1p275aa47663c75455fbec8f6a315c03f38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260313150813eucas1p275aa47663c75455fbec8f6a315c03f38
X-EPHeader: CA
X-CMS-RootMailID: 20260313150813eucas1p275aa47663c75455fbec8f6a315c03f38
References: <20260313150802.1121442-1-m.szyprowski@samsung.com>
	<CGME20260313150813eucas1p275aa47663c75455fbec8f6a315c03f38@eucas1p2.samsung.com>

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
index 331646d667b9..43a0944ca462 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1274,7 +1274,7 @@ void __init unflatten_device_tree(void)
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
index b8d4fbcde3b1..229573d6dacb 100644
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
+ * the "static" reserved memory regions, that are defined using the "reg"
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

