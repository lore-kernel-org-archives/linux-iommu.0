Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82EC4CEC9
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:55:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B54121670
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9LwQx38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B54121670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D7F25C64;
	Tue, 17 Sep 2019 18:55:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AFD30C5D
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:55:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A61676D
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:55:42 +0000 (UTC)
Received: from kernel.org (unknown [104.132.0.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 29EB5214AF;
	Tue, 17 Sep 2019 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568746542;
	bh=GES6jY4SrgchwiFDLmCd0LxgVWZjnEk+gbEGOc928XQ=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
	b=k9LwQx38N2BdNc66+3x/viHSY2juEQIkGNDwqC7RC5qWXwJi29ZVStsSdAb4mMl/s
	QwXwITGlVNF3gB3KQrxck1nkk79fvRSbAffQgGL0DxcRj6yvF6E3eUh8Ik6KDGZqrp
	keQixx7YXQIb8U8MUxG+ZkXC3m274H2HeGOHSe6E=
MIME-Version: 1.0
In-Reply-To: <1566327992-362-4-git-send-email-jcrouse@codeaurora.org>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
	<1566327992-362-4-git-send-email-jcrouse@codeaurora.org>
To: Jordan Crouse <jcrouse@codeaurora.org>, freedreno@lists.freedesktop.org
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/7] iommu/arm-smmu: Add a SMMU variant for the Adreno GPU
User-Agent: alot/0.8.1
Date: Tue, 17 Sep 2019 11:55:41 -0700
Message-Id: <20190917185542.29EB5214AF@mail.kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Quoting Jordan Crouse (2019-08-20 12:06:28)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 39e81ef..3f41cf7 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1858,6 +1858,7 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>  ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
> +ARM_SMMU_MATCH_DATA(qcom_adreno_smmuv2, ARM_SMMU_V2, QCOM_ADRENO_SMMUV2);
>  
>  static const struct of_device_id arm_smmu_of_match[] = {
>         { .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
> @@ -1867,6 +1868,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>         { .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>         { .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
>         { .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
> +       { .compatible = "qcom,adreno-smmu-v2", .data = &qcom_adreno_smmuv2 },

Can this be sorted on compat?

>         { },
>  };
>  
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 91a4eb8..e5a2cc8 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -222,6 +222,7 @@ enum arm_smmu_implementation {
>         ARM_MMU500,
>         CAVIUM_SMMUV2,
>         QCOM_SMMUV2,
> +       QCOM_ADRENO_SMMUV2,

Can this be sorted alphabetically?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
