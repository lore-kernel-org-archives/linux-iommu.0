From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: SMR masking and PCI
Date: Mon, 31 Oct 2016 18:36:43 +0000
Message-ID: <851032d7-6b04-3930-b5c6-04ad97b52d3d@arm.com>
References: <VI1PR0401MB26389CC8820C9654337B578E8DAA0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
	<c39b785a-0f18-fc0a-ce08-7ebe3cfaf8c5@arm.com>
	<HE1PR04MB1321DED0E75BD607BB52889EFFAE0@HE1PR04MB1321.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <HE1PR04MB1321DED0E75BD607BB52889EFFAE0-6LN7OEpIatWwb60icsfScs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Diana Madalina Craciun <diana.craciun-3arQi8VN3Tc@public.gmane.org>, Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 31/10/16 15:57, Diana Madalina Craciun wrote:
> Hi Robin,
> 
> On 10/28/2016 07:16 PM, Robin Murphy wrote:
>> Hi Stuart,
>>
>> On 27/10/16 18:10, Stuart Yoder wrote:
>>> Hi Robin,
>>>
>>> A question about how the SMR masking defined in the arm,smmu binding
>>> relates to the PCI iommu-map.
>>>
>>> The #iommu-cells property defines the number of cells an "IOMMU specifier"
>>> takes and 2 is specified to be:
>>>
>>>    SMMUs with stream matching support and complex masters
>>>    may use a value of 2, where the second cell represents
>>>    an SMR mask to combine with the ID in the first cell.
>>>
>>> An iommu-map entry is defined as:
>>>
>>>    (rid-base,iommu,iommu-base,length)
>>>
>>> What seems to be currently missing in the iommu-map support is
>>> the possibility the case where #iommu-cells=<2>.
>> Indeed. The bindings have so far rather implicitly assumed the case of
>> #{msi,iommu}-cells = 1, and the code has followed suit.
>>
>>> In this case iommu-base which is an IOMMU specifier should
>>> occupy 2 cells.  For example on an ls2085a we would want:
>>>
>>> 	iommu-map = <0x0   0x6 0x7 0x3ff 0x1
>>> 		       0x100 0x6 0x8 0x3ff 0x1>;
>>>
>>> ...to mask our stream IDs to 10 bits.
>>>
>>> This should work in theory and comply with the bindings, no?
>> In theory, but now consider:
>>
>> 	iommu-map = <0x0 0x6 0x7 0x3ff 0x2>;
>>
>> faced with ID 1. The input base is 0, the output base is the 2-cell
>> value 0x7000003ff, so the final ID value should be 0x700000400, right?
>>
>>> of_pci_map_rid() seems to have a hardcoded assumption that
>>> each field in the map is 4 bytes.
>> It does. I guess we should explicitly check that #{msi,iommu}-cells = 1
>> on the target node, and maybe clarify in the binding that that cell
>> should represent a plain linear ID value (although that's pretty obvious
>> from context IMO).
>>
>>> (Also, I guess that msi-map is not affected by this since it
>>> is not related to the IOMMU...but we do have common code
>>> handling both maps.)
>> I'd say it's definitely affected, since #msi-cells can equally be more
>> than 1, and encodes an equally opaque value.
>>
>> It seems pretty reasonable to me that we could extend the binding to
>> accommodate #cells > 1 iff length == 1. Mark?
>>
>> That said, is there a concrete need for this, i.e. do you actually have
>> one device with a single requester ID, which maps to multiple output IDs
>> (which differ only in the upper bits) in a non-predictable manner?
>>
> Actually in the example presented by Stuart, the SMR mask should be
> 0x7C00 (as 0 means that the bit is relevant for matching). So, we have
> the stream ID 7, but the SMMU 500 is appending the TBU bits which makes
> the stream ID look like 0x1407 (TBU 5). In our platform the relationship
> device-TBU is not exposed and documented.

To be fair, that's only the fault of the folks who neglected to document
it (and if this really was the anticipated use-case, possibly also the
integration folks for not simply using the 15-bit Stream ID
configuration and tying any extra bits off). The TBU IDs are still an
undeniable property of the hardware, and not exactly difficult to
discover either. For instance, an LS2085a has been running with the
following map for PCIe for quite some time:

	/* Squash 8:5:3 BDF down to 2:2:3 */
	iommu-map-mask = <0x031f>;
	iommu-map = <0x000 &smmu 0x1400 0x20>,
		    <0x100 &smmu 0x1420 0x20>,
		    <0x200 &smmu 0x1440 0x20>,
		    <0x300 &smmu 0x1460 0x20>;

(with the obligatory hacks to program the PEX LUT entries to match, and
the SATA ICIDs not to alias as they apparently go through the same TBU).

> The SMMU-500 ref manual
> describes this case:
> 
> "If the Stream ID presented to each TBU is already unique, and the TBU
> ID addition is not required, then you must ensure that the TBU ID field
> is masked in the SMR."
> 
> This is the reason that we need the SMR mask, to mask the TBU bits in
> the SMR.

The PCIe example might be a reason to *want* masking, in order to work
around inadequate documentation, but it certainly isn't a *need*.

Fortunately, Stuart's description of the DPAA complex mastering through
multiple TBUs such that a single device's ICID may map to multiple
stream IDs *is* a compelling justification, because iommu-map isn't
designed for one-to-many mappings. You just need to be very careful the
ICIDs really are completely unique system-wide once you start masking,
or the aliasing will result in weird, and possibly impractical, group
assignment.

Anyway, from the SMMU driver perspective SMR masking does work nicely
now, so I'm happy to review patches to of_pci_map_rid() ;)

Robin.

> 
> Thank you,
> 
> Diana
> 
> 
> 
