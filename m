Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B05C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 16:18:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2B522228
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 16:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2B522228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE6EB84AAB;
	Mon, 18 Jan 2021 16:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3S9G8bdMYfX7; Mon, 18 Jan 2021 16:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C7FB8449E;
	Mon, 18 Jan 2021 16:18:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 130A6C088B;
	Mon, 18 Jan 2021 16:18:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5472BC013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 50AAB8449E
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Et9nyygmnm6g for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 16:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6C70B84B62
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:18:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF3C31B;
 Mon, 18 Jan 2021 08:18:07 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86073F68F;
 Mon, 18 Jan 2021 08:18:04 -0800 (PST)
Subject: Re: [PATCH v3 5/7] iommu: Allow io_pgtable_tlb ops optional
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-6-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <310cc809-ac74-7048-8718-c65c815a1faa@arm.com>
Date: Mon, 18 Jan 2021 16:18:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201216103607.23050-6-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

On 2020-12-16 10:36, Yong Wu wrote:
> This patch allows io_pgtable_tlb ops could be null since the IOMMU drivers
> may use the tlb ops from iommu framework.

There's not much in it, but I guess this does make more sense overall 
than just making .tlb_flush_all optional and drivers having to provide a 
full set of NULL callbacks.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   include/linux/io-pgtable.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index adde9e49be08..c81796814afa 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -206,14 +206,16 @@ struct io_pgtable {
>   
>   static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
>   {
> -	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> +	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_all)
> +		iop->cfg.tlb->tlb_flush_all(iop->cookie);
>   }
>   
>   static inline void
>   io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
>   			  size_t size, size_t granule)
>   {
> -	iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
> +	if (iop->cfg.tlb && iop->cfg.tlb->tlb_flush_walk)
> +		iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
>   }
>   
>   static inline void
> @@ -221,7 +223,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
>   			struct iommu_iotlb_gather * gather, unsigned long iova,
>   			size_t granule)
>   {
> -	if (iop->cfg.tlb->tlb_add_page)
> +	if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
>   		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
