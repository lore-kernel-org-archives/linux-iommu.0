Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9C1848
	for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 00:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967939; cv=none; b=GmDm2s6ZB0rqO5t5a3biXpzSXmCEzm6cAXpZ4SjO/GwscGCA3k+W/nkUIS0QblkJXMleBQj3tCnrHP94hTSHN3PDBOfBP19u5B6RpXr3fF16mRIMKNMBYO+SJsuPXKgGxWE+2b5BeDVoyyg4DY+NywZHEg92/HLBubeHo0ofME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967939; c=relaxed/simple;
	bh=+YqO7m0APqOhnWYPWv0RsekRuXxDAcBHnQ9Hfpmy8eI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6Kkd+X6TjFfvKsXcLdXlqKzfjM0Gsd81A+mZEk8pAWFdtR6+f6xN6HPKzPjfj81ulUOGryXZrl2o1edFqkZzPVcI20fnM1imZzHEdyb6yuynDrh2W4LPnCak1jRIVqw1AfdY0SnaFDwDtYhCVmuX7UjYIJgBhfqlSa6mm1jyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Xwnv2+HG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Xwnv2+HG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d54a3e462so92119885a.0
        for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 17:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967933; x=1713572733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MO45TG6xfzZsYhTVPnL09wSWtApUT5YGrrbgII3maTY=;
        b=Xwnv2+HGTHZyRmo3LtuRb3REAl5I1tj0rrID9jcpV8oU1j1pl1XGt1kOLQhLPAKCsR
         wY/NiHbUlAU4tG8CANAiDbQWFZW9LiwdYZ4x5ls2+gK2JaDUhpGPOTH/rnLIseOVDEQA
         qSIQRyHqi7vOPdB1HTzTAsiB40Zg0BjGfEGVyWgNUfP/V0m63eiBufyHlrNC9z03f65n
         A3VzqGsdHjVuLNjgKrdj//db3vIXgcz7NhbHKosN6OSlSZ2wwdlrgBpx0ABZQq+o/jcl
         FqPq60OTav+8VhW3zs8jL6PfIdU9uD4Kysn2b4hhgZF6fcg/5u4cvZDpc/ZcDY0aGsMy
         jPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967933; x=1713572733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO45TG6xfzZsYhTVPnL09wSWtApUT5YGrrbgII3maTY=;
        b=NHwsBCuRml4hk24HiqfJvhGXQlM1wwu83peKutzKCHI8xZ5P/lNbVqNDlTW9xsNfIN
         TwbCTm150+bSdbaZAEm993iTpSJ6+wwCdHnv+xvMHRKdfEN6xLUma1M1x+Hx4NmTGeJs
         RgSZT8r2BByEuyNkgt46RMZdXDZ0B7USUReikwzGzrX2d0i4tGGZmCBVkXVzlb1rCsdB
         hMxuAX5L+APAkeoJE2tpuvhQd87gG8XS/U1ZT/E7eQySpQ/KmIMEwDu+S8B3PrtnRyCj
         5befEEaoQOu0hTpDOwC4u0k+2z6SqywUbCQoQOqZLxPwZtDBFMGJE3LP6dGF9C/UnR4j
         QGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYkjatqi0fYWxGoLUayU+btp7vgBCTPknnCrrOYRfrdWG/2UfsdYW3ej9wdFmdWalZMu7oNWDh8p5LYrRPaqzXmUCszxw=
X-Gm-Message-State: AOJu0YxrxFodnA1et3tgsssSwB+sV+cSF6qZqsD9OzSLs2ssWHOcSzvF
	/brNpRN+G3/tjyA9jwWd3J8VZh3TClnL+xAVAirz42rhZUNz6iqsB1QVwUR0H5Q=
X-Google-Smtp-Source: AGHT+IEXUm4h5HemGXduoWJF1eYDhRYKVLtFqnvpNR6ns26vxx0/EdOeXta2X/OaQb67WRloCqHbfw==
X-Received: by 2002:a37:e306:0:b0:78e:c0f7:54fb with SMTP id y6-20020a37e306000000b0078ec0f754fbmr4866171qki.50.1712967933251;
        Fri, 12 Apr 2024 17:25:33 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:32 -0700 (PDT)
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
Subject: [PATCH v6 08/11] iommu/sun50i: use page allocation function provided by iommu-pages.h
Date: Sat, 13 Apr 2024 00:25:19 +0000
Message-ID: <20240413002522.1101315-9-pasha.tatashin@soleen.com>
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

Convert iommu/sun50i-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index decd52cba998..c519b991749d 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "iommu-pages.h"
+
 #define IOMMU_RESET_REG			0x010
 #define IOMMU_RESET_RELEASE_ALL			0xffffffff
 #define IOMMU_ENABLE_REG		0x020
@@ -679,8 +681,7 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						    get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -702,7 +703,7 @@ static void sun50i_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 
-	free_pages((unsigned long)sun50i_domain->dt, get_order(DT_SIZE));
+	iommu_free_pages(sun50i_domain->dt, get_order(DT_SIZE));
 	sun50i_domain->dt = NULL;
 
 	kfree(sun50i_domain);
-- 
2.44.0.683.g7961c838ac-goog

