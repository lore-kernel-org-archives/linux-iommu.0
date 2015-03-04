From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU is
 blocked
Date: Wed, 4 Mar 2015 09:06:08 -0300
Message-ID: <20150304120608.GA26762@amt.cnet>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-25-git-send-email-feng.wu@intel.com>
 <20150226234048.GA7784@amt.cnet>
 <E959C4978C3B6342920538CF579893F0023F5A98@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F0023F5A98@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 02, 2015 at 01:36:51PM +0000, Wu, Feng wrote:
> 
> 
> > -----Original Message-----
> > From: Marcelo Tosatti [mailto:mtosatti@redhat.com]
> > Sent: Friday, February 27, 2015 7:41 AM
> > To: Wu, Feng
> > Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org;
> > gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> > joro@8bytes.org; alex.williamson@redhat.com; jiang.liu@linux.intel.com;
> > eric.auger@linaro.org; linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org; kvm@vger.kernel.org
> > Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> > is blocked
> > 
> > On Fri, Dec 12, 2014 at 11:14:58PM +0800, Feng Wu wrote:
> > > This patch updates the Posted-Interrupts Descriptor when vCPU
> > > is blocked.
> > >
> > > pre-block:
> > > - Add the vCPU to the blocked per-CPU list
> > > - Clear 'SN'
> > > - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> > >
> > > post-block:
> > > - Remove the vCPU from the per-CPU list
> > >
> > > Signed-off-by: Feng Wu <feng.wu@intel.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h |  2 +
> > >  arch/x86/kvm/vmx.c              | 96
> > +++++++++++++++++++++++++++++++++++++++++
> > >  arch/x86/kvm/x86.c              | 22 +++++++---
> > >  include/linux/kvm_host.h        |  4 ++
> > >  virt/kvm/kvm_main.c             |  6 +++
> > >  5 files changed, 123 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/kvm_host.h
> > b/arch/x86/include/asm/kvm_host.h
> > > index 13e3e40..32c110a 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -101,6 +101,8 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t
> > base_gfn, int level)
> > >
> > >  #define ASYNC_PF_PER_VCPU 64
> > >
> > > +extern void (*wakeup_handler_callback)(void);
> > > +
> > >  enum kvm_reg {
> > >  	VCPU_REGS_RAX = 0,
> > >  	VCPU_REGS_RCX = 1,
> > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > index bf2e6cd..a1c83a2 100644
> > > --- a/arch/x86/kvm/vmx.c
> > > +++ b/arch/x86/kvm/vmx.c
> > > @@ -832,6 +832,13 @@ static DEFINE_PER_CPU(struct vmcs *,
> > current_vmcs);
> > >  static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
> > >  static DEFINE_PER_CPU(struct desc_ptr, host_gdt);
> > >
> > > +/*
> > > + * We maintian a per-CPU linked-list of vCPU, so in wakeup_handler() we
> > > + * can find which vCPU should be waken up.
> > > + */
> > > +static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
> > > +static DEFINE_PER_CPU(spinlock_t, blocked_vcpu_on_cpu_lock);
> > > +
> > >  static unsigned long *vmx_io_bitmap_a;
> > >  static unsigned long *vmx_io_bitmap_b;
> > >  static unsigned long *vmx_msr_bitmap_legacy;
> > > @@ -1921,6 +1928,7 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu,
> > int cpu)
> > >  		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > >  		struct pi_desc old, new;
> > >  		unsigned int dest;
> > > +		unsigned long flags;
> > >
> > >  		memset(&old, 0, sizeof(old));
> > >  		memset(&new, 0, sizeof(new));
> > > @@ -1942,6 +1950,20 @@ static void vmx_vcpu_load(struct kvm_vcpu
> > *vcpu, int cpu)
> > >  			new.nv = POSTED_INTR_VECTOR;
> > >  		} while (cmpxchg(&pi_desc->control, old.control,
> > >  				new.control) != old.control);
> > > +
> > > +		/*
> > > +		 * Delete the vCPU from the related wakeup queue
> > > +		 * if we are resuming from blocked state
> > > +		 */
> > > +		if (vcpu->blocked) {
> > > +			vcpu->blocked = false;
> > > +			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
> > > +				vcpu->wakeup_cpu), flags);
> > > +			list_del(&vcpu->blocked_vcpu_list);
> > > +			spin_unlock_irqrestore(&per_cpu(blocked_vcpu_on_cpu_lock,
> > > +				vcpu->wakeup_cpu), flags);
> > > +			vcpu->wakeup_cpu = -1;
> > > +		}
> > >  	}
> > >  }
> > >
> > > @@ -1950,6 +1972,9 @@ static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
> > >  	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
> > >  		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > >  		struct pi_desc old, new;
> > > +		unsigned long flags;
> > > +		int cpu;
> > > +		struct cpumask cpu_others_mask;
> > >
> > >  		memset(&old, 0, sizeof(old));
> > >  		memset(&new, 0, sizeof(new));
> > > @@ -1961,6 +1986,54 @@ static void vmx_vcpu_put(struct kvm_vcpu
> > *vcpu)
> > >  				pi_set_sn(&new);
> > >  			} while (cmpxchg(&pi_desc->control, old.control,
> > >  					new.control) != old.control);
> > > +		} else if (vcpu->blocked) {
> > > +			/*
> > > +			 * The vcpu is blocked on the wait queue.
> > > +			 * Store the blocked vCPU on the list of the
> > > +			 * vcpu->wakeup_cpu, which is the destination
> > > +			 * of the wake-up notification event.
> > > +			 */
> > > +			vcpu->wakeup_cpu = vcpu->cpu;
> > > +			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
> > > +					  vcpu->wakeup_cpu), flags);
> > > +			list_add_tail(&vcpu->blocked_vcpu_list,
> > > +				      &per_cpu(blocked_vcpu_on_cpu,
> > > +				      vcpu->wakeup_cpu));
> > > +			spin_unlock_irqrestore(
> > > +					&per_cpu(blocked_vcpu_on_cpu_lock,
> > > +					vcpu->wakeup_cpu), flags);
> > > +
> > > +			do {
> > > +				old.control = new.control = pi_desc->control;
> > > +
> > > +				/*
> > > +				 * We should not block the vCPU if
> > > +				 * an interrupt is posted for it.
> > > +				 */
> > > +				if (pi_test_on(pi_desc) == 1) {
> > > +					/*
> > > +					 * We need schedule the wakeup worker
> > > +					 * on a different cpu other than
> > > +					 * vcpu->cpu, because in some case,
> > > +					 * schedule_work() will call
> > > +					 * try_to_wake_up() which needs acquire
> > > +					 * the rq lock. This can cause deadlock.
> > > +					 */
> > > +					cpumask_copy(&cpu_others_mask,
> > > +						     cpu_online_mask);
> > > +					cpu_clear(vcpu->cpu, cpu_others_mask);
> > > +					cpu = any_online_cpu(cpu_others_mask);
> > > +
> > > +					schedule_work_on(cpu,
> > > +							 &vcpu->wakeup_worker);
> > > +				}
> > > +
> > > +				pi_clear_sn(&new);
> > > +
> > > +				/* set 'NV' to 'wakeup vector' */
> > > +				new.nv = POSTED_INTR_WAKEUP_VECTOR;
> > > +			} while (cmpxchg(&pi_desc->control, old.control,
> > > +				new.control) != old.control);
> > >  		}
> > 
> > This can be done exclusively on HLT emulation, correct? (that is, on
> > entry to HLT and exit from HLT).
> 
> Do you mean the following?
> In kvm_emulate_halt(), we do:
> 1. Add vCPU in the blocking list
> 2. Clear 'SN'
> 3. set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> 
> In __vcpu_run(), after kvm_vcpu_block(), we remove the vCPU from the
> Bloc king list.

