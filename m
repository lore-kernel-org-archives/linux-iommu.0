Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB117C3
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TGR5tegU9EdtFyp5Oa3vLTzENZhAJOwkFJvKq0QZ0/k=; b=1ZiMTpEm37lzcMv9vuqQoBcHtQ
	3fC6o7KNF91I7YXlI5t0oPSNhqPXCOme4RMeRMlQzwwiSuq9+XrMIl/yHuVlUb0Rs0+x0qXiuv1OD
	YAh4tPwJzeaDTN/goeSsSs4bCOdfoQa41RhiK0mQjZBItRz7MKKytfY55erXzW+vHa+kf/j9x5Tg5
	qjuWg+XPScxt28hrqKxA5pm7XQ2b5va0Iudvwk9l0yyUzSVovANUZvaFofhs2viaRu2IBvAdne7ST
	WUSiiuA9j+jizTBXMggh1JYH5wDH36QtvxObN8PYCW91QRV9kopqDKHFeTQrTkz7oF3jeqAv7NwAw
	/QXHIQtQ==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVPp-000PEt-Sw
	for iommu@lists.linux.dev; Wed, 13 Jul 2022 06:00:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Subject: [PATCH] swiotlb: move struct io_tlb_slot to swiotlb.c
Date: Wed, 13 Jul 2022 08:00:04 +0200
Message-Id: <20220713060004.1894806-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No need to expose this structure definition in the header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 6 +-----
 kernel/dma/swiotlb.c    | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f65ff19301201..cf2274a8b12f1 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -106,11 +106,7 @@ struct io_tlb_mem {
 	unsigned int nareas;
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
-	struct io_tlb_slot {
-		phys_addr_t orig_addr;
-		size_t alloc_size;
-		unsigned int list;
-	} *slots;
+	struct io_tlb_slot *slots;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0e61f4206de21..0ffb23c0e0e8e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -88,6 +88,12 @@ struct io_tlb_area {
 	spinlock_t lock;
 };
 
+struct io_tlb_slot {
+	phys_addr_t orig_addr;
+	size_t alloc_size;
+	unsigned int list;
+};
+
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
 	if (!is_power_of_2(nareas))
-- 
2.30.2

