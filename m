Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C14C66
	for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967933; cv=none; b=d+pgJasOo2GgeVr/+Rv7CLiTzczwvSFJ7JaEsbHqDVmKL8GKPBM0G2Q2MYs3P4olm6OySvhMVO6llz2YiDtyYtG0R2TWHCXK8QmWGCR9elmnd1JAqKqzHVqQAxD32tMolhiMtgJbZbO5apmEmA393eE88CHwaxbqiuXZv7pc6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967933; c=relaxed/simple;
	bh=tvr+YHESVCDsvV6C8kn/Jw8FuPrm06qlyauU87/mTpU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoEMtz2k9pjflzJjQtUf6lmdKsfKOHuOzA/yNvZTBmNOeJa6AcZh0diddh0/0+IZ4/lK6pn0NKh9gKfkmbwSoV740b9ujB/kPl4/cntZhNw1IistbtRetewbwFyX4U4B+x6sU2MQQJcaD1fSj+7F8sfxND9aZhdXrXhfLollERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=iMVcI1vO; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="iMVcI1vO"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23319017c4cso893611fac.2
        for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967929; x=1713572729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/4w+T4tucdgPG/H173cldAS0HyQQ6sjlO97Kz+1k94=;
        b=iMVcI1vOOAdTsg2PtdXY/NM+f4F6ICmz6lpamLKUkqks/l2HMw36wWDVRDVjlcWeL4
         0yei4CFu8GXpQzQW9i8pX9gR15ksHQobWK7mgqZewfAekKSMIbnwJtij9/chMMKeLNBy
         RwSn6VAkr3YMG4JdTJYhyVrCAKOZzVlF5SR7TjKSTY2ZsoxG+LuG7Lmqte44PoOIjeMs
         TJaOZPCFDl9kyMSBytMiiA7j/0zS5EGrMn+731wo6zUdoRMJWpiATqOD8BDKe9FH9qBj
         tE+Svhxu3fXWAvQhdBHnkygO7J41w2SzKTqPxvZLLpzrG0jQZYJkqbQgarQOJyuNxiNo
         ZGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967929; x=1713572729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/4w+T4tucdgPG/H173cldAS0HyQQ6sjlO97Kz+1k94=;
        b=qU1oXJTHsSWf1ZljeNYh7RaPGcEmiD6VotkwvypM9gbNrGdTJCvoSu02GvOU/XK9QA
         i3ViDsQ9QhbS1U/dbqjjAGvQMenY0bIClHpDegaUxmNyl+5N71xsGUnR3rOMGR7x2845
         DOClFvs8WcJT4awFf8uSSpOK1aADX6NLq+FR1MQVPU62oBi4qO6Xof4T2Yf2oCMA5pFG
         Z8xt766qT9JdGzYXePJy5ZHqlg9Jd+xyOdplHRTcHi1heV8xEtQd50dHtJ1CKIiY0A6X
         Svzwfa9luAcqUHSqz7OGgRoZhVte+3Yl669nUH5qXLA3uE8kyvBFoaHIg4apmZH6AhwS
         6DLw==
X-Forwarded-Encrypted: i=1; AJvYcCWmao0y5UcogQAjbJLdEleh6ruG8N3bmIWJtYkWBjFPtmMfZZZ95TTtMa2ATyiCkxLg8ks5Zo4BqLn1gT//SUMGzg6EuCk=
X-Gm-Message-State: AOJu0Yx10UP7Lb8fFr0xkm1vtlIitoiWKVhbiPyYNiVZCPdjYT3STfJN
	jJxokt/wKFSPLv/vDBz3qENWNCKkLokoqwUtTY434rQXdwHbTrvDGueYY8s2nms=
X-Google-Smtp-Source: AGHT+IGQ8QPk+98rhr31FfHy1KfwN56vAk+9hMwwlY09C3v6VEVpJ5zGBKiShhcihkczGu9koLGDjQ==
X-Received: by 2002:a05:6870:2254:b0:22e:8ba0:921f with SMTP id j20-20020a056870225400b0022e8ba0921fmr4264166oaf.52.1712967929611;
        Fri, 12 Apr 2024 17:25:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:28 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v6 04/11] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Sat, 13 Apr 2024 00:25:15 +0000
Message-ID: <20240413002522.1101315-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/io-pgtable-arm.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/io-pgtable-arm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..3d23b924cec1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -198,14 +199,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
 
-	if (cfg->alloc) {
+	if (cfg->alloc)
 		pages = cfg->alloc(cookie, size, gfp);
-	} else {
-		struct page *p;
-
-		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
-		pages = p ? page_address(p) : NULL;
-	}
+	else
+		pages = iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
 
 	if (!pages)
 		return NULL;
@@ -233,7 +230,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
 	else
-		free_pages((unsigned long)pages, order);
+		iommu_free_pages(pages, order);
 
 	return NULL;
 }
@@ -249,7 +246,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
 	else
-		free_pages((unsigned long)pages, get_order(size));
+		iommu_free_pages(pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-- 
2.44.0.683.g7961c838ac-goog

