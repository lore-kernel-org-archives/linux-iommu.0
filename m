From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/1] iommu: Add config option to set lazy mode as default
Date: Fri, 22 Mar 2019 14:42:57 +0000
Message-ID: <8cf20613-7a9a-d4a1-b52e-4b526f2c7ff2@huawei.com>
References: <20190322141121.18428-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322141121.18428-1-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 22/03/2019 14:11, Zhen Lei wrote:

> This allows the default behaviour to be controlled by a kernel config
> option instead of changing the command line for the kernel to include
> "iommu.strict=0" on ARM64 where this is desired.
>
> This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH
>
> Note: At present, intel_iommu, amd_iommu and s390_iommu use lazy mode as
> defalut, so there is no need to add code for them.

/s/defalut/default/

>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/Kconfig | 14 ++++++++++++++
>  drivers/iommu/iommu.c |  5 +++++

Do we need to update kernel-parameters.txt for iommu.strict?

>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6f07f3b21816c64..5ec9780f564eaf8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>
>  	  If unsure, say N here.
>
> +config IOMMU_LAZY_MODE

maybe should add "DMA" to the name, and even "DEFAULT"

> +	bool "IOMMU use lazy mode to flush IOTLB and free IOVA"
> +	depends on IOMMU_API
> +	help
> +	  For every IOMMU unmap operation, the flush operation of IOTLB and the free
> +	  operation of IOVA are deferred.

This is a bit unclear, as there is no context. I think that you need to 
say something like, "Support lazy mode, where for every IOMMU DMA unmap 
operation, the flush operation of IOTLB and the free operation of IOVA 
are deferred. "


They are only guaranteed to be done before
> +	  the related IOVA will be reused. Removing the need to pass in iommu.strict=0
> +	  through command line on ARM64(Now, intel_iommu, amd_iommu, s390_iommu use
> +	  lazy mode as deault).

prone to going out-of-date

  If this is enabled, you can still disable with kernel
> +	  parameters, such as iommu.strict=1, intel_iommu=strict, amd_iommu=fullflush
> +	  or s390_iommu=strict depending on the architecture.
> +
> +	  If unsure, say N here.
> +
>  config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 33a982e33716369..e307d70d1578b3b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,12 @@
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> +
> +#ifdef CONFIG_IOMMU_LAZY_MODE
> +static bool iommu_dma_strict __read_mostly;
> +#else
>  static bool iommu_dma_strict __read_mostly = true;
> +#endif
>
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> --
> 1.8.3
>
>
>

Cheers
