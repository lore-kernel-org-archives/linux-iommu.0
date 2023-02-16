Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBAA17E3
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9G4gnfB2XPl7lbkUbFeUPOTouFnZ2fjPZU+k0NM6des=; b=j4NH4cX3nUNh4CgRmhS3n0rn/K
	oPt3Y1WT5Yt3mJIlDH2+bM1tEbw6sw6+BhD2JBSBFhT7Xr2tE4oWAKjNPB/hl11E6lvQ7wXvXyCVv
	u+TrBFJlKGky9YMoFTkoFeZGR2+uI5ixYaOSYVfQUYDSdodZmScr1+rhvowy1dV1fJsCNxCvmckXf
	nJaxcVL3pt4KjmZqafGR8esKhuAeNiriLrQTsoM91olCm5E1L6+0rPkJ9C/3X2YLr32GRhFP9jGcs
	rpACsYiwwx0G/bpRlCT5379Bv9TgcJlOmexnz8nvIOHv8tb6aCnlRLnMHfPXQSykBJuL9hsggxewg
	Js7SoX/g==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSXiN-008fz3-Te; Thu, 16 Feb 2023 06:25:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH] swiotlb: remove swiotlb_max_segment
Date: Thu, 16 Feb 2023 07:25:53 +0100
Message-Id: <20230216062553.2151773-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

swiotlb_max_segment has always been a bogus API, so remove it now that
the remaining callers are gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 5 -----
 kernel/dma/swiotlb.c    | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 35bc4e281c2125..bcef10e20ea4fa 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -121,7 +121,6 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 
 void swiotlb_init(bool addressing_limited, unsigned int flags);
 void __init swiotlb_exit(void);
-unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
@@ -140,10 +139,6 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 static inline void swiotlb_exit(void)
 {
 }
-static inline unsigned int swiotlb_max_segment(void)
-{
-	return 0;
-}
 static inline size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return SIZE_MAX;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f10..f35d934f6e5822 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -156,14 +156,6 @@ setup_io_tlb_npages(char *str)
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
-unsigned int swiotlb_max_segment(void)
-{
-	if (!io_tlb_default_mem.nslabs)
-		return 0;
-	return rounddown(io_tlb_default_mem.nslabs << IO_TLB_SHIFT, PAGE_SIZE);
-}
-EXPORT_SYMBOL_GPL(swiotlb_max_segment);
-
 unsigned long swiotlb_size_or_default(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
-- 
2.39.1

