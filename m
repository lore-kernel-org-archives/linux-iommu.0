Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558A16D9A5
	for <iommu@lists.linux.dev>; Mon, 22 Jul 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661044; cv=none; b=fLI3J0iIIOZ+786fAvID3G0t+UhtpsOIuVLUFF9TxlvqN41Xb1+lt2PVX1DPMahfzcHo8Bp+9LTj9BRBfnNVVx6ed6UwAL4d2xBB3oPE6q9D1uo3UFHxT5ZDTtadMmc9bh2M6gINwLBHFduZFrCJ2UnxdvUhE6vba/DPoFa7c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661044; c=relaxed/simple;
	bh=h0avLBh1l9SpGT34z41LHtNgE3HKNHjT+leiPk8F7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+Sfpz9VS283QH1TKA2z6lmulg3VyoMbBsZYugyfap73k0Fy7c7oP8MBUaJ8b0P7PvsXR2zZZztdCzd9O0ILkU89adhyiyKg49NkCumWhYvHGgnXjtE7f4A0pXE4Z2yBdub73BHJjN9ks00Xr8AGkKLXZ/zA3FQ+j2lBHXNVBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E0D968C7B; Mon, 22 Jul 2024 17:10:38 +0200 (CEST)
Date: Mon, 22 Jul 2024 17:10:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240722151037.GA25001@lst.de>
References: <cover.1721547902.git.leon@kernel.org> <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 21, 2024 at 10:49:11AM +0300, Leon Romanovsky wrote:
> -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt, enum dma_data_direction dir)
> +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +				  struct sg_table *sgt,
> +				  enum dma_data_direction dir)

Why are you reformatting these to a much less readable coding style?

> +static inline struct page *
> +dma_common_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		       enum dma_data_direction dir, gfp_t gfp)
> +{
> +	return NULL;
> +}
> +static inline void dma_common_free_pages(struct device *dev, size_t size,
> +					 struct page *vaddr,
> +					 dma_addr_t dma_handle,
> +					 enum dma_data_direction dir)
> +{
> +}

dma-iommu very much depends on these.  So we'll need to also
build ops_helpers.o if dma-iommu is enabled.  So we'll probably need
a separate Kconfig option for it that the various users select.

