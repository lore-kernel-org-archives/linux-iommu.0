From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 05/13] KVM: Update IRTE according to guest interrupt
	configuration changes
Date: Thu, 13 Nov 2014 01:30:54 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00228443D@SHSMSX104.ccr.corp.intel.com>
References: <E959C4978C3B6342920538CF579893F00226EF05@SHSMSX104.ccr.corp.intel.com>
	<5461EC99.1000101@redhat.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0ABDBB25@SHSMSX104.ccr.corp.intel.com>
	<546324F4.8010002@redhat.com>
	<E959C4978C3B6342920538CF579893F00227680F@SHSMSX104.ccr.corp.intel.com>
	<54632ECA.4070903@redhat.com>
	<E959C4978C3B6342920538CF579893F002284398@SHSMSX104.ccr.corp.intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0ABE5A68@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A9667DDFB95DB7438FA9D7D576C3D87E0ABE5A68-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Zhang, Yang Z
> Sent: Thursday, November 13, 2014 9:21 AM
> To: Wu, Feng; Paolo Bonzini; Alex Williamson
> Cc: gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: RE: [PATCH 05/13] KVM: Update IRTE according to guest interrupt
> configuration changes
> 
> Wu, Feng wrote on 2014-11-13:
> >
> >
> > kvm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org wrote on 2014-11-12:
> >> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> >> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Subject: Re: [PATCH 05/13] KVM: Update IRTE according to guest
> >> interrupt configuration changes
> >>
> >>
> >>
> >> On 12/11/2014 10:19, Wu, Feng wrote:
> >>>> You can certainly backport these patches to distros that do not
> >>>> have VFIO.  But upstream we should work on VFIO first.  VFIO has
> >>>> feature parity with legacy device assignment, and adding a new
> >>>> feature that is not in VFIO would be a bad idea.
> >>>>
> >>>> By the way, do you have benchmark results for it?  We have not been
> >>>> able to see any performance improvement for APICv on e.g. netperf.
> >>>
> >>> Do you mean benchmark results for APICv itself or VT-d Posted-Interrtups?
> >>
> >> Especially for VT-d posted interrupts---but it'd be great to know
> >> which workloads see the biggest speedup from APICv.
> >
> > We have some draft performance data internally, please see the
> > attached. For VT-d PI, I think we can get the biggest performance gain
> > if the VCPU is running in non-root mode for most of the time (not in
> > HLT state), since external interrupt from assigned devices will be delivered by
> guest directly in this case.
> > That means we can run some cpu intensive workload in the guests.
> 
> Have you check that the CPU side posted interrupt is taking effect in w/o VT-D
> PI case? Per my understanding, the performance gap should be so large if you
> use CPU side posted interrupt. This data more like the VT-d PI vs non PI(both
> VT-d and CPU).

Yes, this data is VT-d PI vs Non VT-d PI. The CPU side APICv mechanism (including CPU side Posted-Interrtups) is enabled.

Thanks,
Feng

> 
> >
> > Thanks,
> > Feng
> >
> >>
> >> Paolo
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe kvm" in the
> >> body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> >> http://vger.kernel.org/majordomo-info.html
> 
> 
> Best regards,
> Yang
> 
