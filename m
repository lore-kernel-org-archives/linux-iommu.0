From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
Date: Wed, 24 Jul 2013 16:42:03 -0400
Message-ID: <51F03C1B.2070002@redhat.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	<20130711210326.1701.56478.stgit@bling.home>
	<20130723223533.GB19765@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130723223533.GB19765-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/23/2013 06:35 PM, Bjorn Helgaas wrote:
> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
>> This provides interfaces for drivers to discover the visible PCIe
>> requester ID for a device, for things like IOMMU setup, and iterate
>
> IDs (plural)
>
a single device does not have multiple requester id's;
can have multiple tag-id's (that are ignored in this situation, but
can be used by switches for ordering purposes), but there's only 1/fcn
(except for those quirker pdevs!).

>> over the device chain from requestee to requester, including DMA
>> quirks at each step.
>
> "requestee" doesn't make sense to me.  The "-ee" suffix added to a verb
> normally makes a noun that refers to the object of the action.  So
> "requestee" sounds like it means something like "target" or "responder,"
> but that's not what you mean here.
>
sorry, I didn't follow the requester/requestee terminology either...

>> Suggested-by: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Alex Williamson<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/pci/search.c |  198 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   include/linux/pci.h  |    7 ++
>>   2 files changed, 205 insertions(+)
>>
>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>> index d0627fa..4759c02 100644
>> --- a/drivers/pci/search.c
>> +++ b/drivers/pci/search.c
>> @@ -18,6 +18,204 @@ DECLARE_RWSEM(pci_bus_sem);
>>   EXPORT_SYMBOL_GPL(pci_bus_sem);
>>
>>   /*
>> + * pci_has_pcie_requester_id - Does @dev have a PCIe requester ID
>> + * @dev: device to test
>> + */
>> +static bool pci_has_pcie_requester_id(struct pci_dev *dev)
>> +{
>> +	/*
>> +	 * XXX There's no indicator of the bus type, conventional PCI vs
>> +	 * PCI-X vs PCI-e, but we assume that a caller looking for a PCIe
>> +	 * requester ID is a native PCIe based system (such as VT-d or
>> +	 * AMD-Vi).  It's common that PCIe root complex devices do not
could the above comment be x86-iommu-neutral?
by definition of PCIe, all devices have a requester id (min. to accept cfg =
cycles);
req'd if source of read/write requests, read completions.

>> +	 * include a PCIe capability, but we can assume they are PCIe
>> +	 * devices based on their topology.
>> +	 */
>> +	if (pci_is_pcie(dev) || pci_is_root_bus(dev->bus))
>> +		return true;
>> +
>> +	/*
>> +	 * PCI-X devices have a requester ID, but the bridge may still take
>> +	 * ownership of transactions and create a requester ID.  We therefore
>> +	 * assume that the PCI-X requester ID is not the same one used on PCIe.
>> +	 */
>> +
>> +#ifdef CONFIG_PCI_QUIRKS
>> +	/*
>> +	 * Quirk for PCIe-to-PCI bridges which do not expose a PCIe capability.
>> +	 * If the device is a bridge, look to the next device upstream of it.
>> +	 * If that device is PCIe and not a PCIe-to-PCI bridge, then by
>> +	 * deduction, the device must be PCIe and therefore has a requester ID.
>> +	 */
>> +	if (dev->subordinate) {
>> +		struct pci_dev *parent =3D dev->bus->self;
>> +
>> +		if (pci_is_pcie(parent)&&
>> +		    pci_pcie_type(parent) !=3D PCI_EXP_TYPE_PCI_BRIDGE)
>> +			return true;
>> +	}
>> +#endif
>> +
>> +	return false;
>> +}
>> +
>> +/*
>> + * pci_has_visible_pcie_requester_id - Can @bridge see @dev's requester=
 ID?
>> + * @dev: requester device
>> + * @bridge: upstream bridge (or NULL for root bus)
>> + */
>> +static bool pci_has_visible_pcie_requester_id(struct pci_dev *dev,
>> +					      struct pci_dev *bridge)
>> +{
>> +	/*
>> +	 * The entire path must be tested, if any step does not have a
>> +	 * requester ID, the chain is broken.  This allows us to support
>> +	 * topologies with PCIe requester ID gaps, ex: PCIe-PCI-PCIe
>> +	 */
>> +	while (dev !=3D bridge) {
>> +		if (!pci_has_pcie_requester_id(dev))
>> +			return false;
>> +
>> +		if (pci_is_root_bus(dev->bus))
>> +			return !bridge; /* false if we don't hit @bridge */
>> +
>> +		dev =3D dev->bus->self;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Legacy PCI bridges within a root complex (ex. Intel 82801) report
>> + * a different requester ID than a standard PCIe-to-PCI bridge.  Instead
First, I'm assuming you mean that devices behind a Legacy PCI bridge within=
 a root complex
get assigned IDs different than std PCIe-to-PCI bridges (as quoted below).

>> + * of using (subordinate<<  8 | 0) the use (bus<<  8 | devfn), like a
>
> s/the/they/
>
well, the PPBs should inject their (secondary << 8 | 0), not subordinate.
 From the PCI Express to PCI/PCI-X Bridge spec, v1.0:
The Tag is reassigned by the bridge according to the rules outlined in the =
following sections. If the
bridge generates a new Requester ID for a transaction forwarded from the se=
condary interface to the
primary interface, the bridge assigns the PCI Express Requester ID using it=
s secondary interface=92s
                                                                           =
   ^^^^^^^^^
Bus Number and sets both the Device Number and Function Number fields to ze=
ro.
^^^^^^^^^^

As for the 82801, looks like they took this part of the PCIe spec to heart:
(PCIe v3 spec, section 2.2.6.2 Transaction Descriptor - Transaction ID Fiel=
d):
Exception: The assignment of Bus and Device Numbers to the Devices within a=
 Root Complex,
and the Device Numbers to the Downstream Ports within a Switch, may be done=
 in an
implementation specific way.
Obviously, you're missing the 'implementation-specific way' compiler... ;-)

aw: which 'bus' do you mean above in  '(bus<<  8 | devfn)' ?


> Did you learn about this empirically?  Intel spec?  I wonder if there's
> some way to derive this from the PCIe specs.
>
>> + * standard PCIe endpoint.  This function detects them.
>> + *
>> + * XXX Is this Intel vendor ID specific?
>> + */
>> +static bool pci_bridge_uses_endpoint_requester(struct pci_dev *bridge)
>> +{
>> +	if (!pci_is_pcie(bridge)&&  pci_is_root_bus(bridge->bus))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +#define PCI_REQUESTER_ID(dev)	(((dev)->bus->number<<  8) | (dev)->devfn)
>> +#define PCI_BRIDGE_REQUESTER_ID(dev)	((dev)->subordinate->number<<  8)
>> +
>> +/*
>> + * pci_get_visible_pcie_requester - Get requester and requester ID for
>> + *                                  @requestee below @bridge
>> + * @requestee: requester device
>> + * @bridge: upstream bridge (or NULL for root bus)
>> + * @requester_id: location to store requester ID or NULL
>> + */
>> +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requeste=
e,
>> +					       struct pci_dev *bridge,
>> +					       u16 *requester_id)
>
> I'm not sure it makes sense to return a struct pci_dev here because
> there's no requirement that a requester ID correspond to an actual
> pci_dev.
>
well, I would expect the only callers would be for subsys (iommu's)
searching to find requester-id for a pdev, b/c if a pdev doesn't exist,
then the device (and requester-id) doesn't exist... :-/

>> +{
>> +	struct pci_dev *requester =3D requestee;
>> +
>> +	while (requester !=3D bridge) {
>> +		requester =3D pci_get_dma_source(requester);
>> +		pci_dev_put(requester); /* XXX skip ref cnt */
>> +
>> +		if (pci_has_visible_pcie_requester_id(requester, bridge))
>
> If we acquire the "requester" pointer via a ref-counting interface,
> it's illegal to use the pointer after dropping the reference, isn't it?
> Maybe that's what you mean by the "XXX" comment.
>
>> +			break;
>> +
>> +		if (pci_is_root_bus(requester->bus))
>> +			return NULL; /* @bridge not parent to @requestee */
>> +
>> +		requester =3D requester->bus->self;
>> +	}
>> +
>> +	if (requester_id) {
>> +		if (requester->bus !=3D requestee->bus&&
>> +		    !pci_bridge_uses_endpoint_requester(requester))
>> +			*requester_id =3D PCI_BRIDGE_REQUESTER_ID(requester);
>> +		else
>> +			*requester_id =3D PCI_REQUESTER_ID(requester);
>> +	}
>> +
>> +	return requester;
>> +}
>> +
>> +static int pci_do_requester_callback(struct pci_dev **dev,
>> +				     int (*fn)(struct pci_dev *,
>> +					       u16 id, void *),
>> +				     void *data)
>> +{
>> +	struct pci_dev *dma_dev;
>> +	int ret;
>> +
>> +	ret =3D fn(*dev, PCI_REQUESTER_ID(*dev), data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dma_dev =3D pci_get_dma_source(*dev);
>> +	pci_dev_put(dma_dev); /* XXX skip ref cnt */
>> +	if (dma_dev =3D=3D *dev)
>
> Same ref count question as above.
>
>> +		return 0;
>> +
>> +	ret =3D fn(dma_dev, PCI_REQUESTER_ID(dma_dev), data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*dev =3D dma_dev;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * pcie_for_each_requester - Call callback @fn on each devices and DMA =
source
>> + *                           from @requestee to the PCIe requester ID v=
isible
>> + *                           to @bridge.
>
> Transactions from a device may appear with one of several requester IDs,
> but there's not necessarily an actual pci_dev for each ID, so I think the
ditto above; have to have a pdev for each id....

> caller reads better if it's "...for_each_requester_id()"
>
> The "Call X on each devices and DMA source from Y to the requester ID"
> part doesn't quite make a sentence.
>
>> + * @requestee: Starting device
>> + * @bridge: upstream bridge (or NULL for root bus)
>
> You should say something about the significance of @bridge.  I think the
> point is to call @fn for every possible requester ID @bridge could see for
> transactions from @requestee.  This is a way to learn the requester IDs an
> IOMMU at @bridge needs to be prepared for.
>
>> + * @fn: callback function
>> + * @data: data to pass to callback
>> + */
>> +int pcie_for_each_requester(struct pci_dev *requestee, struct pci_dev *=
bridge,
>> +			    int (*fn)(struct pci_dev *, u16 id, void *),
>> +			    void *data)
>> +{
>> +	struct pci_dev *requester;
>> +	struct pci_dev *dev =3D requestee;
>> +	int ret =3D 0;
>> +
>> +	requester =3D pci_get_visible_pcie_requester(requestee, bridge, NULL);
>> +	if (!requester)
>> +		return -EINVAL;
>> +
>> +	do {
>> +		ret =3D pci_do_requester_callback(&dev, fn, data);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (dev =3D=3D requester)
>> +			return 0;
>> +
>> +		/*
>> +		 * We always consider root bus devices to have a visible
>> +		 * requester ID, therefore this should never be true.
>> +		 */
>> +		BUG_ON(pci_is_root_bus(dev->bus));
>
> What are we going to do if somebody hits this BUG_ON()?  If it's impossib=
le
> to hit, we should just remove it.  If it's possible to hit it in some wei=
rd
> topology you didn't consider, we should see IOMMU faults for any requester
> ID we neglected to map, and that fault would be a better debugging hint
> than a BUG_ON() here.
>
according to spec, all pdev's have a requester-id, even RC ones, albeit
"implementation specific"...

>> +
>> +		dev =3D dev->bus->self;
>> +
>> +	} while (dev !=3D requester);
>> +
>> +	/*
>> +	 * If we've made it here, @requester is a bridge upstream from
>> +	 * @requestee.
>> +	 */
>> +	if (pci_bridge_uses_endpoint_requester(requester))
>> +		return pci_do_requester_callback(&requester, fn, data);
>> +
>> +	return fn(requester, PCI_BRIDGE_REQUESTER_ID(requester), data);
>> +}
>> +
>> +/*
>>    * find the upstream PCIe-to-PCI bridge of a PCI device
>>    * if the device is PCIE, return NULL
>>    * if the device isn't connected to a PCIe bridge (that is its parent =
is a
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 3a24e4f..94e81d1 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1873,6 +1873,13 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(=
struct pci_dev *pdev)
>>   }
>>   #endif
>>
>> +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requeste=
e,
>> +					       struct pci_dev *bridge,
>> +					       u16 *requester_id);
>
> The structure of this interface implies that there is only one visible
> requester ID, but the whole point of this patch is that a transaction from
> @requestee may appear with one of several requester IDs.  So which one wi=
ll
> this return?
>
Are there devices that use multiple requester id's?
I know we have ones that use the wrong id.
If we want to handle the multiple requester-id's per pdev,
we could pass in a ptr to an initial requester-id; if null, give me first;
if !null, give me next one;  would also need a flag returned to indicate
there is more than 1.
null-rtn when pass in !null ref, means the end.
  ... sledge-hammer + nail ???

>> +int pcie_for_each_requester(struct pci_dev *requestee, struct pci_dev *=
bridge,
>> +			    int (*fn)(struct pci_dev *, u16 id, void *),
>> +			    void *data);
>> +
>>   /**
>>    * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of=
 a device
>>    * @pdev: the PCI device
>>
