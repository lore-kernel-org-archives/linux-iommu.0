Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DD2F4A04;
	Thu, 21 Aug 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771381; cv=none; b=JHLYPxEFmKnexUb2r4TeBwxx613uF5dSfsgmGXd8ZNj3ngd4Z+xmVBEdYQLYHO+YLya3tzt1+7AKD3AAYezEqmA+k1lBbfOsvs0B/WSdlbrRR3Ev+wsNtVNhTA7UibBQqMz7R6m7jdQLqa6eMaxqhsyYF+ZzrOeXRG4iC9JZzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771381; c=relaxed/simple;
	bh=QR7xTObWrG8jzW4vzxiOiGa/8ohWF2v8rWNsIuuOCSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgIiqgnY37JLeWereR+sl1Do0s5Va5LKuS09KCDAFsoTvAFVzdD+qknP5SqTqm/0sNw584TEBWNavrXf4rtrrDVi87AtMRwIj8WseYb8yJYrm0qJu6XWXmGxtz2Dd1O66ADK2VWr0C7GtpYMYZ+ejBT9Sqyer6+/eHelf0ZcJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=d2X/qN2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjTQLdHo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="d2X/qN2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjTQLdHo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA5A9EC01FE;
	Thu, 21 Aug 2025 06:16:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 06:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755771378;
	 x=1755857778; bh=aZ1SIc0xkmBczXLaLJjDEf2jfY3SZlOUWpHblhb+Ar8=; b=
	d2X/qN2HasgwR3D0anppPOLnMCcx+cB5b/4CzQWHmuSXFxrxicLcir5RL6vLOv1A
	vL2DXjC8kdOnYBk828e7aioE91eDXL8OGzBOjpwaU+OPxc8RoLE/pLFbUa1qEe7P
	GjTEiLJA+701SG19Ew36FC0V3MKJZKFcV5RC4IGTH9EJIW04X1EFvpEyWWGWF7FB
	tmjoEP45MAKR8Cv5kvhPTJlAbVzfVEFFaCgDVLh07YrM0qTsjEGxRIyGUHzcg2YG
	SJ1PGk6s0JghqStqpgeHsPuhXpxtd4keVm5l+H3BYuSh4eoVhxjyabkYOF1UwmJE
	GF1UwzroCQ4jEsS38vhCPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755771378; x=
	1755857778; bh=aZ1SIc0xkmBczXLaLJjDEf2jfY3SZlOUWpHblhb+Ar8=; b=I
	jTQLdHoXRyh0lcBRkJL8AR7cUsEfHVnmbd/8hbbyRSXzJNaO+vyxQR5LonNAsVw8
	5nEaBwIOUFg8U3PVhSriL5tMGF5sgE5qJ3nPKGMKlcftRod4Gsu8gHtJm/hL+xag
	e8qA30cSaLVFoEAYFLdt1XZu85lOIJQjI2Nn0yG4cOe/zZk8M/6gp52ZaUCNVXBh
	9jyJ5THP+gt55HBCFHk1QHDE+ep22d5wIdaUe9VWkLPzHvFd2D7DoQ8fKpFtrP/i
	bH2IOdV4wvx6wcoVl+6Ze4Hv6qnjQelJhni4ZdSwi3/mUQBWE+GLSPlBGVDvDTsK
	bnTxtjL0Rl/B3vFc0bYbw==
X-ME-Sender: <xms:8vGmaOiaVk1o--AUDWeKUJZrk0mu922792zufMMeW6ORHoelA7dzKw>
    <xme:8vGmaE-G3DcmwYUogK-OQFfFviYdqrV8sgsyi0hfAu_rhQo3lks9Kw7S8c5k97Cxm
    CtxLU2uRWZ61Hnbx7c>
X-ME-Received: <xmr:8vGmaDPJ0aH8GqIIo-M1UowAvuaM_JK1wQOPWQJzSHxSX7bIhNEzTndXpaQE09UstX_ZrKqGnL6S8AEQPIm0xJfBUUF11WauJv7vVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    rhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpth
    htohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinh
    hugidruggvvh
