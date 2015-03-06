From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
	is blocked
Date: Fri, 6 Mar 2015 06:51:52 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002409841@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-25-git-send-email-feng.wu@intel.com>
	<20150226234048.GA7784@amt.cnet>
	<E959C4978C3B6342920538CF579893F0023F5A98@SHSMSX104.ccr.corp.intel.com>
	<20150304120608.GA26762@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150304120608.GA26762-I4X2Mt4zSy4@public.gmane.org>
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
> Sent: Wednesday, March 04, 2015 8:06 PM
> To: Wu, Feng
> Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is blocked
> 
> On Mon, Mar 02, 2015 at 01:36:51PM +0000, Wu, Feng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Marcelo Tosatti [mailto:mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > > Sent: Friday, February 27, 2015 7:41 AM
> > > To: Wu, Feng
> > > Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org;
> x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> > > gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> > > joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> > > eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when
> vCPU
> > > is blocked
> > >
> > > On Fri, Dec 12, 2014 at 11:14:58PM +0800, Feng Wu wrote:
> > > > This patch updates the Posted-Interrupts Descriptor when vCPU
> > > > is blocked.
> > > >
> > > > pre-block:
> > > > - Add the vCPU to the blocked per-CPU list
> > > > - Clear 'SN'
> > > > - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> > > >
> > > > post-block:
> > > > - Remove the vCPU from the per-CPU list
> > > >
> > > > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > >  arch/x86/include/asm/kvm_host.h |  2 +
> > > >  arch/x86/kvm/vmx.c              | 96
> > > +++++++++++++++++++++++++++++++++++++++++
> > > >  arch/x86/kvm/x86.c              | 22 +++++++---
> > > >  include/linux/kvm_host.h        |  4 ++
> > > >  virt/kvm/kvm_main.c             |  6 +++
> > > >  5 files changed, 123 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/kvm_host.h
> > > b/arch/x86/include/asm/kvm_host.h
> > > > index 13e3e40..32c110a 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -101,6 +101,8 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t
> > > base_gfn, int level)
> > > >
> > > >  #define ASYNC_PF_PER_VCPU 64
> > > >
> > > > +extern void (*wakeup_handler_callback)(void);
> > > > +
> > > >  enum kvm_reg {
> > > >  	VCPU_REGS_RAX = 0,
> > > >  	VCPU_REGS_RCX = 1,
> > > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > > index bf2e6cd..a1c83a2 100644
> > > > --- a/arch/x86/kvm/vmx.c
> > > > +++ b/arch/x86/kvm/vmx.c
> > > > @@ -832,6 +832,13 @@ static DEFINE_PER_CPU(struct vmcs *,
> > > current_vmcs);
> > > >  static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
> > > >  static DEFINE_PER_CPU(struct desc_ptr, host_gdt);
> > > >
> > > > +/*
> > > > + * We maintian a per-CPU linked-list of vCPU, so in wakeup_handler() we
> > > > + * can find which vCPU should be waken up.
> > > > + */
> > > > +static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
> > > > +static DEFINE_PER_CPU(spinlock_t, blocked_vcpu_on_cpu_lock);
> > > > +
> > > >  static unsigned long *vmx_io_bitmap_a;
> > > >  static unsigned long *vmx_io_bitmap_b;
> > > >  static unsigned long *vmx_msr_bitmap_legacy;
> > > > @@ -1921,6 +1928,7 @@ static void vmx_vcpu_load(struct kvm_vcpu
> *vcpu,
> > > int cpu)
> > > >  		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > > >  		struct pi_desc old, new;
> > > >  		unsigned int dest;
> > > > +		unsigned long flags;
> > > >
> > > >  		memset(&old, 0, sizeof(old));
> > > >  		memset(&new, 0, sizeof(new));
> > > > @@ -1942,6 +1950,20 @@ static void vmx_vcpu_load(struct kvm_vcpu
> > > *vcpu, int cpu)
> > > >  			new.nv = POSTED_INTR_VECTOR;
> > > >  		} while (cmpxchg(&pi_desc->control, old.control,
> > > >  				new.control) != old.control);
> > > > +
> > > > +		/*
> > > > +		 * Delete the vCPU from the related wakeup queue
> > > > +		 * if we are resuming from blocked state
> > > > +		 */
> > > > +		if (vcpu->blocked) {
> > > > +			vcpu->blocked = false;
> > > > +			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
> > > > +				vcpu->wakeup_cpu), flags);
> > > > +			list_del(&vcpu->blocked_vcpu_list);
> > > > +
> 	spin_unlock_irqrestore(&per_cpu(blocked_vcpu_on_cpu_lock,
> > > > +				vcpu->wakeup_cpu), flags);
> > > > +			vcpu->wakeup_cpu = -1;
> > > > +		}
> > > >  	}
> > > >  }
> > > >
> > > > @@ -1950,6 +1972,9 @@ static void vmx_vcpu_put(struct kvm_vcpu
> *vcpu)
> > > >  	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
> > > >  		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > > >  		struct pi_desc old, new;
> > > > +		unsigned long flags;
> > > > +		int cpu;
> > > > +		struct cpumask cpu_others_mask;
> > > >
> > > >  		memset(&old, 0, sizeof(old));
> > > >  		memset(&new, 0, sizeof(new));
> > > > @@ -1961,6 +1986,54 @@ static void vmx_vcpu_put(struct kvm_vcpu
> > > *vcpu)
> > > >  				pi_set_sn(&new);
> > > >  			} while (cmpxchg(&pi_desc->control, old.control,
> > > >  					new.control) != old.control);
> > > > +		} else if (vcpu->blocked) {
> > > > +			/*
> > > > +			 * The vcpu is blocked on the wait queue.
> > > > +			 * Store the blocked vCPU on the list of the
> > > > +			 * vcpu->wakeup_cpu, which is the destination
> > > > +			 * of the wake-up notification event.
> > > > +			 */
> > > > +			vcpu->wakeup_cpu = vcpu->cpu;
> > > > +			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
> > > > +					  vcpu->wakeup_cpu), flags);
> > > > +			list_add_tail(&vcpu->blocked_vcpu_list,
> > > > +				      &per_cpu(blocked_vcpu_on_cpu,
> > > > +				      vcpu->wakeup_cpu));
> > > > +			spin_unlock_irqrestore(
> > > > +					&per_cpu(blocked_vcpu_on_cpu_lock,
> > > > +					vcpu->wakeup_cpu), flags);
> > > > +
> > > > +			do {
> > > > +				old.control = new.control = pi_desc->control;
> > > > +
> > > > +				/*
> > > > +				 * We should not block the vCPU if
> > > > +				 * an interrupt is posted for it.
> > > > +				 */
> > > > +				if (pi_test_on(pi_desc) == 1) {
> > > > +					/*
> > > > +					 * We need schedule the wakeup worker
> > > > +					 * on a different cpu other than
> > > > +					 * vcpu->cpu, because in some case,
> > > > +					 * schedule_work() will call
> > > > +					 * try_to_wake_up() which needs acquire
> > > > +					 * the rq lock. This can cause deadlock.
> > > > +					 */
> > > > +					cpumask_copy(&cpu_others_mask,
> > > > +						     cpu_online_mask);
> > > > +					cpu_clear(vcpu->cpu, cpu_others_mask);
> > > > +					cpu = any_online_cpu(cpu_others_mask);
> > > > +
> > > > +					schedule_work_on(cpu,
> > > > +							 &vcpu->wakeup_worker);
> > > > +				}
> > > > +
> > > > +				pi_clear_sn(&new);
> > > > +
> > > > +				/* set 'NV' to 'wakeup vector' */
> > > > +				new.nv = POSTED_INTR_WAKEUP_VECTOR;
> > > > +			} while (cmpxchg(&pi_desc->control, old.control,
> > > > +				new.control) != old.control);
> > > >  		}
> > >
> > > This can be done exclusively on HLT emulation, correct? (that is, on
> > > entry to HLT and exit from HLT).
> >
> > Do you mean the following?
> > In kvm_emulate_halt(), we do:
> > 1. Add vCPU in the blocking list
> > 2. Clear 'SN'
> > 3. set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> >
> > In __vcpu_run(), after kvm_vcpu_block(), we remove the vCPU from the
> > Bloc king list.
> 
> Yes (please check its OK to do this...).

