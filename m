Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C35C43457
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 19:02:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD1E2224F
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 19:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD1E2224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6908D86DC9;
	Mon, 19 Oct 2020 19:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u28MZaalI-Xk; Mon, 19 Oct 2020 19:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 863DD86D9C;
	Mon, 19 Oct 2020 19:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46823C0052;
	Mon, 19 Oct 2020 19:02:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93E6DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 19:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7CB93874D4
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 19:02:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N4dAMaykBvic for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 19:02:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4FAB874F7
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 19:02:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 707F130E;
 Mon, 19 Oct 2020 12:02:29 -0700 (PDT)
Received: from [10.57.19.34] (unknown [10.57.19.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1997C3F719;
 Mon, 19 Oct 2020 12:02:26 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-qcom: Implement S2CR quirk
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Thierry Reding <treding@nvidia.com>,
 Rob Clark <robdclark@chromium.org>
References: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
 <20201019182323.3162386-4-bjorn.andersson@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe27e7f2-7ba0-0b08-e727-84c78d5b7116@arm.com>
Date: Mon, 19 Oct 2020 20:02:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019182323.3162386-4-bjorn.andersson@linaro.org>
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
> The firmware found in some Qualcomm platforms intercepts writes to S2CR
> in order to replace bypass type streams with fault; and ignore S2CR
> updates of type fault.
> 
> Detect this behavior and implement a custom write_s2cr function in order
> to trick the firmware into supporting bypass streams by the means of
> configuring the stream for translation using a reserved and disabled
> context bank.
> 
> Also circumvent the problem of configuring faulting streams by
> configuring the stream as bypass.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - Made the bypass_cbndx an integer...
> - Separated out the "quirk enabled or not" into a bool, rather than reusing
>    (the valid) context bank 0 to represent this.
> - Dropped the unused EXIDS handling.
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 67 ++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 48627fcf6bed..66ba4870659f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -10,8 +10,15 @@
>   
>   struct qcom_smmu {
>   	struct arm_smmu_device smmu;
> +	bool bypass_quirk;
> +	u8 bypass_cbndx;
>   };
>   
> +static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> +{
> +	return container_of(smmu, struct qcom_smmu, smmu);
> +}
> +
>   static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   	{ .compatible = "qcom,adreno" },
>   	{ .compatible = "qcom,mdp4" },
> @@ -25,9 +32,33 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   
>   static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>   {
> +	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	u32 reg;
>   	u32 smr;
>   	int i;
>   
> +	/*
> +	 * With some firmware versions writes to S2CR of type FAULT are
> +	 * ignored, and writing BYPASS will end up written as FAULT in the
> +	 * register. Perform a write to S2CR to detect if this is the case and
> +	 * if so reserve a context bank to emulate bypass streams.
> +	 */
> +	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
> +	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
> +	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
> +	arm_smmu_gr0_write(smmu, last_s2cr, reg);
> +	reg = arm_smmu_gr0_read(smmu, last_s2cr);
> +	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
> +		qsmmu->bypass_quirk = true;
> +		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;

FWIW you could arguably just calculate that at point of use. Or store 
the index as an int and use a negative value to indicate when it's 
irrelevant to save the separate flag. But there's also nothing *wrong* 
with having it all spelled out, so regardless,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> +
> +		set_bit(qsmmu->bypass_cbndx, smmu->context_map);
> +
> +		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
> +		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
> +	}
> +
>   	for (i = 0; i < smmu->num_mapping_groups; i++) {
>   		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>   
> @@ -45,6 +76,41 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>   	return 0;
>   }
>   
> +static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
> +{
> +	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	u32 cbndx = s2cr->cbndx;
> +	u32 type = s2cr->type;
> +	u32 reg;
> +
> +	if (qsmmu->bypass_quirk) {
> +		if (type == S2CR_TYPE_BYPASS) {
> +			/*
> +			 * Firmware with quirky S2CR handling will substitute
> +			 * BYPASS writes with FAULT, so point the stream to the
> +			 * reserved context bank and ask for translation on the
> +			 * stream
> +			 */
> +			type = S2CR_TYPE_TRANS;
> +			cbndx = qsmmu->bypass_cbndx;
> +		} else if (type == S2CR_TYPE_FAULT) {
> +			/*
> +			 * Firmware with quirky S2CR handling will ignore FAULT
> +			 * writes, so trick it to write FAULT by asking for a
> +			 * BYPASS.
> +			 */
> +			type = S2CR_TYPE_BYPASS;
> +			cbndx = 0xff;
> +		}
> +	}
> +
> +	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, type) |
> +	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, cbndx) |
> +	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
> +	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
> +}
> +
>   static int qcom_smmu_def_domain_type(struct device *dev)
>   {
>   	const struct of_device_id *match =
> @@ -86,6 +152,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
>   	.cfg_probe = qcom_smmu_cfg_probe,
>   	.def_domain_type = qcom_smmu_def_domain_type,
>   	.reset = qcom_smmu500_reset,
> +	.write_s2cr = qcom_smmu_write_s2cr,
>   };
>   
>   struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
