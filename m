Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7031D5CE0
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335823; cv=none; b=hClWO3vJ5mCb1grsKX2OQMFnYTfecD7G0B/WaAzxkRvwx1Ov/kOb98mEOfO2rLSp81phLXfJALCqsPmpisLEqY3HAu9tHhx87LpErSEhw5fA7kAVacxU+D9U+G6GjNbYhWIr293boopXg98w5WcrQheOLFmR2XUY2aqTxE2N/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335823; c=relaxed/simple;
	bh=btByfG8J/O/uHq+arR9tAyc/e4eUAeVa41QUMNs0ipY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZolC+y1Lk/5iYF7s3oscUPJv12wdHl0M1j+GUrYV71p/E4ndQgQBrfRtdFIh8D5WCl+2TxEG2yq6JOW9w8nNkoslAgW2lK5r2dFsGTtxF2JvmNC1rrbdNqSl7BYOCbFeYTJqRQFghgrlu2uLpq7VWLxMxx6IL1WQo9NIu5vm5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CD06Yuc1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CD06Yuc1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso874793a12.2
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782335822; x=1782940622; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V286S8A78/gcYLSjq3uOi4CPB9ZMdA6ZUDnrzrYWuWA=;
        b=CD06Yuc1lgwvMQazbbKmWr9O3OlqDRu3S6ILNXGOKfEEVWsCF3rLX3Z6f3wPIw9eMa
         2i8JyatdIqu0GA/7dKsMvsE0c9UT8feLwOFgfFlJ/xF21lL2aSUOPYLQdegXpn37URzN
         QnoLmBut3sDMIzd5tCk6sRSSf54IbsQNe4fEtcVVONiyPSbQweD4X7QQNFGQDvdi9Ybp
         SR38bZhDcqmeCpMVdOcjK/k/cU6ES3A07ZK0+0kfyw0qgbYiAKHYvPP+xxWC/+pHYVY6
         0xgQAsbR6uPWkLJin+x2o6A+kw9UfLeSN7Ufpg7tqW/amIZescRVWMfeNyXVsznx7o8R
         TkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782335822; x=1782940622;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V286S8A78/gcYLSjq3uOi4CPB9ZMdA6ZUDnrzrYWuWA=;
        b=Jpy/9h6CoVi6gT0q8hz3V8/aX/W316QFAXi9gz4LFE2TQEHDGMYARBHrX3jKvjjlbG
         qsqSQ+qkRn9SZ0YqBx3XooW7HN2I4tySQubX6KMyUhzc0LuwLvfjfExGjFRVO71tbbQ5
         lUkASoQcp3b485Lp5Ce1iMfDeWOiVDVldxy6tfh4Hg3kzj2fNnI3uc4WVktVA8potSXk
         /XAOPrXw6L5jmuJP5b4VaZbxqc6nXJhhk28bwAGEAP/M9LVySnllZSpVeWo691l+ODRE
         9dgtkxs2Y2DKzVKVWRdpAisTYWQE4M6mBZXLNekGoZtXI/U7l8SSl3K3jQ+NhtOjHy4O
         pCog==
X-Forwarded-Encrypted: i=1; AFNElJ9vg9g19JguaNN4taMN0Jte9p/iwutBcqbI6CXHTYS8IC8R52U0nRBHA9RsiLnVCkb8JIxIRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHVSH/G4wgL+RoD2nncidfIc0ogM7wQtscOCW1dp9pr240ud8U
	jWqK0FLT1Tagul+4eI5r+8Wy2jFxT+iyvjhlrnsKoF8b9lixE5YOiTHOMe0wEKZZG6QIrAP+IRn
	KZv/hvdLBjyxztG3jFlV8Uw==
X-Received: from pgbfm22.prod.google.com ([2002:a05:6a02:4996:b0:c89:c57:f58])
 (user=sharaienko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9e4a:b0:3b3:fdb0:229a with SMTP id adf61e73a8af0-3bd2d045a4emr5967027637.1.1782335821550;
 Wed, 24 Jun 2026 14:17:01 -0700 (PDT)
Date: Wed, 24 Jun 2026 21:16:45 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624211646.1674041-1-sharaienko@google.com>
Subject: [RFC PATCH v2] dma-coherent: use KiB in DMA allocation logs
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
v1: https://lore.kernel.org/all/20260624000516.597555-1-sharaienko@google.com/
Addressed feedback from v1: changed %ld to %llu for size in KiB
to avoid truncation for sizes (which can be 64-bit on a 32-bit kernel)
larger than 4 GiB.

 kernel/dma/coherent.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index bcdc0f76d2e8..67f9a88ec4fe 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -69,8 +69,8 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	kfree(dma_mem);
 out_unmap_membase:
 	memunmap(mem_base);
-	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
-		&phys_addr, size / SZ_1M);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zu KiB\n",
+		&phys_addr, size / SZ_1K);
 	return ERR_PTR(-ENOMEM);
 }

@@ -384,8 +384,8 @@ static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 	}
 #endif

-	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
-		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	pr_info("Reserved memory: created DMA memory pool at %pa, size %llu KiB\n",
+		&rmem->base, (unsigned long long)(rmem->size / SZ_1K));
 	return 0;
 }

--
2.55.0.rc0.799.gd6f94ed593-goog

