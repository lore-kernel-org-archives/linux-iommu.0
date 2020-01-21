Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77624C2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 09:56:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DC224125
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 09:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DC224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BA978637D;
	Tue, 21 Jan 2020 09:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teIjQIb1eXQr; Tue, 21 Jan 2020 09:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F3F6B86378;
	Tue, 21 Jan 2020 09:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4E7EC1D80;
	Tue, 21 Jan 2020 09:56:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49F9BC0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 38AF985DF8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jH7nrcYWPf3G for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 09:56:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AF0AC80CF0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:56:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB75E1FB;
 Tue, 21 Jan 2020 01:56:10 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C87D3F6C4;
 Tue, 21 Jan 2020 01:56:07 -0800 (PST)
Subject: Re: [Patch v3 3/3] iommu: avoid taking iova_rbtree_lock twice
To: Cong Wang <xiyou.wangcong@gmail.com>, iommu@lists.linux-foundation.org
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-4-xiyou.wangcong@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2ff1002c-28b3-a863-49d2-3eab5b5ea778@arm.com>
Date: Tue, 21 Jan 2020 09:56:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218043951.10534-4-xiyou.wangcong@gmail.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org
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

On 18/12/2019 4:39 am, Cong Wang wrote:
> Both find_iova() and __free_iova() take iova_rbtree_lock,
> there is no reason to take and release it twice inside
> free_iova().
> 
> Fold them into one critical section by calling the unlock
> versions instead.

Makes sense to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   drivers/iommu/iova.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 184d4c0e20b5..f46f8f794678 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -390,10 +390,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
>   void
>   free_iova(struct iova_domain *iovad, unsigned long pfn)
>   {
> -	struct iova *iova = find_iova(iovad, pfn);
> +	unsigned long flags;
> +	struct iova *iova;
>   
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	iova = private_find_iova(iovad, pfn);
>   	if (iova)
> -		__free_iova(iovad, iova);
> +		private_free_iova(iovad, iova);
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>   
>   }
>   EXPORT_SYMBOL_GPL(free_iova);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
