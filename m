From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v5 04/11] VFIO_IOMMU_TYPE1: Introduce the
	VFIO_DMA_MAP_FLAG_EXEC flag
Date: Mon, 28 Apr 2014 10:53:56 -0600
Message-ID: <1398704036.24318.269.camel@ul30vt.home>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-5-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398700371-20096-5-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2014-04-28 at 17:52 +0200, Antonios Motakis wrote:
> The ARM SMMU driver expects the IOMMU_EXEC flag, otherwise it will
> set the page tables for a device as XN (execute never). This affects
> devices such as the ARM PL330 DMA Controller, which fails to operate
> if the XN flag is set on the memory it tries to fetch its instructions
> from.
> 
> We introduce the VFIO_DMA_MAP_FLAG_EXEC to VFIO, and use it in
> VFIO_IOMMU_TYPE1 to set the IOMMU_EXEC flag. This way the user can
> control whether the XN flag will be set on the requested mappings. If
> the IOMMU_EXEC flag is available for at least one IOMMU of a container,
> the new capability VFIO_IOMMU_PROT_EXEC will be exposed.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 34 +++++++++++++++++++++++++++++++---
>  include/uapi/linux/vfio.h       |  2 ++
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 4dc989d..6ce32bf 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -498,12 +498,15 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
>  }
>  
>  static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
> -			  unsigned long pfn, long npage, int prot)
> +			  unsigned long pfn, long npage, int prot, bool exec)
>  {
>  	struct vfio_domain *d;
>  	int ret;
>  
>  	list_for_each_entry(d, &iommu->domain_list, next) {
> +		if (exec && iommu_domain_has_cap(d->domain, IOMMU_CAP_DMA_EXEC))
> +			prot |= IOMMU_EXEC;
> +
>  		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
>  				npage << PAGE_SHIFT, prot | d->prot);
>  		if (ret) {
> @@ -530,6 +533,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  	size_t size = map->size;
>  	long npage;
>  	int ret = 0, prot = 0;
> +	bool prot_exec = false;
>  	uint64_t mask;
>  	struct vfio_dma *dma;
>  	unsigned long pfn;
> @@ -543,6 +547,8 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		prot |= IOMMU_WRITE;
>  	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
>  		prot |= IOMMU_READ;
> +	if (map->flags & VFIO_DMA_MAP_FLAG_EXEC)
> +		prot_exec = true;

Is it really necessary for this to be a new parameter rather than prot |
= IOMMU_EXEC here?  It could simply be masked out in vfio_iommu_map()
when not supported.  When IOMMU_CAP_DMA_EXEC is not supported, does
IOMMU_EXEC effectively follow IOMMU_READ?  If so, does that imply we
need to error on a request for (IOMMU_WRITE | IOMMU_EXEC)?  Thanks,

Alex

>  
>  	if (!prot)
>  		return -EINVAL; /* No READ/WRITE? */
> @@ -595,7 +601,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		}
>  
>  		/* Map it! */
> -		ret = vfio_iommu_map(iommu, iova, pfn, npage, prot);
> +		ret = vfio_iommu_map(iommu, iova, pfn, npage, prot, prot_exec);
>  		if (ret) {
>  			vfio_unpin_pages(pfn, npage, prot, true);
>  			break;
> @@ -887,6 +893,23 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +static int vfio_domains_have_iommu_exec(struct vfio_iommu *iommu)
> +{
> +	struct vfio_domain *d;
> +	int ret = 0;
> +
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		if (iommu_domain_has_cap(d->domain, IOMMU_CAP_DMA_EXEC)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&iommu->lock);
> +
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -902,6 +925,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  			if (!iommu)
>  				return 0;
>  			return vfio_domains_have_iommu_cache(iommu);
> +		case VFIO_IOMMU_PROT_EXEC:
> +			if (!iommu)
> +				return 0;
> +			return vfio_domains_have_iommu_exec(iommu);
>  		default:
>  			return 0;
>  		}
> @@ -925,7 +952,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  	} else if (cmd == VFIO_IOMMU_MAP_DMA) {
>  		struct vfio_iommu_type1_dma_map map;
>  		uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> -				VFIO_DMA_MAP_FLAG_WRITE;
> +				VFIO_DMA_MAP_FLAG_WRITE |
> +				VFIO_DMA_MAP_FLAG_EXEC;
>  
>  		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index cb9023d..0847b29 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -29,6 +29,7 @@
>   * capability is subject to change as groups are added or removed.
>   */
>  #define VFIO_DMA_CC_IOMMU		4
> +#define VFIO_IOMMU_PROT_EXEC		5
>  
>  /*
>   * The IOCTL interface is designed for extensibility by embedding the
> @@ -398,6 +399,7 @@ struct vfio_iommu_type1_dma_map {
>  	__u32	flags;
>  #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
>  #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
> +#define VFIO_DMA_MAP_FLAG_EXEC (1 << 2)		/* executable from device */
>  	__u64	vaddr;				/* Process virtual address */
>  	__u64	iova;				/* IO virtual address */
>  	__u64	size;				/* Size of mapping (bytes) */
