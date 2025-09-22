Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D721C194
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531609; cv=none; b=gCnKQbMxsVf7IV6KUb1U7MNVbBNEF6k3DSLX3bGlHdgUswKZZe2Q29MHWL7d0dUyh//3pubFlCoe/SUMpCvHA1EnqRa/O71+hS/CKeWJEifaa2z09Vj22UPHieF8Q6IzgNUOWDwVxlunbtKq+c6YMPI8IPhlTZ+IddHcVqT2wFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531609; c=relaxed/simple;
	bh=IkvFohIT4Wev3CJlOkrieSRHtDFSjhkdcyilBtxGyoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZuB/va9OM5+Iomo9y7fndOhBYBSEDm0bVpeUCyRate5Wb+BTiyzv3RPAXqLAvStiswVz6ZKXhh7hPcpKfbnnmb7BaZXBWyzf/k1blJBtkwmNDyxx8N8i0BcuXO5RQQA6K+vX8VtwPGXIvo9cusCAYMbKeJw3OQqqcuGod84Kydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2THtMMU1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2THtMMU1"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so36653395e9.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531606; x=1759136406; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=2THtMMU1gTo/B1TEl1JvoZrx0u6pMxKbpQzXOZIASIbfc3yCAXN+qUyP7Ov+MapnVu
         4pFQ74IH4CXVLMUY7FdnPwIvglXF/eWi0G8KdlSRRm/9NF0zCXKfXlvbv8Ml6PIAEf/D
         TwSXYN7W+zDGPijine9clZAhtL9PQwr39I2VujSeJd2cYTPTxhnIF+QzygKwP607TDXY
         oSjQ0ti8FHYdjA0M4sVaKnkomj2Ffhu5ooDVLc/CNzybA+PuFwpvsvaNIDBi6foTUG8g
         PZzfMgIxxuCoZHzyT3JS19jwwx+H5WuGef8AvuNzCKCaQw5kQW+Ux7Jwso1ca3P0A4pE
         bC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531606; x=1759136406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=pCf/SZEn5bsHiPDmonOQcVUmL80ddSNT7pMirFjJLEzIBB0voh1D1S8cDyqKdyqoEz
         lhnlzpQ/S5UWJX4nG2ne77xBNw/PiZR7hgPPtC72hatuRp7mes5xGZBKZ73peCwdZbtL
         3BMv75iW0nYg1jZEIyRrIj6v9VnV7g+oX6elImUZEb/mEnMJFrqpAoqTZ9Bs3kgoYcyi
         2ED6T7u6gHrLgE1QfxcPfL675BvDAsubIHZcgYf7JwN+GUlTiGphW4mMdWGYxg1GskMX
         QpxNuN6nGwcbWfcrCgtDZqicycR7xQMf6GsEKqll79fuohla2tJaUkufl+vdTV9bQTpS
         rEzQ==
X-Gm-Message-State: AOJu0YzXnjHaR+DgCjhDU2JjkVFY/Ermb3CZQzZ8xReII60z0w9yb9zN
	hzfHd5/n+T9CoITgUw0D7KB+aRi3XUe/CNtz8G3C2aDIY2BIqOCYcKEDl+CxkGlwfC4G6LP8vRt
	+/IxQW/AZzX9yVzbgtfJ6PWtmyiip3OxA2L7vMbnaJK/CBkSeLGzEeoQ8ApIbKPicXjpYv9QPCF
	sy7wUimZdfmQCU8SdGSGy7ZIibhIqzIHE8tF4qah7T0BHjsA==
X-Google-Smtp-Source: AGHT+IEqtivvAp1LSR1yfY3OPo8H0NhHHFJcQpxkNow9ciOTTfMvMKV71pcO7sOl6lYxK9wepfDZCsUMSsF6Iw==
X-Received: from wmbep17.prod.google.com ([2002:a05:600c:8411:b0:45d:d179:882f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc6:b0:46e:1aa8:44a3 with SMTP id 5b1f17b1804b1-46e1aa845c9mr2814975e9.37.1758531606327;
 Mon, 22 Sep 2025 02:00:06 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:25 +0000
In-Reply-To: <20250922090003.686704-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250922090003.686704-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-2-smostafa@google.com>
Subject: [PATCH v4 1/4] iommu/io-pgtable-arm: Simplify error prints for selftests
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