Yes (please check its OK to do this...).

> > If the vcpu is scheduled out for any other reason (transition to
> > userspace or transition to other thread), it will eventually resume
> > execution. And in that case, continuation of execution does not depend
> > on the event (VT-d interrupt) notification.
> 
> Yes, I think this is true for my current implementation, right?
> 
> > 
> > There is a race window with the code above, I believe.
> 
> I did careful code review back and forth for the above code, It will
> be highly appreciated if you can point out the race window!

So the remapping HW sees either POSTED_INTR_VECTOR or 
POSTED_INTR_WAKEUP_VECTOR.

You should:

1. Set POSTED_INTR_WAKEUP_VECTOR.
2. Check for PIR / ON bit, which might have been set by
POSTED_INTR_VECTOR notification.
3. emulate HLT.

> > >  	} 
> > >
> > > @@ -2842,6 +2915,8 @@ static int hardware_enable(void)
> > >  		return -EBUSY;
> > >
> > >  	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> > > +	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> > > +	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > >
> > >  	/*
> > >  	 * Now we can enable the vmclear operation in kdump
> > > @@ -9315,6 +9390,25 @@ static struct kvm_x86_ops vmx_x86_ops = {
> > >  	.pi_set_sn = vmx_pi_set_sn,
> > >  };
> > >
> > > +/*
> > > + * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
> > > + */
> > > +void wakeup_handler(void)
> > > +{
> > > +	struct kvm_vcpu *vcpu;
> > > +	int cpu = smp_processor_id();
> > > +
> > > +	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > +	list_for_each_entry(vcpu, &per_cpu(blocked_vcpu_on_cpu, cpu),
> > > +			blocked_vcpu_list) {
> > > +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > > +
> > > +		if (pi_test_on(pi_desc) == 1)
> > > +			kvm_vcpu_kick(vcpu);
> > > +	}
> > > +	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > +}
> > 
> > Looping through all blocked vcpus does not scale:
> > Can you allocate more vectors and then multiplex those
> > vectors amongst the HLT'ed vcpus?
> 
> I am a little confused about this, can you elaborate it a bit more?
> Thanks a lot!

