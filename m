From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 11/17] KVM: Define two weak arch callbacks for irq
	bypass manager
Date: Fri, 11 Sep 2015 12:41:49 +0200
Message-ID: <55F2AFED.5040306@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
	<1440492620-15934-12-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1440492620-15934-12-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
> Define two weak arch callbacks so that archs that don't need
> them don't need define them.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  virt/kvm/eventfd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index d7a230f..f3050b9 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -256,6 +256,16 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
>  	write_seqcount_end(&irqfd->irq_entry_sc);
>  }
>  
> +void __attribute__((weak)) kvm_arch_irq_bypass_stop(
> +				struct irq_bypass_consumer *cons)
> +{
> +}
> +
> +void __attribute__((weak)) kvm_arch_irq_bypass_start(
> +				struct irq_bypass_consumer *cons)
> +{
> +}
> +
>  static int
>  kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  {
> 

This would belong into the patch that adds CONFIG_KVM_HAVE_IRQ_BYPASS
(and the functions should be under "#ifdef CONFIG_KVM_HAVE_IRQ_BYPASS").

Paolo
