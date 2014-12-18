From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
	is blocked
Date: Thu, 18 Dec 2014 03:16:53 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002307C7B@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-25-git-send-email-feng.wu@intel.com>
	<5491B8DD.5020000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5491B8DD.5020000-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gleb Natapov <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: kvm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:kvm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On
> Behalf Of Paolo Bonzini
> Sent: Thursday, December 18, 2014 1:10 AM
> To: Wu, Feng; Thomas Gleixner; Ingo Molnar; H. Peter Anvin; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> Gleb Natapov; Paolo Bonzini; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Alex
> Williamson
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; KVM list;
> Eric Auger
> Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is blocked
> 
> 
> 
> On 12/12/2014 16:14, Feng Wu wrote:
> > This patch updates the Posted-Interrupts Descriptor when vCPU
> > is blocked.
> >
> > pre-block:
> > - Add the vCPU to the blocked per-CPU list
> > - Clear 'SN'
> 
> Should SN be already clear (and NV set to POSTED_INTR_VECTOR)? 

I think the SN bit should be clear here, Adding it here is just to make sure
SN is clear when vCPU is blocked, so it can receive wakeup notification event later.

> Can it
> happen that you go from sched-out to blocked without doing a sched-in first?
> 

I cannot imagine this scenario, can you please be more specific? Thanks a lot!

> In fact, if this is possible, what happens if vcpu->preempted &&
> vcpu->blocked?

In fact, vcpu->preempted && vcpu->blocked happens sometimes, but I think there is
no issues. Please refer to the following case:

kvm_vcpu_block() 
	-> vcpu->blocked = true;
	-> prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);

	before schedule() is called, this vcpu is woken up by another guy, so
	the state of the vcpu associated thread is changed to TASK_RUNNING,
	then preemption happens after interrupts or the following schedule() is
	hit, this will call kvm_sched_out(), in which current->state == TASK_RUNNING
	and vcpu->preempted is set to true. So now vcpu->preempted and vcpu->blocked
	are both true. In vmx_vcpu_put(), we will check vcpu->preempted first, so
	the vCPU will not be blocked, and the vcpu->blocked will be set the false in
	vmx_vcpu_load().

	But maybe I need do a little change to the vmx_vcpu_load() like below:

                /*
                 * Delete the vCPU from the related wakeup queue
                 * if we are resuming from blocked state
                 */
                if (vcpu->blocked) {
                        vcpu->blocked = false;
+						/* if wakeup_cpu == -1, the vcpu is currently not blocked on any
+						  pCPU, don't need dequeue here */
+						if (vcpu->wakeup_cpu != -1) {
               		         spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
                                vcpu->wakeup_cpu), flags);
                    	     list_del(&vcpu->blocked_vcpu_list);
                        	 spin_unlock_irqrestore(&per_cpu(blocked_vcpu_on_cpu_lock,
                                vcpu->wakeup_cpu), flags);
                        	 vcpu->wakeup_cpu = -1;
+						}
                }

Any ideas about this? Thanks a lot!

Thanks,
Feng


	-> schedule();


> 
> > - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> >
> > post-block:
> > - Remove the vCPU from the per-CPU list
> 
> Paolo
> 
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
