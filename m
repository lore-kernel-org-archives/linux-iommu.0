Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266F7B
	for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Apfp3Ntcah1dnmwtlE2hUcJ6OtLUs/yxuytUk8ohreQ=; b=GU53um0FBYaAiJuynSgJeWhHiA
	rCZFQYQ8j9b9DUMZM9RwUKBc71btd+rroHfHIaPMS/Fxp2UYdMvCRBcgpwRgPcUQEQd/vrOnBq0B9
	VkOTpncaIWoMw4vZ1/nvSRxONexbg+kPZU6VZLOKO34N7ze0R7J1HBkIq41zCzYpUD7vOWZQnOhbl
	30h41fe8KnQioNICCHkD0ajEgHxT8CFM/Vvyh3EbTmvxMBNVUeWmS2DwBDY5QMpN7WPuJbJh/HYdP
	OdFOdUFo/ZdkkEiVNqed57AtWzOxiHQq8x8FvpMInyG9aYm1ZCb0mk/919YOxWxWaQumasHPqoUgI
	0uKHuF/w==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFxi-00CLX8-TZ; Sun, 13 Nov 2022 16:36:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 5/7] s390/ism: don't pass bogus GFP_ flags to dma_alloc_coherent
Date: Sun, 13 Nov 2022 17:35:33 +0100
Message-Id: <20221113163535.884299-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113163535.884299-1-hch@lst.de>
References: <20221113163535.884299-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

dma_alloc_coherent is an opaque allocator that only uses the GFP_ flags
for allocation context control.  Don't pass __GFP_COMP which makes no
sense for an allocation that can't in any way be converted to a page
pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/net/ism_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index d34bb6ec1490f..dfd401d9e3623 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -243,7 +243,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct smcd_dmb *dmb)
 
 	dmb->cpu_addr = dma_alloc_coherent(&ism->pdev->dev, dmb->dmb_len,
 					   &dmb->dma_addr,
-					   GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC | __GFP_COMP | __GFP_NORETRY);
+					   GFP_KERNEL | __GFP_NOWARN |
+					   __GFP_NOMEMALLOC | __GFP_NORETRY);
 	if (!dmb->cpu_addr)
 		clear_bit(dmb->sba_idx, ism->sba_bitmap);
 
-- 
2.30.2

