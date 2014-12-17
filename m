From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [v3 16/26] KVM: Make struct kvm_irq_routing_table accessible
Date: Wed, 17 Dec 2014 17:17:45 +0100
Message-ID: <5491ACA9.5020507@redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com> <1418397300-10870-17-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418397300-10870-17-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.orgkvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 12/12/2014 16:14, Feng Wu wrote:
> Move struct kvm_irq_routing_table from irqchip.c to kvm_host.h,
> so we can use it outside of irqchip.c.
> 
> Signed-off-by: Feng Wu <feng.wu@intel.com>
> ---
>  include/linux/kvm_host.h | 19 +++++++++++++++++++
>  virt/kvm/irqchip.c       | 11 -----------
>  2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0b9659d..cfa85ac 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -335,6 +335,25 @@ struct kvm_kernel_irq_routing_entry {
>  	struct hlist_node link;
>  };
>  
> +#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
> +
> +struct kvm_irq_routing_table {
> +	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
> +	struct kvm_kernel_irq_routing_entry *rt_entries;
> +	u32 nr_rt_entries;
> +	/*
> +	 * Array indexed by gsi. Each entry contains list of irq chips
> +	 * the gsi is connected to.
> +	 */
> +	struct hlist_head map[0];
> +};
> +
> +#else
> +
> +struct kvm_irq_routing_table {};

If possible, just make this "struct kvm_irq_routing_table;" and pull
this line to include/linux/kvm_types.h.

Paolo

> +
> +#endif
> +
>  #ifndef KVM_PRIVATE_MEM_SLOTS
>  #define KVM_PRIVATE_MEM_SLOTS 0
>  #endif
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 7f256f3..cdf29a6 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -31,17 +31,6 @@
>  #include <trace/events/kvm.h>
>  #include "irq.h"
>  
> -struct kvm_irq_routing_table {
> -	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
> -	struct kvm_kernel_irq_routing_entry *rt_entries;
> -	u32 nr_rt_entries;
> -	/*
> -	 * Array indexed by gsi. Each entry contains list of irq chips
> -	 * the gsi is connected to.
> -	 */
> -	struct hlist_head map[0];
> -};
> -
>  int kvm_irq_map_gsi(struct kvm *kvm,
>  		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
>  {
> 
