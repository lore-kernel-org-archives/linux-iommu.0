Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129738AC8A
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260556; cv=none; b=AFl8VXGMAeZ3ube5lXlG9DUMo1bfFsgZn55KiYSjQ5HHQcnNY+nEqMGSUX6yumwFqWIelPgQiC/ZYGjcCnFavJoY2m9ci73vtpcK1fACdzBTQgsWvJTcTQadbnm51oEgcHghDikhLwhxyg3x2DwhkOqHo392Phh+M9GXt9f36Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260556; c=relaxed/simple;
	bh=UFxD3Oo6DiJipbrK09mt1t60POygPIdXOUvs+xOwOOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QwkQyb539rSk8eocGDYvSNGHAJrIHbsCxyJzqb5sd6vqvNVE3LEalPfyEQ/qMJVuvRB39a9VntzcLw9eB2EMLkI7VDc45B7IAe0KC2C4mvciHF2UV35TXzufVgH/lqkPfyX6yoj4og4CHwDIvqdCOI8XD41AzhDEja5dRetJQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KvJlPcDi; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KvJlPcDi"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260323100913euoutp02c4846e012312817d2c03f7ca568049e7~fcJK-asNu2543725437euoutp02q
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:09:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260323100913euoutp02c4846e012312817d2c03f7ca568049e7~fcJK-asNu2543725437euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774260553;
	bh=972MCStl0Do5pbAEI1ulif24I8j7EecGgHsf7doFi+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvJlPcDiBhJVwKtTD3Qm8FlVlND9yR6iGVq4FvcsX4FAeEEf0tbbgkS9mJ/q3nbel
	 DFd6KXxe8jPfgJ/BGyy8F9IXIIA2xGppJVH50E70+r8KFBJexZSo8YC8Qw3gK6SM2f
	 9jjaW1MhLIRW/27WCcNgb/edxN8O7UfbH9C8vC0s=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260323100911eucas1p173dd26efc96b0907995fda7d551d1db6~fcJI1zBPu2572725727eucas1p1y;
	Mon, 23 Mar 2026 10:09:11 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323100910eusmtip2e9e46f4e66801de4b7b4824f5e72b134~fcJITYgu-0975809758eusmtip2n;
	Mon, 23 Mar 2026 10:09:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
	<saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robin
	Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 5/7] of: reserved_mem: rearrange code a bit
Date: Mon, 23 Mar 2026 11:08:59 +0100
Message-Id: <20260323100901.4079171-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323100901.4079171-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260323100911eucas1p173dd26efc96b0907995fda7d551d1db6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260323100911eucas1p173dd26efc96b0907995fda7d551d1db6
X-EPHeader: CA
X-CMS-RootMailID: 20260323100911eucas1p173dd26efc96b0907995fda7d551d1db6
References: <20260323100901.4079171-1-m.szyprowski@samsung.com>
	<CGME20260323100911eucas1p173dd26efc96b0907995fda7d551d1db6@eucas1p1.samsung.com>

Move __rmem_check_for_overlap() and __rmem_cmp() functions before
fdt_scan_reserved_mem_reg_nodes() to avoid forward declaration and keep
related code close together.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 99 ++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 50 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 61ef148add68..dceaf19f31fb 100644
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
@@ -565,55 +613,6 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
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

