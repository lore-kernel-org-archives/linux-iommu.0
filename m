From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix race handling in
	split_blk_unmap()
Date: Thu, 6 Sep 2018 12:14:31 +0100
Message-ID: <eadb6ac0-1d7c-2735-c1b4-5aea8f7749bd@arm.com>
References: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
	<20180906100527.GF3592@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180906100527.GF3592-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/09/18 11:05, Will Deacon wrote:
> Hi Robin,
> 
> On Thu, Aug 23, 2018 at 01:14:59PM +0100, Robin Murphy wrote:
>> In removing the pagetable-wide lock, we gained the possibility of the
>> vanishingly unlikely case where we have a race between two concurrent
>> unmappers splitting the same block entry. The logic to handle this is
>> fairly straightforward - whoever loses the race frees their partial
>> next-level table and instead dereferences the winner's newly-installed
>> entry in order to fall back to a regular unmap, which intentionally
>> echoes the pre-existing case of recursively splitting a 1GB block down
>> to 4KB pages by installing a full table of 2MB blocks first.
>>
>> Unfortunately, the chump who implemented that logic failed to update the
>> condition check for that fallback, meaning that if said race occurs at
>> the last level (where the loser's unmap_idx is valid) then the unmap
>> won't actually happen. Fix that to properly account for both the race
>> and recursive cases.
>>
>> Fixes: 2c3d273eabe8 ("iommu/io-pgtable-arm: Support lockless operation")
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Well spotted! Did you just find this by inspection?

Indeed - I just kept seeing this bit in the context of the other patches 
and thinking "hang on, how do we actually use that new tablep after the 
deref?".

IIRC I actually implemented the new logic for v7s first, so clearly made 
the blunder in adding the recursive case when porting the change to LPAE.

>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 010a254305dd..93b4833cef73 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -575,7 +575,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>   		tablep = iopte_deref(pte, data);
>>   	}
>>   
>> -	if (unmap_idx < 0)
>> +	if (unmap_idx < 0 || pte != blk_pte)
>>   		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
> 
> Can we tidy up the control flow a bit here to avoid re-checking the status
> of the cmpxchg? See below.

Sure, I just made the minimal change for correctness so as not to 
overcomplicate matters, but I'm pretty sure that diff looks correct. 
Feel free to squash it in if you're planning on taking this (yes it's 
nominally a fix, but it's absolutely non-urgent on account of nobody 
will ever realistically hit this).

Robin.

> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 88641b4560bc..2f79efd16a05 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -574,13 +574,12 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   			return 0;
>   
>   		tablep = iopte_deref(pte, data);
> +	} else if (unmap_idx >= 0) {
> +		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
> +		return size;
>   	}
>   
> -	if (unmap_idx < 0)
> -		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
> -
> -	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
> -	return size;
> +	return __arm_lpae_unmap(data, iova, size, lvl, tablep);
>   }
>   
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> 
