Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31583321A1
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778992217; cv=none; b=r4av4cLx0kD1SEvkx21VAmx6b/s6mWoq8rlMRVXYjFVI+fbeJrmusUL5Pj2xafn3/96BDgGkF42GMO968ESCUszBogAe1d9GsE49yLBS+5y42Rs2zMwWc152XW2kbS14JhhljEjWVJqdLh8xaLWqHX66sD30UC3o8d51N9CnW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778992217; c=relaxed/simple;
	bh=WMVTvQDMELZTfABGHws/pQzWqv/RZWnEa/gxNKwkzYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnNEZxPzFXsOMCC0cOu+cs1oJt0gxjoEgClKReW+Tq6aqxMNjTuUDNVDUzkaZktuUrbk7SGu1VTKjMf1UbjhgSf8DbsuFKRNSAGnt8Ua9MxrAjeUBdrs2wvmJ3FfuJneEf5DjOYVNS0cD3oj9xWsi1E0Z+AAXb7zjdcEN7INscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzCVkFcw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzCVkFcw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bc763e2ba8so4892545ad.3
        for <iommu@lists.linux.dev>; Sat, 16 May 2026 21:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778992215; x=1779597015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIZ2FRMVNOsLpkup/QFG+70KCdbOCYaZXVBE75waTX8=;
        b=jzCVkFcwwfoFXD4YVbyZVi/Ssv10NoARR9Rg9hiaNn0Nod/5bZOThqH5EOhX+7qobw
         KpqOQ8h7C0To4OabSf9Fgmuw8sgEjtVDs/91cLZOgyC58rPuonYzMVYHcKI+UOETEpFj
         w0vmtRuklxcRRwOpgngQom1KTFMQPLNIRMOzm8frrgy2882OIL45wQr0qlGpAX2m89qA
         bK0siOTztRM+ii7ZUYw6tD82Pa9I0pC1y4RKdKw3+f64ESf5rYHOXpC50cgFI/h2IUTG
         CYwlmCgOTjJxIjHQkKL7w/G46btWB0JDcWEJxT0pnkRzzrgxmPd5AYRbZHQGs+PNsK3n
         mQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778992215; x=1779597015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIZ2FRMVNOsLpkup/QFG+70KCdbOCYaZXVBE75waTX8=;
        b=no8j2bMCrIVp5/d4yV8+SxpShWrkyYI1pgQiZc1rnPivA1icCXgd5Ok+0Ko8uQKoPi
         sVH4z3bkiPJ2wW6G2zSKTGRTsQ265+C3Katj2Hw9r+7Os4xo3bWs1hfx1WBimXOTwrfJ
         PPKQ4/Bx8Mc6Znc+T+ADhLO2Eki7Effb9XL7cliEUcB5+HmvwgVb7F7Br9uQ9zN13rmp
         dQrcSyiojqRLEznzhtrVEyceckMzaIyaILs5dZGIXqBdvJWOk//UX4wazF726gB5eVOQ
         FKvqRB53oenUT7hFGp4cHImDCamYGpV6kQ+nWIxjJ9dTQo+XZBs8HM/TeI1BQjD3fx9X
         cwKQ==
X-Gm-Message-State: AOJu0YwDADR8U5tXIKhjisD/RauaxamZaeI7xewhKAWATfeY//XTwfn3
	tgg00AtvtT0GSQ42dFOMgqRUE1WHC5vaRJotUCXOxs2UdXddymKp6Zqby2YC1Q==
X-Gm-Gg: Acq92OHTQ284Y/b4pbs/JUmu0dCJMJJ7CBzdWHSc1wqgSvAkEVImbWgiHrvQ26M1XS0
	U/eMpyc71gcUToZS1AQ2Uw09+y8amx8ydHWhefvKuItfQEmN6QbZnIOhN5Zd9Svcd7gyURNlLjs
	oLObFwCMRdn3F0Fz8lJDmDz/ztDARSZO3+kzWyNcWsETgDpSUx6rD115R/rbRK3xOmlhA6MilgE
	HeizEdlIQqrupgCUT8vXgvoR15vpAWrba/9MY7onhy1nqw1qw7btxOv9B4LyYr8GMHAOZArIzga
	Eq3OF45jNU/PaMkG8HUR4AZEf4oCeln+KvS/kY3Se6hjfLiahSSp910pVPQacSnMwrXpynjeP5y
	CJqDm5UjEU66AJWbqqWsdncmJJmluqiap3AkPJ1Kp8YXVDy+tbdyMJ2DNZIzRtxwerWtwMa9oEt
	xJoIPFTrkxkmVvRUZ+5uY1zwV+WK1DEYqb01CoBlHmyBCXXp1aDZUHYQzNcNjJBk6KXRvn/nU2Z
	QZUYO9uCy4q96ceq8/4E6eEI0lQY7tmqv6rgNiww1FxHA==
X-Received: by 2002:a17:903:3201:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2bd7e9e9426mr114999455ad.36.1778992213363;
        Sat, 16 May 2026 21:30:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe47bdsm109726135ad.44.2026.05.16.21.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 21:30:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma-direct: Clear pages before coherent remap
Date: Sat, 16 May 2026 21:29:55 -0700
Message-ID: <20260517042955.2218649-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear pages through their page mapping before creating a coherent
remap for dma-direct allocations. Some architectures implement the
coherent remap as uncached memory, where the generic memset() path may
use cache-only zeroing instructions that are not valid for the returned
CPU mapping.

Keep the existing memset() for non-remapped allocations, but avoid
normal memset() on the remapped coherent allocation path.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/dma/direct.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 583c5922bca2..76f7bf43bd28 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h>
+#include <linux/highmem.h>
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
@@ -104,6 +105,15 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 	dma_free_contiguous(dev, page, size);
 }
 
+static void dma_direct_zero_pages(struct page *page, size_t size)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long i;
+
+	for (i = 0; i < count; i++)
+		clear_highpage(page + i);
+}
+
 static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
 {
 	struct page *page = swiotlb_alloc(dev, size);
@@ -268,6 +278,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
+		/*
+		 * Zero via the page mapping before creating a potentially
+		 * uncached remap.  Some architectures cannot safely run normal
+		 * memset on uncached memory.
+		 */
+		dma_direct_zero_pages(page, size);
+
 		if (force_dma_unencrypted(dev))
 			prot = pgprot_decrypted(prot);
 
@@ -283,10 +300,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
 			goto out_leak_pages;
+		memset(ret, 0, size);
 	}
 
-	memset(ret, 0, size);
-
 	if (set_uncached) {
 		arch_dma_prep_coherent(page, size);
 		ret = arch_dma_set_uncached(ret, size);
-- 
2.54.0

