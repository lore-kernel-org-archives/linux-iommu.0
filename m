Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52424C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 09:52:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003C2611AC
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 09:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003C2611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE01F846D2;
	Thu, 15 Apr 2021 09:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vru5qZM1ikjG; Thu, 15 Apr 2021 09:52:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10BAB84596;
	Thu, 15 Apr 2021 09:52:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB983C000B;
	Thu, 15 Apr 2021 09:52:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBC4FC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD0068459D
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTVp5hnFc0dZ for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 09:52:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 549DD84596
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:52:19 +0000 (UTC)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FLZBP3zV9z689wQ;
 Thu, 15 Apr 2021 17:42:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 11:52:16 +0200
Received: from [10.47.83.117] (10.47.83.117) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 15 Apr
 2021 10:52:15 +0100
Subject: Re: [PATCH v2] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
To: chenxiang <chenxiang66@hisilicon.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <joro@8bytes.org>
References: <1618458725-244583-1-git-send-email-chenxiang66@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <80a373d8-0136-b026-9b72-d558c0dd2a66@huawei.com>
Date: Thu, 15 Apr 2021 10:49:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1618458725-244583-1-git-send-email-chenxiang66@hisilicon.com>
Content-Language: en-US
X-Originating-IP: [10.47.83.117]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
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

On 15/04/2021 04:52, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> It is not necessary to put free_iova_mem() inside of spinlock/unlock
> iova_rbtree_lock which only leads to more completion for the spinlock.
> It has a small promote on the performance after the change. And also
> rename private_free_iova() as remove_iova() because the function will not
> free iova after that change.
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   drivers/iommu/iova.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b7ecd5b..c10af23 100644
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
> @@ -473,9 +473,9 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   	iova = private_find_iova(iovad, pfn);
>   	if (iova)
> -		private_free_iova(iovad, iova);
> +		remove_iova(iovad, iova);
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -
> +	free_iova_mem(iova);

you need to make this:
	if (iova)
		free_iova_mem(iova);

as free_iova_mem(iova) dereferences iova:

if (iova->pfn_lo != IOVA_ANCHOR)
	kmem_cache_free(iova_cache, iova)

So if iova were NULL, we crash.

Or you can make free_iova_mem() NULL safe.

>   }
>   EXPORT_SYMBOL_GPL(free_iova);
>   
> @@ -825,7 +825,8 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
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
