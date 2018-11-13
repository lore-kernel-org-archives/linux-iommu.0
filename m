From: Yehezkel Bernat <yehezkelshb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
	support to userspace
Date: Tue, 13 Nov 2018 17:38:53 +0200
Message-ID: <CA+CmpXteN1PJEHMV8rvfeBXK6Eb4z6BgZwa8Ojavi1y9pKN-jA@mail.gmail.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112160628.86620-5-mika.westerberg@linux.intel.com>
	<CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
	<20181113105558.GR2500@lahna.fi.intel.com>
	<CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
	<20181113114020.GV2500@lahna.fi.intel.com>
	<CA+CmpXt1cfqjz94=WsggKpNCUw3761-cewa_HTa0ETcYK7o+Hw@mail.gmail.com>
	<20181113152038.GD2500@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181113152038.GD2500-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>, michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 13, 2018 at 5:20 PM Mika Westerberg
<mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
> On Tue, Nov 13, 2018 at 04:42:58PM +0200, Yehezkel Bernat wrote:
> > On Tue, Nov 13, 2018 at 1:40 PM Mika Westerberg
> > <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > >
> > > On Tue, Nov 13, 2018 at 01:13:31PM +0200, Yehezkel Bernat wrote:
> > > > On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
> > > > <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > > > >
> > > > > > Just one point:
> > > > > > Have you considered the option to add this property per (TBT?) device?
> > > > >
> > > > > No. ;-)
> > > > >
> > > > > You mean that one device uses security levels and another IOMMU? I don't
> > > > > think it is possible without having some sort of table in the IOMMU
> > > > > driver telling which devices it needs identity map and which not. Also
> > > > > not sure what would be the benefit?
> > > >
> > > > For performance, of course. If some devices are considered safe (maybe a list
> > > > communicated by platform firmware), the kernel may decide to configure them to
> > > > passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
> > > > wrong.)
> > >
> > > At least I'm not aware of such an option. Windows for example enables
> > > IOMMU for everything and I think macOS does the same. In Linux (with
> > > these patches) we put all internal devices already passthrough mode so
> > > things like internal graphics should not be affected. eGPUs are
> > > different thing, though.
> >
> > So your point here is "currently we do the IOMMU decisions system-wide; we can
> > always add a per-device attribute if needed"?
>
> Well, let me elaborate a bit :) I think it is possible to put certain
> devices into IOMMU passthrough mode even if they are "external" but I'm
> not that familiar with the guts of Intel IOMMU (Baolu or Ashok are the
> experts). Assuming it is possible we could have a table or similar in
> the kernel that can be used to identify devices that are allowed to be
> in passthrough mode.
>
> I'm not sure if it can be per-device sysfs attribute because at the time
> the PCIe device is enumerated it is already put to its IOMMU group.

Good point. But I thought about per-TBT-device decision. If the platform is
configured for IOMMU+"user" security level, while approving the device the user
may want to set also in which IOMMU group to put all the PCIe devices connected
to it. The same goes if kernel is supposed to auto-approve such devices based on
an internal table. The point is that we can think on a configuration where the
devices aren't tunneled yet and the decision about IOMMU can still be changed.

As you mentioned this isn't the common configuration anyway, so it probably
doesn't worth all this hassle.