X-ME-Proxy: <xmx:8vGmaICHBK_2IzlRLc8sWBGeBO7B5Ek1HSuxn8OYdiuiRNesReiWRw>
    <xmx:8vGmaHP9VI7JBDLfTPQVFPOQgMCfTwKBa0_5JuLEbZ8qfucIX-7FKg>
    <xmx:8vGmaPce189pOnf44c1kMQVKCKiKZWvNn8mjULC6xZ-cWfk8_TTu2A>
    <xmx:8vGmaI4M5B_JBLv2LfG1826UtbAELbCSc-wZuDF4pOOeYVvHM9uZJw>
    <xmx:8vGmaPxZpkf79qfZEKJCFbsZkwvI7XHvxZi49hjha8uCkqbNXEQEZ5Vf>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:16:17 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 21 Aug 2025 12:15:59 +0200
Subject: [PATCH v2 2/3] iommu/io-pgtable-dart: Add 4-level page table
 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-apple-dart-4levels-v2-2-e39af79daa37@jannau.net>
References: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
In-Reply-To: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9158; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=7O24DxlrQs1hU12SJ8GdEYjzt4f5dD8TZi5pceWfWi4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoxlH1/5ytXefywsLXdIcIJsqqvfyQuO3LMcpljNlV9Q4
 DblzEOjjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABPRE2Rk2Prirerd47Me9xzX
 rrFzO/P4+DZrM5t9RVUBb6Xtn11l02JkeBIq06tuym5pcNq+VDTntmnTik36X+bq/Myc6LT9y/r
 /jAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

DARTs on t602x SoCs are of the t8110 variant but have an IAS of 42,
which means optional support for an extra page table level.

Refactor the PTE management to support an arbitrary level count, and
then calculate how many levels we need for any given configuration.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Sven Peter <sven@kernel.org>
---
 drivers/iommu/io-pgtable-dart.c | 143 ++++++++++++++++++++++++----------------
 include/linux/io-pgtable.h      |   1 +
 2 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 679bda1047977602f468ef905b48aeeebcd7a234..9a63c80a2786bf70fc2544b1f96d2e4c8591c2f8 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -27,8 +27,9 @@
 
 #define DART1_MAX_ADDR_BITS	36
 
-#define DART_MAX_TABLES		4
-#define DART_LEVELS		2
+#define DART_MAX_TABLE_BITS	2
+#define DART_MAX_TABLES		BIT(DART_MAX_TABLE_BITS)
+#define DART_MAX_LEVELS		4 /* Includes TTBR level */
 
 /* Struct accessors */
 #define io_pgtable_to_data(x)						\
