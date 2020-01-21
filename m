Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75DFC2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 09:52:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C3420882
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 09:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C3420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 790C287987;
	Tue, 21 Jan 2020 09:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bR+viJYNFrwO; Tue, 21 Jan 2020 09:52:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 538328790F;
	Tue, 21 Jan 2020 09:52:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB94C1D80;
	Tue, 21 Jan 2020 09:52:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D044AC0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BE35286378
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXq7MPWI8xZa for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 09:52:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0805885CE2
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:52:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4599B1FB;
 Tue, 21 Jan 2020 01:52:16 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9023F6C4;
 Tue, 21 Jan 2020 01:52:15 -0800 (PST)
Subject: Re: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
To: Cong Wang <xiyou.wangcong@gmail.com>, iommu@lists.linux-foundation.org
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
Date: Tue, 21 Jan 2020 09:52:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218043951.10534-3-xiyou.wangcong@gmail.com>
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
> If the magazine is empty, iova_magazine_free_pfns() should
> be a nop, however it misses the case of mag->size==0. So we
> should just call iova_magazine_empty().
> 
> This should reduce the contention on iovad->iova_rbtree_lock
> a little bit, not much at all.

Have you measured that in any way? AFAICS the only time this can get 
called with a non-full magazine is in the CPU hotplug callback, where 
the impact of taking the rbtree lock and immediately releasing it seems 
unlikely to be significant on top of everything else involved in that 
operation.

Robin.

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   drivers/iommu/iova.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index cb473ddce4cf..184d4c0e20b5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
>   	kfree(mag);
>   }
>   
> +static bool iova_magazine_full(struct iova_magazine *mag)
> +{
> +	return (mag && mag->size == IOVA_MAG_SIZE);
> +}
> +
> +static bool iova_magazine_empty(struct iova_magazine *mag)
> +{
> +	return (!mag || mag->size == 0);
> +}
> +
>   static void
>   iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   {
>   	unsigned long flags;
>   	int i;
>   
> -	if (!mag)
> +	if (iova_magazine_empty(mag))
>   		return;
>   
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> @@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	mag->size = 0;
>   }
>   
> -static bool iova_magazine_full(struct iova_magazine *mag)
> -{
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> -}
> -
> -static bool iova_magazine_empty(struct iova_magazine *mag)
> -{
> -	return (!mag || mag->size == 0);
> -}
> -
>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>   				       unsigned long limit_pfn)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
