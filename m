From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/2] vfio/type1: Adopt fast IOTLB flush interface when
 unmap IOVAs
Date: Mon, 27 Nov 2017 15:12:25 +0700
Message-ID: <fd7a06db-0f40-c72a-532a-d946477fb19e@amd.com>
References: <1510953080-5619-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1510953080-5619-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20171117145152.41fae930@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117145152.41fae930@t450s.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On 11/18/17 4:51 AM, Alex Williamson wrote:
> On Fri, 17 Nov 2017 15:11:19 -0600
> Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>  wrote:
> 
>> From: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>>
>> VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
>> IOTLB flushing for every unmapping. This results in large IOTLB flushing
>> overhead when handling pass-through devices with a large number of mapped
>> IOVAs (e.g. GPUs).
> Of course the type of device is really irrelevant, QEMU maps the entire
> VM address space for any assigned device.

Right, in this case certain high performance dGPUs map large address space.

> 
>> This can be avoided by using the new IOTLB flushing interface.
>>
>> Cc: Alex Williamson<alex.williamson@redhat.com>
>> Cc: Joerg Roedel<jroedel@suse.de>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 92155cc..28a7ab6 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -698,10 +698,12 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>   				break;
>>   		}
>>   
>> -		unmapped = iommu_unmap(domain->domain, iova, len);
>> +		unmapped = iommu_unmap_fast(domain->domain, iova, len);
>>   		if (WARN_ON(!unmapped))
>>   			break;
>>   
>> +		iommu_tlb_range_add(domain->domain, iova, len);
>> +
> We should only add @unmapped, not @len, right?

Hm right, I will change this in V2.

Thanks,
Suravee
