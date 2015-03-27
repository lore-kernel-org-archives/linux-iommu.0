From: "Wu, Feng" <feng.wu@intel.com>
Subject: RE: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
 is blocked
Date: Fri, 27 Mar 2015 06:34:14 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0024697E0@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-25-git-send-email-feng.wu@intel.com>
 <20150226234048.GA7784@amt.cnet>
 <E959C4978C3B6342920538CF579893F0023F5A98@SHSMSX104.ccr.corp.intel.com>
 <20150304120608.GA26762@amt.cnet>
 <E959C4978C3B6342920538CF579893F002409841@SHSMSX104.ccr.corp.intel.com>
 <20150312011526.GA5878@amt.cnet>
 <E959C4978C3B6342920538CF579893F00243A819@SHSMSX104.ccr.corp.intel.com>
 <20150325231738.GA7333@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150325231738.GA7333@amt.cnet>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Wu, Feng" <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Marcelo Tosatti [mailto:mtosatti@redhat.com]
> Sent: Thursday, March 26, 2015 7:18 AM
> To: Wu, Feng; hpa@zytor.com
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org;
> gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> joro@8bytes.org; alex.williamson@redhat.com; jiang.liu@linux.intel.com;
> eric.auger@linaro.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; kvm@vger.kernel.org
> Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is blocked
> 
> On Mon, Mar 16, 2015 at 11:42:06AM +0000, Wu, Feng wrote:
> > > Do you have any reason why having the code at vcpu_put/vcpu_load is
> > > better than the proposal to have the code at kvm_vcpu_block?
> >
> > I think your proposal is good, I just want to better understand your idea
> here.:)
> 
> Reduce the overhead of vcpu sched in / vcpu sched out, basically.
> 
> > One thing, even we put the code to kvm_vcpu_block, we still need to add
> code
> > at vcpu_put/vcpu_load for the preemption case like what I did now.
> >
> > >
> > > >
> > > > Global vector is a limited resources in the system, and this involves
> > > > common x86 interrupt code changes. I am not sure we can allocate
> > > > so many dedicated global vector for KVM usage.
> > >
> > > Why not? Have KVM use all free vectors (so if vectors are necessary for
> > > other purposes, people should shrink the KVM vector pool).
> >
> > If we want to allocate more global vector for this usage, we need hpa's
> > input about it. Peter, what is your opinion?
> 
> Peter?
> 
> > > BTW the Intel docs talk about that ("one vector per vCPU").
> > Yes, the Spec talks about this, but it is more complex using one vector per
> vCPU.
> >
> > >
> > > > > > > It seems there is a bunch free:
> > > > > > >
> > > > > > > commit 52aec3308db85f4e9f5c8b9f5dc4fbd0138c6fa4
> > > > > > > Author: Alex Shi <alex.shi@intel.com>
> > > > > > > Date:   Thu Jun 28 09:02:23 2012 +0800
> > > > > > >
> > > > > > >     x86/tlb: replace INVALIDATE_TLB_VECTOR by
> > > > > CALL_FUNCTION_VECTOR
> > > > > > >
> > > > > > > Can you add only vcpus which have posted IRTEs that point to this
> pCPU
> > > > > > > to the HLT'ed vcpu lists? (so for example, vcpus without assigned
> > > > > > > devices are not part of the list).
> > > > > >
> > > > > > Is it easy to find whether a vCPU (or the associated domain) has
> assigned
> > > > > devices?
> > > > > > If so, we can only add those vCPUs with assigned devices.
> > > > >
> > > > > When configuring IRTE, at kvm_arch_vfio_update_pi_irte?
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > > > > +
> > > > > > > >  static int __init vmx_init(void)
> > > > > > > >  {
> > > > > > > >  	int r, i, msr;
> > > > > > > > @@ -9429,6 +9523,8 @@ static int __init vmx_init(void)
> > > > > > > >
> > > > > > > >  	update_ple_window_actual_max();
> > > > > > > >
> > > > > > > > +	wakeup_handler_callback = wakeup_handler;
> > > > > > > > +
> > > > > > > >  	return 0;
> > > > > > > >
> > > > > > > >  out7:
> > > > > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > > > > index 0033df3..1551a46 100644
> > > > > > > > --- a/arch/x86/kvm/x86.c
> > > > > > > > +++ b/arch/x86/kvm/x86.c
> > > > > > > > @@ -6152,6 +6152,21 @@ static int vcpu_enter_guest(struct
> > > kvm_vcpu
> > > > > > > *vcpu)
> > > > > > > >  			kvm_vcpu_reload_apic_access_page(vcpu);
> > > > > > > >  	}
> > > > > > > >
> > > > > > > > +	/*
> > > > > > > > +	 * Since posted-interrupts can be set by VT-d HW now, in this
> > > > > > > > +	 * case, KVM_REQ_EVENT is not set. We move the following
> > > > > > > > +	 * operations out of the if statement.
> > > > > > > > +	 */
> > > > > > > > +	if (kvm_lapic_enabled(vcpu)) {
> > > > > > > > +		/*
> > > > > > > > +		 * Update architecture specific hints for APIC
> > > > > > > > +		 * virtual interrupt delivery.
> > > > > > > > +		 */
> > > > > > > > +		if (kvm_x86_ops->hwapic_irr_update)
> > > > > > > > +			kvm_x86_ops->hwapic_irr_update(vcpu,
> > > > > > > > +				kvm_lapic_find_highest_irr(vcpu));
> > > > > > > > +	}
> > > > > > > > +
> > > > > > >
> > > > > > > This is a hot fast path. You can set KVM_REQ_EVENT from
> > > wakeup_handler.
> > > > > >
> > > > > > I am afraid Setting KVM_REQ_EVENT from wakeup_handler doesn't
> help
> > > > > much,
> > > > > > if vCPU is running in ROOT mode, and VT-d hardware issues an
> notification
> > > > > event,
> > > > > > POSTED_INTR_VECTOR interrupt handler will be called.
> > > > >
> > > > > If vCPU is in root mode, remapping HW will find IRTE configured with
> > > > > vector == POSTED_INTR_WAKEUP_VECTOR, use that vector, which will
> > > > > VM-exit, and execute the interrupt handler wakeup_handler. Right?
> > > >
> > > > There are two cases:
> > > > Case 1: vCPU is blocked, so it is in root mode, this is what you described
> > > above.
> > > > Case 2, vCPU is running in root mode, such as, handling vm-exits, in this
> case,
> > > > the notification vector is 'POSTED_INTR_VECTOR', and if external
> interrupts
> > > > from assigned devices happen, the handled of 'POSTED_INTR_VECTOR'
> will
> > > > be called ( it is 'smp_kvm_posted_intr_ipi' in fact), this routine doesn't
> need
> > > > do real things, since the pending interrupts in PIR will be synced to vIRR
> > > before
> > > > VM-Entry (this code have already been there when enabling CPU-side
> > > > posted-interrupt along with APICv). Like what I said before, it is a little
> hard
> > > to
> > > > get vCPU related information in it, even if we get, it is not accurate and
> may
> > > harm
> > > > the performance.(need search)
> > > >
> > > > So only setting KVM_REQ_EVENT in wakeup_handler cannot cover the
> > > notification
> > > > event for 'POSTED_INTR_VECTOR'.
> > > >
> > > > >
> > > > > The point of this comment is that you can keep the
> > > > >
> > > > > "if (kvm_x86_ops->hwapic_irr_update)
> > > > > 	kvm_x86_ops->hwapic_irr_update(vcpu,
> > > > > 			kvm_lapic_find_highest_irr(vcpu));
> > > > > "
> > > > >
> > > > > Code inside KVM_REQ_EVENT handling section of vcpu_run, as long as
> > > > > wakeup_handler sets KVM_REQ_EVENT.
> > > >
> > > > Please see above.
> > >
> > > OK can you set KVM_REQ_EVENT in case the ON bit is set,
> > > after disabling interrupts ?
> > >
> > Currently, the following code is executed before local_irq_disable() is called,
> > so do you mean 1)moving local_irq_disable() to the place before it. 2) after
> interrupt
> > is disabled, set KVM_REQ_EVENT in case the ON bit is set?
> 
> 2) after interrupt is disabled, set KVM_REQ_EVENT in case the ON bit
> is set.

