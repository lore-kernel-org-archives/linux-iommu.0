Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D139CCFE;
	Sat,  3 Oct 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063892; cv=none; b=TuAwXt/oVRrgO/JOFcXjKvn5OeougxAWLxpwFIzqRUNlvx18gHA8IJcvHcvwRcoOBjhd87IMy//bJsEOvY4tb7AZ8WyDnYPTLOULpMUPESaL86koBH9fR6Kyx0Pv9aEvrUokNpnM0iOBY1/Ff8KVIOXI8fXMIx48Wn+AC+ex6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063892; c=relaxed/simple;
	bh=38Fbg65EGEel43VtgYG/9Qaf+D9pTNsdGxBfPRogdU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVRBKMh5NDwIIYS7rK3uvi6EFWFR8cemp+Y1oU67QuOZMVeSBCLTHgapM9s+9SYYQqLppVEOZgJDz5btaBjL3R8Q3Yk7Muh5gwRBHtfD7bTCec45iRv10Nrha+j1jmJtbF7SCIafNZId2q3EQ8tK80PGyPxB6grK3eD94VUTsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Kwn9ykj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Kwn9ykj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PRCu0Kt8JudtLQU7puVFYQ3X0LQWTWd0xA6QLuOvzi4=; b=4Kwn9ykjncxT4a81L4rkYGMdWy
	fKJdEWHGSH5Ne5QIzNptseYoYOxSB54H6Zps6+hOKbHhCFJg/yTqIe+LgWucSspZJTaXCfbnhyKYO
	2eesTTy+4xU73OhrpknCWRKq+lk2D7VTmv2B/8wg0gfLksjaUYED+ogZ2BeLSELv4jPOi62JL97Fz
	aoTEA9GlrKzjCr7ea8mDQ5L5rc9r1I+j/R49PU7mJko+tsJnLrxvAs94J8zx1iozVfkGGW7SZzHHC
	SHCTjwI1Dvw4Ue/jCfFoBjXka9KE0ScDoOT4W+omS+YjuGwVryfBW0jFhOWF02oLzS5phgHIBvyvJ
	Iz6uEVmw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD7X2-0000000E5oE-0sGB;
	Sat, 03 Oct 2026 21:44:36 +0000
Message-ID: <7ce092a4-5c85-4391-809a-3d04b638a722@infradead.org>
Date: Sat, 3 Oct 2026 14:44:34 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC: DMA_PMD 01/22] iommu/dma: introduce CONFIG_DMA_PMD and
 metadata table
To: Luigi Rizzo <lrizzo@google.com>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261003212241.3432303-1-lrizzo@google.com>
 <20261003212241.3432303-2-lrizzo@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261003212241.3432303-2-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/26 2:22 PM, Luigi Rizzo wrote:
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a3..1bb347fd9da4a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -158,6 +158,38 @@ config IOMMU_DMA
>  	select NEED_SG_DMA_LENGTH
>  	select NEED_SG_DMA_FLAGS if SWIOTLB
>  
> +# PMD_SIZE IOMMU backing for DMA-coherent devices
> +config DMA_PMD
> +	bool "PMD_SIZE IOMMU backing for DMA-coherent devices"
> +	depends on IOMMU_DMA
> +	depends on X86_64 || (ARM64 && ARM64_4K_PAGES)
> +	depends on !PREEMPT_RT
> +	default y
> +	help
> +	  Hand out DMA buffers carved out of PMD_SIZE physically contiguous
> +	  blocks that the IOMMU maps with a single leaf PTE. Mapping,
> +	  unmapping and IOTLB flushing are done lazily to reduce CPU overhead.
> +	  The large mappings greatly reduce IOTLB usage. As in strict iommu
> +	  mode, pages are returned to the buddy allocator only when any existing
> +	  mappings have been removed and IOTLB flushed.
> +	  Costs 128KB of metadata per GB of DMA_PMD buffers, allocated on demand.

Paragraph 1 of the patch description says 64KB per 1GB, not 128KB.
Or am I mixing things up?

-- 
~Randy

