Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15835107A5
	for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ShzYu8iM"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-594cac3cbaeso188050eaf.1
        for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703620934; x=1704225734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Px5z3jJNMJ+cqkQJ8fykFQGitjbal7TFA82XDDTiIs=;
        b=ShzYu8iMlhhD8fHtc6dpZq5uJMWLklVuu/THiYRwvi6kDr1wAJ1S5VslmnZzLx6Z0p
         yKRUOuOhnQfKZvU60l0D/bxccqsVeUxVP8ewyYmQV3Ub4iexi2Qj5yj3B0pl3eCBV+RZ
         F+hn5e+7MUtnmbfRIbbbhZvOeWEDryB/5/7m5lhTTdaOSSyawhDgd7pxnlO+PsUUJ/k1
         F78DAjUFqAgH+8433LEeDP/xYNx3BcHM2F1nyHTxXX3oswP/eSXBxkg3T1gv+n6VFSHo
         FyV/Jpr5SuEaQ1qTZ9IE79VrN9mVXWuUjDRv4HeZavzMvs/wYcVQt4siYQE5TmfIWs+N
         iuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703620934; x=1704225734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Px5z3jJNMJ+cqkQJ8fykFQGitjbal7TFA82XDDTiIs=;
        b=R8OaH7opeBOVG8zjo8YRAeMt7qNpQq/4+s0yGvKVylhRGnQPhCtOUHgtGL5slhFbJb
         7xqXmofu/VULIoG6v8xO0tcckSPpQQKmY3tXniyP5Bf+ORVc0Yj/iNuH6sOja4uQHTna
         fGLFb+noEOr82ofPQaxZjWWHmQjO9AbOm904UeU5bXWLCoO9D1iHtOBIIXdC+WKxLCVl
         yqGo/Fudsdh89u37tcmTXeFCtdHBphbDooE3uVf1mo1qEHlrGUpcHKx2/XtNAH3DYmS/
         DlvSngEMYN0FR8Fc+utjlFN1frEVUSjCv+OP57nLQx1p0SmOXka+pDLjOt0qIvD8pPxS
         AZmw==
X-Gm-Message-State: AOJu0YzHBxNK/M52L1naZg3gPU4CsHUd62XMFb3ZJhnyBcYumqPVayAz
	8TWlMSaBeukU1T5UB2E2BFJyH3Ia0aR4sg==
X-Google-Smtp-Source: AGHT+IGuyxzVTrkGD7GeRYCWL+kwqdfuJTNbDB34T0ltwnMiuh8TxVV6prFt2lzUE/2C05msUhTBCA==
X-Received: by 2002:a05:6358:70c4:b0:174:edbf:a9a2 with SMTP id h4-20020a05635870c400b00174edbfa9a2mr2577495rwh.48.1703620933708;
        Tue, 26 Dec 2023 12:02:13 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id t5-20020a0cf985000000b0067f696f412esm4894539qvn.112.2023.12.26.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:02:13 -0800 (PST)
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
	rientjes@google.com
Subject: [PATCH v3 06/10] iommu/rockchip: use page allocation function provided by iommu-pages.h
Date: Tue, 26 Dec 2023 20:02:01 +0000
Message-ID: <20231226200205.562565-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226200205.562565-1-pasha.tatashin@soleen.com>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/rockchip-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a12..e04f22d481d0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include "iommu-pages.h"
+
 /** MMU register offsets */
 #define RK_MMU_DTE_ADDR		0x00	/* Directory table address */
 #define RK_MMU_STATUS		0x04
@@ -727,14 +729,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | rk_ops->gfp_flags);
+	page_table = iommu_alloc_page(GFP_ATOMIC | rk_ops->gfp_flags);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
 	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, pt_dma)) {
 		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
-		free_page((unsigned long)page_table);
+		iommu_free_page(page_table);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1061,7 +1063,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | rk_ops->gfp_flags);
+	rk_domain->dt = iommu_alloc_page(GFP_KERNEL | rk_ops->gfp_flags);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
@@ -1083,7 +1085,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	return &rk_domain->domain;
 
 err_free_dt:
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 err_free_domain:
 	kfree(rk_domain);
 
@@ -1104,13 +1106,13 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 			u32 *page_table = phys_to_virt(pt_phys);
 			dma_unmap_single(dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
-			free_page((unsigned long)page_table);
+			iommu_free_page(page_table);
 		}
 	}
 
 	dma_unmap_single(dma_dev, rk_domain->dt_dma,
 			 SPAGE_SIZE, DMA_TO_DEVICE);
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 
 	kfree(rk_domain);
 }
-- 
2.43.0.472.g3155946c3a-goog

