Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D7221F13
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136720; cv=none; b=lqktLxvA+WE+sK0Um/mV+BxBbLmQ2Dl9Pl//Dvtma3VkKNndH4pJZN0AEnuaaKBQB39k8s5q3K28Nu+4Ad4pKqqY9u5sG65FlL58wDEMsR1obR03WCDIgbmAXKGbcPdny7fkaWSc4EB8qMMO+vzl03+3Q+Y/kPZXZ7NZw9u2pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136720; c=relaxed/simple;
	bh=iPTSG8rWX5/aMDwwlMBzG13CC+5ujaQ3LSalqG4mVLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxjZw8ycNKseHigu4CBwycl2dR9eOZjs4aaj6UhwRKTG21BQMSNRVC2bgJdnzNt6TycOGT8iMSqtna8zmU+YbsZLWQ14d63UbzWZAIRVPYHTRiMMcO1AYQJeA4pn8p/iiofbPMkZfKAHnsfdCq2qHVmzt5RmiBrDt/V982tPslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YC5eNALf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YC5eNALf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so38938f8f.3
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752136716; x=1752741516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsOzu/Shb8U/5A8M6vSewxAHPdIcygl1ZysXscFwvaU=;
        b=YC5eNALfouegCmCMEtdzjCalWakzRNH0GrtW7MQfRNuoiOUF6medLPPe3Ie6cop/v6
         rZI+hsRvro5TUe/jj5q9hU19SHAoJbuiq8bZZw+tVykaAG8HrJjWSPtsCS4Z4LBsCJVa
         hQle4zWxz6CBk6/uFhJ5R4au6gzWuvtS51neWRZ3/k+JCnniWBz7lY215XMTlgSdxQug
         rtGECuHP75lSDK/17L7X9/BxhM42i+FCY8GgLBUZ0L4tCZcaRyVp6gr3CeOrJa/JcJL7
         nroywkIPiQjxnMLpEwx/0gqVP+XTbEf7xjo31Nk67O8FxLha3pt+2fbQgBs6FoJ7cpn4
         IUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136716; x=1752741516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsOzu/Shb8U/5A8M6vSewxAHPdIcygl1ZysXscFwvaU=;
        b=fhB8xQ5+ffj1cRD8gas355wdgilo0fW3AphvqwhpUIwWUHJNKsvGDMCiqZLfbRbPhH
         nefbZ0fuzEVBgEkufiAGeO98263QL/KiCC61XRv70/zI6Q4hUcJh47GuBvUhBan/87Q4
         +mUMgrYkxoBAKoQnohQ5qACztc167tFLXJ5UN5eddauZxlp91iupuMx6a+oYSaLWw7Q2
         3sYkgJmqYW4S/WQiKssje9wXORM62zfMlD1sZksyBhRmyQVhw/xZO7yJDaFYSfwLPtLj
         u0DVeWF5veQSrEwjnCSs5rnNcxXZ5FHMFXGQziabyJwUQnP18MiwQ7srFSyr+TsdHXtF
         17Dg==
X-Gm-Message-State: AOJu0YwkuDczKENiS1d6ZbCAaAEzi1p+QV7b7B0JuAOToN2UxmhV01aE
	fS0hcDez4hK74b6WAYQ3GpVvcUwOLVqBd7o06XKDWQUrr2Nr/q1kpy6ENx0daVYmlzc=
X-Gm-Gg: ASbGncukwxR13UENCBiKFYVKWfvzvh7UGsq8x3cip6Mi3/P1660zmLAI7NdlWcYy4g9
	6kUdWjgEhMUjlxei10Rq+tBnZZob5nDjtGcKYetAIWSK3apT/PQS2f2F7sdtTaedAjXdxuPGl6m
	mlHnlSQEVGDTJ2GHG1J54Q53FW1nVGDYO5/KhHrSyc7Nsj0E4uQwtDmKjqa1IuB6/6qAc2sH1YU
	XDyOSmYOP6J+W0jcqlS0y95CHzzlhSwSblS24OtXSBgfsBQHajUx7cqdxQAfHLxtOpEjOuDzn99
	FwTr1oqU8F910/tv9CnhOqE1R0UQv9kMsvA4sueqbsbvXhDgswfDiZNSiJrLZP+C3R83ifVtWYi
	3VbEc3ScaxxV1r4eMGMudSc8hovoLqyQlXytU9roIunMVX6Jmcic5
X-Google-Smtp-Source: AGHT+IHjCyeYWj52MzibDcNe6h6uxoz7typzxZX5pbdy/ikZ9QMY/8GfHCHLtrwQvn8P5u6F0KuPsw==
X-Received: by 2002:a5d:584e:0:b0:3a3:584b:f5d7 with SMTP id ffacd0b85a97d-3b5e45114b1mr1462475f8f.5.1752136716324;
        Thu, 10 Jul 2025 01:38:36 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-b223-ac12-b926-9872.ipv6.o2.cz. [2a00:1028:83b8:1e7a:b223:ac12:b926:9872])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454d50df5a1sm51191525e9.22.2025.07.10.01.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:38:35 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] dma-direct: clean up the logic in __dma_direct_alloc_pages()
Date: Thu, 10 Jul 2025 10:38:29 +0200
Message-ID: <20250710083829.1853466-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert a goto-based loop to a while() loop. To allow the simplification,
return early when allocation from CMA is successful. As a bonus, this early
return avoids a repeated dma_coherent_ok() check.

No functional change.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/dma/direct.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 24c359d9c879..302e89580972 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -120,7 +120,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, bool allow_highmem)
 {
 	int node = dev_to_node(dev);
-	struct page *page = NULL;
+	struct page *page;
 	u64 phys_limit;
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
@@ -131,30 +131,25 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
-		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
-		    (!allow_highmem && PageHighMem(page))) {
-			dma_free_contiguous(dev, page, size);
-			page = NULL;
-		}
+		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
+		    (allow_highmem || !PageHighMem(page)))
+			return page;
+
+		dma_free_contiguous(dev, page, size);
 	}
-again:
-	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(size));
-	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+
+	while ((page = alloc_pages_node(node, gfp, get_order(size)))
+	       && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		__free_pages(page, get_order(size));
-		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
-		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
+		    !(gfp & (GFP_DMA32 | GFP_DMA)))
 			gfp |= GFP_DMA32;
-			goto again;
-		}
-
-		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
+		else if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA))
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
-			goto again;
-		}
+		else
+			return NULL;
 	}
 
 	return page;
-- 
2.49.0

