Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A581C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 10:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB4F860B97;
	Mon,  7 Feb 2022 10:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2abZvHK6a3V; Mon,  7 Feb 2022 10:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EF2460B54;
	Mon,  7 Feb 2022 10:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E63DC0011;
	Mon,  7 Feb 2022 10:56:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFDB8C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBB8040272
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3--hDpfkxKW for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id F13FD40012
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:56:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C69811D4;
 Mon,  7 Feb 2022 02:56:47 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634383F73B;
 Mon,  7 Feb 2022 02:56:45 -0800 (PST)
Message-ID: <f315aea5-b088-62ad-2234-81e8c0b13f74@arm.com>
Date: Mon, 7 Feb 2022 10:56:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Simplify memory allocation
Content-Language: en-GB
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
 <018afc7c92ae4132ac901b088b72ab5979256a9e.1644081032.git.christophe.jaillet@wanadoo.fr>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <018afc7c92ae4132ac901b088b72ab5979256a9e.1644081032.git.christophe.jaillet@wanadoo.fr>
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2022-02-05 17:11, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand writing it.

Heh, that reminds me that I have more or less the same patch sat locally 
somewhere, except IIRC I took it further and removed the unhelpful error 
message and pruned the local variables as well - I think that would 
still be my preference here (or I could dig out my patch and post it if 
you like).

Cheers,
Robin.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is NOT compile tested.
> I don't have the needed cross compiling tools.
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 14d06aad0726..ba0e7f1f7dbf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2911,12 +2911,6 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>   	return 0;
>   }
>   
> -static void arm_smmu_cmdq_free_bitmap(void *data)
> -{
> -	unsigned long *bitmap = data;
> -	bitmap_free(bitmap);
> -}
> -
>   static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>   {
>   	int ret = 0;
> @@ -2927,13 +2921,13 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>   	atomic_set(&cmdq->owner_prod, 0);
>   	atomic_set(&cmdq->lock, 0);
>   
> -	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
> +	bitmap = (atomic_long_t *)devm_bitmap_zalloc(smmu->dev, nents,
> +						     GFP_KERNEL);
>   	if (!bitmap) {
>   		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
>   		ret = -ENOMEM;
>   	} else {
>   		cmdq->valid_map = bitmap;
> -		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
>   	}
>   
>   	return ret;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
