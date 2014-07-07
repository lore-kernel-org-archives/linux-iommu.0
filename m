From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
Date: Mon, 7 Jul 2014 07:58:18 -0300
Message-ID: <20140707105818.GA1101@arch.cereza>
References: <20140703135146.GA6898@luxor.wired.org>
 <53B5C61D.2060308@free-electrons.com>
 <53B5CA26.7050405@free-electrons.com>
 <1936558.QaAG1bYMuD@avalon>
 <20140705150308.GA28791@arch.cereza>
 <20140705205951.GB3678@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140705205951.GB3678@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Joerg Roedel <joro@8bytes.org>, Hiroshi.DOYU@nokia.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Paolo Pisati <p.pisati@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 05 Jul 01:59 PM, Greg Kroah-Hartman wrote:
> On Sat, Jul 05, 2014 at 12:03:08PM -0300, Ezequiel Garcia wrote:
> > After following Gregory's stacktrace (also reproduced here):
> >=20
> > [<c02451f8>] (iommu_bus_notifier) from [<c00512e8>] (notifier_call_=
chain+0x64/0x9c)
> > [<c00512e8>] (notifier_call_chain) from [<c00514cc>] (__blocking_no=
tifier_call_chain+0x40/0x58)
> > [<c00514cc>] (__blocking_notifier_call_chain) from [<c00514f8>] (bl=
ocking_notifier_call_chain+0x14/0x1c)
> > [<c00514f8>] (blocking_notifier_call_chain) from [<c01d225c>] (devi=
ce_add+0x424/0x524)
> > [<c01d225c>] (device_add) from [<c0186d90>] (pci_device_add+0xec/0x=
110)
> > [<c0186d90>] (pci_device_add) from [<c0186e54>] (pci_scan_single_de=
vice+0xa0/0xac)
> >=20
> > I added a few printks and found that the problem is that the iommu_=
bus_notifier is
> > called for the 'pci' bus type, which has a null iommu_ops.
> >=20
> > On 04 Jul 10:47 AM, Laurent Pinchart wrote:
> > [..]
> > >=20
> > > We need a quick fix for v3.16, ...
> >=20
> > Therefore, a quick fix would be to simply check for that:
> >=20
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index e5555fc..b712cb2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -536,6 +536,9 @@ static int iommu_bus_notifier(struct notifier_b=
lock *nb,
> >         struct iommu_group *group;
> >         unsigned long group_action =3D 0;
> > =20
> > +       if (!ops)
> > +               return 0;
> > +
> >         /*
> >          * ADD/DEL call into iommu driver ops if provided, which ma=
y
> >          * result in ADD/DEL notifiers to group->notifier
> >=20
> > This (nasty workaround?) patch makes the problem go away.
> >=20
> > [..]
> > > > So it also boot well in 3.15 and then failed in 3.16-rc3. I hop=
e it will
> > > > help the developers of the OMAP IOMMU driver to fix it.
> > >=20
> > > Thank you. I've had a look at the OMAP IOMMU driver changes betwe=
en v3.15 and=20
> > > v3.16-rc3, and didn't find at first sight any change that could e=
xplain the=20
> > > crash.
> > >=20
> > > 286f600 iommu/omap: Fix map protection value handling
> > > 67b779d iommu/omap: Remove comment about supporting single page m=
appings only
> > > f7129a0 iommu/omap: Fix 'no page for' debug message in flush_iotl=
b_page()
> > > 5acc97d iommu/omap: Move to_iommu definition from omap-iopgtable.=
h
> > > 2ac6133 iommu/omap: Remove omap_iommu_domain_has_cap() function
> > > d760e3e iommu/omap: Correct init value of iotlb_entry valid field
> > >=20
> > > Could you try reverting those changes and retest ? If the problem=
 doesn't=20
> > > disappear, we'll need to look somewhere else.
> > >=20
> >=20
> > I reverted the above commits but nothing changed. I'm far from bein=
g an expert,
> > but it sounds odd to have this bus notifier (that got registered fo=
r the
> > platform bus type) called by a pci bus type.
>=20
> Why wouldn't the PCI bus set this up for its devices?  Are you
> "assuming" you know the bus type and that's the issue?
>=20

Thanks for looking at this.

I guess I snipped the thread and lost most of the information about the=
 panic.
Here's the original bug report:

http://www.spinics.net/lists/arm-kernel/msg344059.html

The problem reported involves enabling OMAP IOMMU driver and not any ot=
her IOMMU
driver. Doing some tracing and adding a few prints, we found that
omap_iommu_init() sets a bus notifier for the platform bus type:

omap_iommu_init -> bus_set_iommu -> iommu_bus_init:

static void iommu_bus_init(struct bus_type *bus, struct iommu_ops *ops)
{
        bus_register_notifier(bus, &iommu_bus_nb);
        bus_for_each_dev(bus, NULL, ops, add_iommu_group);
}

But the iommu bus notifier gets called for the 'pci' bus type, which
has the iommu_ops field NULL (since it hasn't been set for iommu).

The panic is here when the NULL field is dereferenced:

static int iommu_bus_notifier(struct notifier_block *nb,
                              unsigned long action, void *data)
{
        struct device *dev =3D data;
        struct iommu_ops *ops =3D dev->bus->iommu_ops;


> I see the a number of different places this is being initialized for =
the
> pci bus.
>=20
> Ah, look at drivers/iommu/fsl_pamu_domain.c, odds are, it shouldn't b=
e
> doing that logic in the pamu_domain_init() code, using the same bus o=
ps
> for different bus types, that's ripe for major problems...
>=20

Maybe I'm missing something, but since the fsl driver is not enabled it=
 has
nothing to do. And since the OMAP IOMMU doesn't set the iommu bus notif=
ier
for the 'pci' bus type, I was wondering if there's a problem with the b=
us
notifier itself.

I hope the above makes sense.

Thanks again for helping out,
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
