From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: prevent any devices access to
 memory without registration
Date: Thu, 12 Jul 2018 18:01:21 +0100
Message-ID: <20180712170120.GC26935@arm.com>
References: <1531387723-3592-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531387723-3592-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 12, 2018 at 05:28:43PM +0800, Zhen Lei wrote:
> Stream bypass is not security. A malicious device can be hot plugged
> without match any drivers, but it can access to any memory. So change to
> disable bypass by default.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Whilst this sounds nice, I *bet* you it will break some systems. In
particular, those where the SMMU is described but the toplogical information
is either incorrect or incomplete.

I guess we could put it into next and see if anybody complains. What do
others think?

Will

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..b0ec28d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -366,7 +366,7 @@
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> 
> -static bool disable_bypass;
> +static bool disable_bypass = 1;
>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>  MODULE_PARM_DESC(disable_bypass,
>  	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> --
> 1.8.3
> 
> 
