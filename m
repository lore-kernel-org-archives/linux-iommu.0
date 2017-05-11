From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iova: allow allocation of lowest domain PFN
Date: Thu, 11 May 2017 13:27:18 -0500 (CDT)
Message-ID: <433111847.511288.1494527238012.JavaMail.zimbra@xes-inc.com>
References: <102275367.137137.1494509795293.JavaMail.zimbra@xes-inc.com>
	<7c703cfd-e667-bdce-de49-ae31a696b5dd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7c703cfd-e667-bdce-de49-ae31a696b5dd-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

----- Original Message -----
> From: "Robin Murphy" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> To: "Aaron Sierra" <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>, "Joerg Roedel" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: "iommu" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Nate Watterson" <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Sent: Thursday, May 11, 2017 12:39:01 PM
> Subject: Re: [PATCH] iova: allow allocation of lowest domain PFN

Robin,

> Hi Aaron,
> 
> On 11/05/17 14:36, Aaron Sierra wrote:
>> I found it was impossible to allocate all of the address space
>> defined by an IOVA domain. For example, a trivial domain with 2 pages
>> would cover PFNs 0 (start) and 1 (limit), but attempting to allocate
>> more than one total PFN would fail because the start PFN could never be
>> allocated.
> 
> Does this only happen when start_pfn is 0? The recent fix in
> 5016bdb796b3 implies that allocating the entire address space works
> fine, albeit with a non-zero start_pfn. I was about to say that for all
> current callers, start_pfn is always at least 1 anyway, but I see the
> Nvidia DRM stuff in next is making that no longer true, oh well.

No, this limitation exists regardless of the start_pfn value. I've tested
0, 1, then powers-of-two up to half of the limit_pfn.

The problem with the test case laid out in 5016bdb796b3 is that start_pfn
is 1 and limit_pfn is odd (as usual), so the number of available PFNs is odd.
Therefore allocating two at a time can't possibly allocate all of the address
space.

>> This adds a function to prevent PFN limit calculations from dipping
>> "below" the start PFN in __alloc_and_insert_iova_range() and
>> __get_cached_rbnode(). It also alters the PFN validity checks in
>> __alloc_and_insert_iova_range() to anticipate possible PFN rollover.
>> These combine to allow every PFN within the IOVA domain to be available
>> for allocation.
>> 
>> Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/iommu/iova.c | 43 +++++++++++++++++++++++++++++++------------
>>  1 file changed, 31 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 5c88ba7..9d92005b 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -32,6 +32,18 @@ static unsigned long iova_rcache_get(struct iova_domain
>> *iovad,
>>  static void init_iova_rcaches(struct iova_domain *iovad);
>>  static void free_iova_rcaches(struct iova_domain *iovad);
>>  
>> +static inline unsigned long
>> +bounded_next_pfn(struct iova_domain *iovad, struct iova *iova)
>> +{
>> +	unsigned long next_pfn = iova->pfn_lo - 1;
>> +
>> +	if (!iova->pfn_lo)
>> +		return iovad->start_pfn;
>> +
>> +	/* make sure the PFN doesn't rollover */
>> +	return (next_pfn > iova->pfn_lo) ? iovad->start_pfn : next_pfn;
> 
> Why this check? Substituting the definition of next_pfn:
> 
>	((iova->pfn_lo - 1) > iova->pfn_lo)
>
> which is only true if iova->pfn_lo == 0, in which case we never get this
> far anyway.

That's a good question. That should be able to be simplified.
 
> I'm also not sure about returning start_pfn instead of 0 in the
> underflow case, since reserved entries may exist in the tree such that
> pfn_lo < start_pfn, and I'm not convinced that returning a "next" PFN
> which is actually "previous" to the lowest entry won't cause things to
> go horrendously wrong.

I didn't realize that reservations could occur below the defined IOVA
domain lower limit. Is that really intended behavior? I'd expected that if
you wanted to reserve 0, for example, you'd define a domain starting at
zero, then reserve that PFN before making the domain generally available.

[ snip ]

>>  
>> -	if (!curr) {
>> -		if (size_aligned)
>> -			pad_size = iova_get_pad_size(size, limit_pfn);
>> -		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
> 
> Wouldn't it be sufficient to just change this to
> 
>	if ((iovad->start_pfn + size + pad_size - 1) > limit_pfn)

That may be. My original solution was equivalent, but factored differently
(i.e. limit_pfn + 1). I couldn't fully wrap my head around the logic and
was worried about missing corner cases. If that is indeed a complete fix,
could the refactoring below still be beneficial?

-Aaron S.

> ?
> 
> Since a size of 0 is invalid, that would appear to be sufficiently
> resistant to underflow.
> 
> Robin.
> 
>> -			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> -			return -ENOMEM;
>> -		}
>> -	}
>> +	if (size_aligned)
>> +		pad_size = iova_get_pad_size(size, limit_pfn);
>>  
>>  	/* pfn_lo will point to size aligned address if size_aligned is set */
>> -	new->pfn_lo = limit_pfn - (size + pad_size) + 1;
>> -	new->pfn_hi = new->pfn_lo + size - 1;
>> +	pfn_lo = limit_pfn - (size + pad_size) + 1;
>> +	pfn_hi = pfn_lo + size - 1;
>> +
>> +	/*
>> +	 * We're working with unsigned values, so we have to be careful about
>> +	 * how we detect a PFN "below" the lowest PFN possible; zero.
>> +	 */
>> +	if (pfn_lo < iovad->start_pfn || pfn_lo > limit_pfn) {
>> +		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	new->pfn_lo = pfn_lo;
>> +	new->pfn_hi = pfn_hi;
>>  
>>  	/* If we have 'prev', it's a valid place to start the insertion. */
>>  	iova_insert_rbtree(&iovad->rbroot, new, prev);
