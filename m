Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88910C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 14:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DAE261284;
	Fri, 25 Feb 2022 14:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GgIuyntDa-Qn; Fri, 25 Feb 2022 14:32:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 137086126F;
	Fri, 25 Feb 2022 14:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C91E7C007A;
	Fri, 25 Feb 2022 14:32:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA4E2C001A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC29383F24
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Qlkrz8xlSbk for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 14:32:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2CA283FBE
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:32:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3914106F;
 Fri, 25 Feb 2022 06:32:27 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC7D3F5A1;
 Fri, 25 Feb 2022 06:32:26 -0800 (PST)
Message-ID: <af255483-a2b9-64dd-ec4f-4be21427e23f@arm.com>
Date: Fri, 25 Feb 2022 14:32:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/arm-smmu: remove redundant assignment to variable
 res
Content-Language: en-GB
To: Colin Ian King <colin.i.king@gmail.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <20220225093205.170973-1-colin.i.king@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220225093205.170973-1-colin.i.king@gmail.com>
Cc: llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On 2022-02-25 09:32, Colin Ian King wrote:
> The variable res is being assigned a value that isn't being read
> later. The assignment is redundant and can be removed.
> 
> Cleans up clang scan warning:
> drivers/iommu/arm/arm-smmu/arm-smmu.c:2109:10: warning: Although the
> value stored to 'res' is used in the enclosing expression, the value
> is never actually read from 'res' [deadcode.DeadStores]

Thanks Colin, however in general we need to get rid of this 
platform_get_resource() call ASAP anyway, so Will should hopefully be 
picking up either [1] or [2] for 5.18.

Cheers,
Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/b2a40caaf1622eb35c555074a0d72f4f0513cff9.1645106346.git.robin.murphy@arm.com/
[2] 
https://lore.kernel.org/linux-arm-kernel/20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com/

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4bc75c4ce402..f83d2c32b5a9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2106,7 +2106,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		return PTR_ERR(smmu);
>   
>   	num_irqs = 0;
> -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> +	while (platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs)) {
>   		num_irqs++;
>   		if (num_irqs > smmu->num_global_irqs)
>   			smmu->num_context_irqs++;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
