From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 05/13] pci: New pci_acs_enabled()
Date: Tue, 15 May 2012 13:56:19 -0600
Message-ID: <CAErSpo48ES5iLDCh1WzmHezSEYhPjhtgD5uxoY-TCTKgUBab2g@mail.gmail.com>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225602.30496.80438.stgit@bling.home>
	<CAErSpo58hKPFb5duOi64sWuR5AJDTVp0rRHkQLotYE3CMXRRhA@mail.gmail.com>
	<1337035766.6954.74.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1337035766.6954.74.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 14, 2012 at 4:49 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 2012-05-14 at 16:02 -0600, Bjorn Helgaas wrote:
>> On Fri, May 11, 2012 at 4:56 PM, Alex Williamson
>> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> > In a PCIe environment, transactions aren't always required to
>> > reach the root bus before being re-routed. =A0Peer-to-peer DMA
>> > may actually not be seen by the IOMMU in these cases. =A0For
>> > IOMMU groups, we want to provide IOMMU drivers a way to detect
>> > these restrictions. =A0Provided with a PCI device, pci_acs_enabled
>> > returns the furthest downstream device with a complete PCI ACS
>> > chain. =A0This information can then be used in grouping to create
>> > fully isolated groups. =A0ACS chain logic extracted from libvirt.
>>
>> The name "pci_acs_enabled()" sounds like it returns a boolean, but it do=
esn't.
>
> Right, maybe this should be:
>
> struct pci_dev *pci_find_upstream_acs(struct pci_dev *pdev);
>
>> I'm not sure what "a complete PCI ACS chain" means.
>>
>> The function starts from "dev" and searches *upstream*, so I'm
>> guessing it returns the root of a subtree that must be contained in a
>> group.
>
> Any intermediate switch between an endpoint and the root bus can
> redirect a dma access without iommu translation,

Is this "redirection" just the normal PCI bridge forwarding that
allows peer-to-peer transactions, i.e., the rule (from P2P bridge
spec, rev 1.2, sec 4.1) that the bridge apertures define address
ranges that are forwarded from primary to secondary interface, and the
inverse ranges are forwarded from secondary to primary?  For example,
here:

                   ^
                   |
          +--------+-------+
          |                |
   +------+-----+    +-----++-----+
   | Downstream |    | Downstream |
   |    Port    |    |    Port    |
   |   06:05.0  |    |   06:06.0  |
   +------+-----+    +------+-----+
          |                 |
     +----v----+       +----v----+
     | Endpoint|       | Endpoint|
     | 07:00.0 |       | 08:00.0 |
     +---------+       +---------+

that rule is all that's needed for a transaction from 07:00.0 to be
forwarded from upstream to the internal switch bus 06, then claimed by
06:06.0 and forwarded downstream to 08:00.0.  This is plain old PCI,
nothing specific to PCIe.

I don't understand ACS very well, but it looks like it basically
provides ways to prevent that peer-to-peer forwarding, so transactions
would be sent upstream toward the root (and specifically, the IOMMU)
instead of being directly claimed by 06:06.0.

> so we're looking for
> the furthest upstream device for which acs is enabled all the way up to
> the root bus.

Correct me if this is wrong: To force device A's DMAs to be processed
by an IOMMU, ACS must be enabled on the root port and every downstream
port along the path to A.

If so, I think you're trying to find out the closest upstream device X
such that everything leading to X has ACS enabled.  Every device below
X can DMA freely to other devices below X, so they would all have to
be in the same isolated group.

I tried to work through some examples to develop some intuition about this:

                                |
        +------------+----------+----------------------+
        |            |                                 |
        |            |
+----------------|-------------------------------+
   +----v----+  +----v----+           |          +-----v----+
                |
   | 00:00.0 |  | 00:01.0 |           |          | 00:02.0  |
                |
   |   PCI   |  | PCIe-to |           |          | Upstream |
                |
   +---------+  |   PCI   |           |          +-----+----+
                |
                +----+----+           |                |
                |
                     |                |
+---------+------+----------------+       |
              +------+------+         |      |                |
        |       |
              |             |         | +----v-----+     +----v-----+
   +----v-----+ |
         +----v----+   +----v----+    | | 02:00.0  |     | 02:01.0  |
   | 02:02.0  | |
         | 01:00.0 |   | 01:01.0 |    | |Downstream|     |Downstream|
   |Downstream| |
         |   PCI   |   |   PCI   |    | |  w/o ACS |     |  w/ ACS  |
   |  w/ ACS  | |
         +---------+   +---------+    | +-----+----+     +----+-----+
   +----+-----+ |

+-------|---------------|----------------|-------+
                                              |               |            =
    |
                                         +----v----+     +----v----+
   +----v----+
                                         | 03:00.0 |     | 04:00.0 |
   | 05:00.0 |
                                         |  PCIe   |     |  PCIe   |
   |  PCIe   |
                                         +---------+     | w/o ACS |
   |  w/ ACS |
                                                         +---------+
   +---------+

