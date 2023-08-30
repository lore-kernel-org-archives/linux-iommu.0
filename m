Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B41C03
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8gmZH9KZS0HrbeIK0tHOu5bayJyNxVWXTD8Kfuh2cvM=; b=uuC7JJUp6a3O5WW74bWxJZw9mZ
	eme0jwOG9ZLHGOKD8w9homCbv77A1Ssw8fILPOEaGOjt2GfQGFngA++wr0HQHFzo69H2JiUkChD8A
	L5TfT3YgdAmt3jjJTs+LL99KhWB1dVZ2W7G78Owl1ZHGLkHhxx1w75ZN+/jGBIuKd7VWxmo+RIOeB
	vqIA0f3h86nP8f1vMf8Lcx5SUh5CMAP4DogF6xBl058toPEbhntAH2m8iqMBbaW4XJu+q7FweBSZf
	QUXgdYR5HG3gblCAxYNpfxL+6mzAma8DefDubDZaZwjyQIeAq6gqC0NY2kG/Y0inEAlmqA8tYv7ul
	FxNYGcfg==;
Received: from 213-147-167-102.nat.highway.webapn.at ([213.147.167.102] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qbHU9-00D9Nk-2p;
	Wed, 30 Aug 2023 09:27:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	yajun.deng@linux.dev
Cc: iommu@lists.linux.dev
Subject: [PATCH] dma-contiguous: fix the Kconfig entry for CONFIG_DMA_NUMA_CMA
Date: Wed, 30 Aug 2023 11:27:31 +0200
Message-Id: <20230830092731.148759-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

It makes no sense to expose CONFIG_DMA_NUMA_CMA if CONFIG_NUMA is not
enabled, and random config options shouldn't be default unless there
is a good reason.  Replace the default NUMA with a depends on to fix both
issues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c1e9a3c0ab6f0..f488997b071712 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -160,7 +160,7 @@ if  DMA_CMA
 
 config DMA_NUMA_CMA
 	bool "Enable separate DMA Contiguous Memory Area for NUMA Node"
-	default NUMA
+	depends on NUMA
 	help
 	  Enable this option to get numa CMA areas so that NUMA devices
 	  can get local memory by DMA coherent APIs.
-- 
2.39.2

