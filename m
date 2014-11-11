From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 01/13] iommu/vt-d: VT-d Posted-Interrupts feature detection
Date: Tue, 11 Nov 2014 21:38:22 +0800
Message-ID: <5462114E.1060901@linux.intel.com>
References: <1415600812-27773-1-git-send-email-feng.wu@intel.com>
	<1415600812-27773-2-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415600812-27773-2-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2014/11/10 14:26, Feng Wu wrote:
> VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
> With VT-d Posted-Interrupts enabled, external interrupts from
> direct-assigned devices can be delivered to guests without VMM
> intervention when guest is running in non-root mode.
> 
> This patch adds feature detection logic for VT-d posted-interrupt.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel_irq_remapping.c |   13 +++++++++++++
>  drivers/iommu/irq_remapping.c       |    4 ++++
>  drivers/iommu/irq_remapping.h       |    5 +++++
>  include/linux/intel-iommu.h         |    1 +
>  4 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 7c80661..f99f0f1 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -580,6 +580,19 @@ static int __init intel_irq_remapping_supported(void)
>  		if (!ecap_ir_support(iommu->ecap))
>  			return 0;
>  
> +	/* VT-d posted-interrupt feature detection*/
> +	if (disable_irq_post == 0)
> +		for_each_drhd_unit(drhd) {
> +			struct intel_iommu *iommu = drhd->iommu;
Hi Feng,
	You may use for_each_active_iommu() here.
Regards!
Gerry

> +
> +			if (!cap_pi_support(iommu->cap)) {
> +				irq_post_enabled = 0;
> +				disable_irq_post = 1;
> +				break;
> +			}
> +			irq_post_enabled = 1;
> +		}
> +
>  	return 1;
>  }
>  
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 74a1767..2f8ee00 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -23,6 +23,10 @@ int irq_remap_broken;
>  int disable_sourceid_checking;
>  int no_x2apic_optout;
>  
> +int disable_irq_post = 1;
> +int irq_post_enabled = 0;
> +EXPORT_SYMBOL_GPL(irq_post_enabled);
> +
>  static struct irq_remap_ops *remap_ops;
>  
>  static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec);
> diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
> index fde250f..7bb5913 100644
> --- a/drivers/iommu/irq_remapping.h
> +++ b/drivers/iommu/irq_remapping.h
> @@ -37,6 +37,9 @@ extern int disable_sourceid_checking;
>  extern int no_x2apic_optout;
>  extern int irq_remapping_enabled;
>  
> +extern int disable_irq_post;
> +extern int irq_post_enabled;
> +
>  struct irq_remap_ops {
>  	/* Check whether Interrupt Remapping is supported */
>  	int (*supported)(void);
> @@ -91,6 +94,8 @@ extern struct irq_remap_ops amd_iommu_irq_ops;
>  #define irq_remapping_enabled 0
>  #define disable_irq_remap     1
>  #define irq_remap_broken      0
> +#define disable_irq_post      1
> +#define irq_post_enabled      0
>  
>  #endif /* CONFIG_IRQ_REMAP */
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index a65208a..5b1a124 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -87,6 +87,7 @@ static inline void dmar_writeq(void __iomem *addr, u64 val)
>  /*
>   * Decoding Capability Register
>   */
> +#define cap_pi_support(c)	(((c) >> 59) & 1)
>  #define cap_read_drain(c)	(((c) >> 55) & 1)
>  #define cap_write_drain(c)	(((c) >> 54) & 1)
>  #define cap_max_amask_val(c)	(((c) >> 48) & 0x3f)
> 
