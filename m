From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 10/17] KVM: x86: Update IRTE for posted-interrupts
Date: Tue, 25 Aug 2015 13:57:44 -0600
Message-ID: <1440532664.20355.9.camel@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
	 <1440492620-15934-11-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-11-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>
Cc: pbonzini@redhat.com, joro@8bytes.org, mtosatti@redhat.com, eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-08-25 at 16:50 +0800, Feng Wu wrote:
> This patch adds the routine to update IRTE for posted-interrupts
> when guest changes the interrupt configuration.
> 
> Signed-off-by: Feng Wu <feng.wu@intel.com>
> ---
>  arch/x86/kvm/x86.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5ef2560..8f09a76 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -63,6 +63,7 @@
>  #include <asm/fpu/internal.h> /* Ugh! */
>  #include <asm/pvclock.h>
>  #include <asm/div64.h>
> +#include <asm/irq_remapping.h>
>  
>  #define MAX_IO_MSRS 256
>  #define KVM_MAX_MCE_BANKS 32
> @@ -8248,6 +8249,78 @@ bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
>  }
>  EXPORT_SYMBOL_GPL(kvm_arch_has_noncoherent_dma);
>  
> +/*
> + * kvm_arch_update_pi_irte - set IRTE for Posted-Interrupts
> + *
> + * @kvm: kvm
> + * @host_irq: host irq of the interrupt
> + * @guest_irq: gsi of the interrupt
> + * @set: set or unset PI
> + * returns 0 on success, < 0 on failure
> + */
> +int kvm_arch_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
> +			    uint32_t guest_irq, bool set)
> +{
> +	struct kvm_kernel_irq_routing_entry *e;
> +	struct kvm_irq_routing_table *irq_rt;
> +	struct kvm_lapic_irq irq;
> +	struct kvm_vcpu *vcpu;
> +	struct vcpu_data vcpu_info;
> +	int idx, ret = -EINVAL;
> +
> +	if (!irq_remapping_cap(IRQ_POSTING_CAP))
> +		return 0;
> +
> +	idx = srcu_read_lock(&kvm->irq_srcu);
> +	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
> +	BUG_ON(guest_irq >= irq_rt->nr_rt_entries);
> +
> +	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
> +		if (e->type != KVM_IRQ_ROUTING_MSI)
> +			continue;
> +		/*
> +		 * VT-d PI cannot support posting multicast/broadcast
> +		 * interrupts to a VCPU, we still use interrupt remapping
> +		 * for these kind of interrupts.
> +		 *
> +		 * For lowest-priority interrupts, we only support
> +		 * those with single CPU as the destination, e.g. user
> +		 * configures the interrupts via /proc/irq or uses
> +		 * irqbalance to make the interrupts single-CPU.
> +		 *
> +		 * We will support full lowest-priority interrupt later.
> +		 *
> +		 */
> +
> +		kvm_set_msi_irq(e, &irq);
> +		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu))
> +			continue;
> +
> +		vcpu_info.pi_desc_addr = kvm_x86_ops->get_pi_desc_addr(vcpu);
> +		vcpu_info.vector = irq.vector;
> +
> +		if (set)
> +			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
> +		else {
> +			/* suppress notification event before unposting */
> +			kvm_x86_ops->pi_set_sn(vcpu);
> +			ret = irq_set_vcpu_affinity(host_irq, NULL);
> +			kvm_x86_ops->pi_clear_sn(vcpu);
> +		}

Can we add trace events so that we have a way to tell when PI is being
enabled/disabled other than performance heuristics?  Thanks,

Alex

> +
> +		if (ret < 0) {
> +			printk(KERN_INFO "%s: failed to update PI IRTE\n",
> +					__func__);
> +			goto out;
> +		}
> +	}
> +
> +	ret = 0;
> +out:
> +	srcu_read_unlock(&kvm->irq_srcu, idx);
> +	return ret;
> +}
> +
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
