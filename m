Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE97C2D0F0
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 14:19:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98192206CC
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98192206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 630F224EA2;
	Tue, 31 Mar 2020 14:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AD4I3KNA7hhU; Tue, 31 Mar 2020 14:19:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 77CFB24B59;
	Tue, 31 Mar 2020 14:19:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62F3EC1AE2;
	Tue, 31 Mar 2020 14:19:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1DF1C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 14:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B943879A1
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 14:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BntwO3uSw6WD for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 14:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id B5324876B6
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 14:19:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D33E7FA;
 Tue, 31 Mar 2020 07:19:12 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3A673F71E;
 Tue, 31 Mar 2020 07:19:10 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: move error checking into common path
To: luanshi <zhangliguang@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <1585663188-114303-1-git-send-email-zhangliguang@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <749b7fb7-06c2-bde3-55e9-03232287d727@arm.com>
Date: Tue, 31 Mar 2020 15:19:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585663188-114303-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

On 2020-03-31 2:59 pm, luanshi wrote:
> Move error checking into common path to be consistent with
> drivers/iommu/arm-smmu.c.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index aa3ac2a..970f1c9 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3889,13 +3889,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   	smmu->dev = dev;
>   
> -	if (dev->of_node) {
> +	if (dev->of_node)
>   		ret = arm_smmu_device_dt_probe(pdev, smmu);
> -	} else {
> +	else
>   		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> -		if (ret == -ENODEV)
> -			return ret;
> -	}
> +
> +	if (ret)
> +		return ret;

This completely changes the flow WRT the bypass decision below, so 
without a clear justification of why that's OK, NAK.

Robin.

>   
>   	/* Set bypass mode according to firmware probing result */
>   	bypass = !!ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
