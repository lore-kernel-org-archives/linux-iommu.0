Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AC64D
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rgkhfcc6w7392VtXYI31NxmblWnxEZaDOowFbRN5atY=; b=xPVRxCz3UmLnL+Da5f375EoLMM
	yF5Ea+BmHON++mCc0NVHrp9R5s1Pg//Db7q3wVaAUxQxko7JWm4TPbPGxjJy9qzASQgdanr4s3bXf
	quT9zy40ckm7tJPrSN5AKxfs3W+VfvHMTv7vnCSWRtDI6tCKgKjVI7QnFcmplnjLXjgIwL0WbwBuy
	qc8d1SMoXxxSGokFBDmlCBsldg+InBcRjmn+4Ogq9f8YMcuW2embL8bpAhZzbqAyNc2BkdPtWDrwz
	8qZTUTRlKJ9qN1zKZ2tB5fjBlfFGMGVb5Ye1/UKZ+vvRtM9i6b67Uk6KwgAIm6vDilA523WIIWojM
	6cR/2reQ==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ0ef-005K6Y-3p
	for iommu@lists.linux.dev; Mon, 22 Aug 2022 06:11:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Subject: [PATCH] dma-mapping: mark dma_supported static
Date: Mon, 22 Aug 2022 08:11:18 +0200
Message-Id: <20220822061118.151577-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that the remaining users in drivers are gone, this function can be
marked static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 5 -----
 kernel/dma/mapping.c        | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 25a30906289d9..0ee20b764000c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -139,7 +139,6 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
 bool dma_can_mmap(struct device *dev);
-int dma_supported(struct device *dev, u64 mask);
 bool dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
@@ -248,10 +247,6 @@ static inline bool dma_can_mmap(struct device *dev)
 {
 	return false;
 }
-static inline int dma_supported(struct device *dev, u64 mask)
-{
-	return 0;
-}
 static inline bool dma_pci_p2pdma_supported(struct device *dev)
 {
 	return false;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 49cbf3e33de71..27f272381cf27 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -707,7 +707,7 @@ int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(dma_mmap_noncontiguous);
 
-int dma_supported(struct device *dev, u64 mask)
+static int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -721,7 +721,6 @@ int dma_supported(struct device *dev, u64 mask)
 		return 1;
 	return ops->dma_supported(dev, mask);
 }
-EXPORT_SYMBOL(dma_supported);
 
 bool dma_pci_p2pdma_supported(struct device *dev)
 {
-- 
2.30.2

