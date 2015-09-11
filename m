From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 12/17] KVM: Implement IRQ bypass consumer callbacks for
 x86
Date: Fri, 11 Sep 2015 12:31:52 +0200
Message-ID: <55F2AD98.3050605@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
 <1440492620-15934-13-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-13-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(cons, struct kvm_kernel_irqfd, consumer);
> +
> +	irqfd->producer = prod;

This assignment should be under "if (kvm_x86_ops->update_pi_irte)".

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

And here it should be like:

	if (!kvm_x86_ops->update_pi_irte) {
		WARN_ON(irqfd->producer != NULL);
		return;
	}

	WARN_ON(irqfd->producer != prod);
	irqfd->producer = NULL;

Paolo

> +
