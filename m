From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Sat, 10 Dec 2016 21:05:53 -0500
Message-ID: <584CB481.3040902@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
	<c5d4efa7-699d-4aa3-44cc-4ce03d0ce185@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c5d4efa7-699d-4aa3-44cc-4ce03d0ce185-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/08/2016 04:36 AM, Auger Eric wrote:
> Hi,
>
> On 15/11/2016 14:09, Eric Auger wrote:
>> Following LPC discussions, we now report reserved regions through
>> iommu-group sysfs reserved_regions attribute file.
>
>
> While I am respinning this series into v4, here is a tentative summary
> of technical topics for which no consensus was reached at this point.
>
> 1) Shall we report the usable IOVA range instead of reserved IOVA
>     ranges. Not discussed at/after LPC.
>     x I currently report reserved regions. Alex expressed the need to
>       report the full usable IOVA range instead (x86 min-max range
>       minus MSI APIC window). I think this is meaningful for ARM
>       too where arm-smmu might not support the full 64b range.
>     x Any objection we report the usable IOVA regions instead?
>
> 2) Shall the kernel check collision with MSI window* when userspace
>     calls VFIO_IOMMU_MAP_DMA?
>     Joerg/Will No; Alex yes
>     *for IOVA regions consumed downstream to the IOMMU: everyone says NO
>
> 3) RMRR reporting in the iommu group sysfs? Joerg: yes; Don: no
Um, I'm missing context, but the only thing I recall saying no to wrt RMRR
is that _any_ device that has an RMRR cannot be assigned to a guest.
Or, are you saying, RMRR's should be exposed in the guest os?  if so, then
you have my 'no' there.

>     My current series does not expose them in iommu group sysfs.
>     I understand we can expose the RMRR regions in the iomm group sysfs
>     without necessarily supporting RMRR requiring device assignment.
This sentence doesn't make sense to me.
Can you try re-wording it?
I can't tell what RMRR has to do w/device assignment, other than what I said above.
Exposing RMRR's in sysfs is not an issue in general.

>     We can also add this support later.
>
> Thanks
>
> Eric
>
>
>>
>> Reserved regions are populated through the IOMMU get_resv_region callback
>> (former get_dm_regions), now implemented by amd-iommu, intel-iommu and
>> arm-smmu.
>>
>> The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
>> IOMMU_RESV_NOMAP reserved region.
>>
>> arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and
>> 1MB large) and the PCI host bridge windows.
>>
>> The series integrates a not officially posted patch from Robin:
>> "iommu/dma: Allow MSI-only cookies".
>>
>> This series currently does not address IRQ safety assessment.
>>
>> Best Regards
>>
>> Eric
>>
>> Git: complete series available at
>> https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3
>>
>> History:
>> RFC v2 -> v3:
>> - switch to an iommu-group sysfs API
>> - use new dummy allocator provided by Robin
>> - dummy allocator initialized by vfio-iommu-type1 after enumerating
>>    the reserved regions
>> - at the moment ARM MSI base address/size is left unchanged compared
>>    to v2
>> - we currently report reserved regions and not usable IOVA regions as
>>    requested by Alex
>>
>> RFC v1 -> v2:
>> - fix intel_add_reserved_regions
>> - add mutex lock/unlock in vfio_iommu_type1
>>
>>
>> Eric Auger (10):
>>    iommu/dma: Allow MSI-only cookies
>>    iommu: Rename iommu_dm_regions into iommu_resv_regions
>>    iommu: Add new reserved IOMMU attributes
>>    iommu: iommu_alloc_resv_region
>>    iommu: Do not map reserved regions
>>    iommu: iommu_get_group_resv_regions
>>    iommu: Implement reserved_regions iommu-group sysfs file
>>    iommu/vt-d: Implement reserved region get/put callbacks
>>    iommu/arm-smmu: Implement reserved region get/put callbacks
>>    vfio/type1: Get MSI cookie
>>
>>   drivers/iommu/amd_iommu.c       |  20 +++---
>>   drivers/iommu/arm-smmu.c        |  52 +++++++++++++++
>>   drivers/iommu/dma-iommu.c       | 116 ++++++++++++++++++++++++++-------
>>   drivers/iommu/intel-iommu.c     |  50 ++++++++++----
>>   drivers/iommu/iommu.c           | 141 ++++++++++++++++++++++++++++++++++++----
>>   drivers/vfio/vfio_iommu_type1.c |  26 ++++++++
>>   include/linux/dma-iommu.h       |   7 ++
>>   include/linux/iommu.h           |  49 ++++++++++----
>>   8 files changed, 391 insertions(+), 70 deletions(-)
>>
