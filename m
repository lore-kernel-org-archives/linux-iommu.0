From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: About amd-iommu support for kdump kernel
Date: Wed, 16 Sep 2015 15:26:45 +0800
Message-ID: <20150916072645.GI15856@dhcp-128-28.nay.redhat.com>
References: <20150915120606.GD15856@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150915120606.GD15856-0VdLhd/A9PlfpSRLqpFUpR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/15/15 at 08:06pm, Baoquan He wrote:
> Hi Joerg,
> 
> Recently I am free and can try to work out the amd-iommu support for
> kdump kernel. Now I have some plans and draft them into codes and debugging.
> And also there are prlblems. I brief them here, could you please have a
> look and give some suggestions?

Well, this mail looks messy. I will split them into several patches for
better understand and with patch log. Now I am trying to debug with
adding device_flush_xxx, still don't know why timer interrupt is
impacted and cause reboot.

> 
> Two parts:
> 
> 1) IO page mapping
>  .> Checking if it's in kdump kernel and previously enabled
>  .> If yes do below operatons:
>  	.> Do not disable amd iommu
> 	.> Copy dev table form old kernel and set the old domain id in amd_iommu_pd_alloc_bitmap
> 	.> Don't call update_domain() to update device table until the first __map_single() is called by device driver init
> 
> 2)interrupt remapping
>  .> I didn't think of this well. Now I only copy the old irq table when it first calls get_irq_table(). 
> 
> 
> Attach the patches here, the first 2 patches are clean up patch,
> attach them too for better code understanding.
> 
> The problem happened in check_timer(). Seems timer interrupt doesn't
> work well after modify_irte(). I don't know why it happened. Though I
> have copied the old irte tables.
> 
> [   12.296525] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [   12.302513] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0+ #18
> [   12.308500] Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
> [   12.314832]  0000000000000000 0000000085c693e9 ffff880030d6fd58
> ffffffff8139746f
> [   12.322239]  00000000000000a0 ffff880030d6fd90 ffffffff814b4813
> ffff880030d283c0
> [   12.329645]  ffff880030d2e100 0000000000000002 0000000000000000
> ffff880030c29808
> [   12.337052] Call Trace:
> [   12.339493]  [<ffffffff8139746f>] dump_stack+0x44/0x55
> [   12.344616]  [<ffffffff814b4813>] modify_irte+0x23/0xc0
> [   12.349827]  [<ffffffff814b48cc>] irq_remapping_deactivate+0x1c/0x20
> [   12.356162]  [<ffffffff814b48de>] irq_remapping_activate+0xe/0x10
> [   12.362238]  [<ffffffff810fa6b1>] irq_domain_activate_irq+0x41/0x50
> [   12.368486]  [<ffffffff810fa69b>] irq_domain_activate_irq+0x2b/0x50
> [   12.374736]  [<ffffffff81d6ccbb>] setup_IO_APIC+0x33e/0x7e4
> [   12.380294]  [<ffffffff81052039>] ? clear_IO_APIC+0x39/0x60
> [   12.385853]  [<ffffffff81d6b82c>] apic_bsp_setup+0xa1/0xac
> [   12.391323]  [<ffffffff81d69463>] native_smp_prepare_cpus+0x25f/0x2db
> [   12.397747]  [<ffffffff81d550ee>] kernel_init_freeable+0xc9/0x228
> [   12.403824]  [<ffffffff81762370>] ? rest_init+0x80/0x80
> [   12.409034]  [<ffffffff8176237e>] kernel_init+0xe/0xe0
> [   12.414158]  [<ffffffff8176e19f>] ret_from_fork+0x3f/0x70
> [   12.419541]  [<ffffffff81762370>] ? rest_init+0x80/0x80
> [   12.424751]   modify_irte	 devid: 00:14.0 index: 2, vector:48
> [   12.440491] Kernel panic - not syncing: timer doesn't work through
> Interrupt-remapped IO-APIC
> [   12.449022] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0+ #18
> [   12.455008] Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
> [   12.461340]  0000000000000000 0000000085c693e9 ffff880030d6fd58
> ffffffff8139746f
> [   12.468753]  ffffffff81a3cdf8 ffff880030d6fde0 ffffffff8119e921
> 0000000000000008
> [   12.476165]  ffff880030d6fdf0 ffff880030d6fd88 0000000085c693e9
> ffffffff813a41b5
> [   12.483577] Call Trace:
> [   12.486018]  [<ffffffff8139746f>] dump_stack+0x44/0x55
> [   12.491142]  [<ffffffff8119e921>] panic+0xd3/0x20b
> [   12.495919]  [<ffffffff813a41b5>] ? delay_tsc+0x25/0x60
> [   12.501129]  [<ffffffff814bfaba>] panic_if_irq_remap+0x1a/0x20
> [   12.506947]  [<ffffffff81d6ccf2>] setup_IO_APIC+0x375/0x7e4
> [   12.512503]  [<ffffffff81052039>] ? clear_IO_APIC+0x39/0x60
> [   12.518060]  [<ffffffff81d6b82c>] apic_bsp_setup+0xa1/0xac
> [   12.523530]  [<ffffffff81d69463>] native_smp_prepare_cpus+0x25f/0x2db
> [   12.529952]  [<ffffffff81d550ee>] kernel_init_freeable+0xc9/0x228
> [   12.536030]  [<ffffffff81762370>] ? rest_init+0x80/0x80
> [   12.541238]  [<ffffffff8176237e>] kernel_init+0xe/0xe0
> [   12.546361]  [<ffffffff8176e19f>] ret_from_fork+0x3f/0x70
> [   12.551745]  [<ffffffff81762370>] ? rest_init+0x80/0x80
> [   12.556957] Rebooting in 10 seconds..

