From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v6 07/20] vfio/iommu_type1: implement the
	VFIO_DMA_MAP_FLAG_NOEXEC flag
Date: Thu, 05 Jun 2014 14:48:39 -0600
Message-ID: <1402001319.9207.252.camel@ul30vt.home>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
	<1401987808-23596-8-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1401987808-23596-8-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-06-05 at 19:03 +0200, Antonios Motakis wrote:
> Some IOMMU drivers, such as the ARM SMMU driver, make available the
> IOMMU_NOEXEC flag, to set the page tables for a device as XN (execute never).
> This affects devices such as the ARM PL330 DMA Controller, which respects
> this flag and will refuse to fetch DMA instructions from memory where the
> XN flag has been set.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 6673e7b..e2566fd 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -80,6 +80,24 @@ struct vfio_group {
>  	struct list_head	next;
>  };
>  
> +static int vfio_domains_have_cap_noexec(struct vfio_iommu *iommu)
> +{
> +	struct vfio_domain *d;
> +	int ret = 1;
> +
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		if (!iommu_domain_has_cap(d->domain, IOMMU_CAP_NOEXEC)) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&iommu->lock);
> +
> +	return ret;
> +}
> +
> +
>  /*
>   * This code handles mapping and unmapping of user data buffers
>   * into DMA'ble space using the IOMMU
> @@ -542,6 +560,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		prot |= IOMMU_WRITE;
>  	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
>  		prot |= IOMMU_READ;
> +	if (map->flags & VFIO_DMA_MAP_FLAG_NOEXEC) {
> +		if (!vfio_domains_have_cap_noexec(iommu))
> +			return -EINVAL;
> +		prot |= IOMMU_NOEXEC;
> +	}
>  
>  	if (!prot)
>  		return -EINVAL; /* No READ/WRITE? */
> @@ -899,6 +922,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  			if (!iommu)
>  				return 0;
>  			return vfio_domains_have_iommu_cache(iommu);
> +		case VFIO_IOMMU_PROT_NOEXEC:
> +			if (!iommu)
> +				return 0;
> +			return vfio_domains_have_cap_noexec(iommu);
>  		default:
>  			return 0;
>  		}
> @@ -922,7 +949,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  	} else if (cmd == VFIO_IOMMU_MAP_DMA) {
>  		struct vfio_iommu_type1_dma_map map;
>  		uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> -				VFIO_DMA_MAP_FLAG_WRITE;
> +				VFIO_DMA_MAP_FLAG_WRITE |
> +				VFIO_DMA_MAP_FLAG_NOEXEC;
>  
>  		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
>  

This doesn't look complete.  What happens if we support NOEXEC, then we
add a group behind an IOMMU that doesn't support NOEXEC?  In one case we
attempt to use the same domain, which might imply the same IOMMU page
tables, but is the hardware going to support that?  In the other case we
create a new domain, then try to replay the mappings, including the
NOEXEC bit... what's that going to do?  Can we add a non-NOEXEC domain
to a container that was previously NOEXEC?  The point of changing the
flag from EXEC to NOEXEC was to make it enforceable, but doesn't that
mean we need to prevent that happening if we have NOEXEC mappings?

Something needs to happen in vfio_iommu_type1_attach_group() to figure
out what's allowed.  Also, vfio_domains_have_cap_noexec() should be
named vfio_domains_have_iommu_nexec() to match _iommu_cache() and
possibly they should both be wrappers to a common function if they end
up sharing similar implementations.  Thanks,

Alex
