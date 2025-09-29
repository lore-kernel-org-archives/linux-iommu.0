Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384A307AC6
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161012; cv=none; b=tnM+0NmOrA/S7KXFNu2QB78YAO98wS9HJ8LP3CjmwsZmo1mIRHzVxqYyte9adEifF2ROsmLpEmaweX16yOQ6cL3j8ZZmhpAeyS2nIQPMf2x81Ary/8cJjYCLQSgRVSCm+2dFseQh2eJLKLR7dkDpE2ul4KbDa19xHoJckZRW1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161012; c=relaxed/simple;
	bh=gtKktn5mD4ClJKXry7SWpVCtKEWHd43jNhA79F/2a/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVHQPsVmGIPl+5sohVu+e70Rs5ReUyEWzUQ9EuxUFsiFBER4DARloIseIJZDgMhTYOhydl5mE59QEHRDKzC1ouWSHIlBWQzS/CsuE/72ifr4gdjqfOGdbiw9cQwAekYKo8RhqHj630NFW8BFYHRSViOvtLKzSXYO4YyOo0euNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MP0vGh6u; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP0vGh6u"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3d83a7b6d7so97982366b.3
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161009; x=1759765809; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpdr13Dtlhg01cWCXIYI35AG1Y3QRBsSx2SpN+S+hFU=;
        b=MP0vGh6uKhqamABsSXwS15e+MNKE+3Xsjh7Ins6FDS1omPgJMXm3TkvxH85Qgn51Et
         fqQLyeCzG89NTTnMODEA52NuUrFFZ3xcwxIPjsjoYgSOiZGCEUbs4VYje3bdSXiEqLw6
         1RqSfpRK4KdHm6B5q0VPnJ+2KFVW7ULxDr8muiqJ5X9B+WP+PbJWbJQQN8fRidtu1cJk
         L3zfSiadTERBKgFOhsOjxZUsBfw6EtnXy0OsEzlw0EBCwoTJc8pL4HqQJMTkyIC0YQV4
         tX2nQ3gwDYpFNwqd4bUkp/nfMwjqkpah1y76AnCJnbjpcIdz67oXsVyfjtEHVHOdmS9E
         kIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161009; x=1759765809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpdr13Dtlhg01cWCXIYI35AG1Y3QRBsSx2SpN+S+hFU=;
        b=eOPA6P462qqlUOdt7CMLLduuqslFzdUlz/f7aZDM6uiGu7jj6rdXaG+w2vDWY3UP77
         OSfFXs36PR6A/VdQU9EhaDJmBFRKGYUJURIq/9uDWoMaLNRv7l+c8pJ4Lak15wUhlyPu
         IhfhLZqDA8LwhxVHb9YDvyYJRDhztjx97SPcTEkr8yaytnZ+XDPZpIpWHa5SRb36Aq8+
         u3LWnyYSWufhyRy2E55nFp2voD2GLay9ZuGYuRDGm0fJXpFKcd41uYWobAnGFi85LKSn
         0COwmq4tmjhGVK/dHNstV3zC36eVpGMXuccb0Wq86xDSLvdCL2SWlD/S/CgMFcc7ryQo
         LIjA==
X-Gm-Message-State: AOJu0Yxdkv8zI0REG+vDZMJWjbAC4yaz6/0IbxEvHPwHTICyGteSgTnB
	Ip2JodzVMy05K9oOl0PPmiDXzHJCOHAQgGIxvtdZ6rFAvxsP0xkmiDuk4iRwb0c/RsJDIEZllEc
	v4rGIttkneqm8YQuAHucDot+2DyZrObpKx0A4t32CPMmPmtF+7Cm9HwhIfWnSp2wP/ytHWl9Zbl
	e37m2S2D5x5rt3g8onrE/dj41VYMGBmhSAQvcg+11E4bRa1g==
X-Google-Smtp-Source: AGHT+IFx3LiQcFYe261z/EWWagWvnj6dQR302njS+xm6S18t3FOG1/h2C5xa6C/Nr1sj0mZq6rNxxvXG2ayzJg==
X-Received: from ejrn23.prod.google.com ([2002:a17:906:6897:b0:b3c:699c:2f83])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a0e:b0:b3e:c7d5:4cbb with SMTP id a640c23a62f3a-b3ec7f3d880mr431947266b.35.1759161008650;
 Mon, 29 Sep 2025 08:50:08 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:56 +0000
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-2-smostafa@google.com>
Subject: [PATCH v5 1/4] iommu/io-pgtable-arm: Simplify error prints for selftests
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, if the self test fails it prints a lot of information
about the page table (size, levels...) this requires access to many
internals, which has to be exposed in the next patch moving the
tests out.

Instead, we can simplify the print, using ias, oas, pgsize_bitmap
and fmt is enough to identify the failed case, and the rest can
be deduced from the code.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
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
2.51.0.536.g15c5d4f767-goog