I think about this for some time, and I feel this may be another solution
to implement it. Do you mind sharing your ideas about why do you think
this alternative is better than the current one? Thanks a lot!

> 
> > > If the vcpu is scheduled out for any other reason (transition to
> > > userspace or transition to other thread), it will eventually resume
> > > execution. And in that case, continuation of execution does not depend
> > > on the event (VT-d interrupt) notification.
> >
> > Yes, I think this is true for my current implementation, right?
> >
> > >
> > > There is a race window with the code above, I believe.
> >
> > I did careful code review back and forth for the above code, It will
> > be highly appreciated if you can point out the race window!
> 
> So the remapping HW sees either POSTED_INTR_VECTOR or
> POSTED_INTR_WAKEUP_VECTOR.
> 
> You should:
> 
> 1. Set POSTED_INTR_WAKEUP_VECTOR.
> 2. Check for PIR / ON bit, which might have been set by
> POSTED_INTR_VECTOR notification.
> 3. emulate HLT.

My original idea for pre-block operation is:
1. Add vCPU to the per-cpu blocking list. Here is the code for this in my patch:
+                       vcpu->wakeup_cpu = vcpu->cpu;
+                       spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
+                                         vcpu->wakeup_cpu), flags);
+                       list_add_tail(&vcpu->blocked_vcpu_list,
+                                     &per_cpu(blocked_vcpu_on_cpu,
+                                     vcpu->wakeup_cpu));
+                       spin_unlock_irqrestore(
+                                       &per_cpu(blocked_vcpu_on_cpu_lock,
+                                       vcpu->wakeup_cpu), flags);
2. Update Posted-interrupt descriptor, here is the code in my patch:
+                       do {
+                               old.control = new.control = pi_desc->control;
+
+                               /*
+                                * We should not block the vCPU if
+                                * an interrupt is posted for it.
+                                */
+                               if (pi_test_on(pi_desc) == 1) {
+                                       /*
+                                        * We need schedule the wakeup worker
+                                        * on a different cpu other than
+                                        * vcpu->cpu, because in some case,
+                                        * schedule_work() will call
+                                        * try_to_wake_up() which needs acquire
+                                        * the rq lock. This can cause deadlock.
+                                        */
+                                       cpumask_copy(&cpu_others_mask,
+                                                    cpu_online_mask);
+                                       cpu_clear(vcpu->cpu, cpu_others_mask);
+                                       cpu = any_online_cpu(cpu_others_mask);
+
+                                       schedule_work_on(cpu,
+                                                        &vcpu->wakeup_worker);
+                               }
+
+                               WARN((pi_desc->sn == 1),
+                                    "Warning: SN field of posted-interrupts "
+                                    "is set before blocking\n");
+
+                               /* set 'NV' to 'wakeup vector' */
+                               new.nv = POSTED_INTR_WAKEUP_VECTOR;
+                       } while (cmpxchg(&pi_desc->control, old.control,
+                               new.control) != old.control);

