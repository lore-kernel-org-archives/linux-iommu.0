From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] ACPI/IORT: Handle potential overflow in iort_dma_setup
Date: Thu, 10 Jan 2019 11:44:56 +0100
Message-ID: <fbf8dc04-6f80-b30b-c9ef-87fa3a33d0ec@redhat.com>
References: <20181218184841.20034-1-drjones@redhat.com>
	<20181218184841.20034-2-drjones@redhat.com>
	<1503e3b8-1a6c-3b66-fa1e-d13f4e19f31f@arm.com>
	<20181219131849.hziujd5zgclangce@kamzik.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181219131849.hziujd5zgclangce-gVz1Vyx/EOXkZJWtSm8s3NvLeJWuRmrY@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Jones <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin, Drew,

On 12/19/18 2:18 PM, Andrew Jones wrote:
> On Wed, Dec 19, 2018 at 12:21:35PM +0000, Robin Murphy wrote:
>> On 18/12/2018 18:48, Andrew Jones wrote:
>>> The sum of dmaaddr and size may overflow, particularly considering
>>> there are cases where size will be U64_MAX.
>>
>> Only if the firmware is broken in the first place, though. It would be weird
>> to describe an explicit _DMA range of base=0 and size=U64_MAX, because it's
>> effectively the same as just not having one at all, but it's not strictly
>> illegal. However, since the ACPI System Memory address space is at most
>> 64-bit, anything that would actually overflow here is already describing an
>> impossibility - really, we should probably scream even louder about a
>> firmware bug and reject it entirely, rather than quietly hiding it.
> 
> Ah, looking again I see the paths. Either acpi_dma_get_range() returns
> success, in which case base and size are fine, or it returns an EINVAL,
> in which case base=size=0, or it returns ENODEV in which case base is
> zero, so size may be set to U64_MAX by rc_dma_get_range() with no problem.
> The !dev_is_pci(dev) path is also fine since base=0.

So practically putting an explicit memory_address_limit=64 is harmless
as dmaaddr always is 0, right?

In QEMU I intended to update the ACPI code to comply with the rev D
spec. in that case the RC table revision is 1 (rev D) and the
memory_address_limit needs to be filled. If we don't want to restrict
the limit, isn't it the right choice to set 64 here?

Thanks

Eric
> 
> While I agree that we should complain when firmware provides bad ACPI
> tables, my understanding of setting iort.memory_address_limit=64 was
> that it simply meant "no limit", regardless of the base. However I now
> see that it won't be used unless base=0. So I don't think we have a
> problem, and we don't even seem to be missing firmware sanity checks.
> 
> It might be nice to have a comment explaining this stuff somewhere, but
> otherwise sorry for the noise.
> 
> Thanks,
> drew
> 
>>
>> Robin.
>>
>>> Signed-off-by: Andrew Jones <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   drivers/acpi/arm64/iort.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index 70f4e80b9246..a0f4c157ba5e 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -1002,7 +1002,12 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>   	}
>>>   	if (!ret) {
>>> -		msb = fls64(dmaaddr + size - 1);
>>> +		u64 dmaaddr_max = dmaaddr + size - 1;
>>> +		if (dmaaddr_max >= dmaaddr)
>>> +			msb = fls64(dmaaddr_max);
>>> +		else
>>> +			msb = 64;
>>> +
>>>   		/*
>>>   		 * Round-up to the power-of-two mask or set
>>>   		 * the mask to the whole 64-bit address space
>>>
