From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix iova_to_phys for block entries
Date: Fri, 17 Jun 2016 15:07:36 +0100
Message-ID: <57640428.408@arm.com>
References: <1466099078-3919-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1466099078-3919-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 16/06/16 18:44, Will Deacon wrote:
> The implementation of iova_to_phys for the long-descriptor ARM
> io-pgtable code always masks with the granule size when inserting the
> low virtual address bits into the physical address determined from the
> page tables. In cases where the leaf entry is found before the final
> level of table (i.e. due to a block mapping), this results in rounding
> down to the bottom page of the block mapping. Consequently, the physical
> address range batching in the vfio_unmap_unpin is defeated and we end
> up taking the long way home.
>
> This patch fixes the problem by masking the virtual address with the
> appropriate mask for the level at which the leaf descriptor is located.
> The short-descriptor code already gets this right, so no change is
> needed there.

With this, I now see VFIO unmapping at the same granularity as the 
initial mapping. To think of all the cumulative hours we've spent 
watching it split the blocks and go 4K at a time... *sigh*

Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Reported-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>   drivers/iommu/io-pgtable-arm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a1ed1b73fed4..f5c90e1366ce 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -576,7 +576,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>   	return 0;
>
>   found_translation:
> -	iova &= (ARM_LPAE_GRANULE(data) - 1);
> +	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
>   	return ((phys_addr_t)iopte_to_pfn(pte,data) << data->pg_shift) | iova;
>   }
>
>
