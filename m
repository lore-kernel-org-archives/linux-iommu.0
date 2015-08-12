From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 11/16] KVM: Implement IRQ bypass consumer callbacks
	for x86
Date: Wed, 12 Aug 2015 14:17:59 -0600
Message-ID: <1439410679.4023.537.camel@redhat.com>
References: <1439273038-59463-1-git-send-email-feng.wu@intel.com>
	<1439273038-59463-12-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439273038-59463-12-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-08-11 at 14:03 +0800, Feng Wu wrote:
> Implement the following callbacks for x86:
> 
> - kvm_arch_irq_bypass_add_producer
> - kvm_arch_irq_bypass_del_producer
> - kvm_arch_irq_bypass_stop: dummy callback
> - kvm_arch_irq_bypass_resume: dummy callback
> 
> and set CONFIG_HAVE_KVM_IRQ_BYPASS for x86.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/Kconfig            |  1 +
>  arch/x86/kvm/x86.c              | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 82d0709..3038c1b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -24,6 +24,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/pvclock_gtod.h>
>  #include <linux/clocksource.h>
> +#include <linux/irqbypass.h>
>  
>  #include <asm/pvclock-abi.h>
>  #include <asm/desc.h>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index c951d44..b90776f 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -30,6 +30,7 @@ config KVM
>  	select HAVE_KVM_IRQCHIP
>  	select HAVE_KVM_IRQFD
>  	select IRQ_BYPASS_MANAGER
> +	select HAVE_KVM_IRQ_BYPASS
>  	select HAVE_KVM_IRQ_ROUTING
>  	select HAVE_KVM_EVENTFD
>  	select KVM_APIC_ARCHITECTURE
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8f09a76..8df7b0d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -50,6 +50,8 @@
>  #include <linux/pci.h>
>  #include <linux/timekeeper_internal.h>
>  #include <linux/pvclock_gtod.h>
> +#include <linux/kvm_irqfd.h>
> +#include <linux/irqbypass.h>
>  #include <trace/events/kvm.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -8321,6 +8323,43 @@ out:
>  	return ret;
>  }
>  
> +int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
> +				      struct irq_bypass_producer *prod)
> +{
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(cons, struct kvm_kernel_irqfd, consumer);
> +
> +	irqfd->producer = prod;
> +
> +	return kvm_arch_update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 1);
> +}
> +
> +void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
> +				      struct irq_bypass_producer *prod)
> +{
> +	int ret;
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(cons, struct kvm_kernel_irqfd, consumer);
> +
> +	irqfd->producer = NULL;
> +
> +	/*
> +	 * When producer of consumer is unregistered, we change back to
> +	 * remapped mode, so we can re-use the current implementation
> +	 * when the irq is masked/disabed or the consumer side (KVM
> +	 * int this case doesn't want to receive the interrupts.
> +	*/
> +	ret = kvm_arch_update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
> +	WARN_ON(ret);
> +}

Some tracing support would be nice here so we have some way to determine
whether we've made a successful connection.

> +
> +void kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *cons)
> +{
> +}
> +void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
> +{
> +}

Can't we define a common version of these with __attribute__((weak)) so
that archs that don't need them don't need to add this cruft?

> +
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
