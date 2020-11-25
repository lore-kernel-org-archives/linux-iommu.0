Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0FC63798
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B432087C
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B432087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D0D5872E1;
	Wed, 25 Nov 2020 16:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id heEr4XqCZ95W; Wed, 25 Nov 2020 16:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 951ED872ED;
	Wed, 25 Nov 2020 16:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81858C0891;
	Wed, 25 Nov 2020 16:38:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5C31C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B6D762E19F
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ueGZuACFROcw for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 16:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id C64EA203B4
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A0631B;
 Wed, 25 Nov 2020 08:38:25 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBEA3F7BB;
 Wed, 25 Nov 2020 08:38:22 -0800 (PST)
Subject: Re: [PATCH v2 3/6] iommu/mediatek: Add iotlb_sync_map to sync whole
 the iova range
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
 <20201119061836.15238-4-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <751e08a1-d3c3-29f9-5c62-560370ac0703@arm.com>
Date: Wed, 25 Nov 2020 16:38:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-4-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, jun.wen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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

On 2020-11-19 06:18, Yong Wu wrote:
> Remove IO_PGTABLE_QUIRK_TLBI_ON_MAP to avoid tlb sync for each a small
> chunk memory, Use the new iotlb_sync_map to tlb_sync once for whole the
> iova range of iommu_map.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> After reading msm_iommu.c, It looks IO_PGTABLE_QUIRK_TLBI_ON_MAP can be
> removed.
> ---
>   drivers/iommu/mtk_iommu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c072cee532c2..8c2d4a225666 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -323,7 +323,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>   	dom->cfg = (struct io_pgtable_cfg) {
>   		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
>   			IO_PGTABLE_QUIRK_NO_PERMS |
> -			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
>   			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
>   		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
>   		.ias = 32,
> @@ -454,6 +453,14 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   				       data);
>   }
>   
> +static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size)
> +{
> +	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +
> +	mtk_iommu_tlb_flush_range_sync(iova, size, size, dom->data);

So we have a conflict/dependency against the MT8192 series here - I 
guess we need to make a decision up-front about which series should go 
first. Other than that, though:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +}
> +
>   static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>   					  dma_addr_t iova)
>   {
> @@ -540,6 +547,7 @@ static const struct iommu_ops mtk_iommu_ops = {
>   	.unmap		= mtk_iommu_unmap,
>   	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
>   	.iotlb_sync	= mtk_iommu_iotlb_sync,
> +	.iotlb_sync_map	= mtk_iommu_sync_map,
>   	.iova_to_phys	= mtk_iommu_iova_to_phys,
>   	.probe_device	= mtk_iommu_probe_device,
>   	.release_device	= mtk_iommu_release_device,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
