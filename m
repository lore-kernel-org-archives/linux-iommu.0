From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU is
 blocked
Date: Fri, 27 Mar 2015 16:30:13 -0300
Message-ID: <20150327193013.GA6502@amt.cnet>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-25-git-send-email-feng.wu@intel.com>
 <20150226234048.GA7784@amt.cnet>
 <E959C4978C3B6342920538CF579893F0023F5A98@SHSMSX104.ccr.corp.intel.com>
 <20150304120608.GA26762@amt.cnet>
 <E959C4978C3B6342920538CF579893F002409841@SHSMSX104.ccr.corp.intel.com>
 <20150312011526.GA5878@amt.cnet>
 <E959C4978C3B6342920538CF579893F00243A819@SHSMSX104.ccr.corp.intel.com>
 <20150325231738.GA7333@amt.cnet>
 <E959C4978C3B6342920538CF579893F0024697E0@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F0024697E0@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 27, 2015 at 06:34:14AM +0000, Wu, Feng wrote:
> > > Currently, the following code is executed before local_irq_disable() is called,
> > > so do you mean 1)moving local_irq_disable() to the place before it. 2) after
> > interrupt
> > > is disabled, set KVM_REQ_EVENT in case the ON bit is set?
> > 
> > 2) after interrupt is disabled, set KVM_REQ_EVENT in case the ON bit
> > is set.
> 
> Here is my understanding about your comments here:
> - Disable interrupts
> - Check 'ON'
> - Set KVM_REQ_EVENT if 'ON' is set
> 
> Then we can put the above code inside " if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) "
> just like it used to be. However, I still have some questions about this comment:
> 
> 1. Where should I set KVM_REQ_EVENT? In function vcpu_enter_guest(), or other places?

See below:

> If in vcpu_enter_guest(), since currently local_irq_disable() is called after 'KVM_REQ_EVENT'
> is checked, is it helpful to set KVM_REQ_EVENT after local_irq_disable() is called?

        local_irq_disable();

	*** add code here ***

        if (vcpu->mode == EXITING_GUEST_MODE || vcpu->requests
						^^^^^^^^^^^^^^
            || need_resched() || signal_pending(current)) {
                vcpu->mode = OUTSIDE_GUEST_MODE;
                smp_wmb();
                local_irq_enable();
                preempt_enable();
                vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
                r = 1;
                goto cancel_injection;
        }

> 2. 'ON' is set by VT-d hardware, it can be set even when interrupt is disabled (the related bit in PIR is also set).

Yes, we are checking if the HW has set an interrupt in PIR while
outside VM (which requires PIR->VIRR transfer by software).

If the interrupt it set by hardware after local_irq_disable(), 
VMX-entry will handle the interrupt and perform the PIR->VIRR
transfer and reevaluate interrupts, injecting to guest 
if necessary, is that correct ?

> So does it make sense to check 'ON' and set KVM_REQ_EVENT accordingly after interrupt is disabled?

To replace the costly 

+            */
+           if (kvm_x86_ops->hwapic_irr_update)
+                   kvm_x86_ops->hwapic_irr_update(vcpu,
+                           kvm_lapic_find_highest_irr(vcpu));

Yes, i think so.

> I might miss something in your comments, if so please point out. Thanks a lot!
> 
> Thanks,
> Feng
> 
> > 
> > >
> > > "if (kvm_x86_ops->hwapic_irr_update)
> > > 	kvm_x86_ops->hwapic_irr_update(vcpu,
> > > 			kvm_lapic_find_highest_irr(vcpu));
> > >
> > > > kvm_lapic_find_highest_irr(vcpu) eats some cache
> > > > (4 cachelines) versus 1 cacheline for reading ON bit.
> > > >
> > > > > > > > Please remove blocked and wakeup_cpu, they should not be
> > necessary.
> > > > > > >
> > > > > > > Why do you think wakeup_cpu is not needed, when vCPU is blocked,
> > > > > > > wakeup_cpu saves the cpu which the vCPU is blocked on, after vCPU
> > > > > > > is woken up, it can run on a different cpu, so we need wakeup_cpu to
> > > > > > > find the right list to wake up the vCPU.
> > > > > >
> > > > > > If the vCPU was moved it should have updated IRTE destination field
> > > > > > to the pCPU which it has moved to?
> > > > >
> > > > > Every time a vCPU is scheduled to a new pCPU, the IRTE destination filed
> > > > > would be updated accordingly.
> > > > >
> > > > > When vCPU is blocked. To wake up the blocked vCPU, we need to find
> > which
> > > > > list the vCPU is blocked on, and this is what wakeup_cpu used for?
> > > >
> > > > Right, perhaps prev_vcpu is a better name.
> > >
> > > Do you mean "prev_pcpu"?
> > 
> > Yes.
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
