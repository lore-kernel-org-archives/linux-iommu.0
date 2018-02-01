From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return
 type
Date: Thu, 1 Feb 2018 12:03:46 +0700
Message-ID: <de21de51-1589-edb1-3dd1-b7065eb8fb3c@amd.com>
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
 <eaa33cb6-3df0-6f95-59ea-e563076d7f76@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <eaa33cb6-3df0-6f95-59ea-e563076d7f76@arm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 2/1/18 1:02 AM, Robin Murphy wrote:
> Hi Suravee,
> 
> On 31/01/18 01:48, Suravee Suthikulpanit wrote:
>> Currently, iommu_unmap and iommu_unmap_fast return unmapped
>> pages with size_t.  However, the actual value returned could
>> be error codes (< 0), which can be misinterpreted as large
>> number of unmapped pages. Therefore, change the return type to ssize_t.
>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd_iommu.c   |  6 +++---
>>   drivers/iommu/intel-iommu.c |  4 ++--
> 
> Er, there are a few more drivers than that implementing iommu_ops ;)

Ahh right.
> 
> It seems like it might be more sensible to fix the single instance of a driver returning -EINVAL (which appears to be a "should never happen if used correctly" kinda thing anyway) and leave the API-internal callback prototype as-is. I do agree the inconsistency of iommu_unmap() itself wants sorting, though (particularly the !IOMMU_API stubs which are wrong either way).
> 
> Robin.

Make sense. I'll leave the API alone, and change the code to not returning error then.
There are a few places to fix.

Thanks,
Suravee
