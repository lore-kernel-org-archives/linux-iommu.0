Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FCAC433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 16:08:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FE62251F
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 16:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FE62251F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3A4E85F3A;
	Mon, 11 Jan 2021 16:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HS53KxPdEnda; Mon, 11 Jan 2021 16:08:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 85C7185EA5;
	Mon, 11 Jan 2021 16:08:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71354C088B;
	Mon, 11 Jan 2021 16:08:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42C62C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 16:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 361D785F3A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 16:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KvGQr2DmdNh2 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 16:08:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 13EF285EA5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 16:08:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DDB31B;
 Mon, 11 Jan 2021 08:08:33 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FE93F70D;
 Mon, 11 Jan 2021 08:08:31 -0800 (PST)
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To: Marc Orr <marcorr@google.com>, hch@lst.de, m.szyprowski@samsung.com,
 jxgao@google.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20210111154335.23388-1-marcorr@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
Date: Mon, 11 Jan 2021 16:08:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111154335.23388-1-marcorr@google.com>
Content-Language: en-GB
Cc: stable@vger.kernel.org
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

On 2021-01-11 15:43, Marc Orr wrote:
> This patch updates dma_direct_unmap_sg() to mark each scatter/gather
> entry invalid, after it's unmapped. This fixes two issues:

s/fixes/bodges around (badly)/

> 1. It makes the unmapping code able to tolerate a double unmap.
> 2. It prevents the NVMe driver from erroneously treating an unmapped DMA
> address as mapped.
> 
> The bug that motivated this patch was the following sequence, which
> occurred within the NVMe driver, with the kernel flag `swiotlb=force`.
> 
> * NVMe driver calls dma_direct_map_sg()
> * dma_direct_map_sg() fails part way through the scatter gather/list
> * dma_direct_map_sg() calls dma_direct_unmap_sg() to unmap any entries
>    succeeded.
> * NVMe driver calls dma_direct_unmap_sg(), redundantly, leading to a
>    double unmap, which is a bug.

So why not just fix that actual bug?

> With this patch, a hadoop workload running on a cluster of three AMD
> SEV VMs, is able to succeed. Without the patch, the hadoop workload
> suffers application-level and even VM-level failures.
> 
> Tested-by: Jianxiong Gao <jxgao@google.com>
> Tested-by: Marc Orr <marcorr@google.com>
> Reviewed-by: Jianxiong Gao <jxgao@google.com>
> Signed-off-by: Marc Orr <marcorr@google.com>
> ---
>   kernel/dma/direct.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0a4881e59aa7..3d9b17fe5771 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>   			     attrs);
> +		sg->dma_address = DMA_MAPPING_ERROR;

There are more DMA API backends than just dma-direct, so while this 
might help paper over bugs when SWIOTLB is in use, it's not going to 
have any effect when those same bugs are hit under other circumstances. 
Once again, the moral of the story is that effort is better spent just 
fixing the bugs ;)

Robin.

> +	}
>   }
>   EXPORT_SYMBOL(dma_direct_unmap_sg);
>   #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
