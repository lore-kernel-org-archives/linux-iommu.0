Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BBC2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 14:48:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45842207E0
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 14:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45842207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1D94834A7;
	Tue, 21 Jan 2020 14:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ev2bWiDP5LUh; Tue, 21 Jan 2020 14:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CC8F84E1A;
	Tue, 21 Jan 2020 14:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB5AC0176;
	Tue, 21 Jan 2020 14:47:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48671C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3600E20430
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3uxvMEuHWdq for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 14:47:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id ED272204D8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:47:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EECE30E;
 Tue, 21 Jan 2020 06:47:47 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EBF93F52E;
 Tue, 21 Jan 2020 06:47:46 -0800 (PST)
Subject: Re: [PATCH v3 2/5] iommu/arm-smmu: Add support for split pagetables
To: Jordan Crouse <jcrouse@codeaurora.org>, iommu@lists.linux-foundation.org
References: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
 <1576514271-15687-3-git-send-email-jcrouse@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <03d68ca6-254d-227f-e428-b85f6f4d7981@arm.com>
Date: Tue, 21 Jan 2020 14:47:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576514271-15687-3-git-send-email-jcrouse@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, will@kernel.org,
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

Oh, one more thing...

On 16/12/2019 4:37 pm, Jordan Crouse wrote:
[...]
> @@ -651,6 +659,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	enum io_pgtable_fmt fmt;
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	u32 quirks = 0;
>   
>   	mutex_lock(&smmu_domain->init_mutex);
>   	if (smmu_domain->smmu)
> @@ -719,6 +728,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   		oas = smmu->ipa_size;
>   		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
>   			fmt = ARM_64_LPAE_S1;
> +			if (smmu_domain->split_pagetables)
> +				quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;

To avoid me forgetting and questioning it again in future, I'd recommend 
sticking a comment somewhere near here that we don't reduce cfg->ias in 
this case because we're currently assuming SEP_UPSTREAM.

Robin.

>   		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
>   			fmt = ARM_32_LPAE_S1;
>   			ias = min(ias, 32UL);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
