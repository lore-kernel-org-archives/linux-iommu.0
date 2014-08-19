From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Tue, 19 Aug 2014 11:37:02 -0700
Message-ID: <53F3994E.7080104@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
	<20140818215553.GJ9809@8bytes.org>
	<53F2829C.2040809@codeaurora.org>
	<20140819115954.GC16329@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140819115954.GC16329-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 8/19/2014 4:59 AM, Joerg Roedel wrote:
> On Mon, Aug 18, 2014 at 03:47:56PM -0700, Olav Haugan wrote:
>> If the alignment is not correct then iommu_map() will return error. Not
>> sure what other option we have here (and why make it different behavior
>> than iommu_map which just return error when it is not aligned properly).
>> I don't think we want to force any kind of alignment automatically. I
>> would rather have the API tell me I am doing something wrong than having
>> the function aligning the values and possibly undermap or overmap.
> 
> But sg->offset is an offset into the page (at least it is used that way
> in the DMA-API and since you do 'page_len = s->offset + s->length' you
> use it the same way).
> So when you pass iova + offset the result will no longer be
> page-aligned. You should force sg->offset == 0 and sg->length to be
> page-aligned instead. This makes more sense because the IOMMU-API works
> on (io)-page granularity and not on arbitrary phys-addr ranges like the
> DMA-API.

Ok, but I don't think we want to force a specific alignment here (as I
discussed earlier with Will D.). So I would just do something like
	
	iommu_map(domain, iova + offset, phys, s->length, prot);
	offset += s->length;

>> Yes, I am aware of that. However, several people prefer this than
>> passing in scatterlist. It is not very convenient to pass a scatterlist
>> in some use cases. Someone mentioned a use case where they would have to
>> create a dummy sg list and populate it with the iova just to do an
>> unmap. I believe we would have to do this also. There is no use for
>> sglist when unmapping. However, would like to keep separate API from
>> iommu_unmap() to keep the API function names symmetric (map_sg/unmap_sg).
> 
> Keeping it symetric is not more complicated, the caller just needs to
> keep the sg-list used for mapping around. I prefer the unmap_sg call to
> work in sg-lists too.

So are you looking for something like this then:

int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
			 struct scatterlist *sg, unsigned int nents,
			 int prot, unsigned long flags)

int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
			 struct scatterlist *sg, unsigned int nents,
			 unsigned long flags)

This makes unmapping code more complicated (and slow) though. For
example the way I would implement the fallback would be to iterate
through the sglist first to calculate the total length to unmap and then
call iommu_unmap().

I know we talked about removing the flag argument in the map call.
However, the TLB_NO_INV usage is actually needed for both map and unmap.
We have HW that requires TLB invalidate on MAP and TLB inv. is also
required if you implement your mapping function to support replacing an
existing mapping...

Rob, did you have an issue with this API before or was it just an issue
with not having the iova in the unmap call?

>> I thought that was why we added the default fallback and set all the
>> drivers to point to these fallback functions. Several people wanted this
>> so that we don't have to have NULL-check in these functions (and have
>> the functions be simple inline functions).
> 
> Okay, since you add these call-backs to all drivers I think I can live
> with not doing a pointer check here.
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
