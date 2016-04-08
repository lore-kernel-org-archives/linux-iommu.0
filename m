From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
Date: Fri, 8 Apr 2016 11:31:49 -0600
Message-ID: <20160408113149.1386ec8c@t450s.home>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160225143841.GA8726@localhost>
	<1457995420.78634.63.camel@infradead.org>
	<20160316004817.GG19974@localhost>
	<20160408160632.GF8780@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160408160632.GF8780@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>, Joerg Roedel <jroedel@suse.de>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 8 Apr 2016 11:06:32 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Mar 15, 2016 at 07:48:17PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 14, 2016 at 10:43:40PM +0000, David Woodhouse wrote: =20
> > > On Thu, 2016-02-25 at 08:38 -0600, Bjorn Helgaas wrote: =20
> > > >  =20
> > > > >=C2=A0 /*
> > > > > - * Look for aliases to or from the given device for exisitin=
g groups.=C2=A0 The
> > > > > - * dma_alias_devfn only supports aliases on the same bus, th=
erefore the search
> > > > > + * Look for aliases to or from the given device for existing=
 groups. DMA
> > > > > + * aliases are only supported on the same bus, therefore the=
 search =20
> > > >=20
> > > > I'm trying to reconcile this statement that "DMA aliases are on=
ly
> > > > supported on the same bus" (which was there even before this pa=
tch)
> > > > with the fact that pci_for_each_dma_alias() does not have that
> > > > limitation. =20
> > >=20
> > > Doesn't it? You can still only set a DMA alias on the same bus wi=
th
> > > pci_add_dma_alias(), can't you? =20
> >=20
> > I guess it's true that PCI_DEV_FLAGS_DMA_ALIAS_DEVFN and the propos=
ed
> > pci_add_dma_alias() only add aliases on the same bus.  I was thinki=
ng
> > about a scenario like this:
> >=20
> >   00:00.0 PCIe-to-PCI bridge to [bus 01]
> >   01:01.0 conventional PCI device
> >=20
> > where I think 01:00.0 is a DMA alias for 01:01.0 because the bridge
> > takes ownership of DMA transactions from 01:01.0 and assigns a
> > Requester ID of 01:00.0 (secondary bus number, device 0, function 0=
).

This is true, but this is a topology alias, not a quirk.
pci_for_each_dma_alias() already handles this case.  It would trigger
the callback function for any direct alias of the conventional device
as well as the bridge itself.  Obviously we don't end up with any
quirks for conventional devices because the aliases are masked behind
the bridge anyway.
=20
> > > > >=C2=A0=C2=A0 * space is quite small (especially since we're re=
ally only looking at pcie
> > > > >=C2=A0=C2=A0 * device, and therefore only expect multiple slot=
s on the root complex or
> > > > >=C2=A0=C2=A0 * downstream switch ports).=C2=A0 It's conceivabl=
e though that a pair of
> > > > > @@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias=
_group(struct pci_dev *pdev,
> > > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0continue;
> > > > >=C2=A0=C2=A0
> > > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/* We alias them or they alias us */
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN=
) &&
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdev->dma_alias_devfn =3D=3D=
 tmp->devfn) ||
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((tmp->dev_flags & PCI_DEV_FLAGS_D=
MA_ALIAS_DEVFN) &&
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp->dma_alias_devfn =3D=3D =
pdev->devfn)) {
> > > > > -
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (dma_alias_is_enabled(pdev, tmp->devfn) ||
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_alias_is_enabled(tmp, pdev->de=
vfn)) {
> > > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0group =3D get_pci_alias_group(tmp, devfns); =20
> > > >=20
> > > > We basically have this:
> > > >=20
> > > > =C2=A0 for_each_pci_dev(tmp) {
> > > > =C2=A0=C2=A0=C2=A0 if ()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 group =3D get_pci_alias_group();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > > =C2=A0 } =20
> > >=20
> > > Strictly, that's:
> > >=20
> > > =C2=A0for_each_pci_dev(tmp) {
> > > =C2=A0 =C2=A0if (pdev is an alias of tmp || tmp is an alias of pd=
ev)
> > > =C2=A0 =C2=A0 =C2=A0group =3D get_pci_alias_group();
> > > =C2=A0 =C2=A0...
> > > =C2=A0} =20
> >=20
> > OK. =20
> >  =20
> > > > I'm trying to figure out why we don't do something like the fol=
lowing
> > > > instead:
> > > >=20
> > > > =C2=A0 callback(struct pci_dev *pdev, u16 alias, void *opaque)
> > > > =C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0 struct iommu_group *group;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 group =3D get_pci_alias_group();
> > > > =C2=A0=C2=A0=C2=A0 if (group)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return group;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 return 0;
> > > > =C2=A0 }
> > > >=20
> > > > =C2=A0 pci_for_each_dma_alias(pdev, callback, ...); =20
> > >=20
> > > And this would be equivalent to
> > >=20
> > > =C2=A0for_each_pci_dev(tmp) {
> > > =C2=A0 =C2=A0if (tmp is an alias of pdev)
> > > =C2=A0 =C2=A0 =C2=A0group =3D get_pci_alias_group();
> > > =C2=A0 =C2=A0...
> > > =C2=A0}
> > >=20
> > > The "is an alias of" property is not commutative. Perhaps it shou=
ld be.
> > > But that's hard because in some cases the alias doesn't even *exi=
st* as
> > > a real PCI device. It's just that you appear to get DMA transacti=
ons
> > > from a given source-id. =20
> >=20
> > Right.  In my example above, 01:00.0 is not a PCI device; it's only=
 a
> > Requester ID that is fabricated by the bridge when it forwards DMA
> > transactions upstream.
> >=20
> > I think I'm confused because I don't really understand IOMMU groups=
=2E
> >=20
> > Let me explain what I think they are and you can correct me when I =
go
> > wrong.  The iommu_group_alloc() comment says "The IOMMU group
> > represents the minimum granularity of the IOMMU."  So I suppose the
> > IOMMU cannot distinguish between devices in a group.  All the devic=
es
> > in the group use the same set of DMA mappings.  Granting device A D=
MA
> > access to a buffer grants the same access to all other members of A=
's
> > IOMMU group.
> >=20
> > That would mean my question was fundamentally backwards.  In
> > get_pci_alias_group(A), we're not trying to figure out what all the
> > aliases of A are, which is what pci_for_each_dma_alias() does.
> >=20
> > Instead, we're trying to figure out which IOMMU group A belongs to.
> > But I still don't quite understand how aliases fit into this.  Let'=
s
> > go back to my example and assume we've already put 00:00.0 and 01:0=
1.0
> > in IOMMU groups:
> >=20
> >   00:00.0 PCIe-to-PCI bridge to [bus 01]     # in IOMMU group G0
> >   01:01.0 conventional PCI device            # in IOMMU group G1
> >=20
> > I assume these devices are in different IOMMU groups because if the
> > bridge generated its own DMA, it would use Requester ID 00:00.0, wh=
ich
> > is distinct from the 01:00.0 it would use when forwarding DMAs from
> > its secondary side.

The actual requester ID of the bridge depends on quirks as well, see
PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS, so it might either be the bridge itself
or the subordinate bus address.  However, trace how these groups would
be created, the bridge device is discovered first, so we call
pci_device_group() for it.  since it's on the root bus and it's the 0th
function, there will be no existing groups for it to alias, so it gets
a new group.  Then we discover 01:01.0, pci_device_group() calls
pci_for_each_dma_alias(), which hits the bridge, regardless of which
alias is used.  So 01:01.0 ends up in the same iommu group as the
bridge.

=46rom the purist standpoint of iommu groups, your expectations are
probably correct, but we also include within IOMMU groups DMA isolation
between devices.  So if two devices can DMA between each other without
it necessarily passing through the iommu, the devices are grouped
together.  The more important cases of this are ACS isolation on PCI-e
devices, but it still sort of applies to this conventional PCI example
here.
=20
> > What happens when we add 01:02.0?  I think 01:01.0 and 01:02.0
> > should both end up in IOMMU group G1 because the IOMMU will see onl=
y
> > Requester ID 01:00.0, so it can't distinguish them.
> >=20
> > When we add 01:02.0, the ops->add_device() ... ops->device_group()
> > path calls pci_device_group(01:02.0):
> >=20
> >   pci_device_group(01:02.0)
> >     pci_for_each_dma_alias(01:02.0, get_pci_alias_or_group)
> >       get_pci_alias_or_group(01:02.0, 01:02.0)   # callback
> >         return 0           # 01:02.0 group not set yet
> >       get_pci_alias_or_group(00:00.0, 01:00.0)   # callback
> >         return 1           # 00:00.0 is in G0
> >=20
> > It seems like we'll assign 01:02.0 to group G0, when I think it
> > should be in G1.  Where did I go wrong? =20

In fact they're all part of G0, so you went wrong assuming the initial
grouping rather than applying the same rules and tracing how 01:01.0 is
added.  It's not an ideal representation, it tends to be more
conservative than necessary in some cases, but keeping the group
attached to devices has advantages in being able to search and find
points like this where we don't necessarily have access to the group
behind the bridge without tying it to the bridge itself.  Thanks,

Alex
