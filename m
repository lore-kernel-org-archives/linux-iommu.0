From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 7/7] vfio/type1: return MSI geometry through
	VFIO_IOMMU_GET_INFO capability chains
Date: Mon, 9 May 2016 16:49:50 -0600
Message-ID: <20160509164950.0b1cf9c1@t450s.home>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<1462362858-2925-8-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1462362858-2925-8-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed,  4 May 2016 11:54:18 +0000
Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> This patch allows the user-space to retrieve the MSI geometry. The
> implementation is based on capability chains, now also added to
> VFIO_IOMMU_GET_INFO.
> 
> The returned info comprise:
> - whether the MSI IOVA are constrained to a reserved range (x86 case) and
>   in the positive, the start/end of the aperture,
> - or whether the IOVA aperture need to be set by the userspace. In that
>   case, the size and alignment of the IOVA region to be provided are
>   returned.
> 
> In case the userspace must provide the IOVA range, we currently return
> an arbitrary number of IOVA pages (16), supposed to fulfill the needs of
> current ARM platforms. This may be deprecated by a more sophisticated
> computation later on.
> 
> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> ---
> v8 -> v9:
> - use iommu_msi_supported flag instead of programmable
> - replace IOMMU_INFO_REQUIRE_MSI_MAP flag by a more sophisticated
>   capability chain, reporting the MSI geometry
> 
> v7 -> v8:
> - use iommu_domain_msi_geometry
> 
> v6 -> v7:
> - remove the computation of the number of IOVA pages to be provisionned.
>   This number depends on the domain/group/device topology which can
>   dynamically change. Let's rely instead rely on an arbitrary max depending
>   on the system
> 
> v4 -> v5:
> - move msi_info and ret declaration within the conditional code
> 
> v3 -> v4:
> - replace former vfio_domains_require_msi_mapping by
>   more complex computation of MSI mapping requirements, especially the
>   number of pages to be provided by the user-space.
> - reword patch title
> 
> RFC v1 -> v1:
> - derived from
>   [RFC PATCH 3/6] vfio: Extend iommu-info to return MSIs automap state
> - renamed allow_msi_reconfig into require_msi_mapping
> - fixed VFIO_IOMMU_GET_INFO
> ---
>  drivers/vfio/vfio_iommu_type1.c | 69 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 30 +++++++++++++++++-
>  2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2fc8197..841360b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1134,6 +1134,50 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +static int compute_msi_geometry_caps(struct vfio_iommu *iommu,
> +				     struct vfio_info_cap *caps)
> +{
> +	struct vfio_iommu_type1_info_cap_msi_geometry *vfio_msi_geometry;
> +	struct iommu_domain_msi_geometry msi_geometry;
> +	struct vfio_info_cap_header *header;
> +	struct vfio_domain *d;
> +	bool mapping_required;
> +	size_t size;
> +
> +	mutex_lock(&iommu->lock);
> +	/* All domains have same require_msi_map property, pick first */
> +	d = list_first_entry(&iommu->domain_list, struct vfio_domain, next);
> +	iommu_domain_get_attr(d->domain, DOMAIN_ATTR_MSI_GEOMETRY,
> +			      &msi_geometry);
> +	mapping_required = msi_geometry.iommu_msi_supported;
> +
> +	mutex_unlock(&iommu->lock);
> +
> +	size = sizeof(*vfio_msi_geometry);
> +	header = vfio_info_cap_add(caps, size,
> +				   VFIO_IOMMU_TYPE1_INFO_CAP_MSI_GEOMETRY, 1);
> +
> +	if (IS_ERR(header))
> +		return PTR_ERR(header);
> +
> +	vfio_msi_geometry = container_of(header,
> +				struct vfio_iommu_type1_info_cap_msi_geometry,
> +				header);
> +
> +	vfio_msi_geometry->reserved = !mapping_required;
> +	if (vfio_msi_geometry->reserved) {
> +		vfio_msi_geometry->aperture_start = msi_geometry.aperture_start;
> +		vfio_msi_geometry->aperture_end = msi_geometry.aperture_end;
> +		return 0;
> +	}
> +
> +	vfio_msi_geometry->alignment = 1 << __ffs(vfio_pgsize_bitmap(iommu));
> +	/* we currently report the need for an arbitray number of 16 pages */
> +	vfio_msi_geometry->size = 16 * vfio_msi_geometry->alignment;

Hmm, that really is arbitrary.  How could we know a real value here?

> +
> +	return 0;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -1155,6 +1199,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		}
>  	} else if (cmd == VFIO_IOMMU_GET_INFO) {
>  		struct vfio_iommu_type1_info info;
> +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +		int ret;
>  
>  		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
>  
> @@ -1168,6 +1214,29 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
>  
> +		ret = compute_msi_geometry_caps(iommu, &caps);
> +		if (ret)
> +			return ret;
> +
> +		if (caps.size) {
> +			info.flags |= VFIO_IOMMU_INFO_CAPS;
> +			if (info.argsz < sizeof(info) + caps.size) {
> +				info.argsz = sizeof(info) + caps.size;
> +				info.cap_offset = 0;
> +			} else {
> +				vfio_info_cap_shift(&caps, sizeof(info));
> +				if (copy_to_user((void __user *)arg +
> +						sizeof(info), caps.buf,
> +						caps.size)) {
> +					kfree(caps.buf);
> +					return -EFAULT;
> +				}
> +				info.cap_offset = sizeof(info);
> +			}
> +
> +			kfree(caps.buf);
> +		}
> +
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 4a9dbc2..0ff6a8d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -488,7 +488,33 @@ struct vfio_iommu_type1_info {
>  	__u32	argsz;
>  	__u32	flags;
>  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
> -	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> +#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
> +	__u32   cap_offset;	/* Offset within info struct of first cap */
> +	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */

This would break existing users, we can't arbitrarily change the offset
of iova_pgsizes.  We can add cap_offset to the end and I think
everything would work about above if we do that.

> +};
> +
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_MSI_GEOMETRY	1
> +
> +/*
> + * The MSI geometry capability allows to report the MSI IOVA geometry:
> + * - either the MSI IOVAs are constrained within a reserved IOVA aperture
> + *   whose boundaries are given by [@aperture_start, @aperture_end].
> + *   this is typically the case on x86 host. The userspace is not allowed
> + *   to map userspace memory at IOVAs intersecting this range using
> + *   VFIO_IOMMU_MAP_DMA.
> + * - or the MSI IOVAs are not requested to belong to any reserved range;
> + *   in that case the userspace must provide an IOVA window characterized by
> + *   @size and @alignment using VFIO_IOMMU_MAP_DMA with RESERVED_MSI_IOVA flag.
> + */
> +struct vfio_iommu_type1_info_cap_msi_geometry {
> +	struct vfio_info_cap_header header;
> +	bool reserved; /* Are MSI IOVAs within a reserved aperture? */

Do bools have a guaranteed user size?  Let's make this a __u32 and call
it flags with bit 0 defined as reserved.  I'm tempted to suggest we
could figure out how to make alignment fit in another __u32 so we have a
properly packed structure, otherwise we should make a reserved __u32.

> +	/* reserved */
> +	__u64 aperture_start;
> +	__u64 aperture_end;
> +	/* not reserved */
> +	__u64 size; /* IOVA aperture size in bytes the userspace must provide */
> +	__u64 alignment; /* alignment of the window, in bytes */
>  };
>  
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> @@ -503,6 +529,8 @@ struct vfio_iommu_type1_info {
>   * IOVA region that will be used on some platforms to map the host MSI frames.
>   * In that specific case, vaddr is ignored. Once registered, an MSI reserved
>   * IOVA region stays until the container is closed.
> + * The requirement for provisioning such reserved IOVA range can be checked by
> + * checking the VFIO_IOMMU_TYPE1_INFO_CAP_MSI_GEOMETRY capability.
>   */
>  struct vfio_iommu_type1_dma_map {
>  	__u32	argsz;
