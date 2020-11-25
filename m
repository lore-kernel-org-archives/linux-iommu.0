Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9715C56201
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:37:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D6F2083E
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D6F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9BAC86EB9;
	Wed, 25 Nov 2020 16:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSmSALK62Af7; Wed, 25 Nov 2020 16:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 191AF86EAC;
	Wed, 25 Nov 2020 16:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 005A9C0891;
	Wed, 25 Nov 2020 16:37:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B25D0C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9FA9B876BE
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOswM38Lt8Y2 for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 16:37:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id E7AF8876AD
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:37:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 514B331B;
 Wed, 25 Nov 2020 08:37:53 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFA53F7BB;
 Wed, 25 Nov 2020 08:37:50 -0800 (PST)
Subject: Re: [PATCH v2 1/6] iommu: Move iotlb_sync_map out from __iommu_map
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
 <20201119061836.15238-2-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cf0f81dd-e240-965b-5c75-914d3d48eb27@arm.com>
Date: Wed, 25 Nov 2020 16:37:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-2-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, jun.wen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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

On 2020-11-19 06:18, Yong Wu wrote:
> In the end of __iommu_map, It alway call iotlb_sync_map.
> This patch moves iotlb_sync_map out from __iommu_map since it is
> unnecessary to call this for each sg segment especially iotlb_sync_map
> is flush tlb all currently.

I don't see a way to avoid the boilerplate that wouldn't end up making 
things even more ugly and complicated, so:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/iommu.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8c470f451a32..decef851fa3a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2407,9 +2407,6 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		size -= pgsize;
>   	}
>   
> -	if (ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> -
>   	/* unroll mapping in case something went wrong */
>   	if (ret)
>   		iommu_unmap(domain, orig_iova, orig_size - size);
> @@ -2422,15 +2419,29 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
> +	const struct iommu_ops *ops = domain->ops;
> +	int ret;
> +
>   	might_sleep();
> -	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	if (ret == 0 && ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_map);
>   
>   int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
> -	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +	const struct iommu_ops *ops = domain->ops;
> +	int ret;
> +
> +	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +	if (ret == 0 && ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_map_atomic);
>   
> @@ -2514,6 +2525,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			     struct scatterlist *sg, unsigned int nents, int prot,
>   			     gfp_t gfp)
>   {
> +	const struct iommu_ops *ops = domain->ops;
>   	size_t len = 0, mapped = 0;
>   	phys_addr_t start;
>   	unsigned int i = 0;
> @@ -2544,6 +2556,8 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			sg = sg_next(sg);
>   	}
>   
> +	if (ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
>   	return mapped;
>   
>   out_err:
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
