From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] x86: irq_remapping: Make functions static
Date: Fri, 12 Sep 2014 16:49:02 +0800
Message-ID: <5412B37E.1030207@linux.intel.com>
References: <1410512734-6369-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410512734-6369-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yijing,
	There's an effort to refine the remapping interface by
using hierarchy irqdomain, which plans to kill all these interfaces.
Please refer to
https://lkml.org/lkml/2014/9/11/101
https://lkml.org/lkml/2014/9/11/554
Regards!
Gerry

On 2014/9/12 17:05, Yijing Wang wrote:
> Change local functions to static.
> 
> Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  arch/x86/include/asm/irq_remapping.h |   27 +--------------------------
>  drivers/iommu/irq_remapping.c        |   34 +++++++++++++++++-----------------
>  2 files changed, 18 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
> index b7747c4..944cba6 100644
> --- a/arch/x86/include/asm/irq_remapping.h
> +++ b/arch/x86/include/asm/irq_remapping.h
> @@ -41,16 +41,7 @@ extern int irq_remapping_enable(void);
>  extern void irq_remapping_disable(void);
>  extern int irq_remapping_reenable(int);
>  extern int irq_remap_enable_fault_handling(void);
> -extern int setup_ioapic_remapped_entry(int irq,
> -				       struct IO_APIC_route_entry *entry,
> -				       unsigned int destination,
> -				       int vector,
> -				       struct io_apic_irq_attr *attr);
>  extern void free_remapped_irq(int irq);
> -extern void compose_remapped_msi_msg(struct pci_dev *pdev,
> -				     unsigned int irq, unsigned int dest,
> -				     struct msi_msg *msg, u8 hpet_id);
> -extern int setup_hpet_msi_remapped(unsigned int irq, unsigned int id);
>  extern void panic_if_irq_remap(const char *msg);
>  extern bool setup_remapped_irq(int irq,
>  			       struct irq_cfg *cfg,
> @@ -68,24 +59,8 @@ static inline int irq_remapping_enable(void) { return -ENODEV; }
>  static inline void irq_remapping_disable(void) { }
>  static inline int irq_remapping_reenable(int eim) { return -ENODEV; }
>  static inline int irq_remap_enable_fault_handling(void) { return -ENODEV; }
> -static inline int setup_ioapic_remapped_entry(int irq,
> -					      struct IO_APIC_route_entry *entry,
> -					      unsigned int destination,
> -					      int vector,
> -					      struct io_apic_irq_attr *attr)
> -{
> -	return -ENODEV;
> -}
> +
>  static inline void free_remapped_irq(int irq) { }
> -static inline void compose_remapped_msi_msg(struct pci_dev *pdev,
> -					    unsigned int irq, unsigned int dest,
> -					    struct msi_msg *msg, u8 hpet_id)
> -{
> -}
> -static inline int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
> -{
> -	return -ENODEV;
> -}
>  
>  static inline void panic_if_irq_remap(const char *msg)
>  {
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 33c4395..85eb212 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -27,9 +27,7 @@ static struct irq_remap_ops *remap_ops;
>  static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec);
>  static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
>  				  int index, int sub_handle);
> -static int set_remapped_irq_affinity(struct irq_data *data,
> -				     const struct cpumask *mask,
> -				     bool force);
> +static void __init irq_remapping_modify_x86_ops(void);
>  
>  static bool irq_remapped(struct irq_cfg *cfg)
>  {
> @@ -159,17 +157,6 @@ static void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
>  	io_apic_eoi(apic, pin);
>  }
>  
> -static void __init irq_remapping_modify_x86_ops(void)
> -{
> -	x86_io_apic_ops.disable		= irq_remapping_disable_io_apic;
> -	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
> -	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
> -	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
> -	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
> -	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
> -	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
> -}
> -
>  static __init int setup_nointremap(char *str)
>  {
>  	disable_irq_remap = 1;
> @@ -281,7 +268,7 @@ int __init irq_remap_enable_fault_handling(void)
>  	return remap_ops->enable_faulting();
>  }
>  
> -int setup_ioapic_remapped_entry(int irq,
> +static int setup_ioapic_remapped_entry(int irq,
>  				struct IO_APIC_route_entry *entry,
>  				unsigned int destination, int vector,
>  				struct io_apic_irq_attr *attr)
> @@ -314,7 +301,7 @@ void free_remapped_irq(int irq)
>  		remap_ops->free_irq(irq);
>  }
>  
> -void compose_remapped_msi_msg(struct pci_dev *pdev,
> +static void compose_remapped_msi_msg(struct pci_dev *pdev,
>  			      unsigned int irq, unsigned int dest,
>  			      struct msi_msg *msg, u8 hpet_id)
>  {
> @@ -343,7 +330,7 @@ static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
>  	return remap_ops->msi_setup_irq(pdev, irq, index, sub_handle);
>  }
>  
> -int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
> +static int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
>  {
>  	if (!remap_ops || !remap_ops->setup_hpet_msi)
>  		return -ENODEV;
> @@ -389,3 +376,14 @@ bool setup_remapped_irq(int irq, struct irq_cfg *cfg, struct irq_chip *chip)
>  	irq_remap_modify_chip_defaults(chip);
>  	return true;
>  }
> +
> +static void __init irq_remapping_modify_x86_ops(void)
> +{
> +	x86_io_apic_ops.disable		= irq_remapping_disable_io_apic;
> +	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
> +	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
> +	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
> +	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
> +	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
> +	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
> +}
> 
