From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix IOMMU lookup when multiple IOMMUs
	are registered
Date: Wed, 28 Jan 2015 10:40:32 +0200
Message-ID: <1937580.GPTjQ28sbs@avalon>
References: <1422134030-11121-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422134030-11121-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Could you please pick this patch up for v3.20 ?

On Saturday 24 January 2015 23:13:50 Laurent Pinchart wrote:
> When adding a new device the driver loops over all registered IOMMUs and
> calls the ipmmu_find_utlbs() function to parse the DT iommus attribute.
> The function returns an error when the IOMMU referenced in DT doesn't
> match the current IOMMU. The caller incorrectly breaks from the loop
> immediately when the error is reported, resulting in only the first
> IOMMU being considered.
> 
> Fix this, and while at it move code that isn't specific to an IOMMU
> instance out of the loop.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 49 +++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 791c3daec7c0..407324132587 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1007,45 +1007,28 @@ static phys_addr_t ipmmu_iova_to_phys(struct
> iommu_domain *io_domain, }
> 
>  static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device
> *dev, -			    unsigned int **_utlbs)
> +			    unsigned int *utlbs, unsigned int num_utlbs)
>  {
> -	unsigned int *utlbs;
>  	unsigned int i;
> -	int count;
> -
> -	count = of_count_phandle_with_args(dev->of_node, "iommus",
> -					   "#iommu-cells");
> -	if (count < 0)
> -		return -EINVAL;
> -
> -	utlbs = kcalloc(count, sizeof(*utlbs), GFP_KERNEL);
> -	if (!utlbs)
> -		return -ENOMEM;
> 
> -	for (i = 0; i < count; ++i) {
> +	for (i = 0; i < num_utlbs; ++i) {
>  		struct of_phandle_args args;
>  		int ret;
> 
>  		ret = of_parse_phandle_with_args(dev->of_node, "iommus",
>  						 "#iommu-cells", i, &args);
>  		if (ret < 0)
> -			goto error;
> +			return ret;
> 
>  		of_node_put(args.np);
> 
>  		if (args.np != mmu->dev->of_node || args.args_count != 1)
> -			goto error;
> +			return -EINVAL;
> 
>  		utlbs[i] = args.args[0];
>  	}
> 
> -	*_utlbs = utlbs;
> -
> -	return count;
> -
> -error:
> -	kfree(utlbs);
> -	return -EINVAL;
> +	return 0;
>  }
> 
>  static int ipmmu_add_device(struct device *dev)
> @@ -1053,10 +1036,10 @@ static int ipmmu_add_device(struct device *dev)
>  	struct ipmmu_vmsa_archdata *archdata;
>  	struct ipmmu_vmsa_device *mmu;
>  	struct iommu_group *group = NULL;
> -	unsigned int *utlbs = NULL;
> +	unsigned int *utlbs;
>  	unsigned int i;
> -	int num_utlbs = 0;
> -	int ret;
> +	int num_utlbs;
> +	int ret = -ENODEV;
> 
>  	if (dev->archdata.iommu) {
>  		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
> @@ -1065,11 +1048,21 @@ static int ipmmu_add_device(struct device *dev)
>  	}
> 
>  	/* Find the master corresponding to the device. */
> +
> +	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
> +					       "#iommu-cells");
> +	if (num_utlbs < 0)
> +		return -ENODEV;
> +
> +	utlbs = kcalloc(num_utlbs, sizeof(*utlbs), GFP_KERNEL);
> +	if (!utlbs)
> +		return -ENOMEM;
> +
>  	spin_lock(&ipmmu_devices_lock);
> 
>  	list_for_each_entry(mmu, &ipmmu_devices, list) {
> -		num_utlbs = ipmmu_find_utlbs(mmu, dev, &utlbs);
> -		if (num_utlbs) {
> +		ret = ipmmu_find_utlbs(mmu, dev, utlbs, num_utlbs);
> +		if (!ret) {
>  			/*
>  			 * TODO Take a reference to the MMU to protect
>  			 * against device removal.
> @@ -1080,7 +1073,7 @@ static int ipmmu_add_device(struct device *dev)
> 
>  	spin_unlock(&ipmmu_devices_lock);
> 
> -	if (num_utlbs <= 0)
> +	if (ret < 0)
>  		return -ENODEV;
> 
>  	for (i = 0; i < num_utlbs; ++i) {

-- 
Regards,

Laurent Pinchart
