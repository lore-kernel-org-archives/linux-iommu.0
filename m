Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C27EC433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:50:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F3E223C6
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F3E223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A6DEE2E0F2;
	Mon, 19 Oct 2020 18:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scnP2pdOFNFj; Mon, 19 Oct 2020 18:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B44BB2048E;
	Mon, 19 Oct 2020 18:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C69FC088B;
	Mon, 19 Oct 2020 18:50:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF32C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6C9EF86C1E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLmKuyh0SCFD for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 18:50:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 57CE986C72
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:50:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1124A30E;
 Mon, 19 Oct 2020 11:50:12 -0700 (PDT)
Received: from [10.57.19.34] (unknown [10.57.19.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF4A83F719;
 Mon, 19 Oct 2020 11:50:09 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] iommu/arm-smmu-qcom: Read back stream mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Thierry Reding <treding@nvidia.com>,
 Rob Clark <robdclark@chromium.org>
References: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
 <20201019182323.3162386-3-bjorn.andersson@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2bde9a4d-25bc-0ac7-d6e4-762667cc4fd2@arm.com>
Date: Mon, 19 Oct 2020 19:50:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019182323.3162386-3-bjorn.andersson@linaro.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On 2020-10-19 19:23, Bjorn Andersson wrote:
> The Qualcomm boot loader configures stream mapping for the peripherals
> that it accesses and in particular it sets up the stream mapping for the
> display controller to be allowed to scan out a splash screen or EFI
> framebuffer.
> 
> Read back the stream mappings during initialization and make the
> arm-smmu driver maintain the streams in bypass mode.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - Don't increment s2cr[i]->count, as this is not actually needed to survive
>    probe deferral
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index be4318044f96..48627fcf6bed 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -23,6 +23,28 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   	{ }
>   };
>   
> +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +	u32 smr;
> +	int i;
> +
> +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +
> +		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
> +			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +			smmu->smrs[i].valid = true;
> +
> +			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +			smmu->s2crs[i].cbndx = 0xff;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int qcom_smmu_def_domain_type(struct device *dev)
>   {
>   	const struct of_device_id *match =
> @@ -61,6 +83,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>   }
>   
>   static const struct arm_smmu_impl qcom_smmu_impl = {
> +	.cfg_probe = qcom_smmu_cfg_probe,
>   	.def_domain_type = qcom_smmu_def_domain_type,
>   	.reset = qcom_smmu500_reset,
>   };
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
