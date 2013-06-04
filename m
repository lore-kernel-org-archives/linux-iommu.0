From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
Subject: Re: [Qemu-devel] VFIO and scheduled SR-IOV cards
Date: Tue, 4 Jun 2013 17:50:30 +0200
Message-ID: <20130604155030.GA5991@irqsave.net>
References: <20130603163305.GC4094@irqsave.net>
	<1370282529.30975.344.camel@ul30vt.home>
	<51ACE1B5.2050102@redhat.com>
	<1370285865.30975.361.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370285865.30975.361.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


Hello,

More informations on how the hardware works.

-Each VF will have its own memory and MMR, etc.
That means the resources are not shared.

-Each VF will have its own bus number, function number and device number.
That means request ID is separated for each VF.

There is also VF save/restore area for the switch.

A VF regular memory (not MMR) is still accessible after a switch out.

But when a function VF1 is scheduled a read to a MRR of VF number 0 could r=
eturn
the value of the same MMR in VF number 1 because VF number 1 is switched on=
 and
the PF processor is busy servicing VF number 1.

This could confuse the guest VF driver so the unmap and block or a same goal
achieving technique is required.

I hope these informations makes the area of the problem to solve narrower.

Best regards

Beno=EEt Canet

> Le Monday 03 Jun 2013 =E0 12:57:45 (-0600), Alex Williamson a =E9crit :
> On Mon, 2013-06-03 at 14:34 -0400, Don Dutile wrote:
> > On 06/03/2013 02:02 PM, Alex Williamson wrote:
> > > On Mon, 2013-06-03 at 18:33 +0200, Beno=EEt Canet wrote:
> > >> Hello,
> > >>
> > >> I plan to write a PF driver for an SR-IOV card and make the VFs work=
 with QEMU's
> > >> VFIO passthrough so I am asking the following design question before=
 trying to
> > >> write and push code.
> > >>
> > >> After SR-IOV being enabled on this hardware only one VF function can=
 be active
> > >> at a given time.
> > >
> > > Is this actually an SR-IOV device or are you trying to write a driver
> > > that emulates SR-IOV for a PF?
> > >
> > >> The PF host kernel driver is acting as a scheduler.
> > >> It switch every few milliseconds which VF is the current active func=
tion while
> > >> disabling the others VFs.
> > >>
> > that's time-sharing of hw, which sw doesn't see ... so, ok.
> > =

> > >> One consequence of how the hardware works is that the MMR regions of=
 the
> > >> switched off VFs must be unmapped and their io access should block u=
ntil the VF
> > >> is switched on again.
> > >
> > This violates the spec., and does impact sw -- how can one assign such =
a VF to a guest
> > -- it does not work indep. of other VFs.
> > =

> > > MMR =3D Memory Mapped Register?
> > >
> > > This seems contradictory to the SR-IOV spec, which states:
> > >
> > >          Each VF contains a non-shared set of physical resources requ=
ired
> > >          to deliver Function-specific
> > >          services, e.g., resources such as work queues, data buffers,
> > >          etc. These resources can be directly
> > >          accessed by an SI without requiring VI or SR-PCIM interventi=
on.
> > >
> > > Furthermore, each VF should have a separate requester ID.  What's bei=
ng
> > > suggested here seems like maybe that's not the case.  If true, it wou=
ld
> > I didn't read it that way above.  I read it as the PCIe end is timeshar=
ed
> > btwn VFs (& PFs?). .... with some VFs disappearing (from a driver persp=
ective)
> > as if the device was hot unplug w/o notification.  That will probably c=
ause
> > read-timeouts & SME's, bringing down most enterprise-level systems.
> =

> Perhaps I'm reading too much into it, but using the same requester ID
> would seem like justification for why the device needs to be unmapped.
> Otherwise we could just stop QEMU and leave the mappings alone if we
> just want to make sure access to the device is blocked while the device
> is swapped out.  Not the best overall throughput algorithm, but maybe a
> proof of concept.  Need more info about how the device actually behaves
> to know for sure.  Thanks,
> =

> Alex
> =

> > > make iommu groups challenging.  Is there any VF save/restore around t=
he
> > > scheduling?
> > >
> > >> Each IOMMU map/unmap should be done in less than 100ns.
> > >
> > > I think that may be a lot to ask if we need to unmap the regions in t=
he
> > > guest and in the iommu.  If the "VFs" used different requester IDs,
> > > iommu unmapping whouldn't be necessary.  I experimented with switching
> > > between trapped (read/write) access to memory regions and mmap'd (dir=
ect
> > > mapping) for handling legacy interrupts.  There was a noticeable
> > > performance penalty switching per interrupt.
> > >
> > >> As the kernel iommu module is being called by the VFIO driver the PF=
 driver
> > >> cannot interface with it.
> > >>
> > >> Currently the only interface of the VFIO code is for the userland QE=
MU process
> > >> and I fear that notifying QEMU that it should do the unmap/block wou=
ld take more
> > >> than 100ns.
> > >>
> > >> Also blocking the IO access in QEMU under the BQL would freeze QEMU.
> > >>
> > >> Do you have and idea on how to write this required map and block/unm=
ap feature ?
> > >
> > > It seems like there are several options, but I'm doubtful that any of
> > > them will meet 100ns.  If this is completely fake SR-IOV and there's =
not
> > > a different requester ID per VF, I'd start with seeing if you can even
> > > do the iommu_unmap/iommu_map of the MMIO BARs in under 100ns.  If tha=
t's
> > > close to your limit, then your only real option for QEMU is to freeze
> > > it, which still involves getting multiple (maybe many) vCPUs out of VM
> > > mode.  That's not free either.  If by some miracle you have time to
> > > spare, you could remap the regions to trapped mode and let the vCPUs =
run
> > > while vfio blocks on read/write.
> > >
> > > Maybe there's even a question whether mmap'd mode is worthwhile for t=
his
> > > device.  Trapping every read/write is orders of magnitude slower, but
> > > allows you to handle the "wait for VF" on the kernel side.
> > >
> > > If you can provide more info on the device design/contraints, maybe we
> > > can come up with better options.  Thanks,
> > >
> > > Alex
> > >
> > > _______________________________________________
> > > iommu mailing list
> > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > =

> =

> =

> =

> =
