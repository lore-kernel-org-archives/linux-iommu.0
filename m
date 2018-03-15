From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
 get_irq_table()
Date: Thu, 15 Mar 2018 13:53:42 +0100
Message-ID: <20180315125342.q74wurk6bdbhl6hy@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-6-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-6-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 23, 2018 at 11:27:31PM +0100, Sebastian Andrzej Siewior wrote:
> @@ -4103,10 +4093,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  		return ret;
>  
>  	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
> -		if (get_irq_table(devid, true))
> +		struct irq_remap_table *table;
> +		struct amd_iommu *iommu;
> +
> +		table = get_irq_table(devid);
> +		if (table) {
> +			if (!table->min_index) {
> +				/*
> +				 * Keep the first 32 indexes free for IOAPIC
> +				 * interrupts.
> +				 */
> +				table->min_index = 32;
> +				iommu = amd_iommu_rlookup_table[devid];
> +				for (i = 0; i < 32; ++i)
> +					iommu->irte_ops->set_allocated(table, i);
> +			}

I think this needs to be protected by the table->lock.