pci_acs_enabled(00:00.0) =3D 00:00.0 (on root bus (but doesn't it matter
if 00:00.0 is PCIe or if RP has ACS?))
pci_acs_enabled(00:01.0) =3D 00:01.0 (on root bus)
pci_acs_enabled(01:00.0) =3D 01:00.0 (acs_dev =3D 00:01.0, 01:00.0 is not
PCIe; seems wrong)
pci_acs_enabled(00:02.0) =3D 00:02.0 (on root bus; seems wrong if RP
doesn't have ACS)
pci_acs_enabled(02:00.0) =3D 00:02.0 (acs_dev =3D 00:02.0, 02:00.0 has no A=
CS cap)
pci_acs_enabled(03:00.0) =3D 00:02.0 (acs_dev =3D 00:02.0)
pci_acs_enabled(02:01.0) =3D 02:01.0 (acs_dev =3D 00:02.0, 02:01.0 has ACS =
enabled)
pci_acs_enabled(04:00.0) =3D 04:00.0 (acs_dev =3D 02:01.0, 04:00.0 is not
a bridge; seems wrong if 04:00 is a multi-function device)
pci_acs_enabled(02:02.0) =3D 02:02.0 (acs_dev =3D 00:02.0, 02:02.0 has ACS =
enabled)
pci_acs_enabled(05:00.0) =3D 05:00.0 (acs_dev =3D 02:02.0, 05:00.0 is not a=
 bridge)

But it didn't really help.  I still can't develop a mental picture of
what this function does.

>> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> > ---
>> >
>> > =A0drivers/pci/pci.c =A0 | =A0 43 ++++++++++++++++++++++++++++++++++++=
+++++++
>> > =A0include/linux/pci.h | =A0 =A01 +
>> > =A02 files changed, 44 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> > index 111569c..d7f05ce 100644
>> > --- a/drivers/pci/pci.c
>> > +++ b/drivers/pci/pci.c
>> > @@ -2358,6 +2358,49 @@ void pci_enable_acs(struct pci_dev *dev)
>> > =A0 =A0 =A0 =A0pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
>> > =A0}
>> >
>> > +#define PCI_EXT_CAP_ACS_ENABLED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(PCI_A=
CS_SV | PCI_ACS_RR | \
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0PCI_ACS_CR | PCI_ACS_UF)
>> > +
>> > +/**
>> > + * pci_acs_enabled - test ACS support in downstream chain
>> > + * @dev: starting PCI device
>> > + *
>> > + * Returns the furthest downstream device with an unbroken ACS chain.=
 =A0If
>> > + * ACS is enabled throughout the chain, the returned device is the sa=
me as
>> > + * the one passed in.
>> > + */
>> > +struct pci_dev *pci_acs_enabled(struct pci_dev *dev)
>> > +{
>> > + =A0 =A0 =A0 struct pci_dev *acs_dev;
>> > + =A0 =A0 =A0 int pos;
>> > + =A0 =A0 =A0 u16 ctrl;
>> > +
>> > + =A0 =A0 =A0 if (!pci_is_root_bus(dev->bus))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acs_dev =3D pci_acs_enabled(dev->bus->se=
lf);
>> > + =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev;
>> > +
>> > + =A0 =A0 =A0 /* If the chain is already broken, pass on the device */
>> > + =A0 =A0 =A0 if (acs_dev !=3D dev->bus->self)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acs_dev;
>> > +
>> > + =A0 =A0 =A0 if (!pci_is_pcie(dev) || (dev->class >> 8) !=3D PCI_CLAS=
S_BRIDGE_PCI)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev;
>> > +
>> > + =A0 =A0 =A0 if (dev->pcie_type !=3D PCI_EXP_TYPE_DOWNSTREAM)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev;
>> > +
>> > + =A0 =A0 =A0 pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
>> > + =A0 =A0 =A0 if (!pos)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acs_dev;
>> > +
>> > + =A0 =A0 =A0 pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
>> > + =A0 =A0 =A0 if ((ctrl & PCI_EXT_CAP_ACS_ENABLED) !=3D PCI_EXT_CAP_AC=
S_ENABLED)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acs_dev;
>> > +
>> > + =A0 =A0 =A0 return dev;
>> > +}
>> > +
>> > =A0/**
>> > =A0* pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
>> > =A0* @dev: the PCI device
>> > diff --git a/include/linux/pci.h b/include/linux/pci.h
>> > index 9910b5c..dc25da3 100644
>> > --- a/include/linux/pci.h
>> > +++ b/include/linux/pci.h
>> > @@ -1586,6 +1586,7 @@ static inline bool pci_is_pcie(struct pci_dev *d=
ev)
>> > =A0}
>> >
>> > =A0void pci_request_acs(void);
>> > +struct pci_dev *pci_acs_enabled(struct pci_dev *dev);
>> >
>> >
>> > =A0#define PCI_VPD_LRDT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x80 =A0 =
=A0/* Large Resource Data Type */
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
