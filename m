From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 13/17] KVM: Add an arch specific hooks in 'struct
 kvm_kernel_irqfd'
Date: Fri, 11 Sep 2015 12:39:04 +0200
Message-ID: <55F2AF48.9090700@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
 <1440492620-15934-14-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-14-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> +void kvm_arch_irqfd_init(struct kvm_kernel_irqfd *irqfd)
> +{
> +	irqfd->arch_update = kvm_arch_update_pi_irte;
> +}
> +
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5f183fb..f4005dc 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -34,6 +34,8 @@
>  
>  #include <asm/kvm_host.h>
>  
> +struct kvm_kernel_irqfd;
> +
>  /*
>   * The bit 16 ~ bit 31 of kvm_memory_region::flags are internally used
>   * in kvm, other bits are visible for userspace which are defined in
> @@ -1145,6 +1147,15 @@ extern struct kvm_device_ops kvm_xics_ops;
>  extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
>  extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
>  
> +#ifdef __KVM_HAVE_ARCH_IRQFD_INIT
> +void kvm_arch_irqfd_init(struct kvm_kernel_irqfd *irqfd);
> +#else
> +static inline void kvm_arch_irqfd_init(struct kvm_kernel_irqfd *irqfd)
> +{
> +	irqfd->arch_update = NULL;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>  
>  static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
> diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
> index 0c1de05..b7aab52 100644
> --- a/include/linux/kvm_irqfd.h
> +++ b/include/linux/kvm_irqfd.h
> @@ -66,6 +66,8 @@ struct kvm_kernel_irqfd {
>  	struct work_struct shutdown;
>  	struct irq_bypass_consumer consumer;
>  	struct irq_bypass_producer *producer;
> +	int (*arch_update)(struct kvm *kvm, unsigned int host_irq,
> +			   uint32_t guest_irq, bool set);
>  };
>  
>  #endif /* __LINUX_KVM_IRQFD_H */
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index f3050b9..b2d9066 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -288,6 +288,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	INIT_LIST_HEAD(&irqfd->list);
>  	INIT_WORK(&irqfd->inject, irqfd_inject);
>  	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
> +	kvm_arch_irqfd_init(irqfd);
>  	seqcount_init(&irqfd->irq_entry_sc);
>  
>  	f = fdget(args->fd);
> @@ -580,13 +581,22 @@ kvm_irqfd_release(struct kvm *kvm)
>   */
>  void kvm_irq_routing_update(struct kvm *kvm)
>  {
> +	int ret;
>  	struct kvm_kernel_irqfd *irqfd;
>  
>  	spin_lock_irq(&kvm->irqfds.lock);
>  
> -	list_for_each_entry(irqfd, &kvm->irqfds.items, list)
> +	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
>  		irqfd_update(kvm, irqfd);
>  
> +		if (irqfd->arch_update && irqfd->producer) {

With the changes I suggested in the previous message, you only need to
check "if (irqfd->producer)" here.  Then you can remove
kvm_arch_irqfd_init and just put the new "if (irqfd->producer)" under
"#ifdef CONFIG_KVM_HAVE_IRQ_BYPASS".

Just rename kvm_arch_update_pi_irte to kvm_arch_update_irqfd_routing.

Paolo

> +			ret = irqfd->arch_update(
> +					irqfd->kvm, irqfd->producer->irq,
> +					irqfd->gsi, 1);
> +			WARN_ON(ret);
> +		}
> +	}
