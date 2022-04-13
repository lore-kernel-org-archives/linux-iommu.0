Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA164C433F5
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 13:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EBF360AE0;
	Wed, 13 Apr 2022 13:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c-ljpjUj6Rg2; Wed, 13 Apr 2022 13:40:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 56BD760ABA;
	Wed, 13 Apr 2022 13:40:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D0F5C0033;
	Wed, 13 Apr 2022 13:40:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA199C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 13:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7B9C60AE0
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 13:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8y5msuPoLv3a for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 13:40:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 225F260ABA
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 13:40:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB2C1596;
 Wed, 13 Apr 2022 06:40:37 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15A933F73B;
 Wed, 13 Apr 2022 06:40:35 -0700 (PDT)
Message-ID: <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
Date: Wed, 13 Apr 2022 14:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, joro@8bytes.org
References: <20220413041745.35174-1-nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220413041745.35174-1-nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
 iommu@lists.linux-foundation.org, christophe.jaillet@wanadoo.fr,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
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

On 2022-04-13 05:17, Nicolin Chen wrote:
> To calculate num_pages, the size should be aligned with
> "page size", determined by the tg value. Otherwise, its
> following "while (iova < end)" might become an infinite
> loop if unaligned size is slightly greater than 1 << tg.

Hmm, how does a non-page-aligned invalidation request get generated in 
the first place?

Robin.

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..8249dad5ae44 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1879,7 +1879,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>   		/* Determine what level the granule is at */
>   		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>   
> -		num_pages = size >> tg;
> +		num_pages = ALIGN(size, 1 << tg) >> tg;
>   	}
>   
>   	cmds.num = 0;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
