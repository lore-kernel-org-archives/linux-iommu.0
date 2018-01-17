From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/of: Only do IOMMU lookup for available ones
Date: Wed, 17 Jan 2018 14:28:08 +0100
Message-ID: <20180117132808.s5henw63oseg3ufd@8bytes.org>
References: <20180103060920.23475-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103060920.23475-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org, tfiga@chromium.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 03, 2018 at 02:09:20PM +0800, Jeffy Chen wrote:
> The for_each_matching_node_and_match() would return every matching
> nodes including unavailable ones.
> 
> It's pointless to init unavailable IOMMUs, so add a sanity check to
> avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/iommu/of_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 50947ebb6d17..6f7456caa30d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -240,6 +240,9 @@ static int __init of_iommu_init(void)
>  	for_each_matching_node_and_match(np, matches, &match) {
>  		const of_iommu_init_fn init_fn = match->data;
>  
> +		if (!of_device_is_available(np))
> +			continue;
> +

Makes sense to me, but I'd like to have an OK from Robin or Will (added
to Cc) before applying this.



	Joerg
