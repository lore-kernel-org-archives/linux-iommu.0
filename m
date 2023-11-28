Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73D5CD1F
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="E9wyufm+"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5d0572434afso24577677b3.1
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204587; x=1701809387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pzjq4U1m3Jk3/Q2EGDhq/3TlS/Ht1C4D8j4bsFObkQ=;
        b=E9wyufm+H5XNasMOoi5VkTSymFbGQMwuoA7Pn3soBcT27SFU1/oGnyO1boedMyBBsS
         3n15C1afURjzKaPgv/POGoPj8LCssh096Z3OlnxZgWVnWkWVnBc4NBb2O7D8xTpOKj3b
         3+k7NmaxImOrOsECqlEjO78Hls66iOpBs1IMdJeuT83/4R0voL8LhPv1jOGXFnk1Fz2L
         8H6xkuv5pzsumlhJnRAmZiOEto2VaHzlc1n6hCHM65FEbMVe9mepa0IVEuyXeLwnwqUQ
         rTz6mLJB1ICUC+e7vh7/O9aAdHNwtoP5l8xvkfHi4QMCkf0N9gdJKpZt3A44xiD7kIeu
         RPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204587; x=1701809387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pzjq4U1m3Jk3/Q2EGDhq/3TlS/Ht1C4D8j4bsFObkQ=;
        b=ZLs0MRx40OynZArMYn4K5KOe6w4Q5SwHEgZgyrusngyKksJW2SVXFc77ubqDIwt5RX
         OwuaLiGSRX6jQPYre1ycnZkQp6LzM/7JMuEskJmdrStVWh9jKETNfbNeoYEo+AUvNAvn
         3Dq4jQO7UBX8GPY4JHRpZKnfSOEmznEMPHLO756Sj26nJVmnhKBilAcLWKpipTP40lr+
         MJFjuAkOgSsVguE/O/v0q5sSDAXSUw54mn6o9GVV6Qoi34myrHsfqsvPycFnu9YHkiX0
         KKl1+vvUXqtblhnBjsjJ7QZIOe7p7fM/BEXcE6er4uQ8wwE64NgwO02fZHnzDJPyojVj
         FNuQ==
X-Gm-Message-State: AOJu0YwQ7LTguP4u2i3/pGMWm/ajvXM4ecx/sIk3hyQNTZhRLOdTaxLT
	u8MNeK2eHK+jKWPAmTdImxvZGw==
X-Google-Smtp-Source: AGHT+IE/Byn/8N8Vta6BS83r49MMC2Wgiev3AoCZv/F2NdDhJZ9+kkS7XfcNeLYX07tpu8Z2obgTjA==
X-Received: by 2002:a81:87c2:0:b0:5c0:fc45:a249 with SMTP id x185-20020a8187c2000000b005c0fc45a249mr12000775ywf.40.1701204586847;
        Tue, 28 Nov 2023 12:49:46 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:46 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
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
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
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
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 06/16] iommu/dma: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:28 +0000
Message-ID: <20231128204938.1453583-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/dma-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/dma-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f..822adad464c2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 
 #include "dma-iommu.h"
+#include "iommu-pages.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -874,7 +875,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
-		__free_page(pages[count]);
+		__iommu_free_page(pages[count]);
 	kvfree(pages);
 }
 
@@ -912,7 +913,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 			order_size = 1U << order;
 			if (order_mask > order_size)
 				alloc_flags |= __GFP_NORETRY;
-			page = alloc_pages_node(nid, alloc_flags, order);
+			page = __iommu_alloc_pages_node(nid, alloc_flags,
+							order);
 			if (!page)
 				continue;
 			if (order)
@@ -1572,7 +1574,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(alloc_size));
+		page = __iommu_alloc_pages_node(node, gfp, get_order(alloc_size));
 	if (!page)
 		return NULL;
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

