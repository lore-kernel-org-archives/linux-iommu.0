Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6065B
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=AIsbWzdnFRdm4EeVdhV08+wiea9dNfrtpgQtwDn7Zos=; b=KgLRTMb8CZlBN12nvaWDnmp9gj
	Ufu08WWVghabnGDjjdu3QKk9JnEVPvay5o7Euh7Lkso1becueuTYOkb9bbvsi/fnt092XaaVi9mkR
	+rcGJHaoVT0vif72jy7hzhVshlvPlqu8KXGBgvznajLKwWHhtxWttVPJ0TSbEA9ICC2g1Fhs8gmDP
	J6IwygKupFXpzg7vgGF3P2S+RqD9yLF09UeVtK5xWDL0W1ZWzyvNvZ7N3k4wZgr6JS2PHEaw4kLD5
	1Lpp2Q6NzJGg1HXf1CTJauXXQ5BXPLtDUPhbpmhY7uznB6Du+Mg2P0raSZih6tMXaUvXAbb97m9Mm
	mHin6/eQ==;
Received: from [2001:4bb8:180:b914:9f51:af7e:d950:bc8d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogLcL-000URq-T2; Thu, 06 Oct 2022 07:48:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/2] =?UTF-8?q?ARM/dma-mapp=D1=96ng:=20don't=20override=20?= =?UTF-8?q?->dma=5Fcoherent=20when=20set=20from=20a=20bus=20notifier?=
Date: Thu,  6 Oct 2022 09:48:23 +0200
Message-Id: <20221006074824.521457-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221006074824.521457-1-hch@lst.de>
References: <20221006074824.521457-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit ae626eb97376 ("ARM/dma-mapping: use dma-direct unconditionally")
caused a regression on the mvebu platform, wherein devices that are
dma-coherent are marked as dma-noncoherent, because although
mvebu_hwcc_notifier() after that commit still marks then as coherent,
the arm_coherent_dma_ops() function, which is called later, overwrites
this setting, since it is being called from drivers/of/device.c with
coherency parameter determined by of_dma_is_coherent(), and the
device-trees do not declare the 'dma-coherent' property.

Fix this by defaulting never clearing the dma_coherent flag in
arm_coherent_dma_ops().

Fixes: ae626eb97376 ("ARM/dma-mapping: use dma-direct unconditionally")
Reported-by: Marek Behún <kabel@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 089c9c644cce2..bfc7476f14114 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1769,8 +1769,16 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-	dev->archdata.dma_coherent = coherent;
-	dev->dma_coherent = coherent;
+	/*
+	 * Due to legacy code that sets the ->dma_coherent flag from a bus
+	 * notifier we can't just assign coherent to the ->dma_coherent flag
+	 * here, but instead have to make sure we only set but never clear it
+	 * for now.
+	 */
+	if (coherent) {
+		dev->archdata.dma_coherent = true;
+		dev->dma_coherent = true;
+	}
 
 	/*
 	 * Don't override the dma_ops if they have already been set. Ideally
-- 
2.30.2

