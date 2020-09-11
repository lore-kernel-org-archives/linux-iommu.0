Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8583DC43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:24:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C4A221E3
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 08:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n20eJMmn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="nxccvSjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C4A221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 82D5687773;
	Fri, 11 Sep 2020 08:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1QGGElkbp2op; Fri, 11 Sep 2020 08:24:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DC95C8772F;
	Fri, 11 Sep 2020 08:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC4ACC0859;
	Fri, 11 Sep 2020 08:24:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B89E3C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A0BB8871C1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACyQkDdTRTnN for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 08:24:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-55.smtp-out.us-west-2.amazonses.com
 (a27-55.smtp-out.us-west-2.amazonses.com [54.240.27.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0CF5287184
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812662;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
 bh=YcrG/LuDfQatkkUvVrsoN1HVKrTFRH1ANNeQ0qNYkz8=;
 b=n20eJMmnGSebGMdH//DaWtr1IZU/MyQZi9EN6U2cLYPc1EQSQU/2mUVPJikJ3V69
 b9goYRsEucBy+PsmYAynYHF5mIDusIfpIyL9hpGnrux7v8z+PS9Lkty/BMMR5iFBla/
 Rz2UhSAtWIp5T4Igbmlo3vK/jqn6PJ+xd0C4zEuU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812662;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
 bh=YcrG/LuDfQatkkUvVrsoN1HVKrTFRH1ANNeQ0qNYkz8=;
 b=nxccvSjJ2kmzEDO5ciUbxlTPbLD9ZU0Oc0nZMfXlgr4YVj+VIlerABIvCQfMc8Dz
 Mtisope98hoJciOJzDwviOJxeXBbo+swbYqgRZPR3t1ZI195y/8VnV9aI/yIzMPs2T3
 /NU44rYlrHyk30FTtNmBBmEu6eDqPeU/RxaY4HII=
MIME-Version: 1.0
Date: Fri, 11 Sep 2020 08:24:22 +0000
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 3/8] iommu/arm-smmu: Consult context bank allocator for
 identify domains
In-Reply-To: <20200904155513.282067-4-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-4-bjorn.andersson@linaro.org>
Message-ID: <010101747c43f41a-1f3a1b52-e138-4f59-badf-f945b4d0a156-000000@us-west-2.amazonses.com>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-09-04 21:25, Bjorn Andersson wrote:
> For implementations of the ARM SMMU where stream mappings of bypass 
> type
> are prohibited identity domains can be implemented by using context
> banks with translation disabled.
> 
> Postpone the decision to skip allocating a context bank until the
> implementation specific context bank allocator has been consulted and 
> if
> it decides to use a context bank for the identity map, don't enable
> translation (i.e. omit ARM_SMMU_SCTLR_M).
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

<snip>...

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index ddf2ca4c923d..235d9a3a6ab6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -243,6 +243,8 @@ enum arm_smmu_cbar_type {
>  #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
>  #define TLB_SPIN_COUNT			10
> 
> +#define ARM_SMMU_CBNDX_BYPASS		0xffff
> +
>  /* Shared driver definitions */
>  enum arm_smmu_arch_version {
>  	ARM_SMMU_V1,
> @@ -346,6 +348,7 @@ struct arm_smmu_cfg {
>  	u32				sctlr_clr;    /* bits to mask in SCTLR */
>  	enum arm_smmu_cbar_type		cbar;
>  	enum arm_smmu_context_fmt	fmt;
> +	bool				m;

Can we use mmu_enable instead of m here to be more descriptive?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
