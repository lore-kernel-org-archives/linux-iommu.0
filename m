From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
	VT-d PI
Date: Fri, 19 Dec 2014 01:30:41 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00230A5EA@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-14-git-send-email-feng.wu@intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC048A2@SHSMSX104.ccr.corp.intel.com>
	<549307A5.3060305@redhat.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC04E0A@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A9667DDFB95DB7438FA9D7D576C3D87E0AC04E0A-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Sankaran, Rajesh" <rajesh.sankaran-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Zhang, Yang Z
> Sent: Friday, December 19, 2014 9:14 AM
> To: Paolo Bonzini; Wu, Feng; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
> Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: RE: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
> VT-d PI
> 
> Paolo Bonzini wrote on 2014-12-19:
> >
> >
> > On 18/12/2014 15:49, Zhang, Yang Z wrote:
> >>>> Here, we introduce a similar way with 'apic_arb_prio' to handle
> >>>> guest lowest priority interrtups when VT-d PI is used. Here is the
> >>>> ideas: - Each vCPU has a counter 'round_robin_counter'. - When
> >>>> guests sets an interrupts to lowest priority, we choose the vCPU
> >>>> with smallest 'round_robin_counter' as the destination, then
> >>>> increase it.
> >>
> >> How this can work well? All subsequent interrupts are delivered to
> >> one vCPU? It shouldn't be the best solution, need more consideration.
> >
> > Well, it's a hardware limitation.  The alternative (which is easy to
> 
> Agree, it is limited by hardware. But lowest priority distributes the interrupt
> more efficient than fixed mode. And current implementation more likes to
> switch the lowest priority mode to fixed mode. In case of interrupt intensive
> environment, this may be a bottleneck and VM may not benefit greatly from
> VT-d PI. But agree again, it is really a hardware limitation.
> 
> > implement) is to only do PI for single-CPU interrupts.  This should
> > work well for multiqueue NICs (and of course for UP guests :)), so
> > perhaps it's a good idea to only support that as a first attempt.
> 
> The more easy way is to deliver the interrupt to the first matched VCPU we find.
> The round_robin_counter really helps nothing here since the interrupt is
> delivered by hardware directly.
> 
> >
> > Paolo
> >
> >> Also, I think you should take the apic_arb_prio into consider since
> >> the priority is for the whole vCPU not for one interrupt.
> 
> 
> Best regards,
> Yang

In fact, the current solution was discussed with Rajesh in the cc List, here is Rajesh's original words:

"When you see a guest requesting a lowest priority interrupts (by programming the virtual IOAPIC, or by programming the virtual MSI/MSI-X registers), have KVM associate it to a vCPU.  Or, put another way, use the 'apic_arb_prio' method you describe below, but instead of using it at time of interrupt (which you no longer have control with posted interrupt direct delivery), do it at time of initializing the interrupt resource.  This way, if the guest asks for 4 lowest priority interrupts, and say you a guest with two vCPUs, the first interrupt request will be serviced by KVM by assigning it through posting to vCPU0, the next one goes to vCPU1, the next one would go back to vCPU0, and so forth..  You could also choose to do this based on vector hashing instead of round-robin."

Thanks,
Feng

> 
