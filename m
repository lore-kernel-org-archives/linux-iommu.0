Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1120E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 07:17:36 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 49E033D9; Fri, 15 Jul 2022 09:17:28 +0200 (CEST)
Date: Fri, 15 Jul 2022 09:17:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tina Zhang <tina.zhang@intel.com>, jean-philippe@linaro.org
Cc: iommu@lists.linux.dev, will@kernel.org, kevin.tian@intel.com,
	jean-philippe@linaro.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Message-ID: <YtEUhkmSb5rd+h5t@8bytes.org>
References: <20220605161152.3171-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605161152.3171-1-tina.zhang@intel.com>

Hey Jean-Philippe,

can you have a look at this please?

Thanks,

	Joerg

On Mon, Jun 06, 2022 at 12:11:52AM +0800, Tina Zhang wrote:
> Map/unmap_pags() allows map and unmap multiple pages of the same size
> in one call, which can improve performance by reducing the numbers of
> vmexits. With map/unmap_pages() implemented, the prior map/unmap()
> callbacks are deprecated.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/virtio-iommu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..3c943dbd9fd0 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,11 +788,13 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> -static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> -		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
> +			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			    int prot, gfp_t gfp, size_t *mapped)
>  {
>  	int ret;
>  	u32 flags;
> +	size_t size = pgsize * pgcount;
>  	u64 end = iova + size - 1;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> @@ -823,17 +825,21 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
>  	if (ret)
>  		viommu_del_mappings(vdomain, iova, end);
> +	else if (mapped)
> +		*mapped = size;
>  
>  	return ret;
>  }
>  
> -static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
> -			   size_t size, struct iommu_iotlb_gather *gather)
> +static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
> +				 size_t pgsize, size_t pgcount,
> +				 struct iommu_iotlb_gather *gather)
>  {
>  	int ret = 0;
>  	size_t unmapped;
>  	struct virtio_iommu_req_unmap unmap;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	size_t size = pgsize * pgcount;
>  
>  	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
>  	if (unmapped < size)
> @@ -1018,8 +1024,8 @@ static struct iommu_ops viommu_ops = {
>  	.owner			= THIS_MODULE,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev		= viommu_attach_dev,
> -		.map			= viommu_map,
> -		.unmap			= viommu_unmap,
> +		.map_pages		= viommu_map_pages,
> +		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.free			= viommu_domain_free,
> -- 
> 2.34.1
