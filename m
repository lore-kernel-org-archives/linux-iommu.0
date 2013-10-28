From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: SMMU: add devices attached to the SMMU to an
	IOMMU group
Date: Mon, 28 Oct 2013 10:44:22 -0600
Message-ID: <1382978662.4097.35.camel@ul30vt.home>
References: <1382108910-18049-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1382108910-18049-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2013-10-18 at 17:08 +0200, Antonios Motakis wrote:
> IOMMU groups are expected by certain users of the IOMMU API,
> e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
> group to satisfy those users.
> 
> Changes from v1:
>  * Added check that dev->archdata.iommu has not been set already by an IOMMU
>    driver. This way we can also skip checking for an existing IOMMU group.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>


Looks ok to me.

Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/iommu/arm-smmu.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 0f45a48..6762885 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1502,6 +1502,13 @@ static int arm_smmu_add_device(struct device *dev)
>  {
>  	struct arm_smmu_device *child, *parent, *smmu;
>  	struct arm_smmu_master *master = NULL;
> +	struct iommu_group *group;
> +	int ret;
> +
> +	if (dev->archdata.iommu) {
> +		dev_warn(dev, "IOMMU driver already assigned to device\n");
> +		return -EINVAL;
> +	}
>  
>  	spin_lock(&arm_smmu_devices_lock);
>  	list_for_each_entry(parent, &arm_smmu_devices, list) {
> @@ -1534,13 +1541,23 @@ static int arm_smmu_add_device(struct device *dev)
>  	if (!master)
>  		return -ENODEV;
>  
> +	group = iommu_group_alloc();
> +	if (IS_ERR(group)) {
> +		dev_err(dev, "Failed to allocate IOMMU group\n");
> +		return PTR_ERR(group);
> +	}
> +
> +	ret = iommu_group_add_device(group, dev);
> +	iommu_group_put(group);
>  	dev->archdata.iommu = smmu;
> -	return 0;
> +
> +	return ret;
>  }
>  
>  static void arm_smmu_remove_device(struct device *dev)
>  {
>  	dev->archdata.iommu = NULL;
> +	iommu_group_remove_device(dev);
>  }
>  
>  static struct iommu_ops arm_smmu_ops = {
