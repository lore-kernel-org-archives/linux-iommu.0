From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
Date: Fri, 21 Oct 2016 18:32:54 +0100
Message-ID: <792320ab-13ae-741e-7202-1e7983e0b7a4@arm.com>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
	<20161019233633.10506.3943.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161019233633.10506.3943.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 20/10/16 00:36, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Not all architectures have an iommu member in their archdata, so
> use #ifdefs support build wit COMPILE_TEST on any architecture.

As an alternative to this we could now use iommu_fwspec in place of the
custom ipmmu_vmsa_archdata - that's deliberately
architecture-independent. I converted the Mediatek drivers[1] as an
example to stand separately from the big SMMU rework, as those are the
ones I'm most familiar with, but it looks like the IPMMU is a similarly
perfect fit.

Of course, that could always come afterwards as a cleanup - I wouldn't
consider it a blocker at this point - but it does look like it might
simplify some of the code being moved around in this series if it were
to be done beforehand.

Robin.

[1]:http://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg14577.html

> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
> 
>  Changes since V5:
>  - None
> 
>  Changes since V4:
>  - None
> 
>  Changes since V3:
>  - New patch
> 
>  drivers/iommu/ipmmu-vmsa.c |   37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> --- 0012/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-09-20 21:59:21.690607110 +0900
> @@ -70,6 +70,25 @@ static struct ipmmu_vmsa_domain *to_vmsa
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
> @@ -539,7 +558,7 @@ static void ipmmu_domain_free(struct iom
>  static int ipmmu_attach_device(struct iommu_domain *io_domain,
>  			       struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  	struct ipmmu_vmsa_device *mmu = archdata->mmu;
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  	unsigned long flags;
> @@ -581,7 +600,7 @@ static int ipmmu_attach_device(struct io
>  static void ipmmu_detach_device(struct iommu_domain *io_domain,
>  				struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  	unsigned int i;
>  
> @@ -701,7 +720,7 @@ static int ipmmu_init_platform_device(st
>  	archdata->mmu = mmu;
>  	archdata->utlbs = utlbs;
>  	archdata->num_utlbs = num_utlbs;
> -	dev->archdata.iommu = archdata;
> +	set_archdata(dev, archdata);
>  	return 0;
>  
>  error:
> @@ -713,12 +732,11 @@ error:
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
> @@ -754,8 +772,7 @@ static int ipmmu_add_device(struct devic
>  	 * - Make the mapping size configurable ? We currently use a 2GB mapping
>  	 *   at a 1GB offset to ensure that NULL VAs will fault.
>  	 */
> -	archdata = dev->archdata.iommu;
> -	mmu = archdata->mmu;
> +	mmu = to_archdata(dev)->mmu;
>  	if (!mmu->mapping) {
>  		struct dma_iommu_mapping *mapping;
>  
> @@ -783,7 +800,7 @@ error:
>  	if (mmu)
>  		arm_iommu_release_mapping(mmu->mapping);
>  
> -	dev->archdata.iommu = NULL;
> +	set_archdata(dev, NULL);
>  
>  	if (!IS_ERR_OR_NULL(group))
>  		iommu_group_remove_device(dev);
> @@ -793,7 +810,7 @@ error:
>  
>  static void ipmmu_remove_device(struct device *dev)
>  {
> -	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
>  
>  	arm_iommu_detach_device(dev);
>  	iommu_group_remove_device(dev);
> @@ -801,7 +818,7 @@ static void ipmmu_remove_device(struct d
>  	kfree(archdata->utlbs);
>  	kfree(archdata);
>  
> -	dev->archdata.iommu = NULL;
> +	set_archdata(dev, NULL);
>  }
>  
>  static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> 
