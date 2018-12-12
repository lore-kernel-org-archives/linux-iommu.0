From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Don't check PHYS_OFFSET if
 RAMDOMIZE_BASE is enabled
Date: Wed, 12 Dec 2018 13:39:55 +0000
Message-ID: <50292758-47b1-1d08-5827-f7bdb3c33e1c@arm.com>
References: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, CK Hu <ck.hu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

On 12/12/2018 13:02, Yong Wu wrote:
> If CONFIG_RANDOMIZE_BASE is enabled, the "memstart_addr" will be updated
> randomly, then the PHYS_OFFSET may be random.

Oh, I hadn't ever realised that, good catch. However, since 29859aeb8a6e 
I think we should probably just remove this check altogether.

> Fixes: 82db33dc5e49 ("iommu/io-pgtable-arm: Check for v7s-incapable
> systems")

Note that this alone wouldn't be sufficient for stable prior to 4.18, 
since CONFIG_RANDOMIZE_BASE would then allow the original crash to 
happen again.

Robin.

> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bd..70941e6 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -709,7 +709,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   {
>   	struct arm_v7s_io_pgtable *data;
>   
> -#ifdef PHYS_OFFSET
> +#if defined(PHYS_OFFSET) && !defined(CONFIG_RANDOMIZE_BASE)
>   	if (upper_32_bits(PHYS_OFFSET))
>   		return NULL;
>   #endif
> 
