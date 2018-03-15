From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 3/5] dt-bindings: arm-smmu: Add reserved-msi-region
Date: Thu, 15 Mar 2018 19:42:56 +0000
Message-ID: <d2e1d6fa-05ec-ac4a-7db4-2adc756369d1@arm.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
	<1520312368-7068-4-git-send-email-jitendra.bhivare@broadcom.com>
	<9aeb8e14-2a14-d71b-7970-055ed04a131c@arm.com>
	<CAOA9gs0_mUJcuthxon5Ru1B7FFK=_XuCh4E4D98DzPih8dey8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOA9gs0_mUJcuthxon5Ru1B7FFK=_XuCh4E4D98DzPih8dey8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/03/18 07:19, Jitendra Bhivare wrote:
> On Tue, Mar 6, 2018 at 5:17 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 06/03/18 04:59, Jitendra Bhivare wrote:
>>>
>>> iPROC SoC has a special device window to treat GICv3 ITS MSI.
>>
>>
>> Ugh, really? After preferably printing out 100 copies of the SBSA, binding
>> them all together and dropping the lot onto the hardware designers from a
>> great height, could you clarify what exactly the special behaviour is here?
>>
>> Robin.
>>
> The special device window needs to programmed so that writes to
> specified address
> region helps for specific ordering of traffic prior to it.

OK, I know of PCIe root complexes having address matching to give the 
MSI write the appropriate AXI memory type attributes when the SMMU is 
bypassed, but ordering is a new one. I guess you have some glue logic on 
the root complex master interface which injects an ACE barrier 
transaction in front of any write to the ITS doorbell address?
>>> Current code maps MSI to IOVA space. Add SMMU node property to use
>>> direct mappings for MSI region.
>>>
>>> This property is read and reserved when arm_smmu_get_resv_regions
>>> gets called.

Either way, this should be a generic, not SMMU-specific, property - 
there are other platforms that would also make use of it to describe a 
similar hardware situation (which we currently only support via ACPI). 
The big question is where to put it: hardware-wise, the property of 
"MSIs won't work properly if the doorbell is remapped to a different 
address" belongs firmly to the root complex, not the IOMMU, while the 
address itself is already a property of the MSI controller. The IOMMU is 
just the innocent guy in the middle who has to discover and respect the 
constraints.

I'd like to think we could just have some flag to say "you can't remap 
my MSIs!" then go and chase the msi-parent/msi-map phandle to the MSI 
controller to get the address from its reg property, which is more or 
less the equivalent of what the current ACPI workaround does - see 
commit 8b4282e6b8e2 ("ACPI/IORT: Add msi address regions reservation 
helper") in linux-next - but I can already think of ways in which that 
might not work. For one, there's not necessarily any guarantee that the 
MSI controller's programming interface and doorbell are in the same 
place, so we probably do need to describe the specific MSI address(es) 
that the root complex cares about, from the root complex end :/

Robin.

>>>
>>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>> ---
>>>    Documentation/devicetree/bindings/iommu/arm,smmu.txt | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>> index 8a6ffce..13fa2b9 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>> @@ -71,6 +71,15 @@ conditions.
>>>                      or using stream matching with #iommu-cells = <2>, and
>>>                      may be ignored if present in such cases.
>>>    +- reserved-msi-region: MSI region to be reserved with specific prot in
>>> IOVA
>>> +                 space for direct mapping. The region is specified in
>>> tuple
>>> +                 of (busno,prot,bus_addr,size).
>>> +
>>> +- #region-address-cells: specifies number of cells needed to encode
>>> bus_addr
>>> +
>>> +- #region-size-cells: specifies number of cells needed to encode size
>>> +
>>> +
>>>    ** Deprecated properties:
>>>      - mmu-masters (deprecated in favour of the generic "iommus" binding) :
>>> @@ -95,6 +104,9 @@ conditions.
>>>                                 <0 36 4>,
>>>                                 <0 37 4>;
>>>                    #iommu-cells = <1>;
>>> +               #region-address-cells = <1>;
>>> +               #region-size-cells = <1>;
>>> +               reserved-msi-region = <0x0 0x1a 0x63c3000 0x8000>;
>>>            };
>>>              /* device with two stream IDs, 0 and 7 */
>>>
>>
