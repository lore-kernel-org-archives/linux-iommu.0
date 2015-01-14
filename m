From: Radim =?utf-8?B?S3I/bcOhPw==?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
	VT-d PI
Date: Wed, 14 Jan 2015 17:59:10 +0100
Message-ID: <20150114165909.GA1283@potion.brq.redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-14-git-send-email-feng.wu@intel.com>
	<20150109145435.GA22469@potion.brq.redhat.com>
	<54AFEC00.80507@redhat.com>
	<E959C4978C3B6342920538CF579893F002341102@SHSMSX104.ccr.corp.intel.com>
	<20150113161716.GA12941@potion.brq.redhat.com>
	<E959C4978C3B6342920538CF579893F00234E4CD@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F00234E4CD-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2015-01-14 01:27+0000, Wu, Feng:
> > the new
> > > hardware even doesn't consider the TPR for lowest priority interrupts
> > delivery.
> > 
> > A bold move ... what hardware was the first to do so?
> 
> I think it was starting with Nehalem.

Thanks,  (Could be that QPI can't inform about TPR changes anymore ...)

I played with Linux's TPR on Haswell and found that is has no effect.

> > > As discussed with Paolo before, I will submit a patch to support lowest
> > priority for PI
> > > after this series is merged.
> > 
> > Sure, I see only two good solutions though
> >  1) don't optimize lowest priority with PI
> >  2) don't balance lowest priority
> 
> As discussed with Paolo before, as the first stage, we only support single-CPU
> lowest priority for PI, since this is a new hardware feature enabling, Paolo trends
> to do simple things in the beginning.

I agree, that is the best we can do without changing lowest priority.

I wanted to avoid a future solution that would introduce two behaviors
for lowest priority (round robin and something).
Round robin (anything dynamic) can't be done with PI, hence the question
if we can remove it.

>                                       Then we will support full lowest priority for
> it, such as, using vector hashing (this is one method of what hardware do for
> lowest priority today), I need to get some detailed information about this from
> hardware guys before enabling it.

I wasn't able to confirm hashing, is it a recent addition?
I'm not sure we want it then:  OS still has to take care of proper
distribution, being predictable is better than uncertain gains, and
we'll save code.

The same should apply to hardware though ... do you know the reasons
behind vector hashing?

Thank you.