> From 09943d6354ee1626426f6ff060d92173bb164279 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date: Thu, 25 Jun 2015 16:46:16 +0800
> Subject: [PATCH 1/3] iommu/amd: Fix a code bug of bitmap operation
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c      | 2 +-
>  drivers/iommu/amd_iommu_init.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 45b7581..552730b 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1901,7 +1901,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
>  	 * mark the first page as allocated so we never return 0 as
>  	 * a valid dma-address. So we can use 0 as error value
>  	 */
> -	dma_dom->aperture[0]->bitmap[0] = 1;
> +	__set_bit(0, dma_dom->aperture[0]->bitmap);
>  	dma_dom->next_address = 0;
>  
>  
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index f954ae8..0fe7eb4 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -21,6 +21,7 @@
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/list.h>
> +#include <linux/bitmap.h>
>  #include <linux/slab.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/interrupt.h>
> @@ -1939,8 +1940,7 @@ static int __init early_amd_iommu_init(void)
>  	 * never allocate domain 0 because its used as the non-allocated and
>  	 * error value placeholder
>  	 */
> -	amd_iommu_pd_alloc_bitmap[0] = 1;
> -
> +	 __set_bit(0, amd_iommu_pd_alloc_bitmap);
>  	spin_lock_init(&amd_iommu_pd_lock);
>  
>  	/*
> -- 
> 2.5.0
> 

> From 997465ee1d23f1895bcf574df7a8b19ee0dde03d Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date: Fri, 26 Jun 2015 21:06:27 +0800
> Subject: [PATCH 2/3] get the device range
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c | 45 +++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 0fe7eb4..ae5f35a 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -413,14 +413,32 @@ static inline int ivhd_entry_length(u8 *ivhd)
>   * This function reads the last device id the IOMMU has to handle from the PCI
>   * capability header for this IOMMU
>   */
> -static int __init find_last_devid_on_pci(int bus, int dev, int fn, int cap_ptr)
> +static int __init find_first_devid_on_pci(struct ivhd_header *h)
>  {
>  	u32 cap;
>  
> -	cap = read_pci_config(bus, dev, fn, cap_ptr+MMIO_RANGE_OFFSET);
> -	update_last_devid(PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_LD(cap)));
> +	cap = read_pci_config(PCI_BUS_NUM(h->devid),
> +				PCI_SLOT(h->devid),
> +				PCI_FUNC(h->devid),
> +				h->cap_ptr+MMIO_RANGE_OFFSET);
>  
> -	return 0;
> +	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_FD(range));
> +}
> +
> +/*
> + * This function reads the last device id the IOMMU has to handle from the PCI
> + * capability header for this IOMMU
> + */
> +static int __init find_last_devid_on_pci(struct ivhd_header *h)
> +{
> +	u32 cap;
> +
> +	cap = read_pci_config(PCI_BUS_NUM(h->devid),
> +				PCI_SLOT(h->devid),
> +				PCI_FUNC(h->devid),
> +				h->cap_ptr+MMIO_RANGE_OFFSET);
> +
> +	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_LD(range));
>  }
>  
>  /*
> @@ -431,15 +449,14 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
>  {
>  	u8 *p = (void *)h, *end = (void *)h;
>  	struct ivhd_entry *dev;
> +	u16 devid;
> +
> +	devid = find_last_devid_on_pci(h);
> +	update_last_devid(devid);
>  
>  	p += sizeof(*h);
>  	end += h->length;
>  
> -	find_last_devid_on_pci(PCI_BUS_NUM(h->devid),
> -			PCI_SLOT(h->devid),
> -			PCI_FUNC(h->devid),
> -			h->cap_ptr);
> -
>  	while (p < end) {
>  		dev = (struct ivhd_entry *)p;
>  		switch (dev->type) {
> @@ -1099,6 +1116,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  	iommu->pci_seg = h->pci_seg;
>  	iommu->mmio_phys = h->mmio_phys;
>  
> +	iommu->first_device = find_first_devid_on_pci(h);
> +	iommu->last_device = find_last_devid_on_pci(h);
> +
>  	/* Check if IVHD EFR contains proper max banks/counters */
>  	if ((h->efr != 0) &&
>  	    ((h->efr & (0xF << 13)) != 0) &&
> @@ -1260,16 +1280,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
>  
>  	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
>  			      &iommu->cap);
> -	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_RANGE_OFFSET,
> -			      &range);
>  	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_MISC_OFFSET,
>  			      &misc);
>  
> -	iommu->first_device = PCI_DEVID(MMIO_GET_BUS(range),
> -					 MMIO_GET_FD(range));
> -	iommu->last_device = PCI_DEVID(MMIO_GET_BUS(range),
> -					MMIO_GET_LD(range));
> -
>  	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
>  		amd_iommu_iotlb_sup = false;
>  
> -- 
> 2.5.0
> 

