From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
	kvm_intr_is_single_vcpu()
Date: Wed, 16 Sep 2015 11:23:01 +0200
Message-ID: <55F934F5.7040605@redhat.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
	<1442393409-2623-4-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442393409-2623-4-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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



On 16/09/2015 10:49, Feng Wu wrote:
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
> v8:
> - Some optimizations in kvm_intr_is_single_vcpu().
> - Expose kvm_intr_is_single_vcpu() so we can use it in vmx code.
> - Add kvm_intr_is_single_vcpu_fast() as the fast path to find
>   the target vCPU for the single-destination interrupt
> 
>  arch/x86/include/asm/kvm_host.h |  3 ++
>  arch/x86/kvm/irq_comm.c         | 94 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/lapic.c            |  5 +--
>  arch/x86/kvm/lapic.h            |  2 +
>  4 files changed, 101 insertions(+), 3 deletions(-)
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
> index 9efff9e..97ba1d6 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -297,6 +297,100 @@ out:
>  	return r;
>  }
>  
> +static bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm,
> +					 struct kvm_lapic_irq *irq,
> +					 struct kvm_vcpu **dest_vcpu)

Please put this in lapic.c, similar to kvm_irq_delivery_to_apic_fast, so
that you do not have to export other functions.

> +{
> +	struct kvm_apic_map *map;
> +	bool ret = false;
> +	struct kvm_lapic *dst = NULL;
> +
> +	if (irq->shorthand)
> +		return false;
> +
> +	rcu_read_lock();
> +	map = rcu_dereference(kvm->arch.apic_map);
> +
> +	if (!map)
> +		goto out;
> +
> +	if (irq->dest_mode == APIC_DEST_PHYSICAL) {
> +		if (irq->dest_id == 0xFF)
> +			goto out;
> +
> +		if (irq->dest_id >= ARRAY_SIZE(map->phys_map)) {

Warning here is wrong, the guest can trigger it.

> +			WARN_ON_ONCE(1);
> +			goto out;
> +		}
> +
> +		dst = map->phys_map[irq->dest_id];
> +		if (dst && kvm_apic_present(dst->vcpu))
> +			*dest_vcpu = dst->vcpu;
> +		else
> +			goto out;
> +	} else {
> +		u16 cid;
> +		unsigned long bitmap = 1;
> +		int i, r = 0;
> +
> +		if (!kvm_apic_logical_map_valid(map)) {
> +			WARN_ON_ONCE(1);

Same here.

> +			goto out;
> +		}
> +
> +		apic_logical_id(map, irq->dest_id, &cid, (u16 *)&bitmap);
> +
> +		if (cid >= ARRAY_SIZE(map->logical_map)) {
> +			WARN_ON_ONCE(1);

Same here.

Otherwise looks good.

Paolo

> +			goto out;
> +		}
> +
> +		for_each_set_bit(i, &bitmap, 16) {
> +			dst = map->logical_map[cid][i];
> +			if (++r == 2)
> +				goto out;
> +		}
> +
> +		if (dst && kvm_apic_present(dst->vcpu))
> +			*dest_vcpu = dst->vcpu;
> +		else
> +			goto out;
> +	}
> +
> +	ret = true;
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +
> +bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
> +			     struct kvm_vcpu **dest_vcpu)
> +{
> +	int i, r = 0;
> +	struct kvm_vcpu *vcpu;
> +
> +	if (kvm_intr_is_single_vcpu_fast(kvm, irq, dest_vcpu))
> +		return true;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (!kvm_apic_present(vcpu))
> +			continue;
> +
> +		if (!kvm_apic_match_dest(vcpu, NULL, irq->shorthand,
> +					irq->dest_id, irq->dest_mode))
> +			continue;
> +
> +		if (++r == 2)
> +			return false;
> +
> +		*dest_vcpu = vcpu;
> +	}
> +
> +	return r == 1;
> +}
> +EXPORT_SYMBOL_GPL(kvm_intr_is_single_vcpu);
> +
>  #define IOAPIC_ROUTING_ENTRY(irq) \
>  	{ .gsi = irq, .type = KVM_IRQ_ROUTING_IRQCHIP,	\
>  	  .u.irqchip = { .irqchip = KVM_IRQCHIP_IOAPIC, .pin = (irq) } }
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 2a5ca97..9848cd50 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -136,13 +136,12 @@ static inline int kvm_apic_id(struct kvm_lapic *apic)
>  /* The logical map is definitely wrong if we have multiple
>   * modes at the same time.  (Physical map is always right.)
>   */
> -static inline bool kvm_apic_logical_map_valid(struct kvm_apic_map *map)
> +bool kvm_apic_logical_map_valid(struct kvm_apic_map *map)
>  {
>  	return !(map->mode & (map->mode - 1));
>  }
>  
> -static inline void
> -apic_logical_id(struct kvm_apic_map *map, u32 dest_id, u16 *cid, u16 *lid)
> +void apic_logical_id(struct kvm_apic_map *map, u32 dest_id, u16 *cid, u16 *lid)
>  {
>  	unsigned lid_bits;
>  
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 7195274..6798b87 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -169,4 +169,6 @@ bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
>  
>  void wait_lapic_expire(struct kvm_vcpu *vcpu);
>  
> +void apic_logical_id(struct kvm_apic_map *map, u32 dest_id, u16 *cid, u16 *lid);
> +bool kvm_apic_logical_map_valid(struct kvm_apic_map *map);
>  #endif
> 
