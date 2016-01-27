From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v3 11/12] iommu/amd: No need to wait iommu completion if
	no dte irq entry change
Date: Wed, 27 Jan 2016 19:03:08 +0800
Message-ID: <56A8A3EC.7090701@iommu.org>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
	<1453804166-25646-12-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-12-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
> This is a clean up. In get_irq_table() only if DTE entry is changed
> iommu_completion_wait() need be called. Otherwise no need to do it.
>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 0880500..dda703b 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3674,7 +3674,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
>
>   	table = irq_lookup_table[devid];
>   	if (table)
> -		goto out;
> +		goto out_unlock;
>
>   	alias = amd_iommu_alias_table[devid];
>   	table = irq_lookup_table[alias];
> @@ -3688,7 +3688,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
>   	/* Nothing there yet, allocate new irq remapping table */
>   	table = kzalloc(sizeof(*table), GFP_ATOMIC);
>   	if (!table)
> -		goto out;
> +		goto out_unlock;
>
>   	/* Initialize table spin-lock */
>   	spin_lock_init(&table->lock);
> @@ -3701,7 +3701,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
>   	if (!table->table) {
>   		kfree(table);
>   		table = NULL;
> -		goto out;
> +		goto out_unlock;
>   	}
>
>   	memset(table->table, 0, MAX_IRQS_PER_TABLE * sizeof(u32));
>

So here the 'out:' label text should also remove, since no err need goto 
it, right?

out:
	iommu_completion_wait(iommu);
