From: Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH 1/1] iommu/amd: Use delayed mmu release notifier
Date: Fri, 7 Nov 2014 22:22:14 +0200
Message-ID: <545D29F6.1000200@amd.com>
References: <54418D7F.3050304@amd.com> <20141106133354.GP10744@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
>>    called and releases more things that are related to the process.
>>    In that function, amd_iommu_unbind_pasid() is explicitly called.
> 
> Can't you just register a delayed funtion in
> kfd_process_notifier_release() and call amd_iommu_unbind_pasid() from
> there? 
OK, I implemented that and I don't need to change the IOMMUv2 code anymore.
So, I think we can conclude this discussion at this point :)

	Oded

I really hate to make that part of the IOMMUv2 driver API,
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
