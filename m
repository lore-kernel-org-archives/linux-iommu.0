From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/9] iommu/dma-iommu: Add iommu_dma_map_page_coherent
Date: Sun, 14 Apr 2019 23:33:17 -0700
Message-ID: <20190415063317.GC1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-5-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-5-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <tmurphy@arista.com>
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, linux-samsung-soc@vger.kernel.org, dima@arista.com, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

> @@ -693,7 +694,19 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  		unsigned long offset, size_t size, int prot)
>  {
>  	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> -			iommu_get_dma_domain(dev));
> +			iommu_get_dma_domain(dev), dma_get_mask(dev));
> +}
> +
> +dma_addr_t iommu_dma_map_page_coherent(struct device *dev, struct page *page,
> +		unsigned long offset, size_t size, int prot)
> +{

Note that my tree pointed to above removes the iommu_dma_map_page
wrapper.  I think for the coherent mappign we should also just
call __iommu_dma_map directly and not introduce another wrapper.

> +	dma_addr_t dma_mask = dev->coherent_dma_mask;
> +
> +	if (!dma_mask)
> +		dma_mask = dma_get_mask(dev);
> +
> +	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> +			iommu_get_dma_domain(dev), dma_mask);
>  }

In the DMA API there is no fallback when the coherent_dma_mask is not
set.  While various bits of legacy code do that we should not copy it
to new code.
