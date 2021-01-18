Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26BC433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 18:41:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69332225E
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 18:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69332225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78B6A850E0;
	Mon, 18 Jan 2021 18:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GShYrp93Z-uL; Mon, 18 Jan 2021 18:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A39A847FE;
	Mon, 18 Jan 2021 18:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BADDC088B;
	Mon, 18 Jan 2021 18:41:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9895C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 18:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 987B0860D5
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 18:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9L1Vkpj8-dB for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 18:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0BC5D85CCF
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 18:41:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5894131B;
 Mon, 18 Jan 2021 10:41:32 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77F8E3F719;
 Mon, 18 Jan 2021 10:41:29 -0800 (PST)
Subject: Re: [PATCH v4 4/7] iommu: Switch gather->end to the inclusive end
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
 <20210107122909.16317-5-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9e49206b-0762-9451-a5ab-9cd7ad5959e0@arm.com>
Date: Mon, 18 Jan 2021 18:41:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210107122909.16317-5-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 David Laight <David.Laight@ACULAB.COM>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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

On 2021-01-07 12:29, Yong Wu wrote:
> Currently gather->end is "unsigned long" which may be overflow in
> arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
> Although it doesn't affect the size(end - start), it affects the checking
> "gather->end < end"
> 
> This patch changes this "end" to the real end address
> (end = start + size - 1). Correspondingly, update the length to
> "end - start + 1".
> 
> Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   drivers/iommu/mtk_iommu.c                   | 2 +-
>   drivers/iommu/tegra-gart.c                  | 2 +-
>   include/linux/iommu.h                       | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ca7415d785d..c70d6e79f534 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2280,7 +2280,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   
> -	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start,
> +	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start + 1,
>   			       gather->pgsize, true, smmu_domain);
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index f579fc21971e..66a00a2cb445 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -443,7 +443,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   				 struct iommu_iotlb_gather *gather)
>   {
>   	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> -	size_t length = gather->end - gather->start;
> +	size_t length = gather->end - gather->start + 1;
>   
>   	if (gather->start == ULONG_MAX)
>   		return;
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 05e8e19b8269..6f130e51f072 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -270,7 +270,7 @@ static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
>   static void gart_iommu_sync(struct iommu_domain *domain,
>   			    struct iommu_iotlb_gather *gather)
>   {
> -	size_t length = gather->end - gather->start;
> +	size_t length = gather->end - gather->start + 1;

TBH I don't think there's any need to bother doing precise calculations 
on effectively-uninitialised data (this driver doesn't even do 
address-based invalidation, let alone use the gather mechanism). In fact 
it might make sense to flip things around and define gart_iommu_sync_map 
in terms of gart_iommu_sync now just so there's one less unused argument 
to make up. However we can always do cleanup on top, and right now I'm 
more interested in getting these changes landed, so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	gart_iommu_sync_map(domain, gather->start, length);
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9ce0aa9e236b..ae8eddd4621b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -170,7 +170,7 @@ enum iommu_dev_features {
>    * struct iommu_iotlb_gather - Range information for a pending IOTLB flush
>    *
>    * @start: IOVA representing the start of the range to be flushed
> - * @end: IOVA representing the end of the range to be flushed (exclusive)
> + * @end: IOVA representing the end of the range to be flushed (inclusive)
>    * @pgsize: The interval at which to perform the flush
>    *
>    * This structure is intended to be updated by multiple calls to the
> @@ -539,7 +539,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   					       struct iommu_iotlb_gather *gather,
>   					       unsigned long iova, size_t size)
>   {
> -	unsigned long start = iova, end = start + size;
> +	unsigned long start = iova, end = start + size - 1;
>   
>   	/*
>   	 * If the new page is disjoint from the current range or is mapped at
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
