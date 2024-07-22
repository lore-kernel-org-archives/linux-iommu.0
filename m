Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36678F70;
	Mon, 22 Jul 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664360; cv=none; b=NhEAcXtHZH+XyGJSJRGe69nOImmTgfcaYftjfbhVyYxHTeoYEFkUfrO+/ymK6GPz/onIEA6x3E7j0lXlD8uj2PpPPmTJyHqGBjT6Ty86Pks2dPI2g2EVeXKO3JcSAU/Zyrb7d0Sa8/odGKkUDWzTCtfF2lng0oiKNfAAPMvLNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664360; c=relaxed/simple;
	bh=zvIBIpJiNaJ4ePuY0Wj/+npfGAN2dsmG8tz9UNefWyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuza45Z3JmxsZgEaoAcEbrcZR096r9rc8U9cvrfkfDmkkwposC5bZixJtbJS6rD3DksSjkdQz5N2s+5OK3Jw7Z1Y97QHHrT+NSFC0e79eE1CS4wJLh9ff29gujqiqsuGjd0wPJTLCT4Gbzv8oS53QxKvujQiv+ciEgej7gBR530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ0sc/Po; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ0sc/Po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD03C116B1;
	Mon, 22 Jul 2024 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721664360;
	bh=zvIBIpJiNaJ4ePuY0Wj/+npfGAN2dsmG8tz9UNefWyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJ0sc/PoZFoHwX9G3poxp2se1OlCKQFqgjb2301kAWha960ll1HyOftijAra6la8o
	 hgwYMSeNotq/5bEI5JX7cCyOgpn7/PgGZkC/vOtUO8heiYnk4reKVphdd4AGe7TO/E
	 oelS5QHyvNEfogzMi7dPyccID7BnOUXUU91+WXwBwIkKV8CdabyShXkQyC+ZZvFBLj
	 ufGu8sg7rtjdgufT1EKAqLjWdyMISaKEX7ndnOHSDZ26+HaBH/TRvY+ntD/VguWkFl
	 BwZLfqNJrhJ2lt+nOHh+nMOUiVXRGc319XQC0BqNUDlbTrvNNLj/fCVGPLVZhdrobm
	 tYZCTbwsC/xWQ==
Date: Mon, 22 Jul 2024 19:05:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240722160555.GB7022@unreal>
References: <cover.1721547902.git.leon@kernel.org>
 <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org>
 <20240722151037.GA25001@lst.de>
 <20240722154458.GA7022@unreal>
 <20240722154929.GA26317@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722154929.GA26317@lst.de>

On Mon, Jul 22, 2024 at 05:49:29PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2024 at 06:44:58PM +0300, Leon Romanovsky wrote:
> > On Mon, Jul 22, 2024 at 05:10:37PM +0200, Christoph Hellwig wrote:
> > > On Sun, Jul 21, 2024 at 10:49:11AM +0300, Leon Romanovsky wrote:
> > > > -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > > > -		struct sg_table *sgt, enum dma_data_direction dir)
> > > > +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > > > +				  struct sg_table *sgt,
> > > > +				  enum dma_data_direction dir)
> > > 
> > > Why are you reformatting these to a much less readable coding style?
> > 
> > I'm relying on clang-formatter to format the code, see .clang-format
> > file in the kernel root directory.
> 
> Well, that uses a really horrible default then.  Aligning to the opening
> brace not only is hard to read, but requireѕ reformatting with every
> addition and removal of a static like here, or when trivially changing
> the function name.

Should I need to reformat the code to your preferred style?
I can do it, but it will be manual work :(.

> 
> > > > +static inline void dma_common_free_pages(struct device *dev, size_t size,
> > > > +					 struct page *vaddr,
> > > > +					 dma_addr_t dma_handle,
> > > > +					 enum dma_data_direction dir)
> > > > +{
> > > > +}
> > > 
> > > dma-iommu very much depends on these.  So we'll need to also
> > > build ops_helpers.o if dma-iommu is enabled.  So we'll probably need
> > > a separate Kconfig option for it that the various users select.
> > > 
> > 
> > I removed them from dma-iommu.c and there are no calls to them in that file.
> > ➜  kernel git:(m/dma-v2) git grep dma_common_alloc_pages drivers/iommu/ | wc -l
> 
> Well, you replaced them with direct calls from mapping.c, which now
> needs them if dma-iommu is supported.  So while strictly speaking
> dma-iommu doesn't need them, proper operation with dma-iommu still
> needs them.

No problem, I can add.

Thanks

> 