If PIR/ON bit is set by POSTED_INTR_VECTOR notification during the above operation, we will stop
blocking the vCPU like about. But seems I missed something in the above code which should be in
my mind from the beginning, I should add a 'break' in the end the above ' if (pi_test_on(pi_desc) == 1) {}',
so in this case, the 'NV' filed remains unchanged.

> 
> > > >  	}
> > > >
> > > > @@ -2842,6 +2915,8 @@ static int hardware_enable(void)
> > > >  		return -EBUSY;
> > > >
> > > >  	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
> > > > +	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
> > > > +	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > >
> > > >  	/*
> > > >  	 * Now we can enable the vmclear operation in kdump
> > > > @@ -9315,6 +9390,25 @@ static struct kvm_x86_ops vmx_x86_ops = {
> > > >  	.pi_set_sn = vmx_pi_set_sn,
> > > >  };
> > > >
> > > > +/*
> > > > + * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
> > > > + */
> > > > +void wakeup_handler(void)
> > > > +{
> > > > +	struct kvm_vcpu *vcpu;
> > > > +	int cpu = smp_processor_id();
> > > > +
> > > > +	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > > +	list_for_each_entry(vcpu, &per_cpu(blocked_vcpu_on_cpu, cpu),
> > > > +			blocked_vcpu_list) {
> > > > +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > > > +
> > > > +		if (pi_test_on(pi_desc) == 1)
> > > > +			kvm_vcpu_kick(vcpu);
> > > > +	}
> > > > +	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> > > > +}
> > >
> > > Looping through all blocked vcpus does not scale:
> > > Can you allocate more vectors and then multiplex those
> > > vectors amongst the HLT'ed vcpus?
> >
> > I am a little confused about this, can you elaborate it a bit more?
> > Thanks a lot!
> 
> Picture the following overcommitment scenario:
> 
> * High ratio of vCPUs/pCPUs, in the ratio 128/1 (this is exaggerated
> to demonstrate the issue).
> * Every VT-d interrupt is going to scan 128 entries in the list.
> 
> Moreover, the test:
> 
> 		if (pi_test_on(pi_desc) == 1)
> 			kvm_vcpu_kick(vcpu);
> 
> Can trigger for vCPUs which have not been waken up due
> to VT-d interrupts, but for other interrupts.
> 
> You can allocate, say 16 vectors on the pCPU for VT-d interrupts:
> 
> POSTED_INTERRUPT_WAKEUP_VECTOR_1,
> POSTED_INTERRUPT_WAKEUP_VECTOR_2,
> ...
> 