@@ -68,6 +69,7 @@
 struct dart_io_pgtable {
 	struct io_pgtable	iop;
 
+	int			levels;
 	int			tbl_bits;
 	int			bits_per_level;
 
@@ -156,44 +158,45 @@ static dart_iopte dart_install_table(dart_iopte *table,
 	return old;
 }
 
-static int dart_get_table(struct dart_io_pgtable *data, unsigned long iova)
+static int dart_get_index(struct dart_io_pgtable *data, unsigned long iova, int level)
 {
-	return (iova >> (3 * data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
-		((1 << data->tbl_bits) - 1);
+	return (iova >> (level * data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
+		((1 << data->bits_per_level) - 1);
 }
 
-static int dart_get_l1_index(struct dart_io_pgtable *data, unsigned long iova)
-{
-
-	return (iova >> (2 * data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
-		 ((1 << data->bits_per_level) - 1);
-}
-
-static int dart_get_l2_index(struct dart_io_pgtable *data, unsigned long iova)
+static int dart_get_last_index(struct dart_io_pgtable *data, unsigned long iova)
 {
 
 	return (iova >> (data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
 		 ((1 << data->bits_per_level) - 1);
 }
 
-static  dart_iopte *dart_get_l2(struct dart_io_pgtable *data, unsigned long iova)
+static dart_iopte *dart_get_last(struct dart_io_pgtable *data, unsigned long iova)
 {
 	dart_iopte pte, *ptep;
-	int tbl = dart_get_table(data, iova);
+	int level = data->levels;
+	int tbl = dart_get_index(data, iova, level);
+
+	if (tbl > (1 << data->tbl_bits))
+		return NULL;
 
 	ptep = data->pgd[tbl];
 	if (!ptep)
 		return NULL;
 
-	ptep += dart_get_l1_index(data, iova);
-	pte = READ_ONCE(*ptep);
+	while (--level > 1) {
+		ptep += dart_get_index(data, iova, level);
+		pte = READ_ONCE(*ptep);
 
-	/* Valid entry? */
-	if (!pte)
-		return NULL;
+		/* Valid entry? */
+		if (!pte)
+			return NULL;
 
-	/* Deref to get level 2 table */
-	return iopte_deref(pte, data);
+		/* Deref to get next level table */
+		ptep = iopte_deref(pte, data);
+	}
+
+	return ptep;
 }
 
 static dart_iopte dart_prot_to_pte(struct dart_io_pgtable *data,
@@ -230,6 +233,7 @@ static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	int ret = 0, tbl, num_entries, max_entries, map_idx_start;
 	dart_iopte pte, *cptep, *ptep;
 	dart_iopte prot;
+	int level = data->levels;
 
 	if (WARN_ON(pgsize != cfg->pgsize_bitmap))
 		return -EINVAL;
@@ -240,31 +244,36 @@ static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
 		return -EINVAL;
 
-	tbl = dart_get_table(data, iova);
+	tbl = dart_get_index(data, iova, level);
+
+	if (tbl > (1 << data->tbl_bits))
+		return -ENOMEM;
 
 	ptep = data->pgd[tbl];
-	ptep += dart_get_l1_index(data, iova);
-	pte = READ_ONCE(*ptep);
-
-	/* no L2 table present */
-	if (!pte) {
-		cptep = iommu_alloc_pages_sz(gfp, tblsz);
-		if (!cptep)
-			return -ENOMEM;
-
-		pte = dart_install_table(cptep, ptep, 0, data);
-		if (pte)
-			iommu_free_pages(cptep);
-
-		/* L2 table is present (now) */
+	while (--level > 1) {
+		ptep += dart_get_index(data, iova, level);
 		pte = READ_ONCE(*ptep);
-	}
 
-	ptep = iopte_deref(pte, data);
+		/* no table present */
+		if (!pte) {
+			cptep = iommu_alloc_pages_sz(gfp, tblsz);
+			if (!cptep)
+				return -ENOMEM;
+
+			pte = dart_install_table(cptep, ptep, 0, data);
+			if (pte)
+				iommu_free_pages(cptep);
+
+			/* L2 table is present (now) */
+			pte = READ_ONCE(*ptep);
+		}
+
+		ptep = iopte_deref(pte, data);
+	}
 
 	/* install a leaf entries into L2 table */
 	prot = dart_prot_to_pte(data, iommu_prot);
-	map_idx_start = dart_get_l2_index(data, iova);
+	map_idx_start = dart_get_last_index(data, iova);
 	max_entries = DART_PTES_PER_TABLE(data) - map_idx_start;
 	num_entries = min_t(int, pgcount, max_entries);
 	ptep += map_idx_start;
@@ -293,13 +302,13 @@ static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(pgsize != cfg->pgsize_bitmap || !pgcount))
 		return 0;
 
-	ptep = dart_get_l2(data, iova);
+	ptep = dart_get_last(data, iova);
 
 	/* Valid L2 IOPTE pointer? */
 	if (WARN_ON(!ptep))
 		return 0;
 
-	unmap_idx_start = dart_get_l2_index(data, iova);
+	unmap_idx_start = dart_get_last_index(data, iova);
 	ptep += unmap_idx_start;
 
 	max_entries = DART_PTES_PER_TABLE(data) - unmap_idx_start;
@@ -330,13 +339,13 @@ static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
 	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	dart_iopte pte, *ptep;
 
-	ptep = dart_get_l2(data, iova);
+	ptep = dart_get_last(data, iova);
 
 	/* Valid L2 IOPTE pointer? */
 	if (!ptep)
 		return 0;
 
-	ptep += dart_get_l2_index(data, iova);
+	ptep += dart_get_last_index(data, iova);
 
 	pte = READ_ONCE(*ptep);
 	/* Found translation */
@@ -353,21 +362,37 @@ static struct dart_io_pgtable *
 dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
 {
 	struct dart_io_pgtable *data;
-	int tbl_bits, bits_per_level, va_bits, pg_shift;
+	int levels, max_tbl_bits, tbl_bits, bits_per_level, va_bits, pg_shift;
+
+	/*
+	 * Old 4K page DARTs can use up to 4 top-level tables.
+	 * Newer ones only ever use a maximum of 1.
+	 */
+	if (cfg->pgsize_bitmap == SZ_4K)
+		max_tbl_bits = DART_MAX_TABLE_BITS;
+	else
+		max_tbl_bits = 0;
 
 	pg_shift = __ffs(cfg->pgsize_bitmap);
 	bits_per_level = pg_shift - ilog2(sizeof(dart_iopte));
 
 	va_bits = cfg->ias - pg_shift;
 
-	tbl_bits = max_t(int, 0, va_bits - (bits_per_level * DART_LEVELS));
-	if ((1 << tbl_bits) > DART_MAX_TABLES)
+	levels = max_t(int, 2, (va_bits - max_tbl_bits + bits_per_level - 1) / bits_per_level);
+
+	if (levels > (DART_MAX_LEVELS - 1))
+		return NULL;
+
+	tbl_bits = max_t(int, 0, va_bits - (bits_per_level * levels));
+
+	if (tbl_bits > max_tbl_bits)
 		return NULL;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
+	data->levels = levels + 1; /* Table level counts as one level */
 	data->tbl_bits = tbl_bits;
 	data->bits_per_level = bits_per_level;
 
@@ -403,6 +428,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	cfg->apple_dart_cfg.n_ttbrs = 1 << data->tbl_bits;
+	cfg->apple_dart_cfg.n_levels = data->levels;
 
 	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i) {
 		data->pgd[i] =
@@ -422,24 +448,31 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
-static void apple_dart_free_pgtable(struct io_pgtable *iop)
+static void apple_dart_free_pgtables(struct dart_io_pgtable *data, dart_iopte *ptep, int level)
 {
-	struct dart_io_pgtable *data = io_pgtable_to_data(iop);
-	dart_iopte *ptep, *end;
-	int i;
+	dart_iopte *end;
+	dart_iopte *start = ptep;
 
-	for (i = 0; i < (1 << data->tbl_bits) && data->pgd[i]; ++i) {
-		ptep = data->pgd[i];
+	if (level > 1) {
 		end = (void *)ptep + DART_GRANULE(data);
 
 		while (ptep != end) {
 			dart_iopte pte = *ptep++;
 
 			if (pte)
-				iommu_free_pages(iopte_deref(pte, data));
+				apple_dart_free_pgtables(data, iopte_deref(pte, data), level - 1);
 		}
-		iommu_free_pages(data->pgd[i]);
 	}
+	iommu_free_pages(start);
+}
+
+static void apple_dart_free_pgtable(struct io_pgtable *iop)
+{
+	struct dart_io_pgtable *data = io_pgtable_to_data(iop);
+	int i;
+
+	for (i = 0; i < (1 << data->tbl_bits) && data->pgd[i]; ++i)
+		apple_dart_free_pgtables(data, data->pgd[i], data->levels - 1);
 
 	kfree(data);
 }
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 138fbd89b1e633b8dad7a931d507c4809e40a171..8a823c6f2b4a88cbb96273d3aaf972b6a4c222a3 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -180,6 +180,7 @@ struct io_pgtable_cfg {
 		struct {
 			u64 ttbr[4];
 			u32 n_ttbrs;
+			u32 n_levels;
 		} apple_dart_cfg;
 
 		struct {

-- 
2.50.1

