From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v3 03/12] iommu/amd: move dte irq macro defitions to
	amd_iommu_types.h
Date: Wed, 27 Jan 2016 18:25:35 +0800
Message-ID: <56A89B1F.6010004@iommu.org>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
	<1453804166-25646-4-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-4-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> These macro definitions are also needed by irq table copy function
> later, so move them to amd_iommu_types.h.

Typo for your subject (defitions?).

>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c       | 4 ----
>   drivers/iommu/amd_iommu_types.h | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index dd869fe..aeae07a 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3627,10 +3627,6 @@ struct amd_ir_data {
>
>   static struct irq_chip amd_ir_chip;
>
> -#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> -#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> -#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> -#define DTE_IRQ_REMAP_ENABLE    1ULL
>
>   static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
>   {
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 9d32b20..9b8ace4 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -224,6 +224,11 @@
>
>   #define PPR_REQ_FAULT		0x01
>
> +#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> +#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> +#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> +#define DTE_IRQ_REMAP_ENABLE    1ULL
> +
>   #define PAGE_MODE_NONE    0x00
>   #define PAGE_MODE_1_LEVEL 0x01
>   #define PAGE_MODE_2_LEVEL 0x02
>
