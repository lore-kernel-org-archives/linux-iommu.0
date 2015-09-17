From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v8 03/13] KVM: Define a new interface
	kvm_intr_is_single_vcpu()
Date: Thu, 17 Sep 2015 23:15:21 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00271A67E@SHSMSX104.ccr.corp.intel.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
	<1442393409-2623-4-git-send-email-feng.wu@intel.com>
	<55F934F5.7040605@redhat.com>
	<E959C4978C3B6342920538CF579893F002716FFA@SHSMSX104.ccr.corp.intel.com>
	<55FA8AED.6090700@redhat.com>
	<E959C4978C3B6342920538CF579893F002718968@SHSMSX104.ccr.corp.intel.com>
	<55FACD35.1030602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55FACD35.1030602-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?iso-8859-2?Q?Radim_Kr=3Fm=E1=3F?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Thursday, September 17, 2015 10:25 PM
> To: Wu, Feng; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Radim
> Kr=E8m=E1=F8
> Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
> kvm_intr_is_single_vcpu()
> =

> >> On 17/09/2015 05:17, Wu, Feng wrote:
> >>>>>>> +	if (irq->dest_mode =3D=3D APIC_DEST_PHYSICAL) {
> >>>>>>> +		if (irq->dest_id =3D=3D 0xFF)
> >>>>>>> +			goto out;
> >>>>>>> +
> >>>>>>> +		if (irq->dest_id >=3D ARRAY_SIZE(map->phys_map)) {
> >>>>>
> >>>>> Warning here is wrong, the guest can trigger it.
> >>> Could you please share more information about how the guest
> >>> triggers these conditions (including the following two), Thanks
> >>> a lot!
> >>
> >> irq->dest_id is a 16-bit value, so it can be > 255.
> >
> > Yes, irq->dest_id is defined as u32, but by looking the current KVM
> > code, seems desst_id is used as an u8 variable, even in x2apic mode
> > the dest_id will not beyond 255 (except for broadcast dest in in x2apic
> > mode). Correct me if I am wrong. Thanks a lot!
> =

> Actually you're right, the MSI destination is only 8 bits.  I was
> confused because of
> =

> #define	 MSI_ADDR_DEST_ID_MASK		0x00ffff0
> =

> in arch/x86/include/asm/msidef.h.  But there may be a bug, see below...
> =

> >>> +		if (cid >=3D ARRAY_SIZE(map->logical_map)) {
> >>> +			WARN_ON_ONCE(1);
> >>
> >> In x2apic mode irq->dest_id could have bits 12..15 set.
> >
> > cid is gotten from bit 16 ..31 of the ldr (in apic_logical_id()), and
> > in x2apic mode, ldr is constructed in kvm_apic_set_x2apic_id() as
> > below:
> >
> > u32 ldr =3D ((id >> 4) << 16) | (1 << (id & 0xf));
> >
> > So in fact, cid is (id >> 4), I cannot think of why cid can beyond 15.
> =

> I think kvm_apic_match_logical_addr for MSI and IOAPIC interrupts is
> buggy in x2apic mode.
> =

> It does:
> =

>         if (apic_x2apic_mode(apic))
>                 return ((logical_id >> 16) =3D=3D (mda >> 16))
>                        && (logical_id & mda & 0xffff) !=3D 0;
> =

> But mda is only 8-bits for MSI and IOAPIC interrupts.
> =

> Radim, should kvm_apic_mda also handle the !ipi && x2apic_mda && dest_id
> !=3D APIC_BROADCAST case?  It never triggers with Linux because it uses
> only the physical mode (that's not super-easy to see;
> ioapic_set_affinity looks for the RTEs in irq_data->chip_data and that
> is allocated with kzalloc).
> =

> > Do I miss something here? Thanks!
> =

> No, you were right.
> =

> But still I think the WARNs are unnecessary; it is conceivable that some
> future chipset adds support for more than 8-bits in the dest_id.

No problem, I agree with it. Here I just want clarify some questions, thanks
for the elaboration!

Thanks,
Feng

> =

> Paolo
> =

> > Thanks,
> > Feng
> >
> >>
> >> Paolo
