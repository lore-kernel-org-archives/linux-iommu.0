From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v4 3/9] iommu/amd: Detect pre enabled translation
Date: Sat, 28 May 2016 20:49:46 +0800
Message-ID: <3371fab6-b3db-6f4a-a1a1-b272c3f8fdbe@iommu.org>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
	<1464157735-8865-4-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464157735-8865-4-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: vincent.wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> Add functions to check whether translation is already enabled in IOMMU.
>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c  | 25 +++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_types.h |  4 ++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 8361367d..9e1dfcb 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -229,6 +229,26 @@ static int amd_iommu_enable_interrupts(void);
>  static int __init iommu_go_to_state(enum iommu_init_state state);
>  static void init_device_table_dma(void);
>
> +
> +static bool translation_pre_enabled(struct amd_iommu *iommu)
> +{
> +	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
> +}
> +
> +static void clear_translation_pre_enabled(struct amd_iommu *iommu)
> +{
> +        iommu->flags &= ~AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
> +}
> +
> +static void init_translation_status(struct amd_iommu *iommu)
> +{
> +	u32 ctrl;
> +
> +	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
> +	if (ctrl & (1<<CONTROL_IOMMU_EN))
> +		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
> +}
> +
>  static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
>  				    u8 bank, u8 cntr, u8 fxn,
>  				    u64 *value, bool is_write);
> @@ -1101,6 +1121,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>
>  	iommu->int_enabled = false;
>
> +	init_translation_status(iommu);
> +
> +	if (translation_pre_enabled())
> +		pr_warn("Translation is already enabled - trying to copy translation structures\n");
> +

You missed this 'iommu' parameter here, even I saw you fixed it in 
another patch, but please keep each patch to be meaningful.

>  	ret = init_iommu_from_acpi(iommu, h);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 9d32b20..01783cc 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -384,6 +384,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
>  #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
>
>
> +
>  /*
>   * This struct is used to pass information about
>   * incoming PPR faults around.
> @@ -401,6 +402,8 @@ struct amd_iommu_fault {
>  struct iommu_domain;
>  struct irq_domain;
>
> +#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
> +
>  /*
>   * This structure contains generic data for  IOMMU protection domains
>   * independent of their use.
> @@ -525,6 +528,7 @@ struct amd_iommu {
>  	struct irq_domain *ir_domain;
>  	struct irq_domain *msi_domain;
>  #endif
> +	u32 flags;
>  };
>
>  struct devid_map {
>
