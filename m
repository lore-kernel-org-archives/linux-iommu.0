Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52368828
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wZgBTFtc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dVs40bsganJI+j23T0NRSSkeLhHC7BdXczFaw4B1Wwg=; b=wZgBTFtcaczhjFymv4NkjwlXw9
	PlKvtGMv8uAjjXRZ+1sFJmLZrEcEPZuSYSgf1ahPNCzexvqb24sOV9ZDImwXHBKjz1zScIzcz6fR5
	IAgEiPP2hUIF81q1/U/hI8kcZWaNb0Ypl5cGAZnnZzn34tNmW2aBIgnShhOTfbYaUKrsoP1jopTUE
	TFg1ah66X4bwBWCira8rh41w+izWR8pD8a6nuQ8H6cAle82sQajlYZWST/si3O7nCPX73jiKxHzwJ
	h5mEwS8JAWmHvaeVzlFqZFp8qcEHHCbMbSIqIiyFXe8ArWZwN9116oXhdE1fNf6v+y0X7TFWZumCx
	MsFkft+g==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktK-009uhV-1f;
	Mon, 09 Oct 2023 07:41:27 +0000
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
Subject: fix the non-coherent coldfire dma_alloc_coherent
Date: Mon,  9 Oct 2023 09:41:15 +0200
Message-Id: <20231009074121.219686-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is the next attempt to not return memory that is not DMA coherent
on coldfire/m68knommu.  The last one needed more fixups in the fec
driver, which this versions includes.  On top of that I've also added
a few more cleanups to the core dma allocation code.

Jim: any work to support the set_uncached and remap method for arm32
should probably be based on this, and patch 3 should make that
selection a little easier.

