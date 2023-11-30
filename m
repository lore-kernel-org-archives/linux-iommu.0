Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0F584F2
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h5fNg9zs"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b84402923fso804861b6e.0
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375314; x=1701980114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwZxW20NTsAI6OtU2mg3WBn7dc7VhXurLb9lJcGaB3s=;
        b=h5fNg9zsp/yRlPJ7ltk09xXPxHzFer7fOgCtnz1vOLtL+VKM8XtW5pApIfBJMNV9GO
         XcGEuifPpbkEx0ynERGQgsQRzd7ZI9z6Xzvk7opIPKCU8rkCPfaA1RAWv9khooSVtEaX
         IELhxJnOBo/YE+Df1mjp/aNELrGsEyVk2pWk/OzQLdgHqG1/jn+w92DBGefkczXYh3xF
         3QSCdKvJ1CkcuUZit0KZNexTButTCn4xGX3+SwUBFrUpCqPswpxkPej5xRuj94XtR/Cn
         Lke9tvZ6nYr0rU2pceD06tp3wZzwTOw3atLzQVdjKSMquo4ZyG/ajm7H4BZnTQnTyS0o
         qdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375314; x=1701980114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwZxW20NTsAI6OtU2mg3WBn7dc7VhXurLb9lJcGaB3s=;
        b=v4WImmQ0qAzrHJV8TMfbgJcIszYys3gc8aCv/557GERWrE5uc/T8manOwM6WyM4Klx
         QXZ31CY2qV4UsdpQErxPtcZc8QYRnlNjyOKomiQce4GfB5BNE1AyNIig9Pkde8PPa4dI
         TiW9YzI+O6IgT+ZS8liMbMhPo0SzZvS92cwznSgjvIrqVOY3kT8JvErdZclawRjw0Ldw
         +3D6nJQLcBIbEbxCfGP6oxY7jdGQFjq4HTu4vPat0Oeh5SqwCvzZFGjaRMdJ6gRD+M1V
         m57rb6SwKrQMoYhq38+K/vrQm5BQQJrFfxlbr9p9B2vxqGA5Ef7I74X2Njj+KUg0WT58
         GgjA==
X-Gm-Message-State: AOJu0YxRCRI408HCnTazF1tlmW1b+K6quCccckfnqFQh4G6vYa0ZXT1X
	Gu6NAePk9ZlLp+CP7r3MHp0roQ==
X-Google-Smtp-Source: AGHT+IGTxsoHsoEZ+jaTqaWghyHDgBjLPZzal0bywx3elLmQBrrmBhd0Hv9BOGHbfQGzeWmE2Kea2A==
X-Received: by 2002:a05:6871:3281:b0:1fa:5890:7840 with SMTP id mp1-20020a056871328100b001fa58907840mr16958744oac.35.1701375314449;
        Thu, 30 Nov 2023 12:15:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:14 -0800 (PST)
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
	yu-cheng.yu@intel.com
Subject: [PATCH v2 07/10] iommu/sun50i: use page allocation function provided by iommu-pages.h
Date: Thu, 30 Nov 2023 20:15:01 +0000
Message-ID: <20231130201504.2322355-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
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
---
 drivers/iommu/sun50i-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399b..172ddb717eb5 100644
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
2.43.0.rc2.451.g8631bc7472-goog

