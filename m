Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD66372
	for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 06:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5GHQ8lsVBIhq+oelqV2y6+nyZwMa9j4Xf+XLM5s2Zb0=; b=F5FpUK1WANEgjo+iDNQ2Mh29GI
	FmHm6mXPXNLIsJFejBP0Asx3X787+4h3/8U8EcPWduLPve964t+OH/AiY3qNChCcVvIddsTGzMwfY
	2h0sWUiikHF2Fy1eH79ET3Gz8v8Na+DFwZ677VPQ4/9rhKnBJF7Zfxw8nur6utLKAimrJlmZ6etfU
	BC/JM4GuFCFazyE9zJp/R5/48wVKAT75ib0Dbo3e3fCIMhwbOx9UV9PJQlne5jn88r6mgEOunx0il
	sAik/mt2tAFTaiPKdpX0+PK8U4NFm2jIPsL1uYJCl65BYU+5pRyBUmS6DNjPudgNJwslKlOmtoD9d
	LWyBwysA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPeHI-006gRs-I3; Sun, 21 Aug 2022 06:17:44 +0000
Date: Sat, 20 Aug 2022 23:17:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vadym Kochan <vadym.kochan@plvision.eu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
	Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <YwHOCHmKaf7yfgOD@infradead.org>
References: <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
 <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
 <20220818120740.GA21548@plvision.eu>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818120740.GA21548@plvision.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
> It works with the following changes:
> 
>     #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> 
>     #3 swiotlb="force"
> 
> Is it OK to force the memory allocation from the start for the swiotlb ?

It should be ok, but isn't really optimal.

I wonder if we should just allow DT to specify the swiotlb buffer
location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
for it, which shouldn't be all that much work except for figuring
out the interaction with the various kernel command line options.
