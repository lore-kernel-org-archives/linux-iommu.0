Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEC16E870;
	Mon, 22 Jul 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663104; cv=none; b=RXnJUYLD5F1ej+UqJYnzTZmzTE1kSgSls5A/LUxLUvL9JwI9sJoQWXA8ljqced/owoTLM/gt4Lrw49HLypqUmIaGiowVVAdst0y6wJLaeMKQjgmbOKEUlujZ1CuGowYhlx+qwprefz9FyppQ9Gs8KtIeLsPpWjR5S1v9dDR+jRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663104; c=relaxed/simple;
	bh=bCvbrk9FV/DzuIXbwrWAxBe66DRNZWe3YPI3MsNS7cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C66JLT0ho7z6Gi4uEGteHq4/F2/75kxybswnwDdsf8+gG6+92WFHtq7EL60D6nkmCBVv/5SVmOPULD3I6t7r1e/PpgyOw30yZFMlvl8e/bzyvtLZ1lQJN7FfTQxQxoqhYGCoi5VIsyrkXhZd+mgQaDgs/gYX766C9F9iTxKEb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFuNHrk8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFuNHrk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29B5C116B1;
	Mon, 22 Jul 2024 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721663103;
	bh=bCvbrk9FV/DzuIXbwrWAxBe66DRNZWe3YPI3MsNS7cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFuNHrk8l5mfFqkewb8lTfyCjNriVOqMgkCFRAumgqWx6wpE4XSkItBG82a96B4sW
	 /lrYTptphhnLn1z/uTS5IjgSBGZKQjJs2q8J1GxfJw1p2JF8iF8gufsL36iIc9fmEq
	 StB4q2EVQ0+1lUyU9pWFR1+ZqT6nzl3IVJ2NJOHETbUdLgUdfcdoMsCWv9/LPYhVHV
	 ZWkTTygDwp/YrU982viW0RrVEhsisf6CJmESsTYYHKeI1y+NeI9G1+96WR36hDlbPV
	 zvSRwnkhdpB/cH0i1vHYbgVy6Nd9XkcbZdDEWgI5zqJJgdzS9y0rVttUbxsQGa/Hrd
	 x4rphrDR6+urg==
Date: Mon, 22 Jul 2024 18:44:58 +0300
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
Message-ID: <20240722154458.GA7022@unreal>
References: <cover.1721547902.git.leon@kernel.org>
 <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org>
 <20240722151037.GA25001@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722151037.GA25001@lst.de>

On Mon, Jul 22, 2024 at 05:10:37PM +0200, Christoph Hellwig wrote:
> On Sun, Jul 21, 2024 at 10:49:11AM +0300, Leon Romanovsky wrote:
> > -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > -		struct sg_table *sgt, enum dma_data_direction dir)
> > +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > +				  struct sg_table *sgt,
> > +				  enum dma_data_direction dir)
> 
> Why are you reformatting these to a much less readable coding style?

I'm relying on clang-formatter to format the code, see .clang-format
file in the kernel root directory.

> 
> > +static inline struct page *
> > +dma_common_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
> > +		       enum dma_data_direction dir, gfp_t gfp)
> > +{
> > +	return NULL;
> > +}
> > +static inline void dma_common_free_pages(struct device *dev, size_t size,
> > +					 struct page *vaddr,
> > +					 dma_addr_t dma_handle,
> > +					 enum dma_data_direction dir)
> > +{
> > +}
> 
> dma-iommu very much depends on these.  So we'll need to also
> build ops_helpers.o if dma-iommu is enabled.  So we'll probably need
> a separate Kconfig option for it that the various users select.
> 

I removed them from dma-iommu.c and there are no calls to them in that file.
➜  kernel git:(m/dma-v2) git grep dma_common_alloc_pages drivers/iommu/ | wc -l
0

Thanks
