Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119551586E6
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623602; cv=none; b=OnnzCfXAubIBanYcwddo4/leuRZ/Dt5nmyr9qgU4zCaRygM/GyN5Q5cz2Ir95eFhD21qbtfKFiF59kKa/BrSD7nHCpOMxRl+MKRmjEsTOvQbexiLUF+o7+f7gmwM9ZUiBhw5IaTog75xaIafFwhnp5bdjMDe7UBp4gO+LazDUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623602; c=relaxed/simple;
	bh=pCPGI7sXGSKUAtLTTEysb8+tbDwRnVhJivy4g3n1bag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk0pG9cBhtic8udiYX73lpLRiiQ6gzkKXe8ds5qP/ZubTeGsIThae0TXgmwmPWE59d+IRszrpG0v85FvETQKzrterlalnh3HhJ4aNrYCz+VW/QWHm7glVRmdocW51ly391RT/Jhqwv/R1z5MD57HaQqvxc+qYFZCc/MxMt601V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=r+u17s6+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="r+u17s6+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42c7f8588c5so18181201cf.3
        for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623594; x=1709228394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uv35HUKrFfNdue1C7Aw2CpDwCbY0H46wtzckiJmEetQ=;
        b=r+u17s6+ngAJUEBsz3Q4q9WeUtBojEsco/eqKH9K5Ad/928qnhn+KxfEwFdfgdgqSc
         1ZeOh18Qk1ZrJeE6bEuy3B99AfKoEuS/4Tyj2oCE/c78k6KSt+vbXYCumARJS9YDVD4a
         NTzQRYrZM1qAHAj+rX+NoyWCz7KSMJ+Av6lKlzNuklsUsePawNpcyCOVuUtNTev/yfiD
         XVBUJZ1hHqaZaSFKqchW+qhBRwvjLEmoUKmlU1TBCAbszGJGqsoFyCYMKW7Z0hjA6F8L
         X41Hm82Bs5H3q8G7Iba8MffIrlQp9inqSphSBNKOlIWZVWgidWGGSGIaaf8ToFbttPf0
         QZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623594; x=1709228394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv35HUKrFfNdue1C7Aw2CpDwCbY0H46wtzckiJmEetQ=;
        b=luuobaxPTOgxjqNI4pFvnWqx+8yqpi6kQgeXSZe7ySrTxyJoGu4L4FfJT0+Fq0137G
         Qzx36LN1+H8POA0gzSw3PGUEZen/bgou95JDSjC/HhrwPwwfvjiuCeKD2JUUVYDGx529
         7Xx3txbyBcehvu9bdmxZga5Qm3KkBzm81GpqbbcnOWfXiuUaILqmDX8BEw9JCt4mQu+A
         rEbwV0BK96K9AtgAMPlk1w4Ja4DN+HwCauJghfqb2tGotm1hSmkGHz/v7wdUdkfE0JoS
         dCvXTcqsLLVoHJLIxudOKZkensbEq19ymlCO3ucNyP3Td/mfMBuaHDYzSyfAvFosX8I8
         LwDw==
X-Forwarded-Encrypted: i=1; AJvYcCX8MEyubg1C3rKZYtoVaBqS/oOXJ2bBaDaNGpa7qbZLstQD5JTwqH/XnjyLsKJzqPF4Sn8Aie6LOLaCIGAksdZiKwgrot4=
X-Gm-Message-State: AOJu0YyFe4Ta3L8SOUQmVcXv6CoCN79f93NQlQdiJ++ShBp7QZVp/GwD
	kwyjUf33yDDXKF8HJQDNGm3v2fWPwab7kn4iHzk7vk88N9MbC+FjckGp2IXm66o=
X-Google-Smtp-Source: AGHT+IE+Akg5+Cr9C5q9XoLFcnfSS9pk8lVxXF1AmEM7lT1XFT68HyiX2ha271XqH9ioEWyp0Wi6uw==
X-Received: by 2002:a05:622a:148e:b0:42e:1d1a:d414 with SMTP id t14-20020a05622a148e00b0042e1d1ad414mr12238355qtx.15.1708623594202;
        Thu, 22 Feb 2024 09:39:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:53 -0800 (PST)
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
Subject: [PATCH v5 09/11] iommu/tegra-smmu: use page allocation function provided by iommu-pages.h
Date: Thu, 22 Feb 2024 17:39:35 +0000
Message-ID: <20240222173942.1481394-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
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
index 310871728ab4..8be74d472f21 100644
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
+	as->pd = __iommu_alloc_pages(GFP_KERNEL | __GFP_DMA, 0);
 	if (!as->pd) {
 		kfree(as);
 		return NULL;
@@ -290,7 +292,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 
 	as->count = kcalloc(SMMU_NUM_PDE, sizeof(u32), GFP_KERNEL);
 	if (!as->count) {
-		__free_page(as->pd);
+		__iommu_free_pages(as->pd, 0);
 		kfree(as);
 		return NULL;
 	}
@@ -298,7 +300,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
 	if (!as->pts) {
 		kfree(as->count);
-		__free_page(as->pd);
+		__iommu_free_pages(as->pd, 0);
 		kfree(as);
 		return NULL;
 	}
@@ -599,14 +601,14 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
-			__free_page(page);
+			__iommu_free_pages(page, 0);
 			return NULL;
 		}
 
 		if (!smmu_dma_addr_valid(smmu, dma)) {
 			dma_unmap_page(smmu->dev, dma, SMMU_SIZE_PT,
 				       DMA_TO_DEVICE);
-			__free_page(page);
+			__iommu_free_pages(page, 0);
 			return NULL;
 		}
 
@@ -649,7 +651,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 		tegra_smmu_set_pde(as, iova, 0);
 
 		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
-		__free_page(page);
+		__iommu_free_pages(page, 0);
 		as->pts[pde] = NULL;
 	}
 }
@@ -688,7 +690,7 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
 	if (gfpflags_allow_blocking(gfp))
 		spin_unlock_irqrestore(&as->lock, *flags);
 
-	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
+	page = __iommu_alloc_pages(gfp | __GFP_DMA, 0);
 
 	if (gfpflags_allow_blocking(gfp))
 		spin_lock_irqsave(&as->lock, *flags);
@@ -700,7 +702,7 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
 	 */
 	if (as->pts[pde]) {
 		if (page)
-			__free_page(page);
+			__iommu_free_pages(page, 0);
 
 		page = as->pts[pde];
 	}
-- 
2.44.0.rc0.258.g7320e95886-goog

