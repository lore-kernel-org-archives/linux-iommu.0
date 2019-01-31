From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
Date: Thu, 31 Jan 2019 14:55:17 +0000
Message-ID: <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131135211.6732-1-thunder.leizhen@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 31/01/2019 13:52, Zhen Lei wrote:
> Currently, many peripherals are faster than before. For example, the top
> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
> when iommu page-table mapping enabled, it's hard to reach the top speed
> in strict mode, because of frequently map and unmap operations. In order
> to keep abreast of the times, I think it's better to set non-strict as
> default.

Most users won't be aware of this relaxation and will have their system
vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
Invalidation in
http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf

Why not keep the policy to secure by default, as we do for
iommu.passthrough? And maybe add something similar to
CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
command-line argument or change the default config.

Thanks,
Jean

> 
> Below it's our iperf performance data of 25Gb netcard:
> strict mode: 18-20 Gb/s
> non-strict mode: 23.5 Gb/s
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>  drivers/iommu/iommu.c                           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b799bcf..667221f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1779,13 +1779,13 @@
> 
>  	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>  			Format: { "0" | "1" }
> -			0 - Lazy mode.
> +			0 - Lazy mode (default).
>  			  Request that DMA unmap operations use deferred
>  			  invalidation of hardware TLBs, for increased
>  			  throughput at the cost of reduced device isolation.
>  			  Will fall back to strict mode if not supported by
>  			  the relevant IOMMU driver.
> -			1 - Strict mode (default).
> +			1 - Strict mode.
>  			  DMA unmap operations invalidate IOMMU hardware TLBs
>  			  synchronously.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3ed4db3..10e0b49 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,7 @@
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly;
> 
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> --
> 1.8.3
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
