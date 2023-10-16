Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD44D522
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2LZ3V85G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HNzOvxESbvs0T+eHOSkoEf67mG8U/1N0p04PAmqKDXE=; b=2LZ3V85GIZkSezRnfJZYY+41II
	hAx6KoDUJTBNqUViFNGY1iq1nTy806urFG6DFTIc2y/2hSVyjA5lvblAdhrrnaaZQVtKSHJ0ClxcT
	btOJq+Bmc7p8nTSIiogtPYQD+ROsKcZY1kAf7rXBV5bTPCqZOXR5zAPo+kJAIpYCRWxWcBhYIWT30
	W/8ajfCpTAo+9W/ldmJlQlKV4w+tSlA9wi1V8z5VY1wah9B3q7iD5jhMiU2g3oEsK5+9PSm+AfIol
	T3CyQGbEa0TDUnq9JIaSaM67p8D5JV0MDB3w8KArp2cItSF5Kfm6892pvl119ffXh3wOtu4m6im+q
	LIlB+54Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGSM-008Qdv-36;
	Mon, 16 Oct 2023 05:47:59 +0000
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
Subject: fix the non-coherent coldfire dma_alloc_coherent v2
Date: Mon, 16 Oct 2023 07:47:42 +0200
Message-Id: <20231016054755.915155-1-hch@lst.de>
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
a few more cleanups to the core DMA allocation code.

Jim: any work to support the set_uncached and remap method for arm32
should probably be based on this, and patch 3 should make that
selection a little easier.

Changes since v1:
 - sort out the dependency mess in RISCV
 - don't even built non-coherent DMA support for coldfire cores without
   data caches
 - apply the fec workarounds to all coldfire platforms with data caches
 - add a trivial cleanup for m68k dma.c
