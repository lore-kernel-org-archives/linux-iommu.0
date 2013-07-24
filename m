From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
Date: Wed, 24 Jul 2013 10:47:19 -0600
Message-ID: <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	<20130711210326.1701.56478.stgit@bling.home>
	<20130723223533.GB19765@google.com>
	<1374621703.15429.98.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1374621703.15429.98.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 23, 2013 at 5:21 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, 2013-07-23 at 16:35 -0600, Bjorn Helgaas wrote:
>> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
>> > This provides interfaces for drivers to discover the visible PCIe
>> > requester ID for a device, for things like IOMMU setup, and iterate
>>
>> IDs (plural)
>
> How does a device can't have multiple requester IDs?  Reading below, I'm
> not sure we're on the same page for the purpose of this patch.

>> "requestee" doesn't make sense to me.  The "-ee" suffix added to a verb
>> normally makes a noun that refers to the object of the action.  So
>> "requestee" sounds like it means something like "target" or "responder,"
>> but that's not what you mean here.
>
> Hmm, ok.  I figured a request-er makes a request on behalf of a
> request-ee.  Suggestions?

I would expect a request-er to make a request *to* a request-ee, just
like a grant-or makes a grant to a grant-ee.  My suggestion is to use
"requester" consistently for only the originator of a DMA transaction.
 Any devices above it are by definition "bridges".  As the DMA
transaction propagates through the fabric, it may be tagged by bridges
with different requester IDs.

The requester IDs are needed outside PCI (by IOMMU drivers), but I'm
not sure the intermediate pci_devs are.

>> > + * pci_get_visible_pcie_requester - Get requester and requester ID for
>> > + *                                  @requestee below @bridge
>> > + * @requestee: requester device
>> > + * @bridge: upstream bridge (or NULL for root bus)
>> > + * @requester_id: location to store requester ID or NULL
>> > + */
>> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
>> > +                                          struct pci_dev *bridge,
>> > +                                          u16 *requester_id)
>>
>> I'm not sure it makes sense to return a struct pci_dev here because
>> there's no requirement that a requester ID correspond to an actual
>> pci_dev.
>
> That's why this function is named get_.._requester instead of requester
> ID.  I believe there still has to be a struct pci_dev that does the
> request, but the requester ID for that device may not actually match.
> So I return both.  In a PCIe-to-PCI bridge case, the pci_dev is the
> bridge, but the requester ID is either the bridge bus|devfn or
> subordinate|0 depending on the topology.  If we want to support "ghost
> functions", we can return the real pci_dev and a ghost requester ID.
>
> I think if we used just a requester ID, it ends up being extremely
> difficult to pass that into anything else since we then have to search
> again for where that requester ID is rooted.

Returning both a pci_dev and a requester ID makes it more complicated.
 At the hardware level, transactions contain only a requester ID, and
bridges can either drop it, pass it unchanged, or assign a new one.  I
think the code will be simpler if we just model that.

>> > + * pcie_for_each_requester - Call callback @fn on each devices and DMA source
>> > + *                           from @requestee to the PCIe requester ID visible
>> > + *                           to @bridge.
>>
>> Transactions from a device may appear with one of several requester IDs,
>> but there's not necessarily an actual pci_dev for each ID, so I think the
>> caller reads better if it's "...for_each_requester_id()"
>
> Wouldn't you expect to pass a requester ID into a function with that
> name?  I'm pretty sure I had it named that at one point but thought the
> parameters made more sense this way.  I'll see if I can think of a
> better name.

My thought was to pass a pci_dev (the originator of the DMA, which I
would call the "requester") and a callback.  The callback would accept
the requester pci_dev (always the same requester device) and a
requester ID.

This would call @fn for each possible requester ID for transactions
from the device.  IOMMU drivers should only need the requester ID to
manage mappings; they shouldn't need a pci_dev corresponding to any
intermediate bridges.

>> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
>> > +                                          struct pci_dev *bridge,
>> > +                                          u16 *requester_id);
>>
>> The structure of this interface implies that there is only one visible
>> requester ID, but the whole point of this patch is that a transaction from
>> @requestee may appear with one of several requester IDs.  So which one will
>> this return?
>
> I thought the point of this patch was to have an integrated interface
> for finding the requester ID and doing something across all devices with
> that requester ID

Oh, here's the difference in our understanding.  "Doing something
across all devices with that requester ID" sounds like identifying the
set of devices that have to be handled as a group by the IOMMU.
That's certainly an issue, but I wasn't considering it at all.

I was only concerned with the question of a single device that
requires multiple IOMMU mappings because DMA requests might use any of
several source IDs.  This is mentioned in sec 3.6.1.1 of the VT-d
spec, i.e., "requests arriving with the source-id in the original
PCI-X transaction or the source-id provided by the bridge. ...
software must program multiple context entries, each corresponding to
the possible set of source-ids."

My thought was that the IOMMU driver would use
pcie_for_each_requester_id() and have the callback set up a mapping
for one requester ID each time it was called.

> and thereby remove pci_find_upstream_pcie_bridge(),
> provide a way to quirk broken PCIe-to-PCI bridge and quirk dma_ops for
> devices that use the wrong requester ID.  In what case does a device
> appear to have multiple requester IDs?  We have cases where devices use
> the wrong requester ID, but AFAIK they only use a single wrong requester
> ID.

I think the example in sec 3.6.1.1 answers this, doesn't it?

Bjorn
