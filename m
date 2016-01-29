From: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: [RFC PATCH 4/6] iommu/arm-smmu: Add support for
 IOMMU_DOMAIN_DMA in SMMUv1/SMMUv2 driver
Date: Fri, 29 Jan 2016 03:58:46 +0000
Message-ID: <39063E8F96E11742B35A201CC5D095B7BB2297@SJEXCHMB10.corp.ad.broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-5-git-send-email-anup.patel@broadcom.com>
 <56AA4FBE.6090702@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56AA4FBE.6090702-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Vikram Prakash <vikramp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: 28 January 2016 22:59
> To: Anup Patel; Catalin Marinas; Joerg Roedel; Will Deacon; Sricharan R; Linux
> IOMMU; Linux ARM Kernel
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Device
> Tree; Ray Jui; Scott Branden; Vikram Prakash; Linux Kernel; bcm-kernel-
> feedback-list
> Subject: Re: [RFC PATCH 4/6] iommu/arm-smmu: Add support for
> IOMMU_DOMAIN_DMA in SMMUv1/SMMUv2 driver
> 
> On 27/01/16 05:21, Anup Patel wrote:
> > To allow use of large memory (> 4Gb) with 32bit devices we need to use
> > some kind of iommu for such 32bit devices.
> >
> > This patch extends SMMUv1/SMMUv2 driver to support DMA domains which
> > in-turn will allows us to use iommu based DMA mappings for 32bit devices.
> >
> > Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/iommu/arm-smmu.c | 21 ++++++++++++++++++++-
> >   1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > 9bdf6b2..43424fe 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -29,6 +29,7 @@
> >   #define pr_fmt(fmt) "arm-smmu: " fmt
> >
> >   #include <linux/delay.h>
> > +#include <linux/dma-iommu.h>
> >   #include <linux/dma-mapping.h>
> >   #include <linux/err.h>
> >   #include <linux/interrupt.h>
> > @@ -967,7 +968,7 @@ static struct iommu_domain
> *arm_smmu_domain_alloc(unsigned type)
> >   {
> >   	struct arm_smmu_domain *smmu_domain;
> >
> > -	if (type != IOMMU_DOMAIN_UNMANAGED)
> > +	if (type != IOMMU_DOMAIN_UNMANAGED && type !=
> IOMMU_DOMAIN_DMA)
> >   		return NULL;
> >   	/*
> >   	 * Allocate the domain and initialise some of its data structures.
> > @@ -978,6 +979,12 @@ static struct iommu_domain
> *arm_smmu_domain_alloc(unsigned type)
> >   	if (!smmu_domain)
> >   		return NULL;
> >
> > +	if (type == IOMMU_DOMAIN_DMA &&
> > +	    iommu_get_dma_cookie(&smmu_domain->domain)) {
> > +		kfree(smmu_domain);
> > +		return NULL;
> > +	}
> > +
> >   	mutex_init(&smmu_domain->init_mutex);
> >   	spin_lock_init(&smmu_domain->pgtbl_lock);
> >
> > @@ -992,6 +999,7 @@ static void arm_smmu_domain_free(struct
> iommu_domain *domain)
> >   	 * Free the domain resources. We assume that all devices have
> >   	 * already been detached.
> >   	 */
> > +	iommu_put_dma_cookie(domain);
> >   	arm_smmu_destroy_domain_context(domain);
> >   	kfree(smmu_domain);
> >   }
> > @@ -1361,6 +1369,16 @@ static int arm_smmu_init_platform_device(struct
> device *dev,
> >   	return 0;
> >   }
> >
> > +int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args
> > +*args) {
> > +	/*
> > +	 * Nothing to do here because SMMU is already aware of all
> > +	 * MMU masters and their stream IDs using mmu-master attibute
> > +	 * SMMU DT node.
> > +	 */
> 
> ...but on the same hand this will also never get called if there's no "iommus"
> property on the master. Maintaining support for existing users of the "mmu-
> masters" binding is one thing (namely the thing that's been slowing down my
> efforts to clean up the really hacky generic binding support I did all the DMA
> stuff with), but having _both_ bindings in a single DT is something I don't think
> anybody wants to see - is that how you've tested this?

We want to use iommu aware DMA mapping APIs for certain 32bit devices
in our SoC without changing device driver of these 32bit devices
(such as PL330). Currently, to this we have to specifiy "iommus" attribute in
32bit device DT node. If we specify  "iommus" attribute in device DT node then
of_iommu_configure() expects "of_xlate" callback and it will fail if this
callback is not available.

If there is a way use DMA mappings APIs for 32bit devices without having
"of_xlate" in SMMU driver then I would prefer that approach. Suggestions??

> 
> Robin.
> 
> > +	return 0;
> > +}
> > +
> >   static int arm_smmu_add_device(struct device *dev)
> >   {
> >   	struct iommu_group *group;
> > @@ -1458,6 +1476,7 @@ static struct iommu_ops arm_smmu_ops = {
> >   	.unmap			= arm_smmu_unmap,
> >   	.map_sg			= default_iommu_map_sg,
> >   	.iova_to_phys		= arm_smmu_iova_to_phys,
> > +	.of_xlate		= arm_smmu_of_xlate,
> >   	.add_device		= arm_smmu_add_device,
> >   	.remove_device		= arm_smmu_remove_device,
> >   	.device_group		= arm_smmu_device_group,
> >
> 

Regards,
Anup
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
