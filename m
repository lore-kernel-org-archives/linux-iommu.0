Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331B1E505
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259531; cv=none; b=XQaluPB3mVjD9GAFjEiJI1GU//KwXDD+52tro8orjMEh4CNJyeAouXlApNsxx82bpOeRZ/OgiOptMDdsdBm4KWpeoc04dYKm5GEGYjWx/kLk7+ZEwz0vL01E9iZ6RzNR/gllBc0f3MSBy0iRxH8VWwV8Etmizf8Zm2ayuR4Wj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259531; c=relaxed/simple;
	bh=oxsYiKkHRVF3lMhkuIlJobH0nhUsv83I8luPXjb3nZQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZZHlM7VKOoUENIvQ+FUVU4cOzXEfSWukil899tuJOa+k/PhipIlCnTWZKQzqA+0AD7WYonHIzg+5LGGZzwPvPbfyj0cj8Wq3z7J/zuh0NWtJbwmN9t/8qvb+CoGdGr5idr5pzQ872bxrJ/jjen6QIepSL2XQFeuTxggoLjq1PQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChqKOgJD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChqKOgJD"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso6266195ad.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782259530; x=1782864330; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QNupI7tLyI3JeFZ+5lTSxmfpfk2fOiN5KPcwIK5dr5o=;
        b=ChqKOgJDcmXBvEiGjI1LgDlDV85j8rIsfhPR0NSiJni0W0Uik/ZRS4/rRSk1dfeEXy
         psc9ol6PsMyctgoI25zW6RBB6dMLeW/znRh9CB79ZWoPAGALbTYvQIE8bM+gkVAF2LCW
         zHIDug3aQDZN1Mg6uAE9VTKymYjy0r4rcLBWVN+mPhcFmrS+2CCuFQVWjniRgnay1ziB
         Gq6GMw4K2AaPtkjBzErRQev1G4VlfeaOOOcldZbpek6PU1UBSKQLewYFzL55GObdIJMY
         krtQLFKbTYHO8IkczMGj8i7oyRl5noGb5pZdGJDcF9ppCcJ7/gciASkkU08TgnyuNZ4C
         PV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782259530; x=1782864330;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNupI7tLyI3JeFZ+5lTSxmfpfk2fOiN5KPcwIK5dr5o=;
        b=CUXJkjT33ioaP98SyAEW43scDQEqCoWqjGYnCv+7hJHBx464Ir+5WB9aZjfwAhYTdm
         Qvro67U4fvWLrrSOvMGaf7g92W/lZmephhXYSIAr7uVwUCNfPqyTz0uq9BsyJosuuwRy
         UFNnKRHYmClRGNQUOrUvTYV3+ijI1BdwZu+cjuvym56r6uNR1Dg9z/Q9CA8Tsc7JXylq
         flcTRsnaRq/iGDZe0cKa1Ggfn2jW6X7eFL30nUrXi5S5/YZbYQkHvn07Nyg+tVy2uVrL
         fjOTqifGtWZ5yNfoTXT3QsB4tLrJWxA3IIIlxjLxesDle6T24yHaycWuLmZZsYB2X+CS
         yEWA==
X-Forwarded-Encrypted: i=1; AHgh+RqAnfSHrp4S4GzbbFVNlN8nNlJkTs9gtQ5mCIR27Ncjg/AnOXZ/PidkUmnOxVjuyHmXKqIHxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx58jYzGxSBnEX2kOVZxWtvpu+aLMeGe6kgHZMgFvAeFG569tqD
	Hva4PrKNVW922/Qd2JP+Kucpf0YiakBe+zzFGNDBh8CWAInICjA5pqS4zgHKYTg6L2u0Z4jsplJ
	sfq7UQ3e1cdXztSkdkwqi+A==
X-Received: from pldd21.prod.google.com ([2002:a17:902:c195:b0:2bd:106:8ad0])
 (user=sharaienko job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cec5:b0:2c6:b3dc:b831 with SMTP id d9443c01a7336-2c7e152e685mr11878045ad.27.1782259529463;
 Tue, 23 Jun 2026 17:05:29 -0700 (PDT)
Date: Wed, 24 Jun 2026 00:05:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624000516.597555-1-sharaienko@google.com>
Subject: [RFC PATCH] dma-coherent: use KiB in DMA allocation logs
From: Vova Sharaienko <sharaienko@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: android-mm@google.com, Vova Sharaienko <sharaienko@google.com>, kernel-team@android.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We are proposing to update DMA reserved memory pool allocation log
messages to display sizes in KiB instead of MiB. Using MiB caused
allocations less than 1 MiB to be logged as 0 MiB due to integer
truncation. KiB provides better precision for smaller memory regions
specified in the Device Tree.

This is currently marked as an RFC because we would like feedback on
a KiB unit change.

Signed-off-by: Vova Sharaienko <sharaienko@google.com>
---
 kernel/dma/coherent.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 480dd1766ece..3ede8da395ce 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -69,8 +69,8 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	kfree(dma_mem);
 out_unmap_membase:
 	memunmap(mem_base);
-	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
-		&phys_addr, size / SZ_1M);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %lu KiB\n",
+		&phys_addr, (unsigned long)(size / SZ_1K));
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -384,8 +384,8 @@ static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 	}
 #endif
 
-	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
-		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	pr_info("Reserved memory: created DMA memory pool at %pa, size %lu KiB\n",
+		&rmem->base, (unsigned long)(rmem->size / SZ_1K));
 	return 0;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

