From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 10/17] KVM: x86: Update IRTE for posted-interrupts
Date: Fri, 11 Sep 2015 12:29:29 +0200
Message-ID: <55F2AD09.1000009@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
 <1440492620-15934-11-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-11-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> +int kvm_arch_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
> +			    uint32_t guest_irq, bool set)

Please move all of this code to a vmx.c callback instead of adding
get_pi_desc_addr. Check if this makes the pi_set_sn and pi_clear_sn
callbacks superfluous.

Paolo

> +	if (!irq_remapping_cap(IRQ_POSTING_CAP))
> +		return 0;


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
