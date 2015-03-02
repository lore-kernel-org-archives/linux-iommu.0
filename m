From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU
	is preempted
Date: Mon, 2 Mar 2015 09:12:53 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0023F4969@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-24-git-send-email-feng.wu@intel.com>
	<20150223222138.GB9544@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150223222138.GB9544-I4X2Mt4zSy4@public.gmane.org>
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
> Sent: Tuesday, February 24, 2015 6:22 AM
> To: Wu, Feng
> Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is preempted
> 
> On Fri, Dec 12, 2014 at 11:14:57PM +0800, Feng Wu wrote:
> > This patch updates the Posted-Interrupts Descriptor when vCPU
> > is preempted.
> >
> > sched out:
> > - Set 'SN' to suppress furture non-urgent interrupts posted for
> > the vCPU.
> 
> What wakes the vcpu in the case of a non-urgent interrupt, then?

Here we set 'SN' when vCPU's state is transmitted from running to
runnable (waiting in the runqueue), after the vCPU is chosen to run
again, the 'SN' will be clear. So no need to wakeup it explicitly.

> 
> I wonder how is software suppose to configure the urgent/non-urgent
> flag. Can you give examples of (hypothetical) urgent and non-urgent
> interrupts.

Well, urgent and non-urgent flag is supported in hardware, I think the
original purpose of urgent interrupts is for real time usage. Then, when
such urgent interrupts happen, we can change the behavior of the
scheduler and make the related vCPU run immediately. However, from
software's point of view, we didn't find a clear picture about which
interrupts should be urgent and how to configure it, so we don't support
this currently.

> 
> > sched in:
> > - Clear 'SN'
> > - Change NDST if vCPU is scheduled to a different CPU
> > - Set 'NV' to POSTED_INTR_VECTOR
> 
> What about:
> 
> POSTED_INTR_VECTOR interrupt handler:
> - Wakeup vcpu.
- If the vCPU is still running (not preempted), we don't need
to wakeup it. 
- In POSTED_INTR_VECTOR interrupt handler, it is a little hard
to get vCPU related information, even if we get, it is not accurate
and may harm the performance. (need search)

> - Set 'SN' to suppress future interrupts.
We only need to set 'SN' when the vCPU is waiting on the runqueue,
So seems set 'SN' in this handler is not a good idea.

> 
> HLT emulation entry:
> - Clear 'SN' to receive VT-d interrupt notification.
> 
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  arch/x86/kvm/vmx.c | 44
> ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index ee3b735..bf2e6cd 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -1916,10 +1916,54 @@ static void vmx_vcpu_load(struct kvm_vcpu
> *vcpu, int cpu)
> >  		vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
> >  		vmx->loaded_vmcs->cpu = cpu;
> >  	}
> > +
> > +	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
> > +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > +		struct pi_desc old, new;
> > +		unsigned int dest;
> > +
> > +		memset(&old, 0, sizeof(old));
> > +		memset(&new, 0, sizeof(new));
> > +
> > +		do {
> > +			old.control = new.control = pi_desc->control;
> > +			if (vcpu->cpu != cpu) {
> > +				dest = cpu_physical_id(cpu);
> > +
> > +				if (x2apic_enabled())
> > +					new.ndst = dest;
> > +				else
> > +					new.ndst = (dest << 8) & 0xFF00;
> > +			}
> > +
> > +			pi_clear_sn(&new);
> > +
> > +			/* set 'NV' to 'notification vector' */
> > +			new.nv = POSTED_INTR_VECTOR;
> > +		} while (cmpxchg(&pi_desc->control, old.control,
> > +				new.control) != old.control);
> > +	}
> >  }
> >
> >  static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
> >  {
> > +	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
> > +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > +		struct pi_desc old, new;
> > +
> > +		memset(&old, 0, sizeof(old));
> > +		memset(&new, 0, sizeof(new));
> > +
> > +		/* Set SN when the vCPU is preempted */
> > +		if (vcpu->preempted) {
> > +			do {
> > +				old.control = new.control = pi_desc->control;
> > +				pi_set_sn(&new);
> > +			} while (cmpxchg(&pi_desc->control, old.control,
> > +					new.control) != old.control);
> > +		}
> > +	}
> > +
> >  	__vmx_load_host_state(to_vmx(vcpu));
> >  	if (!vmm_exclusive) {
> >  		__loaded_vmcs_clear(to_vmx(vcpu)->loaded_vmcs);
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
