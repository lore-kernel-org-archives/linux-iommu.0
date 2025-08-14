Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1D2E8899;
	Thu, 14 Aug 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160857; cv=none; b=X5tfBJt0vLnmkanL2yx4v/c8S5CsSXB/QokgdLJjk+ppgMIklFfimfl0s+94aNJzObVQ9yogQlf1OY4F08c+CvNgEepu/58E+349LOSI3eAO7PpIpFV6MTS9B47fmkXHRDxKFV88kplkpbPPkfVlSHJS9yEOGa44olm70HkptqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160857; c=relaxed/simple;
	bh=u34tLGr9zKf+eUJvu9KqUtTGJjAwKIJZ0Bs64nHQ7BQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuTcdqq8SBQGxIgg1TREXV4XLLxJVeMLGKfG8OeXfIHS+brG50xk7gXUBfwJtpHCMyMYknEA04AIk0vQbwcfuD3bwsRtzmRbW16poqul2xJgikqJTQ9/qpeYPrutVN2w2ZCf6gdL5Cb8Xv54XWBYJcBEnPQlUmUBl8RLvdewQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=cnFR2QcV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8NdXwMM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="cnFR2QcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8NdXwMM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 11EFFEC021B;
	Thu, 14 Aug 2025 04:40:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 14 Aug 2025 04:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755160855;
	 x=1755247255; bh=aKXq92/heg/5bgLIDr5SS2U1n4Nz7US13osiHoCM+c4=; b=
	cnFR2QcVPA/qoKaoex4smscDklnVgmbGjFLdtyk7NRo8gi07GxZAV+vQWbmzN2vU
	TdLFMYB2Do2fQjHUgDO/G/6+CPVBMn044ojZGxYRkdJedwdQ2pSenqt0wXdRCHw5
	xzWWjTyQcl2euEICyUpX//VDhxc8EXDzu7H2nBJ2Ec+8GodN/UdK4dab7wnxCKZi
	DvnVXsGmP/oDf92XqEpU0uGx/JX/iqnQ3mxqWCXvRO+XjR6cTXLSonCJiU4Xl+G+
	bDCvyq0N5stto1d6OnJfCzCyl8A8aPQhdZl6Tchiq43iSraQKNWCoRYN0rHKWmH+
	FLqhfIEhVb8uLZCv/yFdjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755160855; x=
	1755247255; bh=aKXq92/heg/5bgLIDr5SS2U1n4Nz7US13osiHoCM+c4=; b=m
	8NdXwMMmvOJgRwjCPoQi+XonS86fVyre0yqAfRo0D0qTPh8XSn/rR1Qoa7g7SyCF
	gZ7QvMcXjB6nwTG3tGF4P9atMbuRGJEmKNqvYci8AIC/3ENUttLa9Ml9LNYhpyBF
	wLS+un5dmk2xw/Dj9DIBkKiAM/exDz9HR/JaLNggIVmG2Rs+sddSVt4a3wklBtQO
	B+YLb8ToS2Z9Lb8TsZzGPZiSgNMpscwDU2piJftU/dL68YvHrk0FCPvKourtzn3E
	wchuA8MVuBr18TuzIx21OQ6oLcPA7XdOuD7rvyx/oRe/5ouRyK0aJM9UaxS0eJW/
	JS+hX4UWQVSvIMWeBUeVg==
X-ME-Sender: <xms:FqGdaITckPUqFrtE6XQDbNFGBpcHaNkzgEie24fyuQYOVU6UvCHFbg>
    <xme:FqGdaLudbPPdCOkXfUfhna_nZgPEVaJcJ3Mqa7fOZFnBYtBH1M3lxR7osLO1R6fjZ
    gimhZBflg-d77zaT2Y>
X-ME-Received: <xmr:FqGdaC_KxjLx8Q86xmhlhz0zKsTp51cuq7MWfoMuX6EwqluAtl6BfVieO5lIkSQ8EvfcbGUNOgfoChBYX3M1--Cmsz8kBpC8Mv3QZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdr
    shhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpth
    htohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvg
    hlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhgvrghlsehg
    ohhmphgrrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FqGdaMxaiPZsiLJWek__OqJG8JzjhvoJP27Xzt5AraG-EfIQOBSoFw>
    <xmx:FqGdaM88XCNqtcSRjq48QkNW0R8LoKKNzR2lY5lOMlc2sZM8qp2crg>
    <xmx:FqGdaCPBqfdNSE811Vzf_1xpjtzEt6bfTkNasLfulp1FKLdM21dIgA>
    <xmx:FqGdaEqh1vqkEfsxos3e10go5U5fwXs8GZkb6RqdryuwjQFNTl_RQg>
    <xmx:F6GdaBir-dCtpPlOsgvKurWHxG_I0qK3bZHmiK8tFm8ikJddiHAINO1B>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 04:40:54 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 14 Aug 2025 10:40:25 +0200
Subject: [PATCH 2/3] iommu: io-pgtable: Add 4-level page table support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-apple-dart-4levels-v1-2-db2214a78c08@jannau.net>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
In-Reply-To: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9115; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=Q7TPabYm+Pa2jKndVkDAFT0tfiuAYSdcrbJxMFXXxTI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoy5C/kq5S5sWsQptm4C/6/7jRtmxDN/V8oVVF+1M7V5+
 u3VuYZeHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACbioc7IcHHKSofQlZKB5Uki
 Zax17vrlm27lRqgenLAr5+OcnkqWREaGLZuK+VljtvMIr5qcyJm0RGoj29G+82tkPlVdult+/po
 4MwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

DARTs on t602x SoCs are of the t8110 variant but have an IAS of 42,
which means optional support for an extra page table level.

Refactor the PTE management to support an arbitrary level count, and
then calculate how many levels we need for any given configuration.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
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

