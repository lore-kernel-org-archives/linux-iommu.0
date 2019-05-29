Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BDFC28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 10:15:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360222075B
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 10:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360222075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06F0824B7;
	Wed, 29 May 2019 10:15:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 436EB24AC
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 10:12:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DB346884
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 10:12:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F789341;
	Wed, 29 May 2019 03:12:20 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FCBC3F59C;
	Wed, 29 May 2019 03:12:18 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix condition check in iommu_dma_unmap_sg
To: Nathan Chancellor <natechancellor@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
References: <20190529081532.73585-1-natechancellor@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8c21972-cb70-34ff-949d-5e2555c3a1fb@arm.com>
Date: Wed, 29 May 2019 11:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529081532.73585-1-natechancellor@gmail.com>
Content-Language: en-GB
Cc: clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org,
	Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 29/05/2019 09:15, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/iommu/dma-iommu.c:897:6: warning: logical not is only applied to
> the left hand side of this comparison [-Wlogical-not-parentheses]
>          if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>              ^                                 ~~
> drivers/iommu/dma-iommu.c:897:6: note: add parentheses after the '!' to
> evaluate the comparison first
>          if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>              ^
>               (                                    )
> drivers/iommu/dma-iommu.c:897:6: note: add parentheses around left hand
> side expression to silence this warning
>          if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>              ^
>              (                                )
> 1 warning generated.
> 
> Judging from the rest of the commit and the conditional in
> iommu_dma_map_sg, either
> 
>      if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> 
> or
>      if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> 
> was intended, not a combination of the two.
> 
> I personally think that the former is easier to understand so use that.

Good catch, thanks Nathan. Looks like this was an unintentional mangling 
while ratifying the couple of odd "x == 0" instances to "!x" in the 
move. The effective double-negation is not what we want at all.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
> Link: https://github.com/ClangBuiltLinux/linux/issues/497
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0cd49c2d3770..0dee374fc64a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -894,7 +894,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
>   
>   	/*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
