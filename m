Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E58D522
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3s/GQaxh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RPVFtxbF5hQhoqQwe72Q5ekV/Nn+oUkF+V9bnWf8/qY=; b=3s/GQaxhf5T1tV4r1mrt44XKn+
	dTjx2MCGBSGDsab9TBZdJjZyROqt2EDb8UGKnk/OXyQRdIoofI0/+NspXKDzFVJtZN7eGmlYUP5HF
	oa9H2jCtARohOmceDQZqk3T8+lv9SiRnPhQkBOWr9GgXJV2SC2IDlayWLhU2jn/ULNkTDeGwVbs5C
	+rZT5hmgfahsNr8tVv+s84nnIaLw9HtEfgRsrc+Dk+hlSccNuyhwNF0fPJKdXmlMG4YBSsJSGI+Kj
	04hfLqQcgSCNhcTaT/D7aXv9AkF6szmJo08DrcjZ0mupH71J3WElHTdRKEwKyQ6kEG49s+YKRadEw
	/i1UiYeg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGSZ-008Qjw-0N;
	Mon, 16 Oct 2023 05:48:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH 05/12] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
Date: Mon, 16 Oct 2023 07:47:47 +0200
Message-Id: <20231016054755.915155-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016054755.915155-1-hch@lst.de>
References: <20231016054755.915155-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

CONFIG_DMA_GLOBAL_POOL can't be combined with other DMA coherent
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