> From b8bbc536151e5134d2e41ab01daaf1d79fe2c1fb Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date: Sun, 28 Jun 2015 21:05:16 +0800
> Subject: [PATCH 3/3] check if it's pre enabled
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> latest
> ---
>  drivers/iommu/amd_iommu.c       |  49 ++++++++++++++-
>  drivers/iommu/amd_iommu_init.c  | 131 +++++++++++++++++++++++++++++++---------
>  drivers/iommu/amd_iommu_types.h |  15 +++++
>  3 files changed, 162 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 552730b..286ff4e 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2351,7 +2351,7 @@ static void update_device_table(struct protection_domain *domain)
>  
>  static void update_domain(struct protection_domain *domain)
>  {
> -	if (!domain->updated)
> +	if (!domain->updated || translation_pre_enabled())
>  		return;
>  
>  	update_device_table(domain);
> @@ -2470,6 +2470,7 @@ static dma_addr_t __map_single(struct device *dev,
>  	unsigned long align_mask = 0;
>  	int i;
>  
> +	clear_translation_pre_enabled();
>  	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
>  	paddr &= PAGE_MASK;
>  
> @@ -2919,6 +2920,7 @@ static int protection_domain_init(struct protection_domain *domain)
>  	domain->id = domain_id_alloc();
>  	if (!domain->id)
>  		return -ENOMEM;
> +	pr_info("#########protection_domain_init() domain->id=%d \n", domain->id);
>  	INIT_LIST_HEAD(&domain->dev_list);
>  
>  	return 0;
> @@ -3641,6 +3643,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
>  	struct amd_iommu *iommu;
>  	unsigned long flags;
>  	u16 alias;
> +	u64 dte;
>  
>  	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
>  
> @@ -3682,12 +3685,33 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
>  
>  	memset(table->table, 0, MAX_IRQS_PER_TABLE * sizeof(u32));
>  
> +#if 0
>  	if (ioapic) {
>  		int i;
>  
>  		for (i = 0; i < 32; ++i)
>  			table->table[i] = IRTE_ALLOCATED;
>  	}
> +#else
> +	if (translation_pre_enabled()) {
> +		u64 old_intr_virt;
> +		dte	= amd_iommu_dev_table[devid].data[2];
> +		dte &= DTE_IRQ_PHYS_ADDR_MASK;
> +		old_intr_virt = ioremap_cache(dte, MAX_IRQS_PER_TABLE * sizeof(u32));
> +		memcpy_fromio(table->table, old_intr_virt, MAX_IRQS_PER_TABLE * sizeof(u32));
> +		iounmap(old_intr_virt);
> +	}
> +	else {
> +
> +		if (ioapic) {
> +			int i;
> +
> +			for (i = 0; i < 32; ++i)
> +				table->table[i] = IRTE_ALLOCATED;
> +		}
> +	}
> +
> +#endif
>  
>  	irq_lookup_table[devid] = table;
>  	set_dte_irq_entry(devid, table);
> @@ -3751,6 +3775,15 @@ static int modify_irte(u16 devid, int index, union irte irte)
>  	struct amd_iommu *iommu;
>  	unsigned long flags;
>  
> +	dump_stack();
> +	pr_info("  modify_irte\t devid: %02x:%02x.%x "
> +                                    "index: %d, vector:%u\n",
> +                                    PCI_BUS_NUM(devid),
> +                                    PCI_SLOT(devid),
> +                                    PCI_FUNC(devid),
> +                                    index,
> +                                        irte.fields.vector);
> +
>  	iommu = amd_iommu_rlookup_table[devid];
>  	if (iommu == NULL)
>  		return -EINVAL;
> @@ -3945,6 +3978,14 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  	if (devid < 0)
>  		return -EINVAL;
>  
> +	pr_info("  irq_remapping_alloc\t devid: %02x:%02x.%x "
> +                                    "info->type: %02x, virq:%u,nr_irqs:%u\n",
> +                                    PCI_BUS_NUM(devid),
> +                                    PCI_SLOT(devid),
> +                                    PCI_FUNC(devid),
> +                                    info->type,
> +					virq,
> +					nr_irqs);
>  	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
>  	if (ret < 0)
>  		return ret;
> @@ -3954,9 +3995,10 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  			index = info->ioapic_pin;
>  		else
>  			ret = -ENOMEM;
> -	} else {
> +	} else
>  		index = alloc_irq_index(devid, nr_irqs);
> -	}
> +
> +	pr_info("########### irq_remapping_alloc index =%d. \n", index);
>  	if (index < 0) {
>  		pr_warn("Failed to allocate IRTE\n");
>  		goto out_free_parent;
> @@ -3979,6 +4021,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  		irq_data->chip_data = data;
>  		irq_data->chip = &amd_ir_chip;
>  		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
> +		pr_info("########### irq_remapping_alloc vector:%d. \n", cfg->vector);
>  		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
>  	}
>  
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index ae5f35a..64a80a2 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -226,6 +226,27 @@ static bool __initdata cmdline_maps;
>  
>  static enum iommu_init_state init_state = IOMMU_START_STATE;
>  
> +u8 g_pre_enabled;
> +
> +bool translation_pre_enabled(void)
> +{
> +        return !!g_pre_enabled;
> +}
> +
> +void clear_translation_pre_enabled(void)
> +{
> +        g_pre_enabled = 0;
> +}
> +
> +static void init_translation_status(struct amd_iommu *iommu)
> +{
> +	u32 ctrl;
> +
> +	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
> +	if (ctrl & (1<<CONTROL_IOMMU_EN))
> +		g_pre_enabled = 1;
> +}
> +
>  static int amd_iommu_enable_interrupts(void);
>  static int __init iommu_go_to_state(enum iommu_init_state state);
>  static void init_device_table_dma(void);
> @@ -422,7 +443,7 @@ static int __init find_first_devid_on_pci(struct ivhd_header *h)
>  				PCI_FUNC(h->devid),
>  				h->cap_ptr+MMIO_RANGE_OFFSET);
>  
> -	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_FD(range));
> +	return PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_FD(cap));
>  }
>  
>  /*
> @@ -438,7 +459,7 @@ static int __init find_last_devid_on_pci(struct ivhd_header *h)
>  				PCI_FUNC(h->devid),
>  				h->cap_ptr+MMIO_RANGE_OFFSET);
>  
> -	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_LD(range));
> +	return PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_LD(cap));
>  }
>  
>  /*
> @@ -712,22 +733,24 @@ static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
>  static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
>  					   u16 devid, u32 flags, u32 ext_flags)
>  {
> -	if (flags & ACPI_DEVFLAG_INITPASS)
> -		set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
> -	if (flags & ACPI_DEVFLAG_EXTINT)
> -		set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
> -	if (flags & ACPI_DEVFLAG_NMI)
> -		set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
> -	if (flags & ACPI_DEVFLAG_SYSMGT1)
> -		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
> -	if (flags & ACPI_DEVFLAG_SYSMGT2)
> -		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
> -	if (flags & ACPI_DEVFLAG_LINT0)
> -		set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
> -	if (flags & ACPI_DEVFLAG_LINT1)
> -		set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
> -
> -	amd_iommu_apply_erratum_63(devid);
> +	if ( !translation_pre_enabled()) {
> +		if (flags & ACPI_DEVFLAG_INITPASS)
> +			set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
> +		if (flags & ACPI_DEVFLAG_EXTINT)
> +			set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
> +		if (flags & ACPI_DEVFLAG_NMI)
> +			set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
> +		if (flags & ACPI_DEVFLAG_SYSMGT1)
> +			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
> +		if (flags & ACPI_DEVFLAG_SYSMGT2)
> +			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
> +		if (flags & ACPI_DEVFLAG_LINT0)
> +			set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
> +		if (flags & ACPI_DEVFLAG_LINT1)
> +			set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
> +
> +		amd_iommu_apply_erratum_63(devid);
> +	}
>  
>  	set_iommu_for_device(iommu, devid);
>  }
> @@ -811,7 +834,8 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
>  		 * per device. But we can enable the exclusion range per
>  		 * device. This is done here
>  		 */
> -		set_dev_entry_bit(devid, DEV_ENTRY_EX);
> +		if (!translation_pre_enabled())
> +			set_dev_entry_bit(devid, DEV_ENTRY_EX);
>  		iommu->exclusion_start = m->range_start;
>  		iommu->exclusion_length = m->range_length;
>  	}
> @@ -1093,6 +1117,7 @@ static void amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
>  static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  {
>  	int ret;
> +	u32 ctrl;
>  
>  	spin_lock_init(&iommu->lock);
>  
> @@ -1143,6 +1168,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  
>  	iommu->int_enabled = false;
>  
> +	init_translation_status(iommu);
> +	pr_info("###g_pre_enabled=%d\n", g_pre_enabled);
> +
>  	ret = init_iommu_from_acpi(iommu, h);
>  	if (ret)
>  		return ret;
> @@ -1405,7 +1433,8 @@ static int __init amd_iommu_init_pci(void)
>  			break;
>  	}
>  
> -	init_device_table_dma();
> +	if ( !translation_pre_enabled() )
> +		init_device_table_dma();
>  
>  	for_each_iommu(iommu)
>  		iommu_flush_all_caches(iommu);
> @@ -1689,6 +1718,38 @@ static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
>  			       iommu->stored_addr_lo | 1);
>  }
>  
> +static void copy_dev_tables(void)
> +{
> +	u64 entry;
> +	u32 lo, hi;
> +	phys_addr_t old_devtb_phys;
> +	u64 old_devtb_virt;
> +	struct dev_table_entry *old_devtb;
> +	struct amd_iommu *iommu;
> +	u16 dom_id;
> +	u32 devid;
> +
> +	for_each_iommu(iommu) {
> +		lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> +		hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> +		entry = (((u64) hi) << 32) + lo;
> +		old_devtb_phys = entry & PAGE_MASK;
> +		old_devtb_virt = ioremap_cache(old_devtb_phys, dev_table_size);
> +		old_devtb = (struct dev_table_entry*) old_devtb_virt;
> +		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> +			amd_iommu_dev_table[devid] = old_devtb[devid];
> +			dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> +			pr_info("###### copy_dev_tables dom_id=%u,data[1]=0x%llx old.data[1]=0x%llx\n",
> +					dom_id, amd_iommu_dev_table[devid].data[1], old_devtb[devid].data[1]);
> +			__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> +			pr_info("###### copy_dev_tables bitmap=0x%lx\n", amd_iommu_pd_alloc_bitmap[0]);
> +		}
> +		iounmap(old_devtb);
> +	}
> +
> +}
> +
> +
>  /*
>   * This function finally enables all IOMMUs found in the system after
>   * they have been initialized
> @@ -1698,14 +1759,21 @@ static void early_enable_iommus(void)
>  	struct amd_iommu *iommu;
>  
>  	for_each_iommu(iommu) {
> -		iommu_disable(iommu);
> -		iommu_init_flags(iommu);
> -		iommu_set_device_table(iommu);
> -		iommu_enable_command_buffer(iommu);
> -		iommu_enable_event_buffer(iommu);
> -		iommu_set_exclusion_range(iommu);
> -		iommu_enable(iommu);
> -		iommu_flush_all_caches(iommu);
> +		if ( !translation_pre_enabled() ) {
> +			iommu_disable(iommu);
> +			iommu_init_flags(iommu);
> +			iommu_set_device_table(iommu);
> +			iommu_enable_command_buffer(iommu);
> +			iommu_enable_event_buffer(iommu);
> +			iommu_set_exclusion_range(iommu);
> +			iommu_enable(iommu);
> +			iommu_flush_all_caches(iommu); 
> +		} else {
> +			copy_dev_tables();
> +			iommu_enable_command_buffer(iommu);
> +			iommu_enable_event_buffer(iommu);
> +			//iommu_flush_all_caches(iommu); 
> +		}
>  	}
>  }
>  
> @@ -1989,10 +2057,11 @@ static int __init early_amd_iommu_init(void)
>  
>  	ret = init_memory_definitions(ivrs_base);
>  	if (ret)
> -		goto out;
> +		goto out; 
>  
>  	/* init the device table */
> -	init_device_table();
> +	if (!g_pre_enabled)
> +		init_device_table();
>  
>  out:
>  	/* Don't leak any ACPI memory */
> @@ -2002,6 +2071,8 @@ out:
>  	return ret;
>  }
>  
> +
> +
>  static int amd_iommu_enable_interrupts(void)
>  {
>  	struct amd_iommu *iommu;
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index f659088..5f5e1ed 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -194,6 +194,12 @@
>  #define DEV_ENTRY_MODE_MASK	0x07
>  #define DEV_ENTRY_MODE_SHIFT	0x09
>  
> +
> +/* kdump fix */
> +#define DEV_PTE_ROOT_LEN 52
> +#define DEV_DOMID_MASK        0xffff
> +
> +
>  #define MAX_DEV_TABLE_ENTRIES	0xffff
>  
>  /* constants to configure the command buffer */
> @@ -205,6 +211,7 @@
>  
>  /* constants for event buffer handling */
>  #define EVT_BUFFER_SIZE		8192 /* 512 entries */
> +#define MMIO_EVT_SIZE_SHIFT 56
>  #define EVT_LEN_MASK		(0x9ULL << 56)
>  
>  /* Constants for PPR Log handling */
> @@ -294,6 +301,7 @@
>  #define IOMMU_PTE_FC (1ULL << 60)
>  #define IOMMU_PTE_IR (1ULL << 61)
>  #define IOMMU_PTE_IW (1ULL << 62)
> +#define IOMMU_PTE_IW (1ULL << 62)
>  
>  #define DTE_FLAG_IOTLB	(0x01UL << 32)
>  #define DTE_FLAG_GV	(0x01ULL << 55)
> @@ -463,6 +471,9 @@ struct dma_ops_domain {
>  	bool need_flush;
>  };
>  
> +#define IOMMU_FLAG_TRANS_PRE_ENABLED     (1 << 0)
> +#define IOMMU_FLAG_IRQ_REMAP_PRE_ENABLED (1 << 1)
> +
>  /*
>   * Structure where we save information about one hardware AMD IOMMU in the
>   * system.
> @@ -573,6 +584,7 @@ struct amd_iommu {
>  	struct irq_domain *ir_domain;
>  	struct irq_domain *msi_domain;
>  #endif
> +	u32	flags;
>  };
>  
>  struct devid_map {
> @@ -686,6 +698,9 @@ extern bool amd_iommu_force_isolation;
>  /* Max levels of glxval supported */
>  extern int amd_iommu_max_glx_val;
>  
> +extern u8 g_pre_enabled;
> +extern bool translation_pre_enabled(void);
> +extern void clear_translation_pre_enabled(void);
>  /*
>   * This function flushes all internal caches of
>   * the IOMMU used by this driver.
> -- 
> 2.5.0
> 
