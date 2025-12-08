Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841E23D7FB
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165435; cv=none; b=bbZ2prq0dw5Otj0sJoKMOyYvawyR+9BYKjE0lujzYf5wk4STHF55mhp2w8ersTM7oBNq5Fl918FL3kCWR+pFvFtwWN6ur4mq8DtIgEYnrtUuutRr4upKwdQ/L4l0le4MbfTSQ6SDWZ3QJQmiYyuBcD5bOVHIN8Me/qgr7uv8qB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165435; c=relaxed/simple;
	bh=rqmI77ec8wv3IcTPEwmIm+kmXEMlDGRcVSQaweqUB6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjxPY7J5gTKseuuBgteBssNytbfNwUMi8so/CDQwOVDIClA9TUoy9p2f0fCRx0OE0kdi7xdZ3WOSdz+yGDELdT0hJnTOC7sJ2Z0VY97mYTVznTIWQhv6hxFCO+1lMlQUHVk0DfKzJ5G/Ojx07Om4jAfGAmg0HlX6/nT3thc0jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pEFyCCeC; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pEFyCCeC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765165425; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=om5dsQvWzxASHszoSFGJ5FtUBquX+4l8f6iGkR80jFU=;
	b=pEFyCCeC3HltJ+cA+JsFtWIlvNfwKNJRjb7Lje1OYP3ycIHE9PZphxFFuSg2CzFLiyDMtvltUqKnzPf+/DFnj4utAbnY5xhmNMi8U16SSFKC8npmHA5dzXy3xShYR6LyKQqOh1FsFvT6Uw/Cu0Pw1rP8QRzU5l0yq3HAzVEoOdA=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuFEAl9_1765165423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 11:43:43 +0800
Message-ID: <f52c705d-6032-4d85-b902-dd6d0a40b9ec@linux.alibaba.com>
Date: Mon, 8 Dec 2025 11:43:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com
Cc: joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skolothumtho@nvidia.com, praan@google.com
References: <cover.1765140287.git.nicolinc@nvidia.com>
 <b6d87901f89c05dd9e1d0c1e819040d205f569a7.1765140287.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <b6d87901f89c05dd9e1d0c1e819040d205f569a7.1765140287.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/8 04:49, Nicolin Chen 写道:
> STE in a nested case requires both S1 and S2 fields. And this makes the use
> case different from the existing one.
> 
> Add coverage for previously failed cases shifting between S2-only and S1+S2
> STEs.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 61 +++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index 3556e65cf9ac..1672e75ebffc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -555,6 +555,65 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
>   						       NUM_EXPECTED_SYNCS(3));
>   }
>   
> +static void arm_smmu_test_make_nested_cdtable_ste(
> +	struct arm_smmu_ste *ste, unsigned int s1dss, const dma_addr_t dma_addr,
> +	enum arm_smmu_test_master_feat feat)
> +{
> +	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
> +	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
> +	struct arm_smmu_ste s1ste;
> +
> +	struct arm_smmu_master master = {
> +		.ats_enabled = ats_enabled,
> +		.cd_table.cdtab_dma = dma_addr,
> +		.cd_table.s1cdmax = 0xFF,
> +		.cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2,
> +		.smmu = &smmu,
> +		.stall_enabled = stall_enabled,
> +	};
> +
> +	arm_smmu_test_make_s2_ste(ste, ARM_SMMU_MASTER_TEST_ATS);
> +	arm_smmu_make_cdtable_ste(&s1ste, &master, ats_enabled, s1dss);

Hi, Nicolin,

Nit. Instead of duplicating this code, we can leverage the existing
arm_smmu_test_make_cdtable_ste() helper here.

> +
> +	ste->data[0] = cpu_to_le64(
> +		STRTAB_STE_0_V |
> +		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
> +	ste->data[0] |= s1ste.data[0] & ~cpu_to_le64(STRTAB_STE_0_CFG);
> +	ste->data[1] |= s1ste.data[1];
> +	/* Merge events for DoS mitigations on eventq */
> +	ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +}
> +
> +static void
> +arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
> +{
> +	struct arm_smmu_ste s1_ste;
> +	struct arm_smmu_ste s2_ste;
> +
> +	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
> +					      STRTAB_STE_1_S1DSS_BYPASS,
> +					      fake_cdtab_dma_addr,
> +					      ARM_SMMU_MASTER_TEST_ATS);
> +	arm_smmu_test_make_s2_ste(&s2_ste, 0);
> +	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
> +						       NUM_EXPECTED_SYNCS(3));
> +}
> +
> +static void
> +arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass(struct kunit *test)
> +{
> +	struct arm_smmu_ste s1_ste;
> +	struct arm_smmu_ste s2_ste;
> +
> +	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
> +					      STRTAB_STE_1_S1DSS_BYPASS,
> +					      fake_cdtab_dma_addr,
> +					      ARM_SMMU_MASTER_TEST_ATS);
> +	arm_smmu_test_make_s2_ste(&s2_ste, 0);
> +	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
> +						       NUM_EXPECTED_SYNCS(2));

It would be better to add comments explaining why the number of syncs differs
between the reverse transitions.

> +}
> +
>   static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
>   {
>   	struct arm_smmu_cd cd = {};
> @@ -601,6 +660,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
>   	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_change_asid),
>   	KUNIT_CASE(arm_smmu_v3_write_ste_test_s1_to_s2_stall),
>   	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
> +	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass),
> +	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass),
>   	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
>   	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
>   	{},

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
