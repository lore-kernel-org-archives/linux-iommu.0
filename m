Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11F398903
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414496; cv=none; b=J2nPdm5M9rZenjjD3QQVDCSukB36ykbREqnZLZ2YNx58SEleLkPb8dJed8oXwWx5xKnfZYj0gWiZm9A60T6FOuqirdcvH17J76eJAgpBTYWEzJCoWU5lii6YLTQx+KLz4Zs12Zf249O6VGiRVv0gpMKSs3PIdJPFzX0I6kAufgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414496; c=relaxed/simple;
	bh=ApzTxJNGXc6vwu+R9APwLyOEWudKLZIA+ySQauXTLyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=b6rA2/P120YpWCJWRtbfr4kMSbVUzhuOJW3OMZtgGicq6HfHGG5jWc9+A6nYd5vgmmmN+fTVTglQJ6ZaB2NFkgHEJgRVg4l0AyAk15+WlRV+OxxfPG1ONPv2kGoe3bMirFIjXECUvoQJ32Q3GzUS9sTPhog9LzVCnTGEVgKdv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q22VrTYk; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q22VrTYk"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260313150813euoutp012556af910d88cd0dbee5336831ba1f09~cbxX2goBE2283422834euoutp01g
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:08:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260313150813euoutp012556af910d88cd0dbee5336831ba1f09~cbxX2goBE2283422834euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773414493;
	bh=uVkBelu4nOXrCEToHgpxpbJSmoGMYEfthgl1FCxyQ+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q22VrTYklKwPz5/JUqBj9GlCybH44mKnzsqxbuQeM7Q+Dxgim68qajX6YUUQAqD2j
	 AL2nhwnFGFAV9CVHv0Is4nSOqo8rStR8BQ89P3QD01n9ImKgzV0yFTv0m2tgbC1eel
	 3h5azmza+8NyP9CBRgXJElbd2wCwCZh7CG8bhnZI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260313150813eucas1p2486c45e5d13f297dac9db334caa258e3~cbxXjVsdn3023330233eucas1p2i;
	Fri, 13 Mar 2026 15:08:13 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313150812eusmtip14ffed3f78a2a054589ad25419ecaccc7~cbxW_dEa-0187001870eusmtip1G;
	Fri, 13 Mar 2026 15:08:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 5/7] of: reserved_mem: rearrange code a bit
Date: Fri, 13 Mar 2026 16:08:00 +0100
Message-Id: <20260313150802.1121442-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313150802.1121442-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313150813eucas1p2486c45e5d13f297dac9db334caa258e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260313150813eucas1p2486c45e5d13f297dac9db334caa258e3
X-EPHeader: CA
X-CMS-RootMailID: 20260313150813eucas1p2486c45e5d13f297dac9db334caa258e3
References: <20260313150802.1121442-1-m.szyprowski@samsung.com>
	<CGME20260313150813eucas1p2486c45e5d13f297dac9db334caa258e3@eucas1p2.samsung.com>

Move __rmem_check_for_overlap() and __rmem_cmp() functions before
fdt_scan_reserved_mem_reg_nodes() to avoid forward declaration and keep
related code close together.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 99 ++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 399cdd11a9ca..b8d4fbcde3b1 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -214,7 +214,55 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
-static void __init __rmem_check_for_overlap(void);
+static int __init __rmem_cmp(const void *a, const void *b)
+{
+	const struct reserved_mem *ra = a, *rb = b;
+
+	if (ra->base < rb->base)
+		return -1;
+
+	if (ra->base > rb->base)
+		return 1;
+
+	/*
+	 * Put the dynamic allocations (address == 0, size == 0) before static
+	 * allocations at address 0x0 so that overlap detection works
+	 * correctly.
+	 */
+	if (ra->size < rb->size)
+		return -1;
+	if (ra->size > rb->size)
+		return 1;
+
+	return 0;
+}
+
+static void __init __rmem_check_for_overlap(void)
+{
+	int i;
+
+	if (reserved_mem_count < 2)
+		return;
+
+	sort(reserved_mem, reserved_mem_count, sizeof(reserved_mem[0]),
+	     __rmem_cmp, NULL);
+	for (i = 0; i < reserved_mem_count - 1; i++) {
+		struct reserved_mem *this, *next;
+
+		this = &reserved_mem[i];
+		next = &reserved_mem[i + 1];
+
+		if (this->base + this->size > next->base) {
+			phys_addr_t this_end, next_end;
+
+			this_end = this->base + this->size;
+			next_end = next->base + next->size;
+			pr_err("OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
+			       this->name, &this->base, &this_end,
+			       next->name, &next->base, &next_end);
+		}
+	}
+}
 
 /**
  * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
@@ -536,55 +584,6 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 	return ret;
 }
 
-static int __init __rmem_cmp(const void *a, const void *b)
-{
-	const struct reserved_mem *ra = a, *rb = b;
-
-	if (ra->base < rb->base)
-		return -1;
-
-	if (ra->base > rb->base)
-		return 1;
-
-	/*
-	 * Put the dynamic allocations (address == 0, size == 0) before static
-	 * allocations at address 0x0 so that overlap detection works
-	 * correctly.
-	 */
-	if (ra->size < rb->size)
-		return -1;
-	if (ra->size > rb->size)
-		return 1;
-
-	return 0;
-}
-
-static void __init __rmem_check_for_overlap(void)
-{
-	int i;
-
-	if (reserved_mem_count < 2)
-		return;
-
-	sort(reserved_mem, reserved_mem_count, sizeof(reserved_mem[0]),
-	     __rmem_cmp, NULL);
-	for (i = 0; i < reserved_mem_count - 1; i++) {
-		struct reserved_mem *this, *next;
-
-		this = &reserved_mem[i];
-		next = &reserved_mem[i + 1];
-
-		if (this->base + this->size > next->base) {
-			phys_addr_t this_end, next_end;
-
-			this_end = this->base + this->size;
-			next_end = next->base + next->size;
-			pr_err("OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
-			       this->name, &this->base, &this_end,
-			       next->name, &next->base, &next_end);
-		}
-	}
-}
 
 /**
  * fdt_init_reserved_mem_node() - Initialize a reserved memory region
-- 
2.34.1

