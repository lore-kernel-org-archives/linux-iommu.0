From: Jitendra Bhivare via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC 2/5] dt-bindings: brcm: Add reserved-dma-region for iPROC
Date: Mon, 12 Mar 2018 12:33:24 +0530
Message-ID: <CAOA9gs32BqGiXD7R2v7=Xkv-PVLTzuU3VmG1dAm6HNd4=w-qQg@mail.gmail.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
	<1520312368-7068-3-git-send-email-jitendra.bhivare@broadcom.com>
	<c2f30c0c-ff5e-2904-11f4-5351749381a9@arm.com>
Reply-To: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c2f30c0c-ff5e-2904-11f4-5351749381a9-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Mar 6, 2018 at 5:12 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 06/03/18 04:59, Jitendra Bhivare wrote:
>>
>> With SoC wide DMA mask of 40-bit, the mappings for entire IOVA space can't
>> be specified in the PAXBv2 PCIe RC of SoC. The holes in IOVA space needs
>> to
>> be reserved to prevent any IOVA allocations in those spaces.
>
>
> Can you clarify why? If this is the PCI inbound window thing again, let me
> say once again that "dma-ranges" is the appropriate way for DT to describe
> the hardware.
>
> Robin.
dma-ranges = < \
0x43000000 0x00 0x00000000 0x00 0x80000000 0x00 0x80000000 \
0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
0x43000000 0x80 0x00000000 0x80 0x00000000 0x80 0x00000000>

Yes, its for PCI inbound windows. In our HW, they are limited by sizes
specified in
ARM memory maps which was done for non-IOMMU cases to catch any transfer
outside the ranges.
dma-ranges are already being used to program these inbound windows and SoC
wide DMA mask is already specified but IOMMU code can still allocate IOVAs
in the gaps for which translation will fail in PCIe RC.
>
>
>> reserved-dma-region property is added to specify the ranges which should
>> never be mapped and given to devices sitting behind.
>>
>> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> index b8e48b4..3be0fe3 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> @@ -30,6 +30,9 @@ Optional properties:
>>   - dma-ranges: Some PAXB-based root complexes do not have inbound mapping
>> done
>>     by the ASIC after power on reset.  In this case, SW is required to
>> configure
>>   the mapping, based on inbound memory regions specified by this property.
>> +- reserved-dma-region: PAXBv2 with IOMMU enabled cannot provide mappings
>> for
>> +  entire IOVA space specified by DMA mask. Hence this is used to reserve
>> the
>> +  gaps in dma-ranges.
>>     - brcm,pcie-ob: Some iProc SoCs do not have the outbound address
>> mapping done
>>   by the ASIC after power on reset. In this case, SW needs to configure it
>>
>
