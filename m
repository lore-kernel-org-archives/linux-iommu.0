From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iova: allow allocation of lowest domain PFN
Date: Mon, 15 May 2017 19:32:12 +0100
Message-ID: <3df9e5cd-0c42-8a6d-c3cf-0c3fe57729a0@arm.com>
References: <102275367.137137.1494509795293.JavaMail.zimbra@xes-inc.com>
	<7c703cfd-e667-bdce-de49-ae31a696b5dd@arm.com>
	<433111847.511288.1494527238012.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <433111847.511288.1494527238012.JavaMail.zimbra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Cc: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/05/17 19:27, Aaron Sierra wrote:
> ----- Original Message -----
>> From: "Robin Murphy" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> To: "Aaron Sierra" <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>, "Joerg Roedel" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Cc: "iommu" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Nate Watterson" <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Sent: Thursday, May 11, 2017 12:39:01 PM
>> Subject: Re: [PATCH] iova: allow allocation of lowest domain PFN
> 
> Robin,
> 
>> Hi Aaron,
>>
>> On 11/05/17 14:36, Aaron Sierra wrote:
>>> I found it was impossible to allocate all of the address space
>>> defined by an IOVA domain. For example, a trivial domain with 2 pages
>>> would cover PFNs 0 (start) and 1 (limit), but attempting to allocate
>>> more than one total PFN would fail because the start PFN could never be
>>> allocated.
>>
>> Does this only happen when start_pfn is 0? The recent fix in
>> 5016bdb796b3 implies that allocating the entire address space works
>> fine, albeit with a non-zero start_pfn. I was about to say that for all
>> current callers, start_pfn is always at least 1 anyway, but I see the
>> Nvidia DRM stuff in next is making that no longer true, oh well.
> 
> No, this limitation exists regardless of the start_pfn value. I've tested
> 0, 1, then powers-of-two up to half of the limit_pfn.
> 
> The problem with the test case laid out in 5016bdb796b3 is that start_pfn
> is 1 and limit_pfn is odd (as usual), so the number of available PFNs is odd.
> Therefore allocating two at a time can't possibly allocate all of the address
> space.

Ah, right you are. I had misread Nate's example as a 2-page address
space, not a 3-page one.

