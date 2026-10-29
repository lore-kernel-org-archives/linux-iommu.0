Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275421;
	b=zgulVgMaXN+KPGve5htLcSBTiGxy97QVD+okn65t50zuhnvlfILTMbQEdfET7r7IThXl
	 5nqueIpMZOknIOwgis3U9xDnxlvWMSa31MKdZwCVjRCp7dHnUKJUXV9q+0+chGZt+BXtd
	 bM+h75sWLMT4ppZMC7ss64efe5cQh9am4TWC0tLHFHlm9dp74IrYv25rD7NlYRKoUEUTN
	 BrZTgRjCnyrjatvgkeM45EcoXv2SwV9yDlXiCoVgzD15WtZ9MwtiyYvHmhMBxapBa5at5
	 r8w2hzW+5AkoRgSplFObb/qNrKE2wItDwtj0+8BXHfY4uACt/moadN/asSCznZrxbmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275421;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=AdT7vjX9hlZBYeDnKKDlyq+tnX7uZdKaSwbD6yyWOuU=;
	b=q4OITQcz7f+tiS4vk5LlU5GI27Q1PpR7j13ewin13BuWjwPedwpH/LcuIQCnAm/WZXuN
	 dm8voTa0ITY+J0tUWoyg4/uCQSzjDdMXpDmq44aKzhp00/z3zzAxO0ks5gqEa4qgDaYk2
	 7DoUIuS3KTzdVTL0BhlOZEYuNpr9pIte/9PQKbAU9XY+EP6WsEYuItcKhgUHpzo78gyLK
	 R0vFrdPuMB16EX0yzFIPPiegHy7GGj06+QJrDFD8D3+tefOOvdKLggT0O6j8RsbZ+BgjS
	 TIKd6lz6GKNEwWA9RDdlvEGGhdJBQ5CUK7C1TCoMaSyWmiLkxWK3Yfo7sCOKdMxlGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LbCmUWEP;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EA606A31A;
	Thu, 29 Oct 2026 12:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LbCmUWEP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AdT7vjX9hlZBYeDnKKDlyq+tnX7uZdKaSwbD6yyWOuU=; b=LbCmUWEPlLqyTsMsRsGY7IVnnu
	/UTqEXdCZU4cX2al+EtBA/OS5TKTn+lUAqS48+J+QxZNfzR4gTR9Trp2RsI1KgucWbEZHS2DoP2wg
	/Zk37Jc6XQbFcB2dyYNnZL+Q4awYpmiiFywc6fArn3zSJXtTsMKK6dlP40p3N/zdccRbgMlRyuHiO
	CGRRk2B5rv9MxnrCKUXqjCxkw/CS9tsmbqLqaodgKZn9EuWkpRqpWP2bla81UFz2bRM5f4kLQC2ke
	pRwf/0sXV4RR2AsBoKRYwAPTgafzVkP4VVYIeSBt614Di9TA9LKVP8Hm8hCMuhmCbLGPpRh8izDnU
	8iTGJLIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOqy-000000096rb-2rgE;
	Thu, 29 Oct 2026 12:03:32 +0000
Date: Thu, 29 Oct 2026 05:03:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
Message-ID: <auM2FAYVK192RzHb@infradead.org>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 26, 2026 at 06:19:25PM +0900, Mikko Perttunen wrote:
> Robin suggested [1] that instead of teaching the legacy path about
> groups, we should explore modernizing the 32-bit ARM DMA code a bit by
> making it use domain cookies and have the core code own the domains, as
> is the case on other architectures. Still, ARM's own DMA code is kept to
> support existing drivers and APIs that expect it, and because dma-iommu
> is considered too big and unnecessary for 32-bit ARM.

Now that the different domain handling is gone, what speaks against
just using the generic dma-iommu code for arm32?

