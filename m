Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB80379EE8;
	Mon,  1 Jun 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317324; cv=none; b=XU2+Yaw1x2Y/axlYox6vRmxBVFNUtbG2PWGKMg75WXGo0d310ZFTRvR529z8/yULa5Z94x1M2WZsyEFmAzFEP10O8PeFa5HKj8JzpjoN17ya+U2J0/LUBfEEP6qHn5zz3sFKzcTyUII/rExB3jbu0xPpJJ5ZytJtiAUiTxFbW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317324; c=relaxed/simple;
	bh=nEMYynZFqktNV6TomQyv9c2Tjmdsd3daH9sy/86ygFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPmIVnbpaoLqwC5s2g5MGQ7ejAHf5yms96JSP+vfj2B88GG5lGj7pZZq/Ro6NxOJcua4+S40WqGisGARyvAjpdcBNCBrsrj5eTBmfmZW+NRf/KlPVS8o8fS9qoPSRX2yJEVKJ7xkBuAkEgfb8eYI7YvKFpXWEeIxZAEnpHY10eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeJxeT58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeJxeT58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B771F00898;
	Mon,  1 Jun 2026 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780317322;
	bh=4D8mKmK+s+4sL4bhA99fPLjzqV9Yidvpyfe324Qy2BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeJxeT58apk3aiYwTcDP8ZuwOqZlxtg6xsRxAvAegwmbFCDWBr1iXRhj/SzfUMjtg
	 ctd1IuB9RXeyJf73H5q5jKeChTLAWYcR+1nbgKUR4qKmsdz81nh3zUoFDzYbS2ERXF
	 Y3hdyA82gVLA+0qtbBuD6/x2Rds6PCzBM4hgiJpPdmalG12vhHakoRTCQDN2nAjOW0
	 0NhnDNlQdED8swk7O1onCeGs2OQ1ePSxqpK8cEUmqZ96lA55xvPKzhRTt83806PL5b
	 Y3RTz2PHWzhSlpIYI8NjtPR4c1MnsuNAg64LpWlb/TYnFk8mhgdoa1+lY6ZFc8dT/H
	 d8hAdyuD2phxQ==
Date: Mon, 1 Jun 2026 13:35:16 +0100
From: Will Deacon <will@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <ah18hDhjSLxIvb-Y@willie-the-truck>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-4-skhawaja@google.com>

On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..c2b98f91900a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -6,6 +6,8 @@
>   */
>  #include <linux/memblock.h> /* for max_pfn */
>  #include <linux/export.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/dma_alloc.h>
>  #include <linux/mm.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/scatterlist.h>
> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_DMA_LIVEUPDATE
> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
> +				   size_t size, dma_addr_t dma_handle,
> +				   unsigned long attrs, u64 *state)
> +{
> +	struct dma_alloc_ser *ser;
> +	int ret;
> +
> +	if (!kho_is_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_CMA))
> +		return -EOPNOTSUPP;

Hmm, it seems a bit overkill to do this just because CMA is compiled
in, especially as it's user-selectable in kconfig.

Maybe you need to iterate over the CMA areas using cma_for_each_area(),
similarly to how you do with the pools?

Will
