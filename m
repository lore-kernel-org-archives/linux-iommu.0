From: Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH 1/1] iommu/amd: Use delayed mmu release notifier
Date: Thu, 6 Nov 2014 15:48:51 +0200
Message-ID: <545B7C43.4020106@amd.com>
References: <54418D7F.3050304@amd.com> <20141106133354.GP10744@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141106133354.GP10744@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 11/06/2014 03:33 PM, Joerg Roedel wrote:
> On Sat, Oct 18, 2014 at 12:43:27AM +0300, Oded Gabbay wrote:
>> 3. Later, amdkfd's mmu notifier callback (kfd_process_notifier_release()) gets
>>     called and releases more things that are related to the process.
>>     In that function, amd_iommu_unbind_pasid() is explicitly called.
>
> Can't you just register a delayed funtion in
> kfd_process_notifier_release() and call amd_iommu_unbind_pasid() from
> there?
Maybe, I need to think about that. Anyway, I'm still not convinced, please see 
next question.

 >>I really hate to make that part of the IOMMUv2 driver API,
What do you mean ? I don't see I change anything in the API. All the changes are 
internal to amd_iommu_unbind_pasid(). I don't think *anyone* calling to 
amd_iommu_unbind_pasid() will care or will notice the slight change in timing of 
releasing the pasid_state object (instead of immediate release, it is released 
after the iteration on the mmu_notifier list has finished)

> especially since it is going to be turned into a generic IOMMU-API
> extension.
>
> And especially since all these hacks could be avoided if the KFD driver
> would just turn down everything on closing the file descriptor.
>
>
> 	Joerg
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
