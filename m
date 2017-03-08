From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
Date: Wed, 8 Mar 2017 12:48:04 +0000
Message-ID: <d7db1ada-863a-ab92-7936-47d0306eaa8f@arm.com>
References: <148885660307.28553.995847796823338863.sendpatchset@little-apple>
	<148885666392.28553.6653211200015255398.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148885666392.28553.6653211200015255398.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/03/17 03:17, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Not all architectures have an iommu member in their archdata, so
> use #ifdefs support build with COMPILE_TEST on any architecture.

I have a feeling I might be repeating myself, but ipmmu_vmsa_archdata
looks to be trivially convertible to iommu_fwspec, which I strongly
encourage, not least because it would obviate bodges like this.

Robin.

> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
> 
> Changes since V6:
>  - Updated patch to handle newly introduced functions in:
>    [PATCH v7 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
> 
>  drivers/iommu/ipmmu-vmsa.c |   43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> --- 0010/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2017-03-06 19:26:26.070607110 +0900
> @@ -72,6 +72,25 @@ static struct ipmmu_vmsa_domain *to_vmsa
>  	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
>  }
>  
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +static struct ipmmu_vmsa_archdata *to_archdata(struct device *dev)
> +{
> +	return dev->archdata.iommu;
> +}
> +static void set_archdata(struct device *dev, struct ipmmu_vmsa_archdata *p)
> +{
> +	dev->archdata.iommu = p;
> +}
> +#else
> +static struct ipmmu_vmsa_archdata *to_archdata(struct device *dev)
> +{
> +	return NULL;
> +}
> +static void set_archdata(struct device *dev, struct ipmmu_vmsa_archdata *p)
> +{
> +}
> +#endif
> +
>  #define TLB_LOOP_TIMEOUT		100	/* 100us */
>  
>  /* -----------------------------------------------------------------------------
> @@ -543,7 +562,7 @@ static void ipmmu_domain_free(struct iom
>  static int ipmmu_attach_device(struct iommu_domain *io_domain,
>  			       struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  	struct ipmmu_vmsa_device *mmu = archdata->mmu;
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  	unsigned long flags;
> @@ -588,7 +607,7 @@ static int ipmmu_attach_device(struct io
>  static void ipmmu_detach_device(struct iommu_domain *io_domain,
>  				struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  	unsigned int i;
>  
> @@ -709,7 +728,7 @@ static int ipmmu_init_platform_device(st
>  	archdata->utlbs = utlbs;
>  	archdata->num_utlbs = num_utlbs;
>  	archdata->dev = dev;
> -	dev->archdata.iommu = archdata;
> +	set_archdata(dev, archdata);
>  	return 0;
>  
>  error:
> @@ -729,12 +748,11 @@ static struct iommu_domain *ipmmu_domain
>  
>  static int ipmmu_add_device(struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata;
>  	struct ipmmu_vmsa_device *mmu = NULL;
>  	struct iommu_group *group;
>  	int ret;
>  
> -	if (dev->archdata.iommu) {
> +	if (to_archdata(dev)) {
>  		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
>  			 dev_name(dev));
>  		return -EINVAL;
> @@ -770,8 +788,7 @@ static int ipmmu_add_device(struct devic
>  	 * - Make the mapping size configurable ? We currently use a 2GB mapping
>  	 *   at a 1GB offset to ensure that NULL VAs will fault.
>  	 */
> -	archdata = dev->archdata.iommu;
> -	mmu = archdata->mmu;
> +	mmu = to_archdata(dev)->mmu;
>  	if (!mmu->mapping) {
>  		struct dma_iommu_mapping *mapping;
>  
> @@ -799,7 +816,7 @@ error:
>  	if (mmu)
>  		arm_iommu_release_mapping(mmu->mapping);
>  
> -	dev->archdata.iommu = NULL;
> +	set_archdata(dev, NULL);
>  
>  	if (!IS_ERR_OR_NULL(group))
>  		iommu_group_remove_device(dev);
> @@ -809,7 +826,7 @@ error:
>  
>  static void ipmmu_remove_device(struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  
>  	arm_iommu_detach_device(dev);
>  	iommu_group_remove_device(dev);
> @@ -817,7 +834,7 @@ static void ipmmu_remove_device(struct d
>  	kfree(archdata->utlbs);
>  	kfree(archdata);
>  
> -	dev->archdata.iommu = NULL;
> +	set_archdata(dev, NULL);
>  }
>  
>  static const struct iommu_ops ipmmu_ops = {
> @@ -874,7 +891,7 @@ static void ipmmu_domain_free_dma(struct
>  
>  static int ipmmu_add_device_dma(struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  	struct iommu_group *group;
>  
>  	/* The device has been verified in xlate() */
> @@ -893,7 +910,7 @@ static int ipmmu_add_device_dma(struct d
>  
>  static void ipmmu_remove_device_dma(struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  
>  	spin_lock(&ipmmu_slave_devices_lock);
>  	list_del(&archdata->list);
> @@ -904,7 +921,7 @@ static void ipmmu_remove_device_dma(stru
>  
>  static struct device *ipmmu_find_sibling_device(struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  	struct ipmmu_vmsa_archdata *sibling_archdata = NULL;
>  	bool found = false;
>  
> 
