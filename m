From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 03/17] KVM: Define a new interface
	kvm_intr_is_single_vcpu()
Date: Fri, 11 Sep 2015 12:20:40 +0200
Message-ID: <55F2AAF8.5090107@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
	<1440492620-15934-4-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1440492620-15934-4-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> This patch defines a new interface kvm_intr_is_single_vcpu(),
> which can returns whether the interrupt is for single-CPU or not.
> 
> It is used by VT-d PI, since now we only support single-CPU
> interrupts, For lowest-priority interrupts, if user configures
> it via /proc/irq or uses irqbalance to make it single-CPU, we
> can use PI to deliver the interrupts to it. Full functionality
> of lowest-priority support will be added later.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/irq_comm.c         | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 49ec903..af11bca 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1204,4 +1204,7 @@ int __x86_set_memory_region(struct kvm *kvm,
>  int x86_set_memory_region(struct kvm *kvm,
>  			  const struct kvm_userspace_memory_region *mem);
>  
> +bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
> +			     struct kvm_vcpu **dest_vcpu);
> +
>  #endif /* _ASM_X86_KVM_HOST_H */
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 9efff9e..a9572a13 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -297,6 +297,30 @@ out:
>  	return r;
>  }
>  
> +bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
> +			     struct kvm_vcpu **dest_vcpu)
> +{
> +	int i, r = 0;
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (!kvm_apic_present(vcpu))
> +			continue;
> +
> +		if (!kvm_apic_match_dest(vcpu, NULL, irq->shorthand,
> +					irq->dest_id, irq->dest_mode))
> +			continue;
> +
> +		r++;

if (++r == 2)
	return false;

> +		*dest_vcpu = vcpu;
> +	}
> +
> +	if (r == 1)
> +		return true;
> +	else
> +		return false;

... then just "return r == 1;" is enough here.

This could also be optimized to treat APIC_DEST_NOSHORT specially.  Get
the mda, and if it has a single physical CPU check that it has
kvm_apic_present(vcpu) set.  Otherwise fall back to the slow path.

Paolo

> +}
> +
>  #define IOAPIC_ROUTING_ENTRY(irq) \
>  	{ .gsi = irq, .type = KVM_IRQ_ROUTING_IRQCHIP,	\
>  	  .u.irqchip = { .irqchip = KVM_IRQCHIP_IOAPIC, .pin = (irq) } }
> 
