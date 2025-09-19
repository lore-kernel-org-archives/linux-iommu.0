Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F2237707
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288804; cv=none; b=rCuoSseo1av9omASigkoYvTaHOgLsgRsBBei50HX0YsROXCEE6jZs8ZYLqdgVkFP3SnQ20weSfHlSp5aJcQj9d3m+roujOe37hu78HXUBnqU23hlGtP8EBfzhan4ST2LPYFfgKIF9S88uOd/Md3tVd4JfBYQ4Sui1vrtAb1X13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288804; c=relaxed/simple;
	bh=IkvFohIT4Wev3CJlOkrieSRHtDFSjhkdcyilBtxGyoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbVe8ywoqTreyifOH9aJ9l58LsqMjScrEMlELaFVZaA9aatoqk6Oy2E9lVHz7vIVjNyuVWmbWbTRDlEfJgCZQPq1YhqEA5tNj1zogzTx8XvmBSQnhNO34X4X/VJbradAQbxpCSeV6ZnRagpg0F5f7AyTpVNFLOATeP3V1kyV0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qF+QK2nn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qF+QK2nn"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dd56f0000so25530675e9.2
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758288801; x=1758893601; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=qF+QK2nn/hR8duA+9wA44CHEWha74lh1Sv57e0EGD7xqJ7tOG+vE/IV25tiQIOX7Sn
         Hd64qIW1Ck3LRMVzXdZMBq95jltuG2DCMHkz0g6Sna5WLkdiM41w0cuAK26cJP0n24yW
         +CqjKTfrukMooMEd+p205cVdedzQbZo+BooYJS+UyXbbpBG7cfbAEd30T3CBlSGq0mYd
         Q9QkGysJFCfBg1frcrt6vQ5iAwZHhlqm5ypiiFPfRRMl+IXqnkvipjgVH6m1evszBtLM
         eyuQjbxth00bYjNLI6aqIarkEhL9rtFqhoTKnrZmgMafr5K0dN7tM19il5wIngjZxGJ+
         Gggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288801; x=1758893601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=I7y5B+N6hn3IwRoiau2SPvjROvcYLGcoTcTjwJylwRpsuS9lpoIxlnlBISJNIali7d
         LPbTPCSSW9aQIJdXiL9ECorROJUTadmBIZ4XSy+vC1fVE32pHdlNn3knCpkNEZD9p/zY
         UzayidazBG57EdSQEDddlSV61gs3p4WgnDP8qty/Dqd2Xq0pjyuIfwfFqUWIfNr/ITSf
         /wASSPp6qk5rUprgTFKe521e3yWXAJD8NWlX2WiPQJHYmAPJws6QwNpIrj1OSUfrUQI2
         YTroHyss8URhCVvQmj5DKcZLFClTLOeQNBHoNswgLu7xshYgEzQtt6ns4irVGdIdc8BR
         8rgw==
X-Gm-Message-State: AOJu0YzBGntquUqE8ed9UEdMLYJpcS86BIoHD4slvQ19qKEfm++rPp1J
	UHSvUTFgyw5Y/knXtVjrQsYEX3+ZXk3jy9b3Iw6hBtAXAAYPChhdJllaHNtwWhWi9Ymt//FcvBi
	T+sv2u6JPgBtUB3isS4qi/sXgBzgLgW6yjIq9yTbOCL6JQDIgoCiVtBNfSePvdh2yX/obn9zxU/
	e8vpOuLsQpfaUsFzVwB6FcrB0BcwB8J7nfkLp0F9XLpd88zA==
X-Google-Smtp-Source: AGHT+IEfxiQvwNODoSv0Q8MyC2iij/p4VeQe4Qd7UQdXLmJ90VPgVJBy+TPvBsuyLaP4UaVBUz+AHld+iqa7Dg==
X-Received: from wmbdr20.prod.google.com ([2002:a05:600c:6094:b0:45c:b62f:ca0d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450a:b0:45e:8e:28bf with SMTP id 5b1f17b1804b1-467eb231105mr25807885e9.28.1758288800565;
 Fri, 19 Sep 2025 06:33:20 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:33:10 +0000
In-Reply-To: <20250919133316.2741279-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250919133316.2741279-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919133316.2741279-2-smostafa@google.com>
Subject: [PATCH v3 1/4] iommu/io-pgtable-arm: Simplify error prints for selftests
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, if the self test fails it prints a lot of information
about the page table (size, levels...) this requires access to many
internals, which has to be exposed in the next patch moving the
tests out.

Instead, we can simplify the print, using ias, oas, pgsize_bitmap
and fmt is enough to identify the failed case, and the rest can
be deduced from the code.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..00218af5d5f7 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1299,14 +1299,10 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 
 static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 {
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
 
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
+	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
+		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
 }
 
 #define __FAIL(ops, i)	({						\
-- 
2.51.0.534.gc79095c0ca-goog

