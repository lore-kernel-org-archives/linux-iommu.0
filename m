Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A1C433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 13:17:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73587611F0
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 13:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73587611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 337F360751;
	Wed, 14 Apr 2021 13:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QMgeUuuqHIl; Wed, 14 Apr 2021 13:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 355FA606A3;
	Wed, 14 Apr 2021 13:17:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18176C000C;
	Wed, 14 Apr 2021 13:17:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F812C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 13:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58FE06073A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 13:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xmjRIUvXkLU4 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 13:17:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 390C0606A3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 13:17:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E95F0113E;
 Wed, 14 Apr 2021 06:17:15 -0700 (PDT)
Received: from [10.57.58.164] (unknown [10.57.58.164])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76D83F694;
 Wed, 14 Apr 2021 06:17:14 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
To: chenxiang <chenxiang66@hisilicon.com>, will@kernel.org, joro@8bytes.org
References: <1618382307-59139-1-git-send-email-chenxiang66@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0394ac29-f120-6c16-502c-f40a3a3a4353@arm.com>
Date: Wed, 14 Apr 2021 14:17:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618382307-59139-1-git-send-email-chenxiang66@hisilicon.com>
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

On 2021-04-14 07:38, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> It is not necessary to put free_iova_mem() inside of spinlock/unlock
> iova_rbtree_lock which only leads to more completion for the spinlock.
> It has a small promote on the performance after the change.

This seems not entirely unreasonable, but private_free_iova() really 
needs to be renamed (maybe something like remove_iova()?) if it's no 
longer actually freeing anything - otherwise it's just unnecessarily 
misleading.

Robin.

> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   drivers/iommu/iova.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c669526f..292ed4a 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -339,7 +339,6 @@ static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
>   	assert_spin_locked(&iovad->iova_rbtree_lock);
>   	__cached_rbnode_delete_update(iovad, iova);
>   	rb_erase(&iova->node, &iovad->rbroot);
> -	free_iova_mem(iova);
>   }
>   
>   /**
> @@ -376,6 +375,7 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   	private_free_iova(iovad, iova);
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	free_iova_mem(iova);
>   }
>   EXPORT_SYMBOL_GPL(__free_iova);
>   
> @@ -397,7 +397,7 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
>   	if (iova)
>   		private_free_iova(iovad, iova);
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -
> +	free_iova_mem(iova);
>   }
>   EXPORT_SYMBOL_GPL(free_iova);
>   
> @@ -746,6 +746,7 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   			continue;
>   
>   		private_free_iova(iovad, iova);
> +		free_iova_mem(iova);
>   	}
>   
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
