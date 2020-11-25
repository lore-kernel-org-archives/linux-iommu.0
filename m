Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E247C56201
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2E220857
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2E220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 946CA872ED;
	Wed, 25 Nov 2020 16:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHsKDICzpvsU; Wed, 25 Nov 2020 16:38:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 547058730D;
	Wed, 25 Nov 2020 16:38:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E290C0891;
	Wed, 25 Nov 2020 16:38:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA518C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94275872ED
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPertXotlBam for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 16:38:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 710EB872E1
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B928F31B;
 Wed, 25 Nov 2020 08:38:11 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46E283F7BB;
 Wed, 25 Nov 2020 08:38:09 -0800 (PST)
Subject: Re: [PATCH v2 2/6] iommu: Add iova and size as parameters in
 iommu_iotlb_map
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
 <20201119061836.15238-3-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a8ae45e0-d384-c87e-946a-1c36bf889f84@arm.com>
Date: Wed, 25 Nov 2020 16:38:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-3-yong.wu@mediatek.com>
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
> iotlb_sync_map allow IOMMU drivers tlb sync after completing the whole
> mapping. This patch adds iova and size as the parameters in it. then the
> IOMMU driver could flush tlb with the whole range once after iova mapping
> to improve performance.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/iommu.c      | 6 +++---
>   drivers/iommu/tegra-gart.c | 3 ++-
>   include/linux/iommu.h      | 3 ++-
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index decef851fa3a..df87c8e825f7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2425,7 +2425,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	might_sleep();
>   	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
>   	if (ret == 0 && ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> +		ops->iotlb_sync_map(domain, iova, size);
>   
>   	return ret;
>   }
> @@ -2439,7 +2439,7 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>   
>   	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
>   	if (ret == 0 && ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> +		ops->iotlb_sync_map(domain, iova, size);
>   
>   	return ret;
>   }
> @@ -2557,7 +2557,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   	}
>   
>   	if (ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> +		ops->iotlb_sync_map(domain, iova, mapped);
>   	return mapped;
>   
>   out_err:
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index fac720273889..d15d13a98ed1 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -261,7 +261,8 @@ static int gart_iommu_of_xlate(struct device *dev,
>   	return 0;
>   }
>   
> -static void gart_iommu_sync_map(struct iommu_domain *domain)
> +static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> +				size_t size)
>   {
>   	FLUSH_GART_REGS(gart_handle);
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b95a6f8db6ff..794d4085edd3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -244,7 +244,8 @@ struct iommu_ops {
>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>   		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
> -	void (*iotlb_sync_map)(struct iommu_domain *domain);
> +	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size);
>   	void (*iotlb_sync)(struct iommu_domain *domain,
>   			   struct iommu_iotlb_gather *iotlb_gather);
>   	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
