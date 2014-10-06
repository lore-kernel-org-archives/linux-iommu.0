From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 06 Oct 2014 12:02:47 -0700
Message-ID: <5432E757.10201@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
	<20140925170108.GE8306@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140925170108.GE8306-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 9/25/2014 10:01 AM, Joerg Roedel wrote:
> On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
>> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			       struct scatterlist *sg, unsigned int nents,
>> +			       int prot, unsigned long flags)
>> +{
>> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
>> +}
>> +
>> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
>> +				 unsigned long iova, size_t size,
>> +				 unsigned long flags)
>> +{
>> +	return domain->ops->unmap_sg(domain, iova, size, flags);
>> +}
>
> I have thought a little bit more about this interface and think that it
> would be better to just return a size_t from iommu_map_sg().  The
> function returns the amount of address space mapped by it, 0 in the
> worst case.
>
> This makes it easy to unmap the region just with
> iommu_unmap(domain, iova, size) in the end and removing the need for a
> new iommu_unmap_sg() function. Also the error-path of the map_sg
> call-backs becomes easier as the function then just returns the amount
> of address-space already mapped before the error happened.
>
> So the prototype would be:
>
> 	size_t iommu_map_sg(struct iommu_domain *domain,
> 			    unsigned long iova,
> 			    struct scatterlist *sg,
> 			    unsigned int nents,
> 			    int prot);
>
> (as I said before, the flags parameter should not be added by this
>   patch-set).
>

Ok, sounds good. I'll post v6 soon.

.Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
