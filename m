Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F265CBB
	for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 23:29:38 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-340a4dcb403so129841107b3.22
        for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=j0gZBmzE7Sfjkj3fK19vZEmRLHOzPYXYudfu9W22ef0=;
        b=bPb1auIgPo3/2J+mfMaXDZh871410KrBXJQKMytf0FgAgs/F+ya3O96wKhX6DhLaSr
         K1HrNyGRVh9mjnzpRRE0QVld7uhji6zvmw9kPtVcYWV0J1WLkwMUSgLgH/+idRKwDGMu
         WVZfVhWawN5TNKG4FdwdLTMjqIh43NhSGiCImZigj7H6xUm5tTtcvOz4e1r729TrUHci
         3PrqorGayOVeVtdIiLLIw0S+u17p+j3HreT1kmnW41h1WNTIfC4M/GAlP8teQTYTjhSC
         OkOvFiXEpkzFQw5ZcjmylMDAet9+rTxXgAUVysqhl1c/mnzag/9955zWGc3jwpIPF6av
         2BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=j0gZBmzE7Sfjkj3fK19vZEmRLHOzPYXYudfu9W22ef0=;
        b=TwzEC05DTsfZ8c2GYAeJw5oiTehgJ09fR3myMoKJukDADGA1vMP7AOmV5l9f2BetrI
         2f+rSohzqpfUrfEGJhOGapT/f7KAlwmjRZyGrpKdOWUMHn2C1E8BZ2JKiBhGOaeRnF36
         PaN35Kls1R15OL3/Uf4j9NwsN0/9ce44vPYSoKdqmEIkhTVMUpayqBm8AP6JoWJNm1H/
         UzwatHAYRzA9ZuMBKz1gzy6Xo14s1l4xw/TorRRCdlf4mrn8NTrrFVV0FticxNAdXAQo
         7CYudnlI17RR0JM0L50ZrQP+BtqJ8dQLKf9vscjL8keqAaicCzlZy/glHxmkl8fieOvs
         iTeg==
X-Gm-Message-State: ACgBeo1G495k6gNf8Ho5e+2CtG9hXG1E+NZJG5XNdLCG2G2YLTXmMSMY
	bjESSLTaVOfSINQ/FnetYvt+JGfHpeA=
X-Google-Smtp-Source: AA6agR57Qelr+wyNISYMYbU6D1FmO6PFtmVX7v1UCupeRr3ikw+DVEQhtxuiNuF/Y/wSno25spds6UFXDBk=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:3049:2153:3017:38c9])
 (user=yuzhao job=sendgmr) by 2002:a81:b04d:0:b0:340:b55c:9b1f with SMTP id
 x13-20020a81b04d000000b00340b55c9b1fmr10198796ywk.212.1661815777286; Mon, 29
 Aug 2022 16:29:37 -0700 (PDT)
Date: Mon, 29 Aug 2022 17:29:34 -0600
Message-Id: <20220829232934.3277747-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH] Revert "swiotlb: panic if nslabs is too small"
From: Yu Zhao <yuzhao@google.com>
To: Christoph Hellwig <hch@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Dongli Zhang <dongli.zhang@oracle.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 0bf28fc40d89b1a3e00d1b79473bad4e9ca20ad1.

Reasons:
  1. new panic()s shouldn't be added [1].
  2. It does no "cleanup" but breaks MIPS [2].

[1]: https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com/
[2]: https://lore.kernel.org/r/20220820012031.1285979-1-yuzhao@google.com/

Fixes: 0bf28fc40d89b ("swiotlb: panic if nslabs is too small")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 kernel/dma/swiotlb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..b3ede72eba5d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -325,10 +325,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
-	nslabs = default_nslabs;
-	if (nslabs < IO_TLB_MIN_SLABS)
-		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
-
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
@@ -341,8 +337,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb) {
-		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
-			__func__, bytes);
+		pr_warn("%s: failed to allocate tlb structure\n", __func__);
 		return;
 	}
 

base-commit: c40e8341e3b3bb27e3a65b06b5b454626234c4f0
-- 
2.37.2.672.g94769d06f0-goog

