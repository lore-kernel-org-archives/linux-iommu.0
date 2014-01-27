From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH] vfio/iommu_type1: Multi-IOMMU domain support
Date: Mon, 27 Jan 2014 08:16:25 +0000
Message-ID: <72231d1d2bce4bdea0a0de508d8b012d@BL2PR03MB468.namprd03.prod.outlook.com>
References: <20140117203126.11429.25235.stgit@gimli.home>
	<4bc6dcb96df44b0e94152d9729958d60@BL2PR03MB468.namprd03.prod.outlook.com>
	<1390234886.8705.142.camel@bling.home>
	<f4597c60b5a04e8e8baa225a279abd0d@BL2PR03MB468.namprd03.prod.outlook.com>
	<CAOtp4Kp0-yZBd_P82CV8-VKPmsTByP8pn_C2T9ctbP3oOke3LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOtp4Kp0-yZBd_P82CV8-VKPmsTByP8pn_C2T9ctbP3oOke3LA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Kai Huang <dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Kai Huang [mailto:dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Monday, January 27, 2014 5:50 AM
> To: Sethi Varun-B16395
> Cc: Alex Williamson; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [RFC PATCH] vfio/iommu_type1: Multi-IOMMU domain support
> 
> On Tue, Jan 21, 2014 at 2:30 AM, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> >> Sent: Monday, January 20, 2014 9:51 PM
> >> To: Sethi Varun-B16395
> >> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Subject: Re: [RFC PATCH] vfio/iommu_type1: Multi-IOMMU domain support
> >>
> >> On Mon, 2014-01-20 at 14:45 +0000, Varun Sethi wrote:
> >> >
> >> > > -----Original Message-----
> >> > > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> >> > > Sent: Saturday, January 18, 2014 2:06 AM
> >> > > To: Sethi Varun-B16395
> >> > > Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> >> > > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> > > Subject: [RFC PATCH] vfio/iommu_type1: Multi-IOMMU domain support
> >> > >
> >> > > RFC: This is not complete but I want to share with Varun the
> >> > > dirrection I'm thinking about.  In particular, I'm really not
> >> > > sure if we want to introduce a "v2" interface version with
> >> > > slightly different unmap semantics.  QEMU doesn't care about the
> >> > > difference, but other users might.  Be warned, I'm not even sure
> >> > > if this code
> >> works at the moment.
> >> > > Thanks,
> >> > >
> >> > > Alex
> >> > >
> >> > >
> >> > > We currently have a problem that we cannot support advanced
> >> > > features of an IOMMU domain (ex. IOMMU_CACHE), because we have no
> >> > > guarantee that those features will be supported by all of the
> >> > > hardware units involved with the domain over its lifetime.  For
> >> > > instance, the Intel VT-d architecture does not require that all
> >> > > DRHDs support snoop control.  If we create a domain based on a
> >> > > device behind a DRHD that does support snoop control and enable
> >> > > SNP support via the IOMMU_CACHE mapping option, we cannot then
> >> > > add a device behind a DRHD which does not support snoop control
> >> > > or we'll get reserved bit faults from the SNP bit in the
> >> > > pagetables.  To add to the complexity, we can't know the
> >> > > properties of a domain until a device
> >> is attached.
> >> > [Sethi Varun-B16395] Effectively, it's the same iommu and iommu_ops
> >> > are common across all bus types. The hardware feature differences
> >> > are abstracted by the driver.
> >>
> >> That's a simplifying assumption that is not made anywhere else in the
> >> code.  The IOMMU API allows entirely independent IOMMU drivers to
> >> register per bus_type.  There is no guarantee that all devices are
> >> backed by the same IOMMU hardware unit or make use of the same
> iommu_ops.
> >>
> > [Sethi Varun-B16395] ok
> >
> >> > > We could pass this problem off to userspace and require that a
> >> > > separate vfio container be used, but we don't know how to handle
> >> > > page accounting in that case.  How do we know that a page pinned
> >> > > in one container is the same page as a different container and
> >> > > avoid double billing the user for the page.
> >> > >
> >> > > The solution is therefore to support multiple IOMMU domains per
> >> > > container.  In the majority of cases, only one domain will be
> >> > > required since hardware is typically consistent within a system.
> >> > > However, this provides us the ability to validate compatibility
> >> > > of domains and support mixed environments where page table flags
> >> > > can be different between domains.
> >> > >
> >> > > To do this, our DMA tracking needs to change.  We currently try
> >> > > to coalesce user mappings into as few tracking entries as
> possible.
> >> > > The problem then becomes that we lose granularity of user
> mappings.
> >> > > We've never guaranteed that a user is able to unmap at a finer
> >> > > granularity than the original mapping, but we must honor the
> >> > > granularity of the original mapping.  This coalescing code is
> >> > > therefore removed, allowing only unmaps covering complete maps.
> >> > > The change in accounting is fairly small here, a typical QEMU VM
> >> > > will start out with roughly a dozen entries, so it's arguable if
> >> > > this
> >> coalescing was ever needed.
> >> > >
> >> > > We also move IOMMU domain creation to the point where a group is
> >> > > attached to the container.  An interesting side-effect of this is
> >> > > that we now have access to the device at the time of domain
> >> > > creation and can probe the devices within the group to determine
> the bus_type.
> >> > > This finally makes vfio_iommu_type1 completely device/bus
> agnostic.
> >> > > In fact, each IOMMU domain can host devices on different buses
> >> > > managed by different physical IOMMUs, and present a single DMA
> >> > > mapping interface to the user.  When a new domain is created,
> >> > > mappings are replayed to bring the IOMMU pagetables up to the
> >> > > state of the current container.  And of course, DMA mapping and
> >> > > unmapping automatically traverse all of the configured IOMMU
> domains.
> >> > >
> >> > [Sethi Varun-B16395] This code still checks to see that devices
> >> > being attached to the domain are connected to the same bus type. If
> >> > we intend to merge devices from different bus types but attached to
> >> > compatible domains in to a single domain, why can't we avoid the
> >> > bus check? Why can't we remove the bus dependency from domain
> allocation?
> >>
> >> So if I were to test iommu_ops instead of bus_type (ie. assume that
> >> if a if an IOMMU driver manages iommu_ops across bus_types that it
> >> can accept the devices), would that satisfy your concern?
> > [Sethi Varun-B16395] I think so. Checking for iommu_ops should allow
> iommu groups from different bus_types, to share a domain.
> >
> >>
> >> It may be possible to remove the bus_type dependency from domain
> >> allocation, but the IOMMU API currently makes the assumption that
> >> there's one IOMMU driver per bus_type.
> > [Sethi Varun-B16395] Is that a valid assumption?
> >
> >> Your fix to remove the bus_type
> >> dependency from iommu_domain_alloc() adds an assumption that there is
> >> only one IOMMU driver for all bus_types.  That may work on your
> >> platform, but I don't think it's a valid assumption in the general
> case.
> > [Sethi Varun-B16395] ok
> >
> >> If you'd like to propose alternative ways to remove the bus_type
> >> dependency, please do.  Thanks,
> >>
> > [Sethi Varun-B16395] My main concern, was to allow devices from
> different bus types, to share the iommu domain. I am fine if this can be
> handled from within vfio.
> >
> > -Varun
> >
> What's the reason that we need to share one domain cross multiple bus
> type (and are we talking the iommu_domain structure in iommu framework,
> right)? I am not familiar with the background info, and new to vfio, but
> from hardware point of view, I don't think it's good idea to share one
> domain cross bus types. Although IOMMUs all basically provide DMA
> remapping, interrupt remapping, etc, but it's possible that some hardware
> capability differences can't be commonly abstracted. For example, some
> old IOMMU just implements very simple functionality, it even can't
> support per-BDF DMA remapping, which means it just can't provide multiple
> domains. And also, I think sharing domain cross bus types should just
> implies that the domain can only support the *common* functionality of
> IOMMUs on bus types that are shared.
> 
> Another point is, the IOMMUs on different types may on a hierarchical
> relationship, but not at the same level, in which case the IOMMUs also
> work hierarchically. Take DMA remapping as example, if PCIE bus is not
> the root bus but under some higher level system bus (which also
> implements DMA remapping), the DMA address will be first translated by
> PCIE IOMMU and then IOMMU on that higher level system bus. I am not sure
> in such case, if sharing domain cross bus types works or not, but looks
> it's not a good idea.
> 
I believe the case you are mentioning  is similar to what Alex stated. I wasn't aware of a scenario where properties of different IOMMUs may vary. I was mostly concerned about the case where devices belonging to different bus types can be added to the same vfio container. This could be possible on the embedded platforms, where you could have platform devices and pcie devices sharing the same iommu domain (it's possible that both are connected to the same iommu).

So, we should certainly consider the possibility where the domain can be shared by different bus types.

-Varun
