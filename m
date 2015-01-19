From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: return dma alias from
	iommu_group_get_for_pci_dev()
Date: Mon, 19 Jan 2015 12:02:18 +0000
Message-ID: <20150119120217.GH32131@arm.com>
References: <1421427514-16579-1-git-send-email-will.deacon@arm.com>
	<1421427514-16579-2-git-send-email-will.deacon@arm.com>
	<1421430111.6130.254.camel@redhat.com>
	<20150116203350.GA21807@arm.com>
	<1421442663.6130.281.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421442663.6130.281.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: "m-karicheri2-l0cyMroinI0@public.gmane.org" <m-karicheri2-l0cyMroinI0@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 16, 2015 at 09:11:03PM +0000, Alex Williamson wrote:
> On Fri, 2015-01-16 at 20:33 +0000, Will Deacon wrote:
> > On Fri, Jan 16, 2015 at 05:41:51PM +0000, Alex Williamson wrote:
> > > On Fri, 2015-01-16 at 16:58 +0000, Will Deacon wrote:
> > > > Some IOMMU drivers (e.g. the ARM SMMU) require not only the IOMMU g=
roup
> > > > for a PCI device, but also the effective alias of the device (as se=
en by
> > > > the IOMMU) in order to program the translations correctly.
> > > > =

> > > > This patch extends iommu_group_get_for_pci_dev to return the DMA al=
ias
> > > > of the device as well as the group, which can potentially be overri=
dden
> > > > by quirks in the PCI layer. The function is also made visible to dr=
ivers
> > > > so that the new functionality can be used.
> > > > =

> > > > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > > > ---
> > > >  drivers/iommu/iommu.c | 14 ++++++++++++--
> > > >  include/linux/iommu.h |  2 ++
> > > >  2 files changed, 14 insertions(+), 2 deletions(-)
> > > =

> > > This would seem to promote the idea that an IOMMU group for a PCI dev=
ice
> > > has a single bdf alias, which is not necessarily true.
> > =

> > True, but you can deal with that in the caller by ensuring you get the =
alias
> > for each member of the group, no?
> =

> If the caller needs to do that anyway (which they do), what's the point
> of this addition?  What does this alias that we're returning here
> represent versus the other aliases available?  Doesn't the alias
> returned depend on the IOMMU group member that it's called from?  Or
> even whether the group has already been established?  So even if it did
> make sense to return an alias, the answer depends on the caller's
> perspective.  Sort of a Schr=F6dinger's cat function.

I'm trying to use this function from the ->add_device IOMMU callback, so
that I can figure out (a) which IOMMU group the new device is in and (b)
which aliases are contained in that group.

I achieve (b) not by walking the group (iommu_group_for_each_dev) on each
->add_device, but by simply adding the alias for the new device to a data
structure stashed via iommu_group_set_iommudata.

Anyway, you have some good points, more below...

> > > It also only returns the alias based on PCI topology, which can easil=
y be
> > > discovered by the caller using pci_for_each_dma_alias() directly.  So=
 I
> > > don't really see the benefit of this versus using
> > > iommu_group_for_each_dev() and/or pci_for_each_dma_alias().
> > =

> > The problem with using pci_for_each_dma_alias is that I end up duplicat=
ing
> > the remainder of iommu_group_get_for_pci_dev in the SMMU driver in order
> > to handle PCI_DEV_FLAGS_DMA_ALIAS_DEVFN set by PCI quirks and
> > aliasing due to ACS constraints. Furthermore, I end up walking the PCI
> > topology twice: once for the group and a second time for the aliases.
> =

> But the patch is taking the alias only after the
> pci_for_each_dma_alias() call, not after the ACS constraints, so I don't
> see how the duplicated code is any more than another
> pci_for_each_dma_alias() plus callback.  intel-iommu does this plenty.

Right, I think this is what I was missing. Given that the ACS stuff is all
about getting the right group, then I should already have seen any other
group members in ->add_device and therefore using pci_for_each_dma_alias
will work fine providing that I obtain the group using
iommu_group_get_for_dev. Any further alias transformations will be described
by the firmware. Sound sensible?

> Is walking the PCI topology a second time really an issue?  IOMMU group
> setup should be done at boot, and really how deep do you expect a PCI
> topology to be?  A "complex" device will have a switch/bridge and
> endpoints, so we're talking about up to 3 bus levels.  In theory, yes we
> could walk a monster topology, in practice, notsomuch.

Ok, I guess we can revisit this if it does ever become an issue.

> > > It's also intentional that while we have PCI specific code in iommu.c,
> > > the exposed interfaces are device agnostic.  I'm not seeing enough
> > > reason here to change that.  Thanks,
> > =

> > Hmm, I'd really rather have *something* in the core to avoid duplication
> > between all IOMMU drivers sitting on PCI without ACPI tables to describe
> > the IDs. How about a method to extract the IDs from an IOMMU group?
> =

> Well, we do have stuff in the core.  We can get an IOMMU group for a
> device, we can iterate the devices within an IOMMU group, and we can get
> alias for devices that are PCI.  The IOMMU & PCI cores facilitates all
> of that.  I don't get why we need to incorporate some combination of
> that into a new or existing interface when it implies a relationship
> that doesn't necessarily exist and biases the IOMMU interfaces towards a
> particular device type.  Thanks,

Combining the interfaces would help to reduce some redundant walking of
device topologies, but since that's not a practical problem at the moment
then I'll make do with what we have.

Will
