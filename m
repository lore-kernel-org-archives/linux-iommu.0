From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 1/2] iommu/s390: Use iommu_group_get_for_dev() in
 s390_iommu_add_device()
Date: Fri, 16 Jun 2017 19:33:01 +0200
Message-ID: <20170616193301.17cebd11@thinkpad>
References: <1497532312-30470-1-git-send-email-joro@8bytes.org>
        <1497532312-30470-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497532312-30470-2-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Thu, 15 Jun 2017 15:11:51 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_group_get_for_dev() function also attaches the
> device to its group, so this code doesn't need to be in the
> iommu driver.
> 
> Further by using this function the driver can make use of
> default domains in the future.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Seems pretty straightforward, so
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>

However, looking at iommu_group_get_for_dev(), I wonder if the
generic_device_group() always returns the right thing, but that
would be independent from this patch.

With generic_device_group() returning NULL in case the allocation failed,
this part of iommu_group_get_for_dev() would then happily dereference the
NULL pointer, because IS_ERR(group) would be false:

        if (ops && ops->device_group)
                group = ops->device_group(dev);

        if (IS_ERR(group))
                return group;

        /*
         * Try to allocate a default domain - needs support from the
         * IOMMU driver.
         */
        if (!group->default_domain) {

The same is true for pci_device_group(), which also returns NULL in case
of allocation failure. I guess both functions should just return the
group pointer from iommu_group_alloc() directly, which already would
contain an appropriate ERR_PTR, but never NULL.

What do you think?

> ---
>  drivers/iommu/s390-iommu.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 179e636..8788640 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -165,20 +165,14 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
> 
>  static int s390_iommu_add_device(struct device *dev)
>  {
> -	struct iommu_group *group;
> -	int rc;
> +	struct iommu_group *group = iommu_group_get_for_dev(dev);
> 
> -	group = iommu_group_get(dev);
> -	if (!group) {
> -		group = iommu_group_alloc();
> -		if (IS_ERR(group))
> -			return PTR_ERR(group);
> -	}
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> 
> -	rc = iommu_group_add_device(group, dev);
>  	iommu_group_put(group);
> 
> -	return rc;
> +	return 0;
>  }
> 
>  static void s390_iommu_remove_device(struct device *dev)
> @@ -344,6 +338,7 @@ static struct iommu_ops s390_iommu_ops = {
>  	.iova_to_phys = s390_iommu_iova_to_phys,
>  	.add_device = s390_iommu_add_device,
>  	.remove_device = s390_iommu_remove_device,
> +	.device_group = generic_device_group,
>  	.pgsize_bitmap = S390_IOMMU_PGSIZES,
>  };
> 
