From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
	VT-d PI
Date: Mon, 22 Dec 2014 04:48:57 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0023103FB@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-14-git-send-email-feng.wu@intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC048A2@SHSMSX104.ccr.corp.intel.com>
	<549307A5.3060305@redhat.com>
	<E959C4978C3B6342920538CF579893F00230A5F8@SHSMSX104.ccr.corp.intel.com>
	<5494131E.9030505@redhat.com>
	<E959C4978C3B6342920538CF579893F00230D036@SHSMSX104.ccr.corp.intel.com>
	<549576C7.4030800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <549576C7.4030800-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gleb Natapov <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiang Liu <public-jiang.liu-VuQAYsv1563Yd54FQh9/CA-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:paolo.bonzini-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Paolo
> Bonzini
> Sent: Saturday, December 20, 2014 9:17 PM
> To: Wu, Feng; Paolo Bonzini; Zhang, Yang Z; Thomas Gleixner; Ingo Molnar; H.
> Peter Anvin; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Gleb Natapov; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Alex Williamson; Jiang Liu
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; KVM list;
> Eric Auger
> Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
> VT-d PI
> 
> 
> 
> On 20/12/2014 00:48, Wu, Feng wrote:
> > In my understanding, lowest priority interrupts are always delivered to a
> > Single CPU, we need to find the right destination CPU from the cpumask.
> 
> Yes, but which CPU however differs every time the interrupt is
> delivered.  So the emulation here is a bit poor.  For now, please limit
> PI to fixed interrupts.

Do you mean we don't support Lowest priority interrupts? As I mentioned before,
Lowest priority interrupts is widely used in Linux, so I think supporting lowest priority
interrupts is very important for Linux guest OS. Do you have any ideas/suggestions about
how to support Lowest priority interrupts for PI? Thanks a lot!

Thanks,
Feng

> 
> > Actually, we don't support posting broadcast/multicast interrupts, because
> > the interrupt is associated with one Posted-interrupts descriptor, then one
> > vCPU.
> 
> Understood.
> 
> Paolo
