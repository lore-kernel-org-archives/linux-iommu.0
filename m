From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v4 9/9] iommu/amd: Check the validation of irq table and
	domain id
Date: Sat, 28 May 2016 21:30:41 +0800
Message-ID: <4da4c13e-1dc8-1096-f05a-e6d172c07df2@iommu.org>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
	<1464157735-8865-10-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464157735-8865-10-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
> From: Baoquan HE <bhe-sa4SJRhfYT7yzlqKoElxGh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
>
> If not valid just skip reserving the old domain id.
>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       | 4 ----
>  drivers/iommu/amd_iommu_init.c  | 5 +++--
>  drivers/iommu/amd_iommu_types.h | 5 +++++
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f3bd7fd..40c4a05 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3697,10 +3697,6 @@ struct amd_ir_data {
>
>  static struct irq_chip amd_ir_chip;
>
> -#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> -#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> -#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> -#define DTE_IRQ_REMAP_ENABLE    1ULL

At least, you should give reason comments to why you want move it.

Any drivers files you want to use them as well?

>
>  static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
>  {
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 47e5972..263704a 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -670,7 +670,7 @@ static int copy_dev_tables(void)
>  	u32 lo, hi, devid;
>  	phys_addr_t old_devtb_phys;
>  	struct dev_table_entry *old_devtb;
> -	u16 dom_id, dte_v;
> +	u16 dom_id, dte_v, irq_v;
>  	struct amd_iommu *iommu;
>  	static int copied;
>
> @@ -692,7 +692,8 @@ static int copy_dev_tables(void)
>                          amd_iommu_dev_table[devid] = old_devtb[devid];
>                          dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
>  			dte_v = amd_iommu_dev_table[devid].data[0] & DTE_FLAG_V;
> -			if (!dte_v)
> +			irq_v = amd_iommu_dev_table[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
> +			if (!dte_v || !irq_v || !dom_id)
>  				continue;
>                          __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
>                  }
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 34acd73..08340f5 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -224,6 +224,11 @@
>
>  #define PPR_REQ_FAULT		0x01
>
> +#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> +#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> +#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> +#define DTE_IRQ_REMAP_ENABLE    1ULL
> +
>  #define PAGE_MODE_NONE    0x00
>  #define PAGE_MODE_1_LEVEL 0x01
>  #define PAGE_MODE_2_LEVEL 0x02
>
