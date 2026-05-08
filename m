Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A737C10D
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232406; cv=none; b=nsU7YTsI4L9Bgc2SFSUrbBHw25CzFUAgpZJqSjwElRY8+MpSaliWZAA7vlbBWAAcHYc5HKnvp1TkOXq4J/wECmDNlrrkE1VaUn1CAOo/NzabdKWnpMifMDSjIbNACjP+Y3mY46QNhWr92kXWxwupRhkH3b3EvjMMbPsZfKZPA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232406; c=relaxed/simple;
	bh=YLMEg4q/wwEDFE63TKqhxmBCuMnX897M8UyyEjYNvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHUSxUhnsXfg3cYuLYwIh414qZiPzr31t3nUe0mTz5oHVwWjwA+ld+K4Mi883uIMK1iFJotzNgJPcWMjV4eErSQj+5KCsFKQEAN5C8OWXds3AkBTlzKS45iN5UCKYF/CdrpjNAx03S1E4SAEFrN7hDkal5VSm1ICGA6TA0iCfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F3u6rsDe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F3u6rsDe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B431BCA;
	Fri,  8 May 2026 02:26:37 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A211D3F7B4;
	Fri,  8 May 2026 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778232402; bh=YLMEg4q/wwEDFE63TKqhxmBCuMnX897M8UyyEjYNvRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3u6rsDe62bPhrrUf6GOV4vEkgRYjvq6R7yl5jTKfIz9yWEYLNmOzW8SVs+gUDUOj
	 OjCE18O0l/KeJl62w3iOBaveeEsJeXZ7AwobX1+DTH20j7G+6yPUjpc3QpKtj4zDRS
	 xgQWTB5YD9MVqUh6O+69JPLT4VTtFyL2fqNiqZfU=
Date: Fri, 8 May 2026 10:26:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/9] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free
 paths
Message-ID: <af2sTsMX1Ap_EOiU@arm.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <20260427055509.898190-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427055509.898190-3-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:25:02AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t size,
>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>  {
> +	unsigned long attrs = 0;
>  	struct page *page;
>  	void *ret;
>  
> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

I was looking at Sashiko's reports and it noticed the wrong type
returned here. Not something your patch introduces but I think it should
be fixed rather than continue to propagate it. It's been around since
5.10, commit 5b138c534fda ("dma-direct: factor out a
dma_direct_alloc_from_pool helper"). This code path isn't used much I
guess.

-- 
Catalin
