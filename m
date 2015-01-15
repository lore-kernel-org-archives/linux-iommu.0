From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 06/10] iommu/vt-d: datatypes and functions used for
	kdump
Date: Thu, 15 Jan 2015 11:28:58 +0800
Message-ID: <20150115032858.GA2461@dhcp-16-105.nay.redhat.com>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
	<1421046388-27925-7-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421046388-27925-7-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/12/15 at 03:06pm, Li, Zhen-Hua wrote:
> +/*
> + * Interface to the "copy translation tables" set of functions
> + * from mainline code.
> + */
> +static int intel_iommu_load_translation_tables(struct dmar_drhd_unit *drhd,
> +		int g_num_of_iommus)

The argument g_num_of_iommus is the same as the global variable, it's better
to rename it as num_of_iommus. And even it can be removed since you can
just use the global variable g_num_of_iommus in this function.

Argument drhd can be intel_iommu because no other member variable in
drhd is needed.

> +{
> +	struct intel_iommu *iommu;	/* Virt(iommu hardware registers) */
> +	unsigned long long q;		/* quadword scratch */
> +	int ret = 0;			/* Integer return code */
> +	int i = 0;			/* Loop index */
> +	unsigned long flags;
> +
> +	/* Structure so copy_page_addr() can accumulate things
> +	 * over multiple calls and returns
> +	 */
> +	struct copy_page_addr_parms ppa_parms = copy_page_addr_parms_init;
> +	struct copy_page_addr_parms *ppap = &ppa_parms;
> +
> +
> +	iommu = drhd->iommu;
> +	q = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
> +	if (!q)
> +		return -1;
> +
> +	/* If (list needs initializing) do it here */

This initializing should not be here, because it's not only for this
drhd. It should be done in init_dmars().

> +	if (!domain_values_list) {
> +		domain_values_list =
> +			 kcalloc(g_num_of_iommus, sizeof(struct list_head),
> +					GFP_KERNEL);
> +
> +		if (!domain_values_list) {
> +			pr_err("Allocation failed for domain_values_list array\n");
> +			return -ENOMEM;
> +		}
> +		for (i = 0; i < g_num_of_iommus; i++)
> +			INIT_LIST_HEAD(&domain_values_list[i]);
> +	}
> +
> +	spin_lock_irqsave(&iommu->lock, flags);
> +
> +	/* Load the root-entry table from the old kernel
> +	 * foreach context_entry_table in root_entry
> +	 *    foreach context_entry in context_entry_table
> +	 *       foreach level-1 page_table_entry in context_entry
> +	 *          foreach level-2 page_table_entry in level 1 page_table_entry
> +	 *             Above pattern continues up to 6 levels of page tables
> +	 *                Sanity-check the entry
> +	 *                Process the bus, devfn, page_address, page_size
> +	 */
> +	if (!iommu->root_entry) {
> +		iommu->root_entry =
> +			(struct root_entry *)alloc_pgtable_page(iommu->node);
> +		if (!iommu->root_entry) {
> +			spin_unlock_irqrestore(&iommu->lock, flags);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
> +	if (!iommu->root_entry_old_phys) {
> +		pr_err("Could not read old root entry address.");
> +		return -1;
> +	}
> +
> +	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
> +						VTD_PAGE_SIZE);
> +	if (!iommu->root_entry_old_virt) {
> +		pr_err("Could not map the old root entry.");
> +		return -ENOMEM;
> +	}
> +
> +	__iommu_load_old_root_entry(iommu);
> +	ret = copy_root_entry_table(iommu, ppap);
> +	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
> +	__iommu_update_old_root_entry(iommu, -1);
> +
> +	spin_unlock_irqrestore(&iommu->lock, flags);
> +
> +	__iommu_free_mapped_mem();
> +
> +	if (ret)
> +		return ret;
> +
> +	ppa_parms.last = 1;
> +	copy_page_addr(0, 0, 0, 0, 0, NULL, ppap);
> +
> +	return 0;
> +}
> +
>  #endif /* CONFIG_CRASH_DUMP */
> -- 
> 2.0.0-rc0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/kexec
