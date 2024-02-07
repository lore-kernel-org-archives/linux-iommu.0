Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB884FD6
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327682; cv=none; b=P9N4Cthh7/nAftkU39+h9RJSepUmbqk+8UtGfmar0ELVw5dplRfPHF4ZXG2PcyE1r94Z/QeQTHoB9Aem0iFN7XQ7kGFRjgx6WJJPxsCELRULwXC9fcgErIefjso8xTlo89pbFndnPOw65EE8FV+uPrje7t+tAvJ/19NR3kWdR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327682; c=relaxed/simple;
	bh=Kc1wEn9YL3T9SCiwN78gVUKQ50UDSkeNUv7CMUuPgKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLRrIkNiDVBLAWInxKrtBQRrloxP8pAlOHXbaiodIp2s+rK5oSyeogZRi5rRp1zUZ9TEnT8sOB8ZKQG9lJbxDfq8ij6CSDRu7jGILobCTuPAr5bY4TjLN6r7mcohzn5n/5ahU7e1T+TGi7xwzFEazyslN+uRrHJ2x4TYtoD+RsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=RUC6KYw9 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="RUC6KYw9"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783d84ecb13so53928585a.0
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327677; x=1707932477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWt6Kj9gOwsVhKnLqI4ecc+RWbgSNCQCfN6SnKHrmRU=;
        b=RUC6KYw9D2PP/g7/qh7b3ntBb/4pa5ooAnpEfbQGchv6v0hwVOhxS1qcpNJVx/c8AV
         UIHSSHqLRvctE5w54XH58aglAhRA517OSF2KIoxi509AiulH3JcexZNqBbnusZwOunq9
         6qiEYP/U8k8gNXx74Zd5N0e7zkZcrg1T7WWsO1vhr+/KIwPLC76emOFGyvBQy0aFTDUT
         J1pj6LyXAORISHoIsCzjMyOpNLvUge9+wRx6nM3EXMlJAQltBCWmYUHfTJPBcZettDPk
         ufPG57X5jdizl2GR7Cb/PGMFx4H+WJ3Y1HJBDwEsoctaibQAicokLVnVHyst6OdgPU8K
         nCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327677; x=1707932477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWt6Kj9gOwsVhKnLqI4ecc+RWbgSNCQCfN6SnKHrmRU=;
        b=eP2GN+Lf+u1gHluZK1daouIuQ6F3926S8/z9HB8uf91rjscWbpLlqIymp3epSQbOhd
         rvS9v/Wg+gYoI0ZGP9YFCgwjyVSb+yzNTlaxKdJuYtOGvivBD9KFkS2G+tmtsLrhF/pz
         MJNQQVmIHsseSnbGq887AR+gs1OMr32ZK4zSUeXHdZFt0M/XjYYbOy6QchMldL5AbZCW
         S8ZKaquhuebovntm1FQRjtn/nC5phbqF0wtWmb0xDyx541XZOW0KEe8hCrDkO9ufV1Yx
         +lCqZ71knAq16eDV4N0xNOFMIZ9MfB1fp9OX7vQ5snuCp6PRYKhtNa1c1mFjOIcxln+K
         vaGw==
X-Gm-Message-State: AOJu0YwSlFjv8Kpvti1xcj+tF+mvIZF2DJLPRWi6Wh2+2A/5EADiSScS
	sKTi/AwaahgBgQtFAD8KfFRn2289QE5XYtZqW84+2+CtsbwhAWjxE5fjpq28SIM=
