Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5CFBF4
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="reTWTHBf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RfzJ0rmOfGgYG4ZhoNJ82M0rcD99jku72cgM5LPVp6w=; b=reTWTHBfcmdUv9mxw9ih2F8KzH
	Ul2ZYncNIWm4uRU9zqbmoaOqK+HuJUlnidtr4gO9Tt4JrMr/SBExJmfk2Gb1cTqCH5kBplyeOf4O2
	7llMFc9qN4ws/+HK9w+JPPlOJ4DhXx8Jh8SMyoqQhK032lIXBIx+Fa6ZFbD359kb96qqjTFJ8m+85
	rG3EUmLTWZtgAkleBaSFOBRPWcDrzoh4UxDfvmzfmvS6Z91gxDZey/nklk6+1S0ju7MoJ8+Pfku1O
	AtYWsy1J7n1aXqRWzBroseoeRwjCA60UWQhIqAzyLxJFdAZFfNorErvjpcYS2ZiJ7T8ih6YC/V39E
	ZbxOeCvQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGSg-008QrU-2t;
	Mon, 16 Oct 2023 05:48:19 +0000
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
Subject: [PATCH 08/12] dma-direct: warn when coherent allocations aren't supported
Date: Mon, 16 Oct 2023 07:47:50 +0200
Message-Id: <20231016054755.915155-9-hch@lst.de>
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

Log a warning once when dma_alloc_coherent fails because the platform
does not support coherent allocations at all.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1327d04fa32a25..fddfea3b2fe173 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -240,8 +240,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		 */
 		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
 		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
-		if (!set_uncached && !remap)
+		if (!set_uncached && !remap) {
+			pr_warn_once("coherent DMA allocations not supported on this platform.\n");
 			return NULL;
+		}
 	}
 
 	/*
-- 
2.39.2

