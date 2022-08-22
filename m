Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C18655
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TqqOOw0uhy2BOLXONZwDPAEaW+S+ReMGePsEGcFCqXI=; b=TwRnSnsi/4lCtlOFxjs6yTDmZX
	H9HWsHEoCVyZDcMKflKmMU0T09mJ0y6u6gLKMLmvZ+a0UwxDMon6Q71l/WZ1tbcB1Y9Kug4PmNpie
	C9Tb+7YfmWWqbBjku3TZ8pxBdXtn6SeFYoUZ5GBE1O1hKKwHUr2QJ25EtLXlHlQuhfelp958Ppd1P
	Qp0U5AM7hYyHL870keovGZ+CagHDvvVd3Y550ZjzLGBs9NZP1QCnvveo6b5IftQ8k43digDbUPAzI
	GULC37fK/MdiljCJOmmq/PDIG506LHPQgtUn2G++WcQfrUa335I6r/qG9e0dpyyITRbbK3diLTOPK
	Bq2wZL8Q==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ0gJ-005Kbg-3N; Mon, 22 Aug 2022 06:13:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dma-pool: don't return errors from dma_atomic_pool_init
Date: Mon, 22 Aug 2022 08:12:54 +0200
Message-Id: <20220822061255.151688-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822061255.151688-1-hch@lst.de>
References: <20220822061255.151688-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Returning errors from initcalls does not change a thing, thus don't
bother with returning -ENOMEM if one of the pool allocations failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/pool.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 37008d4f6d7af..4b4c59d05e436 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -194,8 +194,6 @@ static size_t calculate_pool_size(unsigned long zone_pages)
 
 static int __init dma_atomic_pool_init(void)
 {
-	int ret = 0;
-
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
@@ -207,23 +205,17 @@ static int __init dma_atomic_pool_init(void)
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
 						    GFP_KERNEL);
-	if (!atomic_pool_kernel)
-		ret = -ENOMEM;
 	if (has_managed_dma()) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA);
-		if (!atomic_pool_dma)
-			ret = -ENOMEM;
 	}
 	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
 		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
-			ret = -ENOMEM;
 	}
 
 	dma_atomic_pool_debugfs_init();
-	return ret;
+	return 0;
 }
 postcore_initcall(dma_atomic_pool_init);
 
-- 
2.30.2

