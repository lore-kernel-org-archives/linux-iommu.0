Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B1DC433E0
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 20:16:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD653207D3
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 20:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD653207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77AE484FB2;
	Thu, 21 May 2020 20:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RG2JsVJG4m2E; Thu, 21 May 2020 20:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D9ED84FB9;
	Thu, 21 May 2020 20:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46F88C088B;
	Thu, 21 May 2020 20:16:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5222AC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 20:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 280AB20432
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 20:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQQcBuYXu73o for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 20:16:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 621632041F
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 20:16:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99CC130E;
 Thu, 21 May 2020 13:16:32 -0700 (PDT)
Received: from [10.57.0.164] (unknown [10.57.0.164])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880AF3F305;
 Thu, 21 May 2020 13:16:31 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
To: Prakash Gupta <guptap@codeaurora.org>, akpm@linux-foundation.org,
 mhocko@suse.com, joro@8bytes.org
References: <20200521113004.12438-1-guptap@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
Date: Thu, 21 May 2020 21:16:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521113004.12438-1-guptap@codeaurora.org>
Content-Language: en-GB
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

On 2020-05-21 12:30, Prakash Gupta wrote:
> Limit the iova size while freeing based on unmapped size. In absence of
> this even with unmap failure, invalid iova is pushed to iova rcache and
> subsequently can cause panic while rcache magazine is freed.

Can you elaborate on that panic?

> Signed-off-by: Prakash Gupta <guptap@codeaurora.org>
> 
> :100644 100644 4959f5df21bd 098f7d377e04 M	drivers/iommu/dma-iommu.c
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4959f5df21bd..098f7d377e04 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -472,7 +472,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   
>   	if (!cookie->fq_domain)
>   		iommu_tlb_sync(domain, &iotlb_gather);
> -	iommu_dma_free_iova(cookie, dma_addr, size);
> +	if (unmapped)
> +		iommu_dma_free_iova(cookie, dma_addr, unmapped);

Frankly, if any part of the unmap fails then things have gone 
catastrophically wrong already, but either way this isn't right. The 
IOVA API doesn't support partial freeing - an IOVA *must* be freed with 
its original size, or not freed at all, otherwise it will corrupt the 
state of the rcaches and risk a cascade of further misbehaviour for 
future callers.

TBH my gut feeling here is that you're really just trying to treat a 
symptom of another bug elsewhere, namely some driver calling dma_unmap_* 
or dma_free_* with the wrong address or size in the first place.

Robin.

>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
