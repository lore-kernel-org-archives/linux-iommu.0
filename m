From: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v1] iommu/io-pgtable-arm: Check for leaf entry right
	after finding it
Date: Mon, 13 Feb 2017 13:07:02 +0200
Message-ID: <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
References: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486648600-27457-1-git-send-email-olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, Volodymyr Babchuk <vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, Andrii Anisov <andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleksandr Andrushchenko <andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, al1img <al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Artem Mygaiev <joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, all.

Any comments?

On Thu, Feb 9, 2017 at 3:56 PM, Oleksandr Tyshchenko
<olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
>
> Do a check for already installed leaf entry at the current level before
> performing any actions when trying to map.
>
> This check is already present in arm_lpae_init_pte(), i.e. before
> installing new leaf entry at the current level if conditions to do so
> are met (size == block_size).
>
> But, this might be insufficient in case when we have already
> installed block mapping at this level and it is not time to
> install new leaf entry (size != block_size).
> In that case we continue walking the page table down with wrong pointer
> to the next level.
>
> So, move check from arm_lpae_init_pte() to __arm_lpae_map() in order to
> avoid all cases.
>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> ---
> I hope that following actions can help to catch it:
> 1. Call iommu_map for a block mapping (e.g. 2M) at some address
>    (e.g. iova 0x80000000 pa 0x80000000).
> 2. Call iommu_map for a page mapping (4k) at some address from
>    the previous mapped region (e.g. iova 0x80008000 pa 0x90000000).
>
> I understand that after iommu_map should be iommu_unmap, but
> different scenarios may occur).
> ---
> ---
>  drivers/iommu/io-pgtable-arm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5c90e1..ebdb82f 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -272,11 +272,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>         arm_lpae_iopte pte = prot;
>         struct io_pgtable_cfg *cfg = &data->iop.cfg;
>
> -       if (iopte_leaf(*ptep, lvl)) {
> -               /* We require an unmap first */
> -               WARN_ON(!selftest_running);
> -               return -EEXIST;
> -       } else if (iopte_type(*ptep, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
> +       if (iopte_type(*ptep, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
>                 /*
>                  * We need to unmap and free the old table before
>                  * overwriting it with a block entry.
> @@ -315,6 +311,13 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>         /* Find our entry at the current level */
>         ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
>
> +       /* Check for already installed leaf entry */
> +       if (iopte_leaf(*ptep, lvl)) {
> +               /* We require an unmap first */
> +               WARN_ON(!selftest_running);
> +               return -EEXIST;
> +       }
> +
>         /* If we can install a leaf entry at this level, then do so */
>         if (size == block_size && (size & cfg->pgsize_bitmap))
>                 return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
> --
> 2.7.4
>



-- 
Regards,

Oleksandr Tyshchenko