Global vector is a limited resources in the system, and this involves
common x86 interrupt code changes. I am not sure we can allocate
so many dedicated global vector for KVM usage.

> > > It seems there is a bunch free:
> > >
> > > commit 52aec3308db85f4e9f5c8b9f5dc4fbd0138c6fa4
> > > Author: Alex Shi <alex.shi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Date:   Thu Jun 28 09:02:23 2012 +0800
> > >
> > >     x86/tlb: replace INVALIDATE_TLB_VECTOR by
> CALL_FUNCTION_VECTOR
> > >
> > > Can you add only vcpus which have posted IRTEs that point to this pCPU
> > > to the HLT'ed vcpu lists? (so for example, vcpus without assigned
> > > devices are not part of the list).
> >
> > Is it easy to find whether a vCPU (or the associated domain) has assigned
> devices?
> > If so, we can only add those vCPUs with assigned devices.
> 
> When configuring IRTE, at kvm_arch_vfio_update_pi_irte?

Yes.

> 
> > > > +
> > > >  static int __init vmx_init(void)
> > > >  {
> > > >  	int r, i, msr;
> > > > @@ -9429,6 +9523,8 @@ static int __init vmx_init(void)
> > > >
> > > >  	update_ple_window_actual_max();
> > > >
> > > > +	wakeup_handler_callback = wakeup_handler;
> > > > +
> > > >  	return 0;
> > > >
> > > >  out7:
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index 0033df3..1551a46 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -6152,6 +6152,21 @@ static int vcpu_enter_guest(struct kvm_vcpu
> > > *vcpu)
> > > >  			kvm_vcpu_reload_apic_access_page(vcpu);
> > > >  	}
> > > >
> > > > +	/*
> > > > +	 * Since posted-interrupts can be set by VT-d HW now, in this
> > > > +	 * case, KVM_REQ_EVENT is not set. We move the following
> > > > +	 * operations out of the if statement.
> > > > +	 */
> > > > +	if (kvm_lapic_enabled(vcpu)) {
> > > > +		/*
> > > > +		 * Update architecture specific hints for APIC
> > > > +		 * virtual interrupt delivery.
> > > > +		 */
> > > > +		if (kvm_x86_ops->hwapic_irr_update)
> > > > +			kvm_x86_ops->hwapic_irr_update(vcpu,
> > > > +				kvm_lapic_find_highest_irr(vcpu));
> > > > +	}
> > > > +
> > >
> > > This is a hot fast path. You can set KVM_REQ_EVENT from wakeup_handler.
> >
> > I am afraid Setting KVM_REQ_EVENT from wakeup_handler doesn't help
> much,
> > if vCPU is running in ROOT mode, and VT-d hardware issues an notification
> event,
> > POSTED_INTR_VECTOR interrupt handler will be called.
> 
> If vCPU is in root mode, remapping HW will find IRTE configured with
> vector == POSTED_INTR_WAKEUP_VECTOR, use that vector, which will
> VM-exit, and execute the interrupt handler wakeup_handler. Right?

