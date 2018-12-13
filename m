From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Check for v7s-incapable
 systems"
Date: Thu, 13 Dec 2018 10:26:13 +0000
Message-ID: <38526eab-3010-1ce6-a801-28f5c15dce44@arm.com>
References: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, CK Hu <ck.hu@mediatek.com>, Stephen Boyd <swboyd@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On 2018-12-13 9:19 am, Yong Wu wrote:
> This reverts commit 82db33dc5e49fb625262d81125625d07a0d6184e.
> 
> After the commit 29859aeb8a6e ("iommu/io-pgtable-arm-v7s: Abort
> allocation when table address overflows the PTE"), v7s will return fail
> if the page table allocation isn't expected. this PHYS_OFFSET check
> is unnecessary now.
> 
> And this check may lead to fail. For example, If CONFIG_RANDOMIZE_BASE
> is enabled, the "memstart_addr" will be updated randomly, then the
> PHYS_OFFSET may be random.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Joerg, if you have any more fixes to send for 4.19, please consider 
picking this up directly.

Thanks,
Robin.

> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bd..cec29bf 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -709,10 +709,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   {
>   	struct arm_v7s_io_pgtable *data;
>   
> -#ifdef PHYS_OFFSET
> -	if (upper_32_bits(PHYS_OFFSET))
> -		return NULL;
> -#endif
>   	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>   		return NULL;
>   
> 
