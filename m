From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v1] iommu/io-pgtable-arm-v7s: Check for leaf entry
	right after finding it
Date: Tue, 21 Feb 2017 12:00:28 +0000
Message-ID: <bc24299c-748a-4b86-fead-a9ed6b5e5b9f@arm.com>
References: <1487253137-13792-1-git-send-email-olekstysh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1487253137-13792-1-git-send-email-olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 16/02/17 13:52, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> 
> Do a check for already installed leaf entry at the current level before
> performing any actions when trying to map.
> 
> This check is already present in arm_v7s_init_pte(), i.e. before
> installing new leaf entry at the current level if conditions to do so
> are met (num_entries > 0).
> 
> But, this might be insufficient in case when we have already
> installed block mapping at this level and it is not time to
> install new leaf entry (num_entries == 0).
> In that case we continue walking the page table down with wrong pointer
> to the next level.
> 
> So, move check from arm_v7s_init_pte() to __arm_v7s_map() in order to
> avoid all cases.

Would it not be more logical (and simpler) to just check that the thing
we dereference is valid to dereference when we dereference it? i.e.:

-----8<-----
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
b/drivers/iommu/io-pgtable-arm-v7s.c
index 0769276c0537..f3112f9ff494 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -418,8 +418,10 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable
*data, unsigned long iova,
                        pte |= ARM_V7S_ATTR_NS_TABLE;

                __arm_v7s_set_pte(ptep, pte, 1, cfg);
-       } else {
+       } else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
                cptep = iopte_deref(pte, lvl);
+       } else {
+               return -EEXIST;
        }

        /* Rinse, repeat */
----->8-----

I think the equivalent could be done in LPAE as well.

Robin.

> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> ---
> This patch does similar things as the patch I have pushed a week ago
> for long-descriptor format [1].
> The reason why this patch is RFC is because I am not sure I did the right
> thing and I even didn't test it.
> 
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
> ---
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index f50e51c..7f7594b 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -364,10 +364,6 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
>  			if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz,
>  						    sz, lvl, tblp) != sz))
>  				return -EINVAL;
> -		} else if (ptep[i]) {
> -			/* We require an unmap first */
> -			WARN_ON(!selftest_running);
> -			return -EEXIST;
>  		}
>  
>  	pte |= ARM_V7S_PTE_TYPE_PAGE;
> @@ -392,11 +388,20 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
>  {
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	arm_v7s_iopte pte, *cptep;
> -	int num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
> +	int i = 0, num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
>  
>  	/* Find our entry at the current level */
>  	ptep += ARM_V7S_LVL_IDX(iova, lvl);
>  
> +	/* Check for already installed leaf entry */
> +	do {
> +		if (ptep[i] && !ARM_V7S_PTE_IS_TABLE(ptep[i], lvl)) {
> +			/* We require an unmap first */
> +			WARN_ON(!selftest_running);
> +			return -EEXIST;
> +		}
> +	} while (++i < num_entries);
> +
>  	/* If we can install a leaf entry at this level, then do so */
>  	if (num_entries)
>  		return arm_v7s_init_pte(data, iova, paddr, prot,
> 
