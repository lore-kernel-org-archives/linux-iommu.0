From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU
	is preempted
Date: Thu, 18 Dec 2014 03:15:37 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002307C66@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-24-git-send-email-feng.wu@intel.com>
	<5491B924.3090200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5491B924.3090200-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gleb Natapov <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <public-jiang.liu-VuQAYsv1563Yd54FQh9/CA-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:paolo.bonzini-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Paolo
> Bonzini
> Sent: Thursday, December 18, 2014 1:11 AM
> To: Wu, Feng; Thomas Gleixner; Ingo Molnar; H. Peter Anvin; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> Gleb Natapov; Paolo Bonzini; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Alex
> Williamson; jiang.liu-VuQAYsv1563Yd54FQh9/CA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; KVM list;
> Eric Auger
> Subject: Re: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is preempted
> 
> 
> 
> On 12/12/2014 16:14, Feng Wu wrote:
> > +	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
> > +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > +		struct pi_desc old, new;
> > +		unsigned int dest;
> > +
> > +		memset(&old, 0, sizeof(old));
> > +		memset(&new, 0, sizeof(new));
> 
> This is quite expensive.  Just use an u64 for old_control and
> new_control, instead of a full struct.
> 
> >
> > +			pi_clear_sn(&new);
> 
> This can be simply new.sn = 0.  It does not need atomic operations.

Thanks for your comments, Paolo!

If we use u64 new_control, we cannot use new.sn any more.
Maybe we can change the struct pi_desc {} like this:

typedef struct pid_control{
        u64     on      : 1,
        sn      : 1,
        rsvd_1  : 13,
        ndm     : 1,
        nv      : 8,
        rsvd_2  : 8,
        ndst    : 32;
}pid_control_t;

struct pi_desc {
        u32 pir[8];     /* Posted interrupt requested */
		pid_control_t control;
        u32 rsvd[6];
} __aligned(64);


Then we can define pid_control_t new_control, old_control. And use new_control.sn = 0.

What is your opinon?

Thanks,
Feng

> 
> Same in patch 24 (if needed at all there---see the reply there).
> 
> >
> > +	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
> > +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> > +		struct pi_desc old, new;
> > +
> > +		memset(&old, 0, sizeof(old));
> > +		memset(&new, 0, sizeof(new));
> > +
> 
> Here you do not need old/new at all because...
> 
> > +		if (vcpu->preempted) {
> > +			do {
> > +				old.control = new.control = pi_desc->control;
> > +				pi_set_sn(&new);
> > +			} while (cmpxchg(&pi_desc->control, old.control,
> > +					new.control) != old.control);
> 
> this can do pi_set_sn directly on pi_desc, without the cmpxchg.
> 
> Paolo