Picture the following overcommitment scenario:

* High ratio of vCPUs/pCPUs, in the ratio 128/1 (this is exaggerated
to demonstrate the issue).
* Every VT-d interrupt is going to scan 128 entries in the list.

Moreover, the test:

		if (pi_test_on(pi_desc) == 1)
			kvm_vcpu_kick(vcpu);

Can trigger for vCPUs which have not been waken up due 
to VT-d interrupts, but for other interrupts.

You can allocate, say 16 vectors on the pCPU for VT-d interrupts:

POSTED_INTERRUPT_WAKEUP_VECTOR_1, POSTED_INTERRUPT_WAKEUP_VECTOR_2,
...

> > It seems there is a bunch free:
> > 
> > commit 52aec3308db85f4e9f5c8b9f5dc4fbd0138c6fa4
> > Author: Alex Shi <alex.shi@intel.com>
> > Date:   Thu Jun 28 09:02:23 2012 +0800
> > 
> >     x86/tlb: replace INVALIDATE_TLB_VECTOR by CALL_FUNCTION_VECTOR
> > 
> > Can you add only vcpus which have posted IRTEs that point to this pCPU
> > to the HLT'ed vcpu lists? (so for example, vcpus without assigned
> > devices are not part of the list).
> 
> Is it easy to find whether a vCPU (or the associated domain) has assigned devices?
> If so, we can only add those vCPUs with assigned devices.

When configuring IRTE, at kvm_arch_vfio_update_pi_irte?

