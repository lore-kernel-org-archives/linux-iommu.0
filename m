Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D30C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 17:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D463B414C7;
	Wed, 15 Jun 2022 17:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cUZzoLWLvC0; Wed, 15 Jun 2022 17:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A8E8410AC;
	Wed, 15 Jun 2022 17:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19939C0039;
	Wed, 15 Jun 2022 17:14:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9E2C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 17:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A66840AFB
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 17:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bzJ6OWhE0TAc for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 17:14:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FCD9405DF
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 17:14:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC787153B;
 Wed, 15 Jun 2022 10:14:25 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FAB23F73B;
 Wed, 15 Jun 2022 10:14:23 -0700 (PDT)
Message-ID: <949c22c4-5f64-47cf-673c-14fcadcc1d27@arm.com>
Date: Wed, 15 Jun 2022 18:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 2/3] iommu/mediatek: Rename MTK_IOMMU_TLB_ADDR to
 MTK_IOMMU_ADDR
Content-Language: en-GB
To: yf.wang@mediatek.com, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20220615161224.6923-1-yf.wang@mediatek.com>
 <20220615161224.6923-3-yf.wang@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220615161224.6923-3-yf.wang@mediatek.com>
Cc: Ning Li <ning.li@mediatek.com>, Miles Chen <miles.chen@mediatek.com>,
 Libo Kang <Libo.Kang@mediatek.com>, wsd_upstream@mediatek.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-06-15 17:12, yf.wang--- via iommu wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR, and update MTK_IOMMU_ADDR
> definition for better generality.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3d62399e8865 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -265,8 +265,8 @@ static const struct iommu_ops mtk_iommu_ops;
>   
>   static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid);
>   
> -#define MTK_IOMMU_TLB_ADDR(iova) ({					\
> -	dma_addr_t _addr = iova;					\
> +#define MTK_IOMMU_ADDR(addr) ({						\
> +	unsigned long long _addr = addr;				\

If phys_addr_t is 64-bit, then dma_addr_t is also 64-bit, so there is no 
loss of generality from using an appropriate type - IOVAs have to fit 
into dma_addr_t for iommu-dma, after all. However, since IOVAs also have 
to fit into unsigned long in the general IOMMU API, as "addr" is here, 
then this is still just as broken for 32-bit LPAE as the existing code is.

Thanks,
Robin.

>   	((lower_32_bits(_addr) & GENMASK(31, 12)) | upper_32_bits(_addr));\
>   })
>   
> @@ -381,8 +381,8 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>   			       base + data->plat_data->inv_sel_reg);
>   
> -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base + REG_MMU_INVLD_START_A);
> -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
> +		writel_relaxed(MTK_IOMMU_ADDR(iova), base + REG_MMU_INVLD_START_A);
> +		writel_relaxed(MTK_IOMMU_ADDR(iova + size - 1),
>   			       base + REG_MMU_INVLD_END_A);
>   		writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