Here is my understanding about your comments here:
- Disable interrupts
- Check 'ON'
- Set KVM_REQ_EVENT if 'ON' is set

Then we can put the above code inside " if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) "
just like it used to be. However, I still have some questions about this comment:

1. Where should I set KVM_REQ_EVENT? In function vcpu_enter_guest(), or other places?
If in vcpu_enter_guest(), since currently local_irq_disable() is called after 'KVM_REQ_EVENT'
is checked, is it helpful to set KVM_REQ_EVENT after local_irq_disable() is called?
2. 'ON' is set by VT-d hardware, it can be set even when interrupt is disabled (the related bit in PIR is also set).
So does it make sense to check 'ON' and set KVM_REQ_EVENT accordingly after interrupt is disabled?

I might miss something in your comments, if so please point out. Thanks a lot!

Thanks,
Feng

> 
> >
> > "if (kvm_x86_ops->hwapic_irr_update)
> > 	kvm_x86_ops->hwapic_irr_update(vcpu,
> > 			kvm_lapic_find_highest_irr(vcpu));
> >
> > > kvm_lapic_find_highest_irr(vcpu) eats some cache
> > > (4 cachelines) versus 1 cacheline for reading ON bit.
> > >
> > > > > > > Please remove blocked and wakeup_cpu, they should not be
> necessary.
> > > > > >
> > > > > > Why do you think wakeup_cpu is not needed, when vCPU is blocked,
> > > > > > wakeup_cpu saves the cpu which the vCPU is blocked on, after vCPU
> > > > > > is woken up, it can run on a different cpu, so we need wakeup_cpu to
> > > > > > find the right list to wake up the vCPU.
> > > > >
> > > > > If the vCPU was moved it should have updated IRTE destination field
> > > > > to the pCPU which it has moved to?
> > > >
> > > > Every time a vCPU is scheduled to a new pCPU, the IRTE destination filed
> > > > would be updated accordingly.
> > > >
> > > > When vCPU is blocked. To wake up the blocked vCPU, we need to find
> which
> > > > list the vCPU is blocked on, and this is what wakeup_cpu used for?
> > >
> > > Right, perhaps prev_vcpu is a better name.
> >
> > Do you mean "prev_pcpu"?
> 
> Yes.
> 
