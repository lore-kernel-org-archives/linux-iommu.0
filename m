Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE813C8E2
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078660; cv=none; b=eoWMSrkX1qj6h2AeEjjGPm3h0vUah8bVjfC+Dohah0WemwRS9fJRPbP2LDWTFWImQ8pu1fD0SAwz9tNyHk8Q+K6fWzCfUndA3nL1noOuS4HaFkXbtQgIQHYXDl5sK4xgFvU0dhF18dM+cIZQDGHtpmSQ/ewB75WbcLQc0kfkDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078660; c=relaxed/simple;
	bh=bf/VeYucpNv6ZZcK2fwIQKDea5xGi/UZ5dimPkOuYKQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=grgv0cjcWdfPJE5u2naS1o5UnIB2GwdpvwDRqHG+ga9QY2O/NddFvdEb9Lh/9atjoNnRpx6CKmo1wMEu8L/E8y0aSxcsudjPmxubTq2Q5+FBOk4TRVG8iQYBxySQ+MvyaE0Rwjad4d+vVc6tWH5PwR98OPyqtNXkQ719jJNI6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+DjnpCj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+DjnpCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730078659; x=1761614659;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bf/VeYucpNv6ZZcK2fwIQKDea5xGi/UZ5dimPkOuYKQ=;
  b=N+DjnpCjMNBE13YZmLEu3hRr225Mpra6I21M8x9ioQbnLGAmcsHzxjcC
   AmzXs/fMswHuf64HBQ8HQAooYp2Di7N0JchPApHPpa0ZvmIYmwK6yL6/G
   R5Wqa+T4MJN6k/8QpFqtksE1v43e300XflAoHRzTMYbl4Z2hAcvT86PWc
   ab6yW3n7kZQ9xEXAJKpB+6sR/72Ji6bz8H8+0PIvQCyv2iP1Tt2suxmBV
   cT07dY+ifW2kxwvYgiyTHLyHhqakFGQbqpv/xEI5G8jLTXCEyDiSkuL9t
   ucmHblczsYV2N/tLMwR16fYlXD9CgmJzgvOndCTMxqnfz49mfqqtdj0Zq
   A==;
X-CSE-ConnectionGUID: 8A1/hITZQA+JGaWzBIKpRQ==
X-CSE-MsgGUID: gpRGkt+uRj6VyEm0TUcjOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40769202"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40769202"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 18:24:17 -0700
X-CSE-ConnectionGUID: 3XId+CpwRcup4hw+6LoFIA==
X-CSE-MsgGUID: nYY7ZZ8XT8aQBqUAXsE3Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86065323"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 18:24:10 -0700
Message-ID: <25c32551-32e2-4a44-b0ae-30ad08e06799@linux.intel.com>
Date: Mon, 28 Oct 2024 09:24:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Leon Romanovsky <leonro@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <cover.1730037276.git.leon@kernel.org>
 <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 22:21, Leon Romanovsky wrote:
> From: Leon Romanovsky<leonro@nvidia.com>
> 
> The existing .map_page() callback provides both allocating of IOVA
> and linking DMA pages. That combination works great for most of the
> callers who use it in control paths, but is less effective in fast
> paths where there may be multiple calls to map_page().
> 
> These advanced callers already manage their data in some sort of
> database and can perform IOVA allocation in advance, leaving range
> linkage operation to be in fast path.
> 
> Provide an interface to allocate/deallocate IOVA and next patch
> link/unlink DMA ranges to that specific IOVA.
> 
> The API is exported from dma-iommu as it is the only implementation
> supported, the namespace is clearly different from iommu_* functions
> which are not allowed to be used. This code layout allows us to save
> function call per API call used in datapath as well as a lot of boilerplate
> code.
> 
> Signed-off-by: Leon Romanovsky<leonro@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.c   | 79 +++++++++++++++++++++++++++++++++++++
>   include/linux/dma-mapping.h | 15 +++++++
>   2 files changed, 94 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c422e36c0d66..0644152c5aad 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1745,6 +1745,85 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
>   	return SIZE_MAX;
>   }
>   
> +static bool iommu_dma_iova_alloc(struct device *dev,
> +		struct dma_iova_state *state, phys_addr_t phys, size_t size)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	size_t iova_off = iova_offset(iovad, phys);
> +	dma_addr_t addr;
> +
> +	if (WARN_ON_ONCE(!size))
> +		return false;
> +	if (WARN_ON_ONCE(size & DMA_IOVA_USE_SWIOTLB))
> +		return false;
> +
> +	addr = iommu_dma_alloc_iova(domain,
> +			iova_align(iovad, size + iova_off),
> +			dma_get_mask(dev), dev);
> +	if (!addr)
> +		return false;
> +
> +	state->addr = addr + iova_off;
> +	state->__size = size;
> +	return true;
> +}
> +
> +/**
> + * dma_iova_try_alloc - Try to allocate an IOVA space
> + * @dev: Device to allocate the IOVA space for
> + * @state: IOVA state
> + * @phys: physical address
I'm curious to know why a physical address is necessary for IOVA space
allocation. Could you please elaborate?

> + * @size: IOVA size
> + *
> + * Check if @dev supports the IOVA-based DMA API, and if yes allocate IOVA space
> + * for the given base address and size.
> + *
> + * Note: @phys is only used to calculate the IOVA alignment. Callers that always
> + * do PAGE_SIZE aligned transfers can safely pass 0 here.
> + *
> + * Returns %true if the IOVA-based DMA API can be used and IOVA space has been
> + * allocated, or %false if the regular DMA API should be used.
> + */
> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
> +		phys_addr_t phys, size_t size)
> +{
> +	memset(state, 0, sizeof(*state));
> +	if (!use_dma_iommu(dev))
> +		return false;
> +	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
> +	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
> +		return false;
> +	return iommu_dma_iova_alloc(dev, state, phys, size);
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_try_alloc);

Thanks,
baolu
