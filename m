From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/1] use documented cmpxchg api
Date: Fri, 06 Jun 2014 06:55:32 -0400
Message-ID: <53919E24.3010206@hurleysoftware.com>
References: <5390ED07.2070009@gatech.edu> <53910C95.7000808@hurleysoftware.com>
	<5391136C.3010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5391136C.3010809-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Pranith Kumar <bobby.prani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pranith Kumar <pranith-/4noJB3qBVQ3uPMLIKxrzw@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/05/2014 09:03 PM, Pranith Kumar wrote:
> On 06/05/2014 08:34 PM, Peter Hurley wrote:
>> On 06/05/2014 06:19 PM, Pranith Kumar wrote:
>>> use the documented atomic_cmpxchg instead of __cmpxchg64
>>>
>>> This kills the last user of said API in drivers code.
>>>
>>>
>>> Signed-off-by: Pranith Kumar <bobby.prani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>    drivers/iommu/intel-iommu.c |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 6bb3277..270113f 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -293,7 +293,7 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
>>>        return pte->val & VTD_PAGE_MASK;
>>>    #else
>>>        /* Must have a full atomic 64-bit read */
>>> -    return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>>> +    return  atomic_cmpxchg(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>>
>> This is not equivalent.
>>
>> The __cmpxchg64() is specifically being used in this case
>> when !CONFIG_64BIT for a full 64-bit RMW, whereas atomic_cmpxchg()
>> uses ints which would be 32-bit RMW.
>>
>
>
> You are right! The previous patch is wrong in that atomic_cmpxchg needs an atomic_t argument.
> cmpxchg() handles the size internally using typeof() to figure out the width of RMW.
> There is also an explicit cmpxchg64() which does the same thing.


This won't work either, and should generate a compile or link error
on CONFIG_X86_32.

The auto-sizing done by __cmpxchg() does not substitute the cmpxchg8b
instruction for the cmpxchg instruction. __X86_CASE_Q is defined as -1 for
CONFIG_X86_32 so the 8-byte size variant is dead-code, and calls
__cmpxchg_wrong_size() instead.


> Fixed with the following v2:
>
> use the documented cmpxchg instead of __cmpxchg64
>
> This kills the last user of said API in drivers code.
>
> Signed-off-by: Pranith Kumar <bobby.prani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/iommu/intel-iommu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6bb3277..270113f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -293,7 +293,7 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
>   	return pte->val & VTD_PAGE_MASK;
>   #else
>   	/* Must have a full atomic 64-bit read */
> -	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
> +	return  cmpxchg(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>   #endif
>   }
