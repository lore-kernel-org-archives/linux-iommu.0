Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1F20409A
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148389; cv=none; b=aWnooqChuobagsIZSUYOFy5rmhv6tIbAnTpxRye1qRyib+Ma8JCvIoQe6tFNti4uLVC7a7Ka65/t9XpzPME3ohr9UfiHQdKh430soIve194gj4z4BatXxie5gC6MFx1kPvG0sPkB+SVtKxs/YsWi/YMZ5iU/6/84vAvd/tW6Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148389; c=relaxed/simple;
	bh=6aetjt+OMEklLKEfHABzDG4+2U83JPgAgo13s+AJ9Ps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLC98K9V0yIKYpYpOTyV8BTdo3iQgvPU/FQlX6o5XRsVe1s3xNHYzrptnv+NS3CI1nKWMfe4hAEai0RiURU+jZ4j8OiGT4a+AsvD4bZsVAqv00Chb62rZ0V6ZW6psK8AeTOqw/Yg9KK8AtIviUhNE6XPLhMixzcwIx05nsbpmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YemC5JhQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YemC5JhQ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso40933065e9.1
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733148385; x=1733753185; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RF9JX+BAZDIHBPnUvFPOFh27GXZinqCyp9d856qhI=;
        b=YemC5JhQhTT4q2hDPN2ME3ly5lgJLPnm7q/vVPZB95EyHZQGOqr1ImRQgdfBazlW5H
         l7/nEXuH0uZQORAyFaOn6d7qc6BHjStVJZlidvf6u/L4CsbHtkJTl4csvXUPol6G2/pE
         9PJZAsNlGSDGiR1WzmtQ9UxCgBxib11ZDVNViSKRElH2BWlNEPuNGCT2HvriPp5OlbQO
         eeNrDXuWgDaxZlJwsiX2HZBHgRA5ScKGz60pW+z+37MJ6RLn8vGCiTHjCwZQWWBZ1H15
         k+apxJBSedz3KPidnvcbKeLLnitHVu4GzpusZFTWzDeMuoVjYZ2+460LllFD3+s1faxn
         /KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148385; x=1733753185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RF9JX+BAZDIHBPnUvFPOFh27GXZinqCyp9d856qhI=;
        b=ZUMw/dmhKr0qbSpwmEeHX0tfpO3Kk7ORS4Yhe0IKGp5DSwbMyAvq7Fv27X5bBCXW1c
         TjY3KbpDDw1ycNnXZcDr8GkjqYzSFHn1BCj4pP5+PqrPydTT5pnlgA4rrtlzdXu4CRqA
         LX7GEQABy8xHgVlb+YWRsZOgcRNloq+2tFPdozDeG9KG9OACMYXFj45N4e+GCYG33RBr
         She7S6yotbPEB9C3SmGpB3b++DBD05jj0BBuTmW3FJhWM87jXfZTErTmKHusjFkBD/Bu
         /DQTrrZ+42GZpMOXqBhOYzqz1dfYu5Sk9gZlh3m//NcMhn/xhOJY6KG0I/IO5F2BIFxi
         VUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUjblX2YhgwMAkzqaSudJuFkcG1gGfhuy6O3tIltSSjV5V/dcBzL42C/l8glxeMZ8T1U+ipg==@lists.linux.dev
X-Gm-Message-State: AOJu0YygqKXyXxrV+JRQCBv6A+qqF6OzT2zhaGqAIJXfLz6wGR3zLbfS
	WRqO7jshkcgkSz+tl9C0Ac3ZuQpCLc4QNoYAnwSAib5pdv1eaOeWcst6u2/ejYzgAqmQNLVGvhS
	JgiNBXpDJJQ==
X-Google-Smtp-Source: AGHT+IGbcuRYpTh4YD2s/LlLvQ+RLHNmyee/bZzsqF0w9Suqv7VzmqnzD+QY/tWrJ1jck1m9Bz5q92qEuZjfxg==
X-Received: from wman26.prod.google.com ([2002:a05:600c:6c5a:b0:434:9fab:eb5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5493:b0:432:d735:cc71 with SMTP id 5b1f17b1804b1-434a9de8e1emr227230595e9.25.1733148385023;
 Mon, 02 Dec 2024 06:06:25 -0800 (PST)
Date: Mon,  2 Dec 2024 14:06:03 +0000
In-Reply-To: <20241202140604.422235-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241202140604.422235-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202140604.422235-2-smostafa@google.com>
Subject: [PATCH v2 1/2] iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, io-pgtable-arm uses concatenation only if it is
possible at level 0, which misses a case where concatenation is
mandatory at level 1 according to R_SRKBC in Arm spec DDI0487 K.a.

Also, that means concatenation can be used when not mandated,
contradicting the comment on the code. However, these cases can only
happen if the SMMUv3 driver is changed to use ias != oas for stage-2.

This patch re-writes the code to use concatenation only if mandatory,
fixing the missing case for level-1 and granule 16K with PA = 40 bits.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 45 +++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6b9bb58a414f..0055876b3527 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -223,6 +223,33 @@ static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
 	return ptes_per_table - (i & (ptes_per_table - 1));
 }
 
+/*
+ * Check if concatenated PGDs are mandatory according to Arm DDI0487 (K.a)
+ * 1) R_DXBSH: For 16KB, and 48-bit input size, use level 1 instead of 0.
+ * 2) R_SRKBC: After de-ciphering the table for PA size and valid initial lookup
+ *   a) 40 bits PA size with 4K: use level 1 instead of level 0 (2 tables for ias = oas)
+ *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
+ *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
+ *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
+ */
+static inline bool arm_lpae_concat_mandatory(struct arm_lpae_io_pgtable *data)
+{
+	unsigned int ias = data->iop.cfg.ias;
+	unsigned int oas = data->iop.cfg.oas;
+
+	/* Covers 1  and 2.d */
+	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
+		return (oas == 48) || (ias = 48);
+
+	/* Covers 2.a and 2.c */
+	if ((ARM_LPAE_GRANULE(data) == SZ_4K) && (data->start_level == 0))
+		return (oas == 40) || (oas == 42);
+
+	/* Case 2.b */
+	return (ARM_LPAE_GRANULE(data) == SZ_16K) &&
+	       (data->start_level == 1) && (oas == 40);
+}
+
 static bool selftest_running = false;
 
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
@@ -1006,18 +1033,12 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	if (!data)
 		return NULL;
 
-	/*
-	 * Concatenate PGDs at level 1 if possible in order to reduce
-	 * the depth of the stage-2 walk.
-	 */
-	if (data->start_level == 0) {
-		unsigned long pgd_pages;
-
-		pgd_pages = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
-		if (pgd_pages <= ARM_LPAE_S2_MAX_CONCAT_PAGES) {
-			data->pgd_bits += data->bits_per_level;
-			data->start_level++;
-		}
+	if (arm_lpae_concat_mandatory(data))  {
+		if (WARN_ON((ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte)) >
+			    ARM_LPAE_S2_MAX_CONCAT_PAGES))
+			return NULL;
+		data->pgd_bits += data->bits_per_level;
+		data->start_level++;
 	}
 
 	/* VTCR */
-- 
2.47.0.338.g60cca15819-goog