> > > +
> > >  static int __init vmx_init(void)
> > >  {
> > >  	int r, i, msr;
> > > @@ -9429,6 +9523,8 @@ static int __init vmx_init(void)
> > >
> > >  	update_ple_window_actual_max();
> > >
> > > +	wakeup_handler_callback = wakeup_handler;
> > > +
> > >  	return 0;
> > >
> > >  out7:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 0033df3..1551a46 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -6152,6 +6152,21 @@ static int vcpu_enter_guest(struct kvm_vcpu
> > *vcpu)
> > >  			kvm_vcpu_reload_apic_access_page(vcpu);
> > >  	}
> > >
> > > +	/*
> > > +	 * Since posted-interrupts can be set by VT-d HW now, in this
> > > +	 * case, KVM_REQ_EVENT is not set. We move the following
> > > +	 * operations out of the if statement.
> > > +	 */
> > > +	if (kvm_lapic_enabled(vcpu)) {
> > > +		/*
> > > +		 * Update architecture specific hints for APIC
> > > +		 * virtual interrupt delivery.
> > > +		 */
> > > +		if (kvm_x86_ops->hwapic_irr_update)
> > > +			kvm_x86_ops->hwapic_irr_update(vcpu,
> > > +				kvm_lapic_find_highest_irr(vcpu));
> > > +	}
> > > +
> > 
> > This is a hot fast path. You can set KVM_REQ_EVENT from wakeup_handler.
> 
> I am afraid Setting KVM_REQ_EVENT from wakeup_handler doesn't help much,
> if vCPU is running in ROOT mode, and VT-d hardware issues an notification event,
> POSTED_INTR_VECTOR interrupt handler will be called.

If vCPU is in root mode, remapping HW will find IRTE configured with
vector == POSTED_INTR_WAKEUP_VECTOR, use that vector, which will
VM-exit, and execute the interrupt handler wakeup_handler. Right?

The point of this comment is that you can keep the 

"if (kvm_x86_ops->hwapic_irr_update)
	kvm_x86_ops->hwapic_irr_update(vcpu,
			kvm_lapic_find_highest_irr(vcpu));
"

Code inside KVM_REQ_EVENT handling section of vcpu_run, as long as
wakeup_handler sets KVM_REQ_EVENT.

> Again, POSTED_INTR_VECTOR interrupt handler may be called very frequently,
> it is a little hard to get vCPU related information in it, even if we get, it is not
> accurate and may harm the performance.(need search)
> 
> > 
> > >  	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
> > >  		kvm_apic_accept_events(vcpu);
> > >  		if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED) {
> > > @@ -6168,13 +6183,6 @@ static int vcpu_enter_guest(struct kvm_vcpu
> > *vcpu)
> > >  			kvm_x86_ops->enable_irq_window(vcpu);
> > >
> > >  		if (kvm_lapic_enabled(vcpu)) {
> > > -			/*
> > > -			 * Update architecture specific hints for APIC
> > > -			 * virtual interrupt delivery.
> > > -			 */
> > > -			if (kvm_x86_ops->hwapic_irr_update)
> > > -				kvm_x86_ops->hwapic_irr_update(vcpu,
> > > -					kvm_lapic_find_highest_irr(vcpu));
> > >  			update_cr8_intercept(vcpu);
> > >  			kvm_lapic_sync_to_vapic(vcpu);
> > >  		}
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index 3d7242c..d981d16 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -239,6 +239,9 @@ struct kvm_vcpu {
> > >  	unsigned long requests;
> > >  	unsigned long guest_debug;
> > >
> > > +	int wakeup_cpu;
> > > +	struct list_head blocked_vcpu_list;
> > > +
> > >  	struct mutex mutex;
> > >  	struct kvm_run *run;
> > >
> > > @@ -282,6 +285,7 @@ struct kvm_vcpu {
> > >  	} spin_loop;
> > >  #endif
> > >  	bool preempted;
> > > +	bool blocked;
> > >  	struct kvm_vcpu_arch arch;
> > >  };
> > 
> > Please remove blocked and wakeup_cpu, they should not be necessary.
> 
> Why do you think wakeup_cpu is not needed, when vCPU is blocked, 
> wakeup_cpu saves the cpu which the vCPU is blocked on, after vCPU
> is woken up, it can run on a different cpu, so we need wakeup_cpu to
> find the right list to wake up the vCPU.

If the vCPU was moved it should have updated IRTE destination field
to the pCPU which it has moved to?
