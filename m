From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Thu, 16 Oct 2014 10:23:07 -0700
Message-ID: <543FFEFB.2010604@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org> <1407797150-515-2-git-send-email-ohaugan@codeaurora.org> <20140925170108.GE8306@8bytes.org> <5432E757.10201@codeaurora.org> <20141015091652.GB13162@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141015091652.GB13162@ulmo>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, laurent.pinchart+renesas@ideasonboard.com, konrad.wilk@oracle.com, mitchelh@codeaurora.org, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, robdclark@gmail.com, Varun.Sethi@freescale.com, kgene.kim@samsung.com, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, hdoyu@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On 10/15/2014 2:16 AM, Thierry Reding wrote:
> On Mon, Oct 06, 2014 at 12:02:47PM -0700, Olav Haugan wrote:
>> On 9/25/2014 10:01 AM, Joerg Roedel wrote:
>>> On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
>>>> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>>>> +			       struct scatterlist *sg, unsigned int nents,
>>>> +			       int prot, unsigned long flags)
>>>> +{
>>>> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
>>>> +}
>>>> +
>>>> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
>>>> +				 unsigned long iova, size_t size,
>>>> +				 unsigned long flags)
>>>> +{
>>>> +	return domain->ops->unmap_sg(domain, iova, size, flags);
>>>> +}
>>>
>>> I have thought a little bit more about this interface and think that it
>>> would be better to just return a size_t from iommu_map_sg().  The
>>> function returns the amount of address space mapped by it, 0 in the
>>> worst case.
>>>
>>> This makes it easy to unmap the region just with
>>> iommu_unmap(domain, iova, size) in the end and removing the need for a
>>> new iommu_unmap_sg() function. Also the error-path of the map_sg
>>> call-backs becomes easier as the function then just returns the amount
>>> of address-space already mapped before the error happened.
>>>
>>> So the prototype would be:
>>>
>>> 	size_t iommu_map_sg(struct iommu_domain *domain,
>>> 			    unsigned long iova,
>>> 			    struct scatterlist *sg,
>>> 			    unsigned int nents,
>>> 			    int prot);
>>>
>>> (as I said before, the flags parameter should not be added by this
>>>   patch-set).
>>>
>>
>> Ok, sounds good. I'll post v6 soon.
>
> Perhaps make the return value ssize_t so that we can propagate errors?
>

I am fine with that. Joerg?

Thanks,

.Olav

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
