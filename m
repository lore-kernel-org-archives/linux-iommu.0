From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/intel-iommu: fix memory leak in
 intel_iommu_put_resv_regions()
Date: Wed, 16 Jan 2019 21:43:40 +0100
Message-ID: <ce818491-4b9c-a5d8-7ad6-707aa25445ed@redhat.com>
References: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Joerg Roedel <jroedel@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Hi Gerald,

On 1/16/19 8:11 PM, Gerald Schaefer wrote:
> Commit 9d3a4de4cb8d ("iommu: Disambiguate MSI region types") changed
> the reserved region type in intel_iommu_get_resv_regions() from
> IOMMU_RESV_RESERVED to IOMMU_RESV_MSI, but it forgot to also change
> the type in intel_iommu_put_resv_regions().
> 
> This leads to a memory leak, because now the check in
> intel_iommu_put_resv_regions() for IOMMU_RESV_RESERVED will never
> be true, and no allocated regions will be freed.
> 
> Fix this by changing the region type in intel_iommu_put_resv_regions()
> to IOMMU_RESV_MSI, matching the type of the allocated regions.
> 
> Fixes: 9d3a4de4cb8d ("iommu: Disambiguate MSI region types")
> Cc: <stable@vger.kernel.org> # v4.11+
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 048b5ab36a02..b83e0f2025bb 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5295,7 +5295,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
>  	struct iommu_resv_region *entry, *next;
>  
>  	list_for_each_entry_safe(entry, next, head, list) {
> -		if (entry->type == IOMMU_RESV_RESERVED)
> +		if (entry->type == IOMMU_RESV_MSI)
>  			kfree(entry);
>  	}
>  }
> 
