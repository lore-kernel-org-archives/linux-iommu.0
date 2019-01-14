From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] ACPI/IORT: Handle potential overflow in iort_dma_setup
Date: Mon, 14 Jan 2019 16:29:27 +0100
Message-ID: <45ec247e-1517-0d68-0287-c3f0e957fe32@redhat.com>
References: <20181218184841.20034-1-drjones@redhat.com>
	<20181218184841.20034-2-drjones@redhat.com>
	<1503e3b8-1a6c-3b66-fa1e-d13f4e19f31f@arm.com>
	<20181219131849.hziujd5zgclangce@kamzik.brq.redhat.com>
	<fbf8dc04-6f80-b30b-c9ef-87fa3a33d0ec@redhat.com>
	<7acdfce6-0a0b-bf68-c5ff-8979721f4e83@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7acdfce6-0a0b-bf68-c5ff-8979721f4e83-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Andrew Jones <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 1/14/19 12:10 PM, Robin Murphy wrote:
> On 10/01/2019 10:44, Auger Eric wrote:
>> Hi Robin, Drew,
>>
>> On 12/19/18 2:18 PM, Andrew Jones wrote:
>>> On Wed, Dec 19, 2018 at 12:21:35PM +0000, Robin Murphy wrote:
>>>> On 18/12/2018 18:48, Andrew Jones wrote:
>>>>> The sum of dmaaddr and size may overflow, particularly considering
>>>>> there are cases where size will be U64_MAX.
>>>>
>>>> Only if the firmware is broken in the first place, though. It would
>>>> be weird
>>>> to describe an explicit _DMA range of base=0 and size=U64_MAX,
>>>> because it's
>>>> effectively the same as just not having one at all, but it's not
>>>> strictly
>>>> illegal. However, since the ACPI System Memory address space is at most
>>>> 64-bit, anything that would actually overflow here is already
>>>> describing an
>>>> impossibility - really, we should probably scream even louder about a
>>>> firmware bug and reject it entirely, rather than quietly hiding it.
>>>
>>> Ah, looking again I see the paths. Either acpi_dma_get_range() returns
>>> success, in which case base and size are fine, or it returns an EINVAL,
>>> in which case base=size=0, or it returns ENODEV in which case base is
>>> zero, so size may be set to U64_MAX by rc_dma_get_range() with no
>>> problem.
>>> The !dev_is_pci(dev) path is also fine since base=0.
>>
>> So practically putting an explicit memory_address_limit=64 is harmless
>> as dmaaddr always is 0, right?
>>
>> In QEMU I intended to update the ACPI code to comply with the rev D
>> spec. in that case the RC table revision is 1 (rev D) and the
>> memory_address_limit needs to be filled. If we don't want to restrict
>> the limit, isn't it the right choice to set 64 here?
> 
> Indeed, the Memory Address Size Limit doesn't cater for offsets so can't
> run into this kind of overflow in the first place. For a fully-emulated
> PCI hierarchy I'd say 64 is not just harmless but in fact entirely
> correct - you're going to have more fun with VFIO passthrough if the
> host tables have more restrictive limits, but I guess that's a problem
> for the future ;)
Yes but that's a good point to notice!

Thanks

Eric
> 
> Robin.
