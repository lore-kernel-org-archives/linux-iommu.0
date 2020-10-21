Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00AC388F9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 16:56:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F411223BF
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 16:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F411223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 98EC98748B;
	Wed, 21 Oct 2020 16:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Nvop3KQDOXp; Wed, 21 Oct 2020 16:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4DD6B8748D;
	Wed, 21 Oct 2020 16:56:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3684AC0052;
	Wed, 21 Oct 2020 16:56:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B95CC0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 16:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 172F78680B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 16:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_x7ZY5QR0MR for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 16:56:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 65C128685B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 16:56:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 764FF31B;
 Wed, 21 Oct 2020 09:56:08 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24073F719;
 Wed, 21 Oct 2020 09:56:03 -0700 (PDT)
Subject: Re: [PATCH 2/4] iommu/mediatek: Add iotlb_sync_range() support
To: Chao Hao <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
 <20201019113100.23661-3-chao.hao@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7fbe0305-91e4-949e-7d84-bf91e81d6b27@arm.com>
Date: Wed, 21 Oct 2020 17:55:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019113100.23661-3-chao.hao@mediatek.com>
Content-Language: en-GB
Cc: Jun Wen <jun.wen@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Mingyuan Ma <mingyuan.ma@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-10-19 12:30, Chao Hao wrote:
> MTK_IOMMU driver writes one page entry and does tlb flush at a time
> currently. More optimal would be to aggregate the writes and flush
> BUS buffer in the end.

That's exactly what iommu_iotlb_gather_add_page() is meant to achieve. 
Rather than jumping straight into hacking up a new API to go round the 
back of the existing API design, it would be far better to ask the 
question of why that's not behaving as expected.

> For 50MB buffer mapping, if mtk_iommu driver use iotlb_sync_range()
> instead of tlb_add_range() and tlb_flush_walk/leaf(), it can increase
> 50% performance or more(depending on size of every page size) in
> comparison to flushing after each page entry update. So we prefer to
> use iotlb_sync_range() to replace iotlb_sync(), tlb_add_range() and
> tlb_flush_walk/leaf() for MTK platforms.

In the case of mapping, it sounds like what you actually want to do is 
hook up .iotlb_sync_map and generally make IO_PGTABLE_QUIRK_TLBI_ON_MAP 
cleverer, because the current implementation is as dumb as it could 
possibly be. In fact if we simply passed an address range to 
.iotlb_sync_map, io-pgtable probably wouldn't need to be involved at all 
any more.

Robin.

> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 785b228d39a6..d3400c15ff7b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -224,6 +224,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   	}
>   }
>   
> +static void __mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size)
> +{
> +	mtk_iommu_tlb_flush_range_sync(iova, size, 0, NULL)
> +}
> +
>   static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>   					    unsigned long iova, size_t granule,
>   					    void *cookie)
> @@ -536,6 +541,7 @@ static const struct iommu_ops mtk_iommu_ops = {
>   	.map		= mtk_iommu_map,
>   	.unmap		= mtk_iommu_unmap,
>   	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
> +	.iotlb_sync_range = __mtk_iommu_tlb_flush_range_sync,
>   	.iotlb_sync	= mtk_iommu_iotlb_sync,
>   	.iova_to_phys	= mtk_iommu_iova_to_phys,
>   	.probe_device	= mtk_iommu_probe_device,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
