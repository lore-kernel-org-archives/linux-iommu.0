From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/3] vfio/iommu_type1: add new
	VFIO_TYPE1_NESTING_IOMMU IOMMU type
Date: Thu, 11 Sep 2014 13:12:28 -0600
Message-ID: <1410462748.2982.342.camel@ul30vt.home>
References: <1409651619-27342-1-git-send-email-will.deacon@arm.com>
	<1409651619-27342-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409651619-27342-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2014-09-02 at 10:53 +0100, Will Deacon wrote:
> VFIO allows devices to be safely handed off to userspace by putting
> them behind an IOMMU configured to ensure DMA and interrupt isolation.
> This enables userspace KVM clients, such as kvmtool and qemu, to further
> map the device into a virtual machine.
> 
> With IOMMUs such as the ARM SMMU, it is then possible to provide SMMU
> translation services to the guest operating system, which are nested
> with the existing translation installed by VFIO. However, enabling this
> feature means that the IOMMU driver must be informed that the VFIO domain
> is being created for the purposes of nested translation.
> 
> This patch adds a new IOMMU type (VFIO_TYPE1_NESTING_IOMMU) to the VFIO
> type-1 driver. The new IOMMU type acts identically to the
> VFIO_TYPE1v2_IOMMU type, but additionally sets the DOMAIN_ATTR_NESTING
> attribute on its IOMMU domains. Userspace can check whether nesting is
> actually available using the VFIO_CHECK_EXTENSION ioctl, in a similar
> manner to checking for cache-coherent DMA.
> 
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 87 +++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/vfio.h       |  2 +
>  2 files changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 0734fbe5b651..50aa56c7b6a7 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -53,11 +53,15 @@ module_param_named(disable_hugepages,
>  MODULE_PARM_DESC(disable_hugepages,
>  		 "Disable VFIO IOMMU support for IOMMU hugepages.");
>  
> +/* Feature flags for VFIO Type-1 IOMMUs */
> +#define VFIO_IOMMU_FEAT_V2	(1 << 0)
> +#define VFIO_IOMMU_FEAT_NESTING	(1 << 1)
> +
>  struct vfio_iommu {
>  	struct list_head	domain_list;
>  	struct mutex		lock;
>  	struct rb_root		dma_list;
> -	bool v2;
> +	int			features;

Personally I'd rather add a nesting bool than mask out flag bits.

>  };
>  
>  struct vfio_domain {
> @@ -441,7 +445,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  	 * will only return success and a size of zero if there were no
>  	 * mappings within the range.
>  	 */
> -	if (iommu->v2) {
> +	if (iommu->features & VFIO_IOMMU_FEAT_V2) {
>  		dma = vfio_find_dma(iommu, unmap->iova, 0);
>  		if (dma && dma->iova != unmap->iova) {
>  			ret = -EINVAL;
> @@ -455,7 +459,8 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  	}
>  
>  	while ((dma = vfio_find_dma(iommu, unmap->iova, unmap->size))) {
> -		if (!iommu->v2 && unmap->iova > dma->iova)
> +		if (!(iommu->features & VFIO_IOMMU_FEAT_V2) &&
> +		    unmap->iova > dma->iova)
>  			break;
>  		unmapped += dma->size;
>  		vfio_remove_dma(iommu, dma);
> @@ -671,7 +676,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	struct vfio_group *group, *g;
>  	struct vfio_domain *domain, *d;
>  	struct bus_type *bus = NULL;
> -	int ret;
> +	int ret, attr = 1;
>  
>  	mutex_lock(&iommu->lock);
>  
> @@ -705,6 +710,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_free;
>  	}
>  
> +	if (iommu->features & VFIO_IOMMU_FEAT_NESTING)
> +		iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_NESTING, &attr);
> +

Shouldn't we fail if this doesn't work?

>  	ret = iommu_attach_group(domain->domain, iommu_group);
>  	if (ret)
>  		goto out_domain;
> @@ -815,12 +823,50 @@ done:
>  	mutex_unlock(&iommu->lock);
>  }
>  
> +static int vfio_iommus_have_nesting(void)
> +{
> +	static struct bus_type *bus_types[] = { &pci_bus_type };

Hmm, we just got rid of all traces of pci in this file, so I'm not too
excited about adding it back.  Don't we no longer include pci.h?  I'm
surprised this doesn't throw a warning.  We should try to be independent
of CONFIG_PCI here.

> +	int i, ret = 0;
> +
> +	for (i = 0; !ret && i < ARRAY_SIZE(bus_types); ++i) {
> +		struct iommu_domain *domain;
> +		struct bus_type *bus = bus_types[i];
> +		int attr = 1;
> +
> +		if (!iommu_present(bus))
> +			continue;
> +
> +		domain = iommu_domain_alloc(bus);
> +		if (!domain)
> +			continue;
> +
> +		if (!iommu_domain_set_attr(domain, DOMAIN_ATTR_NESTING, &attr))
> +			ret = 1;
> +
> +		iommu_domain_free(domain);
> +	}

Can this support Joerg's iommu_capable() interface so we can test w/o
creating a domain?  We still have the bus_type problem though.

> +
> +	return ret;
> +}
> +
>  static void *vfio_iommu_type1_open(unsigned long arg)
>  {
>  	struct vfio_iommu *iommu;
> -
> -	if (arg != VFIO_TYPE1_IOMMU && arg != VFIO_TYPE1v2_IOMMU)
> +	int features = 0;
> +
> +	switch (arg) {
> +	case VFIO_TYPE1_IOMMU:
> +		break;
> +	case VFIO_TYPE1_NESTING_IOMMU:
> +		if (!vfio_iommus_have_nesting())
> +			return ERR_PTR(-EOPNOTSUPP);
> +		features |= VFIO_IOMMU_FEAT_NESTING;
> +	case VFIO_TYPE1v2_IOMMU:
> +		features |= VFIO_IOMMU_FEAT_V2;
> +		break;
> +	default:
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
>  	if (!iommu)
> @@ -829,7 +875,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  	INIT_LIST_HEAD(&iommu->domain_list);
>  	iommu->dma_list = RB_ROOT;
>  	mutex_init(&iommu->lock);
> -	iommu->v2 = (arg == VFIO_TYPE1v2_IOMMU);
> +	iommu->features = features;
>  
>  	return iommu;
>  }
> @@ -875,6 +921,29 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +static int vfio_domains_have_iommu_nesting(struct vfio_iommu *iommu)
> +{
> +	struct vfio_domain *domain;
> +	int ret = 1;
> +
> +	if (!(iommu->features & VFIO_IOMMU_FEAT_NESTING))
> +		return 0;
> +
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(domain, &iommu->domain_list, next) {
> +		int attr;
> +
> +		if (iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_NESTING,
> +					   &attr) || !attr) {
> +			ret = 0;
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
> @@ -886,6 +955,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		case VFIO_TYPE1_IOMMU:
>  		case VFIO_TYPE1v2_IOMMU:
>  			return 1;
> +		case VFIO_TYPE1_NESTING_IOMMU:
> +			if (!iommu)
> +				return vfio_iommus_have_nesting();
> +			return vfio_domains_have_iommu_nesting(iommu);

I'd just about prefer to statically return 1 for NESTING and then fail
to add groups if we can't set the attribute.  It sucks, but here we test
an arbitrary bus type to determine whether nesting is supported, allow a
nesting iommu type to be set regardless of what kind of devices are
about to go into it, and require that the user test to see whether the
requested IOMMU attribute actually stuck.  That's not a very intuitive
interface.  Thanks,

Alex

>  		case VFIO_DMA_CC_IOMMU:
>  			if (!iommu)
>  				return 0;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 6612974c64bf..ac79f6214fd6 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -24,11 +24,13 @@
>  #define VFIO_TYPE1_IOMMU		1
>  #define VFIO_SPAPR_TCE_IOMMU		2
>  #define VFIO_TYPE1v2_IOMMU		3
> +
>  /*
>   * IOMMU enforces DMA cache coherence (ex. PCIe NoSnoop stripping).  This
>   * capability is subject to change as groups are added or removed.
>   */
>  #define VFIO_DMA_CC_IOMMU		4
> +#define VFIO_TYPE1_NESTING_IOMMU	5	/* Implies v2 */
>  
>  /* Check if EEH is supported */
>  #define VFIO_EEH			5
