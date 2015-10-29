From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 8/8] iommu: Move default domain allocation to
	iommu_group_get_for_dev()
Date: Thu, 29 Oct 2015 18:22:49 +0000
Message-ID: <20151029182248.GI3440@arm.com>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
	<1445464303-18206-9-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445464303-18206-9-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Looking at this from an SMMU perspective, I think there's an issue
with attaching to the default domain like this.

On Wed, Oct 21, 2015 at 11:51:43PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Now that the iommu core support for iommu groups is not
> pci-centric anymore, we can move default domain allocation
> to the bus independent iommu_group_get_for_dev() function.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e2b5526..abae363 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -810,14 +810,6 @@ struct iommu_group *pci_device_group(struct device *dev)
>  	if (IS_ERR(group))
>  		return NULL;
>  
> -	/*
> -	 * Try to allocate a default domain - needs support from the
> -	 * IOMMU driver.
> -	 */
> -	group->default_domain = __iommu_domain_alloc(pdev->dev.bus,
> -						     IOMMU_DOMAIN_DMA);
> -	group->domain = group->default_domain;
> -
>  	return group;
>  }
>  
> @@ -849,6 +841,16 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>  	if (IS_ERR(group))
>  		return group;
>  
> +	/*
> +	 * Try to allocate a default domain - needs support from the
> +	 * IOMMU driver.
> +	 */
> +	if (!group->default_domain) {
> +		group->default_domain = __iommu_domain_alloc(dev->bus,
> +							     IOMMU_DOMAIN_DMA);
> +		group->domain = group->default_domain;
> +	}
> +
>  	ret = iommu_group_add_device(group, dev);
>  	if (ret) {
>  		iommu_group_put(group);

The call to iommu_group_get_for_dev in arm_smmu_add_device will end up
calling __iommu_attach_device, since group->domain will now be initialised
by the code above. This means the SMMU driver will see an ->attach_dev
call for a device that is part-way through an ->add_device callback and
will be missing the initialisation necessary for us to idenfity the SMMU
instance to which is corresponds. In fact, the iommudata for the group
won't be initialised at all, so the whole thing will fail afaict.

Note that I haven't actually taken this for a spin, so I could be missing
something.

Will
