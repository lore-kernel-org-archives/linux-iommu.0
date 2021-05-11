Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF13C433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 09:41:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD90D611CC
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 09:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD90D611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B578440B;
	Tue, 11 May 2021 09:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdwarVcwaZHJ; Tue, 11 May 2021 09:41:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E33F84356;
	Tue, 11 May 2021 09:41:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F90AC000D;
	Tue, 11 May 2021 09:41:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9569EC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 09:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D402843A2
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 09:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yIEQPhewOb85 for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 09:41:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66B4684356
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 09:41:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607AC1692;
 Tue, 11 May 2021 02:41:41 -0700 (PDT)
Received: from [10.57.59.124] (unknown [10.57.59.124])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ED133F719;
 Tue, 11 May 2021 02:41:40 -0700 (PDT)
Subject: Re: [RESEND PATCH v3] iommu/iova: put free_iova_mem() outside of
 spinlock iova_rbtree_lock
To: chenxiang <chenxiang66@hisilicon.com>, will@kernel.org, joro@8bytes.org
References: <1620647582-194621-1-git-send-email-chenxiang66@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9edc6849-f9ff-f6fc-30a0-8bb2e8d3bd0d@arm.com>
Date: Tue, 11 May 2021 10:41:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620647582-194621-1-git-send-email-chenxiang66@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

On 2021-05-10 12:53, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> It is not necessary to put free_iova_mem() inside of spinlock/unlock
> iova_rbtree_lock which only leads to more completion for the spinlock.
> It has a small promote on the performance after the change. And also
> rename private_free_iova() as remove_iova() because the function will not
> free iova after that change.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b7ecd5b..b6cf5f1 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -412,12 +412,11 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
>   	return NULL;
>   }
>   
> -static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
> +static void remove_iova(struct iova_domain *iovad, struct iova *iova)
>   {
>   	assert_spin_locked(&iovad->iova_rbtree_lock);
>   	__cached_rbnode_delete_update(iovad, iova);
>   	rb_erase(&iova->node, &iovad->rbroot);
> -	free_iova_mem(iova);
>   }
>   
>   /**
> @@ -452,8 +451,9 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> -	private_free_iova(iovad, iova);
> +	remove_iova(iovad, iova);
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	free_iova_mem(iova);
>   }
>   EXPORT_SYMBOL_GPL(__free_iova);
>   
> @@ -472,10 +472,13 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
>   
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   	iova = private_find_iova(iovad, pfn);
> -	if (iova)
> -		private_free_iova(iovad, iova);
> +	if (!iova) {
> +		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +		return;
> +	}
> +	remove_iova(iovad, iova);
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -
> +	free_iova_mem(iova);
>   }
>   EXPORT_SYMBOL_GPL(free_iova);
>   
> @@ -825,7 +828,8 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   		if (WARN_ON(!iova))
>   			continue;
>   
> -		private_free_iova(iovad, iova);
> +		remove_iova(iovad, iova);
> +		free_iova_mem(iova);
>   	}
>   
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
