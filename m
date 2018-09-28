From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 3/7] iommu: Add "iommu.strict" command line option
Date: Fri, 28 Sep 2018 13:51:31 +0100
Message-ID: <20180928125130.GD1577@brain-police>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <799fad801970298385af3abc8ca82620ad62c000.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <799fad801970298385af3abc8ca82620ad62c000.1537458163.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 05:10:23PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Add a generic command line option to enable lazy unmapping via IOVA
> flush queues, which will initally be suuported by iommu-dma. This echoes
> the semantics of "intel_iommu=strict" (albeit with the opposite default
> value), but in the driver-agnostic fashion of "iommu.passthrough".
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: move handling out of SMMUv3 driver, clean up documentation]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v8:
>  - Rename "non-strict" to "strict" to better match existing options
>  - Rewrite doc text/commit message
>  - Downgrade boot-time message from warn/taint to info
> 
>  .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
>  drivers/iommu/iommu.c                         | 23 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9871e649ffef..92ae12aeabf4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1749,6 +1749,18 @@
>  		nobypass	[PPC/POWERNV]
>  			Disable IOMMU bypass, using IOMMU for PCI devices.
>  
> +	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
> +			Format: { "0" | "1" }
> +			0 - Lazy mode.
> +			  Request that DMA unmap operations use deferred
> +			  invalidation of hardware TLBs, for increased
> +			  throughput at the cost of reduced device isolation.
> +			  Will fall back to strict mode if not supported by
> +			  the relevant IOMMU driver.
> +			1 - Strict mode (default).
> +			  DMA unmap operations invalidate IOMMU hardware TLBs
> +			  synchronously.
> +
>  	iommu.passthrough=
>  			[ARM64] Configure DMA to bypass the IOMMU by default.
>  			Format: { "0" | "1" }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8c15c5980299..02b6603f0616 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> +static bool iommu_dma_strict __read_mostly = true;
>  
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> @@ -131,6 +132,21 @@ static int __init iommu_set_def_domain_type(char *str)
>  }
>  early_param("iommu.passthrough", iommu_set_def_domain_type);
>  
> +static int __init iommu_dma_setup(char *str)
> +{
> +	int ret;
> +
> +	ret = kstrtobool(str, &iommu_dma_strict);
> +	if (ret)
> +		return ret;
> +
> +	if (!iommu_dma_strict)
> +		pr_info("Enabling deferred TLB invalidation for DMA; protection against malicious/malfunctioning devices may be reduced.\n");

Printing here isn't quite right, because if somebody boots with something
like:

	"iommu.strict=1 iommu.strict=0 iommu.strict=0 iommu.strict=1"

then we'll print the wrong thing twice :)

I think we either need to drop the print, or move it to a the DMA domain
initialisation.

Will
