From: Jitendra Bhivare via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC 2/5] dt-bindings: brcm: Add reserved-dma-region for iPROC
Date: Thu, 15 Mar 2018 17:33:28 +0530
Message-ID: <CAOA9gs1XE1RkumEkYafO5f+b1YjGCFTYzxSSB-U4JcsR6=QdQg@mail.gmail.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
	<1520312368-7068-3-git-send-email-jitendra.bhivare@broadcom.com>
	<c2f30c0c-ff5e-2904-11f4-5351749381a9@arm.com>
	<CAOA9gs32BqGiXD7R2v7=Xkv-PVLTzuU3VmG1dAm6HNd4=w-qQg@mail.gmail.com>
	<a4a27e3c-4e7b-4850-ebf7-bd2b8f6f0d97@arm.com>
Reply-To: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a4a27e3c-4e7b-4850-ebf7-bd2b8f6f0d97-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 15, 2018 at 12:15 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 12/03/18 07:03, Jitendra Bhivare wrote:
>>
>> On Tue, Mar 6, 2018 at 5:12 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>>
>>> On 06/03/18 04:59, Jitendra Bhivare wrote:
>>>>
>>>>
>>>> With SoC wide DMA mask of 40-bit, the mappings for entire IOVA space
>>>> can't
>>>> be specified in the PAXBv2 PCIe RC of SoC. The holes in IOVA space needs
>>>> to
>>>> be reserved to prevent any IOVA allocations in those spaces.
>>>
>>>
>>>
>>> Can you clarify why? If this is the PCI inbound window thing again, let
>>> me
>>> say once again that "dma-ranges" is the appropriate way for DT to
>>> describe
>>> the hardware.
>>>
>>> Robin.
>>
>> dma-ranges = < \
>> 0x43000000 0x00 0x00000000 0x00 0x80000000 0x00 0x80000000 \
>> 0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>> 0x43000000 0x80 0x00000000 0x80 0x00000000 0x80 0x00000000>
>>
>> Yes, its for PCI inbound windows. In our HW, they are limited by sizes
>> specified in
>> ARM memory maps which was done for non-IOMMU cases to catch any transfer
>> outside the ranges.
>> dma-ranges are already being used to program these inbound windows and SoC
>> wide DMA mask is already specified but IOMMU code can still allocate IOVAs
>> in the gaps for which translation will fail in PCIe RC.
>
>
> Right, so make iommu-dma reserve the gaps. No need to clutter up the DT with
> redundant information which gets handled pretty much identically anyway.
>
> Robin.
There was a mistake in pasting dma-ranges mentioned. This is what we use it in
IOMMU case.
#define PCIE_DMA_RANGES dma-ranges = < \
0x43000000 0x00 0x00000000 0x00 0x00000000 0x04 0x00000000 \
0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
0x43000000 0x80 0x00000000 0x80 0x00000000 0x80 0x00000000>

#define PCIE_RESERVED_DMA_REGION reserved-dma-region = < \
0x0 0x0 0x04 0x0 0x04 0x0 \
0x0 0x0 0x10 0x0 0x70 0x0>

This is non-iommu case which is per ARM memory map.
#define PCIE_DMA_RANGES dma-ranges = < \
0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>

In IOMMU case, we had to increase first in-bound window i.e.
dma-ranges first entry
from 2GB-4GB (in non-iommu case) to 0-16GB because out-bound window specified
from 2GB-4GB implicitly gets reserved by the PCI iommu code. This allowed IOVA
allocations from 0-2GB and 4-16GB mapped through in-bound windows.

Basically, my point is that dma-ranges specified is being used to
program our in-bound
windows and defines PCI space to CPU address space supported mappings of HW.
In the same way, it would be better to explicitly specify
reserved-dma-region to clarify
this as HW hole than implicity reserving the regions.

We can at least have single property 'reserved-dma-window' for MSI
region and DMA regions
to help describe the holes in the HW than let SW compute it.

>>>
>>>
>>>> reserved-dma-region property is added to specify the ranges which should
>>>> never be mapped and given to devices sitting behind.
>>>>
>>>> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>>> Reviewed-by: Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>>> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> index b8e48b4..3be0fe3 100644
>>>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>> @@ -30,6 +30,9 @@ Optional properties:
>>>>    - dma-ranges: Some PAXB-based root complexes do not have inbound
>>>> mapping
>>>> done
>>>>      by the ASIC after power on reset.  In this case, SW is required to
>>>> configure
>>>>    the mapping, based on inbound memory regions specified by this
>>>> property.
>>>> +- reserved-dma-region: PAXBv2 with IOMMU enabled cannot provide
>>>> mappings
>>>> for
>>>> +  entire IOVA space specified by DMA mask. Hence this is used to
>>>> reserve
>>>> the
>>>> +  gaps in dma-ranges.
>>>>      - brcm,pcie-ob: Some iProc SoCs do not have the outbound address
>>>> mapping done
>>>>    by the ASIC after power on reset. In this case, SW needs to configure
>>>> it
>>>>
>>>
>
