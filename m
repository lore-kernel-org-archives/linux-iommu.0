Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17A4C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 14:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A05A7415D9;
	Thu, 23 Dec 2021 14:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wkmzF4xS9FGP; Thu, 23 Dec 2021 14:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F3CC414C1;
	Thu, 23 Dec 2021 14:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61AF9C001E;
	Thu, 23 Dec 2021 14:14:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4524CC0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 14:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34AFD41578
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 14:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9dDUOTWWeM3c for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 14:14:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 628D6414C1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 14:14:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75DE6D6E;
 Thu, 23 Dec 2021 06:14:41 -0800 (PST)
Received: from [10.57.66.229] (unknown [10.57.66.229])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920083F5A1;
 Thu, 23 Dec 2021 06:14:39 -0800 (PST)
Message-ID: <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
Date: Thu, 23 Dec 2021 14:14:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
Content-Language: en-GB
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robdclark@chromium.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Xin Tan <tanxin.ctf@gmail.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
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

On 2021-12-23 13:00, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_count().

Nit: platform_irq_count()

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4bc75c4ce402..4844cd075644 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	if (IS_ERR(smmu))
>   		return PTR_ERR(smmu);
>   
> -	num_irqs = 0;
> -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> -		num_irqs++;
> -		if (num_irqs > smmu->num_global_irqs)
> -			smmu->num_context_irqs++;
> -	}
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 0)
> +		return num_irqs;
> +
> +	if (num_irqs > smmu->num_global_irqs)
> +		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);

This seems a bit overcomplicated. I reckon:

	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
	if (num_irqs <= smmu->num_global_irqs) {
		dev_err(...

should do it.

However, FYI I have some patches refactoring most of the IRQ stuff here 
that I plan to post next cycle (didn't quite have time to get them done 
for 5.17 as I'd hoped...), so unless this needs to go in right now as an 
urgent fix, I'm happy to take care of removing platform_get_resource() 
as part of that if it's easier.

Thanks,
Robin.

>   
>   	if (!smmu->num_context_irqs) {
>   		dev_err(dev, "found %d interrupts but expected at least %d\n",
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
