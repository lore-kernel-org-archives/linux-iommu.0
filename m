From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date: Fri, 26 Apr 2019 16:04:29 +0200
Message-ID: <20190426140429.GG24576@8bytes.org>
References: <20190424165051.13614-1-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424165051.13614-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <tmurphy@arista.com>
Cc: iommu@lists.linux-foundation.org, murphyt7@tcd.ie, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 24, 2019 at 05:50:51PM +0100, Tom Murphy wrote:
> check if there is a not-present cache present and flush it if there is.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f7cdd2ab7f11..91fe5cb10f50 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1637,6 +1637,11 @@ static int iommu_map_page(struct protection_domain *dom,
>  
>  	update_domain(dom);
>  
> +	if (unlikely(amd_iommu_np_cache && !dom->updated)) {
> +		domain_flush_pages(dom, bus_addr, page_size);
> +		domain_flush_complete(dom);
> +	}
> +

The iommu_map_page function is called once per physical page that is
mapped, so in the worst case for every 4k mapping established. So it is
not the right place to put this check in.

>From a quick glance this check belongs into the map_sg() and the
amd_iommu_map() function, but without the dom->updated check.

Besides, to really support systems with np-cache in a way that doesn't
destroy all performance, the driver also needs range-flushes for IOTLBs.
Currently it can only flush a 4k page of the full address space of a
domain. But that doesn't mean we shouldn't fix the missing flushes now.

So please re-send the patch with the check at the two places I pointed
out above.

Thanks,

	Joerg
