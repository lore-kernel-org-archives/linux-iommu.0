From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
Date: Tue, 15 Mar 2016 19:48:17 -0500
Message-ID: <20160316004817.GG19974@localhost>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160225143841.GA8726@localhost>
	<1457995420.78634.63.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457995420.78634.63.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 14, 2016 at 10:43:40PM +0000, David Woodhouse wrote:
> On Thu, 2016-02-25 at 08:38 -0600, Bjorn Helgaas wrote:
> > =

> > >=A0 /*
> > > - * Look for aliases to or from the given device for exisiting groups=
.=A0 The
> > > - * dma_alias_devfn only supports aliases on the same bus, therefore =
the search
> > > + * Look for aliases to or from the given device for existing groups.=
 DMA
> > > + * aliases are only supported on the same bus, therefore the search
> > =

> > I'm trying to reconcile this statement that "DMA aliases are only
> > supported on the same bus" (which was there even before this patch)
> > with the fact that pci_for_each_dma_alias() does not have that
> > limitation.
> =

> Doesn't it? You can still only set a DMA alias on the same bus with
> pci_add_dma_alias(), can't you?

I guess it's true that PCI_DEV_FLAGS_DMA_ALIAS_DEVFN and the proposed
pci_add_dma_alias() only add aliases on the same bus.  I was thinking
about a scenario like this:

  00:00.0 PCIe-to-PCI bridge to [bus 01]
  01:01.0 conventional PCI device

where I think 01:00.0 is a DMA alias for 01:01.0 because the bridge
takes ownership of DMA transactions from 01:01.0 and assigns a
Requester ID of 01:00.0 (secondary bus number, device 0, function 0).

> > >=A0=A0 * space is quite small (especially since we're really only look=
ing at pcie
> > >=A0=A0 * device, and therefore only expect multiple slots on the root =
complex or
> > >=A0=A0 * downstream switch ports).=A0 It's conceivable though that a p=
air of
> > > @@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias_group(s=
truct pci_dev *pdev,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ontinue;
> > >=A0=A0
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* We alias them or they =
alias us */
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (((pdev->dev_flags & PCI_D=
EV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pdev->dma_alias_=
devfn =3D=3D tmp->devfn) ||
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ((tmp->dev_flags & =
PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tmp->dma_alias_d=
evfn =3D=3D pdev->devfn)) {
> > > -
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (dma_alias_is_enabled(pdev=
, tmp->devfn) ||
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_alias_is_enable=
d(tmp, pdev->devfn)) {
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
roup =3D get_pci_alias_group(tmp, devfns);
> > =

> > We basically have this:
> > =

> > =A0 for_each_pci_dev(tmp) {
> > =A0=A0=A0 if ()
> > =A0=A0=A0=A0=A0 group =3D get_pci_alias_group();
> > =A0=A0=A0=A0=A0 ...
> > =A0 }
> =

> Strictly, that's:
> =

> =A0for_each_pci_dev(tmp) {
> =A0 =A0if (pdev is an alias of tmp || tmp is an alias of pdev)
> =A0 =A0 =A0group =3D get_pci_alias_group();
> =A0 =A0...
> =A0}

OK.  =


> > I'm trying to figure out why we don't do something like the following
> > instead:
> > =

> > =A0 callback(struct pci_dev *pdev, u16 alias, void *opaque)
> > =A0 {
> > =A0=A0=A0 struct iommu_group *group;
> > =

> > =A0=A0=A0 group =3D get_pci_alias_group();
> > =A0=A0=A0 if (group)
> > =A0=A0=A0=A0=A0 return group;
> > =

> > =A0=A0=A0 return 0;
> > =A0 }
> > =

> > =A0 pci_for_each_dma_alias(pdev, callback, ...);
> =

> And this would be equivalent to
> =

> =A0for_each_pci_dev(tmp) {
> =A0 =A0if (tmp is an alias of pdev)
> =A0 =A0 =A0group =3D get_pci_alias_group();
> =A0 =A0...
> =A0}
> =

> The "is an alias of" property is not commutative. Perhaps it should be.
> But that's hard because in some cases the alias doesn't even *exist* as
> a real PCI device. It's just that you appear to get DMA transactions
> from a given source-id.

Right.  In my example above, 01:00.0 is not a PCI device; it's only a
Requester ID that is fabricated by the bridge when it forwards DMA
transactions upstream.

I think I'm confused because I don't really understand IOMMU groups.

Let me explain what I think they are and you can correct me when I go
wrong.  The iommu_group_alloc() comment says "The IOMMU group
represents the minimum granularity of the IOMMU."  So I suppose the
IOMMU cannot distinguish between devices in a group.  All the devices
in the group use the same set of DMA mappings.  Granting device A DMA
access to a buffer grants the same access to all other members of A's
IOMMU group.

That would mean my question was fundamentally backwards.  In
get_pci_alias_group(A), we're not trying to figure out what all the
aliases of A are, which is what pci_for_each_dma_alias() does.

Instead, we're trying to figure out which IOMMU group A belongs to.
But I still don't quite understand how aliases fit into this.  Let's
go back to my example and assume we've already put 00:00.0 and 01:01.0
in IOMMU groups:

  00:00.0 PCIe-to-PCI bridge to [bus 01]     # in IOMMU group G0
  01:01.0 conventional PCI device            # in IOMMU group G1

I assume these devices are in different IOMMU groups because if the
bridge generated its own DMA, it would use Requester ID 00:00.0, which
is distinct from the 01:00.0 it would use when forwarding DMAs from
its secondary side.

What happens when we add 01:02.0?  I think 01:01.0 and 01:02.0 should
both end up in IOMMU group G1 because the IOMMU will see only
Requester ID 01:00.0, so it can't distinguish them.

When we add 01:02.0, the ops->add_device() ... ops->device_group()
path calls pci_device_group(01:02.0):

  pci_device_group(01:02.0)
    pci_for_each_dma_alias(01:02.0, get_pci_alias_or_group)
      get_pci_alias_or_group(01:02.0, 01:02.0)   # callback
        return 0           # 01:02.0 group not set yet
      get_pci_alias_or_group(00:00.0, 01:00.0)   # callback
        return 1           # 00:00.0 is in G0

It seems like we'll assign 01:02.0 to group G0, when I think it should
be in G1.  Where did I go wrong?

Bjorn