There are two cases:
Case 1: vCPU is blocked, so it is in root mode, this is what you described above.
Case 2, vCPU is running in root mode, such as, handling vm-exits, in this case,
the notification vector is 'POSTED_INTR_VECTOR', and if external interrupts
from assigned devices happen, the handled of 'POSTED_INTR_VECTOR' will
be called ( it is 'smp_kvm_posted_intr_ipi' in fact), this routine doesn't need
do real things, since the pending interrupts in PIR will be synced to vIRR before
VM-Entry (this code have already been there when enabling CPU-side
posted-interrupt along with APICv). Like what I said before, it is a little hard to
get vCPU related information in it, even if we get, it is not accurate and may harm
the performance.(need search)

So only setting KVM_REQ_EVENT in wakeup_handler cannot cover the notification
event for 'POSTED_INTR_VECTOR'.

> 
> The point of this comment is that you can keep the
> 
> "if (kvm_x86_ops->hwapic_irr_update)
> 	kvm_x86_ops->hwapic_irr_update(vcpu,
> 			kvm_lapic_find_highest_irr(vcpu));
> "
> 
> Code inside KVM_REQ_EVENT handling section of vcpu_run, as long as
> wakeup_handler sets KVM_REQ_EVENT.

Please see above.

> 
> > Again, POSTED_INTR_VECTOR interrupt handler may be called very
> frequently,
> > it is a little hard to get vCPU related information in it, even if we get, it is not
> > accurate and may harm the performance.(need search)
> >
> > >
> > > >  	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
> > > >  		kvm_apic_accept_events(vcpu);
> > > >  		if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED) {
> > > > @@ -6168,13 +6183,6 @@ static int vcpu_enter_guest(struct kvm_vcpu
> > > *vcpu)
> > > >  			kvm_x86_ops->enable_irq_window(vcpu);
> > > >
> > > >  		if (kvm_lapic_enabled(vcpu)) {
> > > > -			/*
> > > > -			 * Update architecture specific hints for APIC
> > > > -			 * virtual interrupt delivery.
> > > > -			 */
> > > > -			if (kvm_x86_ops->hwapic_irr_update)
> > > > -				kvm_x86_ops->hwapic_irr_update(vcpu,
> > > > -					kvm_lapic_find_highest_irr(vcpu));
> > > >  			update_cr8_intercept(vcpu);
> > > >  			kvm_lapic_sync_to_vapic(vcpu);
> > > >  		}
> > > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > > index 3d7242c..d981d16 100644
> > > > --- a/include/linux/kvm_host.h
> > > > +++ b/include/linux/kvm_host.h
> > > > @@ -239,6 +239,9 @@ struct kvm_vcpu {
> > > >  	unsigned long requests;
> > > >  	unsigned long guest_debug;
> > > >
> > > > +	int wakeup_cpu;
> > > > +	struct list_head blocked_vcpu_list;
> > > > +
> > > >  	struct mutex mutex;
> > > >  	struct kvm_run *run;
> > > >
> > > > @@ -282,6 +285,7 @@ struct kvm_vcpu {
> > > >  	} spin_loop;
> > > >  #endif
> > > >  	bool preempted;
> > > > +	bool blocked;
> > > >  	struct kvm_vcpu_arch arch;
> > > >  };
> > >
> > > Please remove blocked and wakeup_cpu, they should not be necessary.
> >
> > Why do you think wakeup_cpu is not needed, when vCPU is blocked,
> > wakeup_cpu saves the cpu which the vCPU is blocked on, after vCPU
> > is woken up, it can run on a different cpu, so we need wakeup_cpu to
> > find the right list to wake up the vCPU.
> 
> If the vCPU was moved it should have updated IRTE destination field
> to the pCPU which it has moved to?

Every time a vCPU is scheduled to a new pCPU, the IRTE destination filed
would be updated accordingly. 

When vCPU is blocked. To wake up the blocked vCPU, we need to find which
list the vCPU is blocked on, and this is what wakeup_cpu used for?


Thanks,
Feng
