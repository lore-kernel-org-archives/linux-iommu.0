Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75468BFB
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pr0vjBrl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/l9PqXALl8eAHGVDXCtCLR3TdmMUZiHoVO4DUFj3woY=; b=pr0vjBrlwdqYfzLiQLVLo1UoPR
	+dHb37jfGrj+WoUBM5SXfiSNErJ3LrxCvSMM5fAWPv5UoOC/+B/4Yqpca23AHR4XEmXRksyJfR3Yr
	iKcB14cUDgNZLQo0UoarKm0YCX3EXTymHw4abrfcPNcsPhfxo3Gb3EAJfCnPbqhl3xZU1i65VEh/s
	uIbQISG9onx8Unz9nchdyrMPvLEtOoEsqB1v35R7fiuAJAvEkTk/L7JoTH/1xqFORLuucqRe8ELpN
	N0KG63v2NoRrBqggLx1+YZtVoQDz8scF4l46a1J7YooxDbKtFGvDZ913Vp7BDWWIljfZHrjSAm/zF
	9EXvK9/g==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktN-009uhZ-13;
	Mon, 09 Oct 2023 07:41:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH 1/6] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
Date: Mon,  9 Oct 2023 09:41:16 +0200
Message-Id: <20231009074121.219686-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009074121.219686-1-hch@lst.de>
References: <20231009074121.219686-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

CONFIG_DMA_GLOBAL_POOL can't be combined with other dma-coherent
allocators.  Add dependencies to Kconfig to document this, and make
kconfig complain about unment dependencies if someone tries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index f488997b071712..4524db877eba36 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -135,6 +135,8 @@ config DMA_COHERENT_POOL
 
 config DMA_GLOBAL_POOL
 	select DMA_DECLARE_COHERENT
+	depends on !ARCH_HAS_DMA_SET_UNCACHED
+	depends on !DMA_DIRECT_REMAP
 	bool
 
 config DMA_DIRECT_REMAP
-- 
2.39.2