>>> This adds a function to prevent PFN limit calculations from dipping
>>> "below" the start PFN in __alloc_and_insert_iova_range() and
>>> __get_cached_rbnode(). It also alters the PFN validity checks in
>>> __alloc_and_insert_iova_range() to anticipate possible PFN rollover.
>>> These combine to allow every PFN within the IOVA domain to be available
>>> for allocation.
>>>
>>> Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>>  drivers/iommu/iova.c | 43 +++++++++++++++++++++++++++++++------------
>>>  1 file changed, 31 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 5c88ba7..9d92005b 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -32,6 +32,18 @@ static unsigned long iova_rcache_get(struct iova_domain
>>> *iovad,
>>>  static void init_iova_rcaches(struct iova_domain *iovad);
>>>  static void free_iova_rcaches(struct iova_domain *iovad);
>>>  
>>> +static inline unsigned long
>>> +bounded_next_pfn(struct iova_domain *iovad, struct iova *iova)
>>> +{
>>> +	unsigned long next_pfn = iova->pfn_lo - 1;
>>> +
>>> +	if (!iova->pfn_lo)
>>> +		return iovad->start_pfn;
>>> +
>>> +	/* make sure the PFN doesn't rollover */
>>> +	return (next_pfn > iova->pfn_lo) ? iovad->start_pfn : next_pfn;
>>
>> Why this check? Substituting the definition of next_pfn:
>>
>> 	((iova->pfn_lo - 1) > iova->pfn_lo)
>>
>> which is only true if iova->pfn_lo == 0, in which case we never get this
>> far anyway.
> 
> That's a good question. That should be able to be simplified.
>  
>> I'm also not sure about returning start_pfn instead of 0 in the
>> underflow case, since reserved entries may exist in the tree such that
>> pfn_lo < start_pfn, and I'm not convinced that returning a "next" PFN
>> which is actually "previous" to the lowest entry won't cause things to
>> go horrendously wrong.
> 
> I didn't realize that reservations could occur below the defined IOVA
> domain lower limit. Is that really intended behavior? I'd expected that if
> you wanted to reserve 0, for example, you'd define a domain starting at
> zero, then reserve that PFN before making the domain generally available.

Yes, reservations are inserted directly into the tree without reference
to the allocation limits. It's not really set in stone, but it seems
that the general pattern is the the limits are for addresses which would
never be considered valid (i.e. anything physically out of range for the
given device, plus 0 for the sake of software), whereas reservations are
for addresses which are nominally valid, but can't be remapped due to
other reasons.

> [ snip ]
> 
>>>  
>>> -	if (!curr) {
>>> -		if (size_aligned)
>>> -			pad_size = iova_get_pad_size(size, limit_pfn);
>>> -		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
>>
>> Wouldn't it be sufficient to just change this to
>>
>> 	if ((iovad->start_pfn + size + pad_size - 1) > limit_pfn)
> 
> That may be. My original solution was equivalent, but factored differently
> (i.e. limit_pfn + 1). I couldn't fully wrap my head around the logic and
> was worried about missing corner cases. If that is indeed a complete fix,
> could the refactoring below still be beneficial?

Having given it some more thought, it's clear that the fundamental
problem is that having both start_pfn and limit_pfn be inclusive creates
a troublesome ambiguity, and we're really just adding further
complication in attempts to paper over that. I reckon it might be a lot
more straightforward to cut that ambiguity out altogether by just making
limit_pfn exclusive, since it has plenty of room to avoid overflow -
I've lightly tested the below via dma-iommu (i.e. booting a machine and
doing some I/O), but at this stage it comes with no guarantees (after
all, it's basically the mother of all off-by-ones...)

If it checks out I'm happy to write up a proper patch.

Robin.

----->8-----
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 5c88ba70e4e0..0c809441f9c2 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -48,7 +48,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
long granule,
 	iovad->cached32_node = NULL;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
-	iovad->dma_32bit_pfn = pfn_32bit;
+	iovad->dma_32bit_pfn = pfn_32bit + 1;
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
@@ -63,7 +63,7 @@ __get_cached_rbnode(struct iova_domain *iovad,
unsigned long *limit_pfn)
 		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
 		struct iova *curr_iova =
 			rb_entry(iovad->cached32_node, struct iova, node);
-		*limit_pfn = curr_iova->pfn_lo - 1;
+		*limit_pfn = curr_iova->pfn_lo;
 		return prev_node;
 	}
 }
@@ -135,7 +135,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova
*iova,
 static unsigned int
 iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
 {
-	return (limit_pfn + 1 - size) & (__roundup_pow_of_two(size) - 1);
+	return (limit_pfn - size) & (__roundup_pow_of_two(size) - 1);
 }

 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
@@ -155,18 +155,18 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
 	while (curr) {
 		struct iova *curr_iova = rb_entry(curr, struct iova, node);

-		if (limit_pfn < curr_iova->pfn_lo)
+		if (limit_pfn <= curr_iova->pfn_lo)
 			goto move_left;
-		else if (limit_pfn < curr_iova->pfn_hi)
+		else if (limit_pfn <= curr_iova->pfn_hi)
 			goto adjust_limit_pfn;
 		else {
 			if (size_aligned)
 				pad_size = iova_get_pad_size(size, limit_pfn);
-			if ((curr_iova->pfn_hi + size + pad_size) <= limit_pfn)
+			if ((curr_iova->pfn_hi + size + pad_size) < limit_pfn)
 				break;	/* found a free slot */
 		}
 adjust_limit_pfn:
-		limit_pfn = curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
+		limit_pfn = curr_iova->pfn_lo;
 move_left:
 		prev = curr;
 		curr = rb_prev(curr);
@@ -182,7 +182,7 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
 	}

 	/* pfn_lo will point to size aligned address if size_aligned is set */
-	new->pfn_lo = limit_pfn - (size + pad_size) + 1;
+	new->pfn_lo = limit_pfn - (size + pad_size);
 	new->pfn_hi = new->pfn_lo + size - 1;

 	/* If we have 'prev', it's a valid place to start the insertion. */
@@ -269,7 +269,7 @@ alloc_iova(struct iova_domain *iovad, unsigned long
size,
 	if (!new_iova)
 		return NULL;

-	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
+	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
 			new_iova, size_aligned);

 	if (ret) {
