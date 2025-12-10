Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182FD21257B
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331646; cv=none; b=Qhhh1veGkVzoaiVBt9DS/E80sQlGPXIUFGMKJDww97yD0DZ/R+9TJ3rTfWD0R1q3URxoamsKB/31PhIoZNawk/xMXCpHH+WC1WJa4LbWIsaXWI7DzXpnilKjQzkFEJL+/q/Ey2zYJn6KALXQri0q/gKbRDPlyhVKNY5kRORq6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331646; c=relaxed/simple;
	bh=yXomCVJnC9D4/CCRCh2UxupN84CFfnlUXtySk01cpwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjMBxcDIvAHMsqCd8R1fh92h5e885RQPa4y6LgAq3Cg05EzUVcUD/shv2B7VER8p1Io4UQpaAipd31z8xOv6l1sLu3midjMcisQB3/mYNOVxErD3X18bX5cdm4YNmx+CK7/r3+QJJFpJBauGbOpmeARPTCxi8uhP8ZxHA+jvDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nt+MhVlS; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nt+MhVlS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765331639; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=astG5rLVVcsxhNqM58jSlwGQioV5hSGsmvVbRD1A9T8=;
	b=nt+MhVlS7kqcdl0C6tZTSNo6X0X31flg8s07yG8CiJANkPddt6hyFT421ULrjXTmvQBThtqCF2jqt6hQWGeAQKSTo4eHwQesLje3XGdD5GqGAd8EpiB/pjzigljVippy/FX5ozG4zLag5Hg2zxMHKXxor8OGrDGraEzp0N7K4VA=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuUXXfG_1765331637 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 09:53:58 +0800
Message-ID: <04fc0c2e-9649-4cde-9415-e7e0e7145776@linux.alibaba.com>
Date: Wed, 10 Dec 2025 09:53:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, skolothumtho@nvidia.com, praan@google.com
References: <cover.1765140287.git.nicolinc@nvidia.com>
 <b6d87901f89c05dd9e1d0c1e819040d205f569a7.1765140287.git.nicolinc@nvidia.com>
 <f52c705d-6032-4d85-b902-dd6d0a40b9ec@linux.alibaba.com>
 <aTiO69YZ9WA8dFe0@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aTiO69YZ9WA8dFe0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/10 05:04, Nicolin Chen 写道:
> On Mon, Dec 08, 2025 at 11:43:41AM +0800, Shuai Xue wrote:
>> Hi, Nicolin,
>>
>> Nit. Instead of duplicating this code, we can leverage the existing
>> arm_smmu_test_make_cdtable_ste() helper here.
> 
> Thanks for the review. I squashed the following changes:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index 1672e75ebffc2..197b8b55fe7a2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -33,8 +33,12 @@ static struct mm_struct sva_mm = {
>   enum arm_smmu_test_master_feat {
>   	ARM_SMMU_MASTER_TEST_ATS = BIT(0),
>   	ARM_SMMU_MASTER_TEST_STALL = BIT(1),
> +	ARM_SMMU_MASTER_TEST_NESTED = BIT(2),
>   };
>   
> +static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
> +				      enum arm_smmu_test_master_feat feat);
> +
>   static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
>   						const __le64 *used_bits,
>   						const __le64 *target,
> @@ -198,6 +202,17 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
>   	};
>   
>   	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
> +	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
> +		struct arm_smmu_ste s2ste;
> +		int i;
> +
> +		arm_smmu_test_make_s2_ste(&s2ste, ARM_SMMU_MASTER_TEST_ATS);
> +		ste->data[0] |= cpu_to_le64(
> +			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
> +		ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +		for (i = 2; i < NUM_ENTRY_QWORDS; i++)
> +			ste->data[i] = s2ste.data[i];
> +	}
>   }
>   
>   static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
> @@ -555,46 +570,17 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
>   						       NUM_EXPECTED_SYNCS(3));
>   }
>   
> -static void arm_smmu_test_make_nested_cdtable_ste(
> -	struct arm_smmu_ste *ste, unsigned int s1dss, const dma_addr_t dma_addr,
> -	enum arm_smmu_test_master_feat feat)
> -{
> -	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
> -	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
> -	struct arm_smmu_ste s1ste;
> -
> -	struct arm_smmu_master master = {
> -		.ats_enabled = ats_enabled,
> -		.cd_table.cdtab_dma = dma_addr,
> -		.cd_table.s1cdmax = 0xFF,
> -		.cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2,
> -		.smmu = &smmu,
> -		.stall_enabled = stall_enabled,
> -	};
> -
> -	arm_smmu_test_make_s2_ste(ste, ARM_SMMU_MASTER_TEST_ATS);
> -	arm_smmu_make_cdtable_ste(&s1ste, &master, ats_enabled, s1dss);
> -
> -	ste->data[0] = cpu_to_le64(
> -		STRTAB_STE_0_V |
> -		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
> -	ste->data[0] |= s1ste.data[0] & ~cpu_to_le64(STRTAB_STE_0_CFG);
> -	ste->data[1] |= s1ste.data[1];
> -	/* Merge events for DoS mitigations on eventq */
> -	ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> -}
> -
>   static void
>   arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
>   {
>   	struct arm_smmu_ste s1_ste;
>   	struct arm_smmu_ste s2_ste;
>   
> -	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
> -					      STRTAB_STE_1_S1DSS_BYPASS,
> -					      fake_cdtab_dma_addr,
> -					      ARM_SMMU_MASTER_TEST_ATS);
> +	arm_smmu_test_make_cdtable_ste(
> +		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
> +		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
>   	arm_smmu_test_make_s2_ste(&s2_ste, 0);
> +	/* Expect an additional sync to unset ignored bits: EATS and MEV */
>   	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
>   						       NUM_EXPECTED_SYNCS(3));
>   }
> @@ -605,10 +591,9 @@ arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass(struct kunit *test)
>   	struct arm_smmu_ste s1_ste;
>   	struct arm_smmu_ste s2_ste;
>   
> -	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
> -					      STRTAB_STE_1_S1DSS_BYPASS,
> -					      fake_cdtab_dma_addr,
> -					      ARM_SMMU_MASTER_TEST_ATS);
> +	arm_smmu_test_make_cdtable_ste(
> +		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
> +		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
>   	arm_smmu_test_make_s2_ste(&s2_ste, 0);
>   	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
>   						       NUM_EXPECTED_SYNCS(2));


Nice work. LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