X-Google-Smtp-Source: AGHT+IHeQy+PfPTf7nBSLMGCvJMntsBufk0Si/3gJdM+srJ22A2iBif8tXuqrNfbof1VrQoYmJ+haw==
X-Received: by 2002:a05:620a:24c7:b0:783:4c2b:cd31 with SMTP id m7-20020a05620a24c700b007834c2bcd31mr7624063qkn.44.1707327677315;
        Wed, 07 Feb 2024 09:41:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV07MGvI4Ypo2h445jSLHybue8b/Jl//KnDW5a0waD/mCyzQoo4zwqN1ovns4RyMBF7dWelEXf+y/BMce8UTxxq3OAOyEJdx84aMHu3Xj3LNN0h8+PWnMFEE+z2yOaWBuE59sMW37SvqeY2r+eddvdkbwQQ0visKlJywOwTrMUf8bZCr+C97H8x5rJJN90UubbobWaZA/xY1wS0vWPAquvxEg1hW1l28JQ53ZJx95HU0khGFmoTf79lupjMXxqjmuiNshSoarMoqYJlkOScCqu+AzutOUb3hemyHowzfJt4oQ5vEa1AqDVWJc5qq9GwVhdBQpQ1bjwh/41lfRAoS+zdREj8QtB0yC8Yf3fqjP0bV/AQWGDWDl7AfxCGkqvXaWAi3c0FFJ8LHhlIOPCAfJXSiFfWf6hJY4gnlh1zdcTkDpX5vHjlux7o9mLm8xCEuso7GlAvyaCahljtfdJ3n9He1HG2A1JKk14Dp91svBMy4ACi4YjPBYxU5G6arqfc9Aa9ID46kIFxHAabnsJdGUmoWrSiLJ37J4zqxIFPKteeDOU74RPNvqXXZbrh+kwbVkpkNyZe+ausHvzpbhe53+69z5xvpe5yz9LDtoptdeoq/e95bHyxU06s9O4xJWgegjHXaE/TG9CVzS7e8EQ6S+o3PSzjPJiw2FxqV7XKMv5fNqsaq3ZnMqYOZquy2m+v/zhJILWFJWBJQYb1rEPYtmsadOpw3HuDIXjsc7+VkSguFrWGSWLv8KpJD9KFIRW3LI+MvaImrkmCSzDiSVZ6RDudqEFvZYSmqwS7dR+c9ojQ39rqDcRoUTVPgcq9hYxerx4Zb0hKQlrxZdYZlaeEYtvs70TKIyQjNh/90ivUw0nvVBM979zJloyZT0luhm0T77jolZ/+DUh8NcXLhU99yGpN0jycxaJdWQ/XTPQ3YblLvB/JYpeG6+dinfywPfndj0evBQ
 cjwGWfxcAlsvta7HagMoAKkZDmGrKu6IQAXTkfceEaOFQjobeyFL7uPcD9WqPNUuTcinn6O2hVSaDE3sB91Fe25TnZxotHh7OfdDU6pVyT5VjN5xHg8ym4Qy8zTk7FhXznhJubrj5oIYVZd7dTTCR6P0f+WG/aKlC2Uv1CpzhAUn5GH/Bc11h/mtj4gUypoq0KQEevPp5E+tw4JPNQGTKi05iYJiEoXJXGCV167QIg4d8lnRnJM41YFlpwAVduF39jQYyREhtCqzsX9O5lpM4WNzt5CxhwcXH3TL905ZjPt804cwe+TFZc+HM/tZC5gRtjBtVeZb/l/cV0C8UVs2UJsWZqdeH83YNXz6q/p4t7x9MRhw58c7FqTjP4PppYzx7DQGiI/8b7Yz5uKM+/NZUCMppthUMAdoId8salBi+S/s5S9pMfWNkj6O/yEOAkekKT1ezCkB+lRuTIX+hjVWjWA4AxIqA8e/PiDfl4OamSHsHK
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:16 -0800 (PST)
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
Subject: [PATCH v4 08/10] iommu/tegra-smmu: use page allocation function provided by iommu-pages.h
Date: Wed,  7 Feb 2024 17:41:00 +0000
Message-ID: <20240207174102.1486130-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/tegra-smmu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4..5e0730dc1b0e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -19,6 +19,8 @@
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
+#include "iommu-pages.h"
+
 struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
@@ -282,7 +284,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
 
-	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
+	as->pd = __iommu_alloc_page(GFP_KERNEL | __GFP_DMA);
 	if (!as->pd) {
 		kfree(as);
 		return NULL;
@@ -290,7 +292,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 
 	as->count = kcalloc(SMMU_NUM_PDE, sizeof(u32), GFP_KERNEL);
 	if (!as->count) {
-		__free_page(as->pd);
+		__iommu_free_page(as->pd);
 		kfree(as);
 		return NULL;
 	}
@@ -298,7 +300,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
 	if (!as->pts) {
 		kfree(as->count);
-		__free_page(as->pd);
+		__iommu_free_page(as->pd);
 		kfree(as);
 		return NULL;
 	}
@@ -599,14 +601,14 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
-			__free_page(page);
+			__iommu_free_page(page);
 			return NULL;
 		}
 
 		if (!smmu_dma_addr_valid(smmu, dma)) {
 			dma_unmap_page(smmu->dev, dma, SMMU_SIZE_PT,
 				       DMA_TO_DEVICE);
-			__free_page(page);
+			__iommu_free_page(page);
 			return NULL;
 		}
 
@@ -649,7 +651,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 		tegra_smmu_set_pde(as, iova, 0);
 
 		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
-		__free_page(page);
+		__iommu_free_page(page);
 		as->pts[pde] = NULL;
 	}
 }
@@ -688,7 +690,7 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
 	if (gfpflags_allow_blocking(gfp))
 		spin_unlock_irqrestore(&as->lock, *flags);
 
-	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
+	page = __iommu_alloc_page(gfp | __GFP_DMA);
 
 	if (gfpflags_allow_blocking(gfp))
 		spin_lock_irqsave(&as->lock, *flags);
@@ -700,7 +702,7 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
 	 */
 	if (as->pts[pde]) {
 		if (page)
-			__free_page(page);
+			__iommu_free_page(page);
 
 		page = as->pts[pde];
 	}
-- 
2.43.0.594.gd9cf4e227d-goog

