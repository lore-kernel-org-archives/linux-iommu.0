Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BFCC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 10:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A92904029F;
	Mon,  7 Feb 2022 10:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiombT0UpfBp; Mon,  7 Feb 2022 10:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91F70401A2;
	Mon,  7 Feb 2022 10:26:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E618C0011;
	Mon,  7 Feb 2022 10:26:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCADC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 780EB40289
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9La705rkW6f for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61E75401A2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:26:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 595B811B3;
 Mon,  7 Feb 2022 02:26:20 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01BB3F718;
 Mon,  7 Feb 2022 02:26:18 -0800 (PST)
Message-ID: <f17da9b7-1642-762c-0854-e131e3c2f438@arm.com>
Date: Mon, 7 Feb 2022 10:26:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in
 memory allocation
Content-Language: en-GB
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
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

On 2022-02-05 17:10, Christophe JAILLET wrote:
> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
> 
> So turn a devm_kzalloc()+explicit size computation into an equivalent
> devm_kcalloc().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is NOT compile tested.
> I don't have the needed cross compiling tools.

FYI, https://cdn.kernel.org/pub/tools/crosstool/

Either way, the patch looks reasonable, thanks!

Acked-by: Robin Murphy <robin.murphy@arm.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6dc6d8b6b368..14d06aad0726 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2981,10 +2981,10 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>   {
>   	unsigned int i;
>   	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> -	size_t size = sizeof(*cfg->l1_desc) * cfg->num_l1_ents;
>   	void *strtab = smmu->strtab_cfg.strtab;
>   
> -	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
> +	cfg->l1_desc = devm_kcalloc(smmu->dev, cfg->num_l1_ents,
> +				    sizeof(*cfg->l1_desc), GFP_KERNEL);
>   	if (!cfg->l1_desc)
>   		return -ENOMEM;
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
