From: Jitendra Bhivare via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC 3/5] dt-bindings: arm-smmu: Add reserved-msi-region
Date: Mon, 12 Mar 2018 12:49:40 +0530
Message-ID: <CAOA9gs0_mUJcuthxon5Ru1B7FFK=_XuCh4E4D98DzPih8dey8w@mail.gmail.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
	<1520312368-7068-4-git-send-email-jitendra.bhivare@broadcom.com>
	<9aeb8e14-2a14-d71b-7970-055ed04a131c@arm.com>
Reply-To: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9aeb8e14-2a14-d71b-7970-055ed04a131c-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Mar 6, 2018 at 5:17 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 06/03/18 04:59, Jitendra Bhivare wrote:
>>
>> iPROC SoC has a special device window to treat GICv3 ITS MSI.
>
>
> Ugh, really? After preferably printing out 100 copies of the SBSA, binding
> them all together and dropping the lot onto the hardware designers from a
> great height, could you clarify what exactly the special behaviour is here?
>
> Robin.
>
The special device window needs to programmed so that writes to
specified address
region helps for specific ordering of traffic prior to it.
>
>> Current code maps MSI to IOVA space. Add SMMU node property to use
>> direct mappings for MSI region.
>>
>> This property is read and reserved when arm_smmu_get_resv_regions
>> gets called.
>>
>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 8a6ffce..13fa2b9 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -71,6 +71,15 @@ conditions.
>>                     or using stream matching with #iommu-cells = <2>, and
>>                     may be ignored if present in such cases.
>>   +- reserved-msi-region: MSI region to be reserved with specific prot in
>> IOVA
>> +                 space for direct mapping. The region is specified in
>> tuple
>> +                 of (busno,prot,bus_addr,size).
>> +
>> +- #region-address-cells: specifies number of cells needed to encode
>> bus_addr
>> +
>> +- #region-size-cells: specifies number of cells needed to encode size
>> +
>> +
>>   ** Deprecated properties:
>>     - mmu-masters (deprecated in favour of the generic "iommus" binding) :
>> @@ -95,6 +104,9 @@ conditions.
>>                                <0 36 4>,
>>                                <0 37 4>;
>>                   #iommu-cells = <1>;
>> +               #region-address-cells = <1>;
>> +               #region-size-cells = <1>;
>> +               reserved-msi-region = <0x0 0x1a 0x63c3000 0x8000>;
>>           };
>>             /* device with two stream IDs, 0 and 7 */
>>
>
