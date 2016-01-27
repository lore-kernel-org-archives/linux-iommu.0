From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v3 04/12] iommu/amd: add copy_irq_table function
Date: Wed, 27 Jan 2016 19:23:02 +0800
Message-ID: <56A8A896.70405@iommu.org>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
	<1453804166-25646-5-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-5-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
> If irq table exists in old kernel create a new one and copy the content
> of old irq table to the newly created.
>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c       |  2 +-
>   drivers/iommu/amd_iommu_init.c  | 43 +++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/amd_iommu_proto.h |  1 +
>   3 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index aeae07a..63f4c6b 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3628,7 +3628,7 @@ struct amd_ir_data {
>   static struct irq_chip amd_ir_chip;
>
>
> -static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
> +void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
>   {
>   	u64 dte;
>
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 91659d8..450adad 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -660,6 +660,49 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
>   	return (amd_iommu_dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
>   }
>
> +static void copy_irq_table(u16 devid)
> +{
> +	struct irq_remap_table *table = NULL;
> +	u16 alias;
> +	u64 dte;
> +	u64 *old_intr_virt;
> +
> +	alias = amd_iommu_alias_table[devid];
> +	table = irq_lookup_table[alias];
> +	if (table) {
> +	        irq_lookup_table[devid] = table;
> +		set_dte_irq_entry(devid, table);
> +	        return;
> +	}
> +	dte     = amd_iommu_dev_table[devid].data[2];
> +	dte &= DTE_IRQ_PHYS_ADDR_MASK;
> +	if( (!dte&DTE_IRQ_REMAP_ENABLE) || ( dte == 0) )
> +	        return;
> +

here: dte&DTE_IRQ_REMAP_ENABLE

style?
dte & DTE_IRQ_REMAP_ENABLE

> +	table = kzalloc(sizeof(*table), GFP_ATOMIC);
> +	if (!table){
> +	        pr_warn("AMD-Vi: amd irq table allocation failed\n");
> +	        return;
> +	}
> +
> +	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_ATOMIC);
> +        if (!table->table) {
> +                kfree(table);
> +                table = NULL;
> +		return;
> +        }
> +	memset(table->table, 0, MAX_IRQS_PER_TABLE * sizeof(u32));
> +
> +	old_intr_virt = memremap(dte, MAX_IRQS_PER_TABLE * sizeof(u32), MEMREMAP_WB);

Here if rename the 'dte' to 'irte',  better to read?


> +	memcpy(table->table, old_intr_virt, MAX_IRQS_PER_TABLE * sizeof(u32));
> +	irq_lookup_table[devid] = table;
> +	set_dte_irq_entry(devid, table);
> +	if (devid != alias) {
> +                irq_lookup_table[alias] = table;
> +		set_dte_irq_entry(alias, table);
> +        }
> +	memunmap(old_intr_virt);
> +}
>
>   void amd_iommu_apply_erratum_63(u16 devid)
>   {
> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
> index 743e209..ab562e0 100644
> --- a/drivers/iommu/amd_iommu_proto.h
> +++ b/drivers/iommu/amd_iommu_proto.h
> @@ -101,5 +101,6 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
>   /* kdump checking  */
>   extern bool translation_pre_enabled(void);
>   extern void clear_translation_pre_enabled(void);
> +extern void set_dte_irq_entry(u16 devid, struct irq_remap_table *table);
>
>   #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
>
