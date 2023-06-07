Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF12139F
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=XzAYaHL9ahaxOPP7wTiW38IEKuV7Cz7QlmV64UTPi8k=; b=0e9MFrwEE+v0V7RP+MskVcbEhz
	2DScgl72L6ce9DEOW0IkrawNv8AndggNBER0ATTsKhiYzFEDpFJPwH/OgoCIJq0PYh3iEBrh+ONmg
	jHsvj31uGahaXDp3s3Fj59bB4oo8XnpLXqDWq987ycx8QiKvvg9gXxAU2cza9xJnHWXm9VJaH6Y8L
	SzXaYZ8dYAVD6dADBbh6pJvEwcwhkR7GCPb5ZpHyU8sQs3wNxZ4mWpzufQH6qfmGLbpbc6EmMDYQD
	XYvV40bLCMzlahuRB8f9pl5+i3af7WSFUNkOjXXZVTNQaFltyb0eZgi8mZF76ksWrq6+6ZW9Yf9Mm
	mSTy4Rqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q6tZs-0069ed-28;
	Wed, 07 Jun 2023 13:51:56 +0000
Date: Wed, 7 Jun 2023 06:51:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Scatter-gather DMA
Message-ID: <ZICLfJnelBvBr/zF@infradead.org>
References: <20230606162201.1daceefa@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606162201.1daceefa@meshulam.tesarici.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 06, 2023 at 04:22:01PM +0200, Petr Tesařík wrote:
> Is there any reason to use struct page except that the SG list API is
> based on page lists?

That's how the scatterlist was historically done, and we have plenty
of places that use the scatterlist for accessing the data using the
page pointer.

Looking back the scatterlist was a rather bad idea as it mixes the
kernel in-memory representation (page, offset, len) with the DMA
information dma_address, dma_len.   I've been proposing forever to
split these two and just use a bio_vec for the kernel mapping
representation and a new phys_vec for the dma_address, dma_len tuples.

And while I've only been talking, Jason apparently already has working
prototype code for this, but I've not seen it yet.
