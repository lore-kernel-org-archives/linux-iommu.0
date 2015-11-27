From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v2 4/9] iommu/amd: add copy_irq_table function
Date: Fri, 27 Nov 2015 12:13:13 +0100
Message-ID: <20151127111312.GC24300@8bytes.org>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<1446811851-20623-5-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446811851-20623-5-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 06, 2015 at 08:10:46PM +0800, Baoquan He wrote:
> +static void copy_irq_table(u16 devid)
> +{
> +	struct irq_remap_table *table = NULL;
> +	u16 alias;
> +	u64 dte;
> +	u64 old_intr_virt;
> +
> +	alias = amd_iommu_alias_table[devid];
> +	table = irq_lookup_table[alias];
> +	if (table) {
> +	        irq_lookup_table[devid] = table;
> +	        return;
> +	}
> +	dte     = amd_iommu_dev_table[devid].data[2];
> +	dte &= DTE_IRQ_PHYS_ADDR_MASK;
> +	if(!dte)
> +	        return;

Better check the IV bit here to see if the remapping table address is
valid.

> +
> +	table = kzalloc(sizeof(*table), GFP_ATOMIC);
> +	if (!table){
> +	        pr_warn("AMD-Vi: amd irq table allocation failed\n");
> +	        return;   
> +	}
> +	dte &= DTE_IRQ_PHYS_ADDR_MASK;

Applying this mask here is redundant.

> +	old_intr_virt = ioremap_cache(dte, MAX_IRQS_PER_TABLE * sizeof(u32));

The Intel code now uses the memremap interface. Please use it for this
too.

> +	table->table = old_intr_virt;
> +	//table->table = dte;
> +	irq_lookup_table[devid] = table;

Hmm, you are reusing the old tables memory, is there a reason for this?
Copying the old table into new memory is better because it keeps the old
kernels memory as it was at crash time. 


	Joerg
