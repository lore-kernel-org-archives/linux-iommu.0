From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
	is blocked
Date: Mon, 30 Mar 2015 04:46:55 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002479E58@SHSMSX104.ccr.corp.intel.com>
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
	<20150327193013.GA6502@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150327193013.GA6502-I4X2Mt4zSy4@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Marcelo Tosatti [mailto:mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Saturday, March 28, 2015 3:30 AM
> To: Wu, Feng
> Cc: hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is blocked
> 
> On Fri, Mar 27, 2015 at 06:34:14AM +0000, Wu, Feng wrote:
> > > > Currently, the following code is executed before local_irq_disable() is
> called,
> > > > so do you mean 1)moving local_irq_disable() to the place before it. 2) after
> > > interrupt
> > > > is disabled, set KVM_REQ_EVENT in case the ON bit is set?
> > >
> > > 2) after interrupt is disabled, set KVM_REQ_EVENT in case the ON bit
> > > is set.
> >
> > Here is my understanding about your comments here:
> > - Disable interrupts
> > - Check 'ON'
> > - Set KVM_REQ_EVENT if 'ON' is set
> >
> > Then we can put the above code inside " if
> (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) "
> > just like it used to be. However, I still have some questions about this
> comment:
> >
> > 1. Where should I set KVM_REQ_EVENT? In function vcpu_enter_guest(), or
> other places?
> 
> See below:
> 
> > If in vcpu_enter_guest(), since currently local_irq_disable() is called after
> 'KVM_REQ_EVENT'
> > is checked, is it helpful to set KVM_REQ_EVENT after local_irq_disable() is
> called?
> 
>         local_irq_disable();
> 
> 	*** add code here ***

So we need add code like the following here, right?

          if ('ON' is set)
              kvm_make_request(KVM_REQ_EVENT, vcpu);

> 
>         if (vcpu->mode == EXITING_GUEST_MODE || vcpu->requests
> 						^^^^^^^^^^^^^^
>             || need_resched() || signal_pending(current)) {
>                 vcpu->mode = OUTSIDE_GUEST_MODE;
>                 smp_wmb();
>                 local_irq_enable();
>                 preempt_enable();
>                 vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
>                 r = 1;
>                 goto cancel_injection;
>         }
> 
> > 2. 'ON' is set by VT-d hardware, it can be set even when interrupt is disabled
> (the related bit in PIR is also set).
> 
> Yes, we are checking if the HW has set an interrupt in PIR while
> outside VM (which requires PIR->VIRR transfer by software).
> 
> If the interrupt it set by hardware after local_irq_disable(),
> VMX-entry will handle the interrupt and perform the PIR->VIRR
> transfer and reevaluate interrupts, injecting to guest
> if necessary, is that correct ?
> 
> > So does it make sense to check 'ON' and set KVM_REQ_EVENT accordingly
> after interrupt is disabled?
> 
> To replace the costly
> 
> +            */
> +           if (kvm_x86_ops->hwapic_irr_update)
> +                   kvm_x86_ops->hwapic_irr_update(vcpu,
> +                           kvm_lapic_find_highest_irr(vcpu));
> 
> Yes, i think so.

After adding the "checking ON and setting KVM_REQ_EVENT" operations listed in my
comments above, do you mean we still need to keep the costly code above
inside "if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {}" in function
vcpu_enter_guest() as it used to be? If yes, my question is what is the exact purpose
of "checking ON and setting KVM_REQ_EVENT" operations? Here is the code flow in
vcpu_enter_guest():

1. Check KVM_REQ_EVENT, if it is set, sync pir->virr
2. Disable interrupts
3. Check ON and set KVM_REQ_EVENT -- Here, we set KVM_REQ_EVENT, but it is
checked in the step 1, which means, we cannot get any benefits even we set it here,
since the "pir->virr" sync operation was done in step 1, between step 3 and VM-Entry,
we don't synchronize the pir to virr. So even we set KVM_REQ_EVENT here, the interrupts
remaining in PIR cannot be delivered to guest during this VM-Entry, right?

Thanks,
Feng

> 
> > I might miss something in your comments, if so please point out. Thanks a
> lot!
> >
> > Thanks,
> > Feng
> >
> > >
> > > >
> > > > "if (kvm_x86_ops->hwapic_irr_update)
> > > > 	kvm_x86_ops->hwapic_irr_update(vcpu,
> > > > 			kvm_lapic_find_highest_irr(vcpu));
> > > >
> > > > > kvm_lapic_find_highest_irr(vcpu) eats some cache
> > > > > (4 cachelines) versus 1 cacheline for reading ON bit.
> > > > >
> > > > > > > > > Please remove blocked and wakeup_cpu, they should not be
> > > necessary.
> > > > > > > >
> > > > > > > > Why do you think wakeup_cpu is not needed, when vCPU is
> blocked,
> > > > > > > > wakeup_cpu saves the cpu which the vCPU is blocked on, after
> vCPU
> > > > > > > > is woken up, it can run on a different cpu, so we need wakeup_cpu
> to
> > > > > > > > find the right list to wake up the vCPU.
> > > > > > >
> > > > > > > If the vCPU was moved it should have updated IRTE destination field
> > > > > > > to the pCPU which it has moved to?
> > > > > >
> > > > > > Every time a vCPU is scheduled to a new pCPU, the IRTE destination
> filed
> > > > > > would be updated accordingly.
> > > > > >
> > > > > > When vCPU is blocked. To wake up the blocked vCPU, we need to find
> > > which
> > > > > > list the vCPU is blocked on, and this is what wakeup_cpu used for?
> > > > >
> > > > > Right, perhaps prev_vcpu is a better name.
> > > >
> > > > Do you mean "prev_pcpu"?
> > >
> > > Yes.
> > >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
