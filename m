Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C12D7DF1
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076466; cv=none; b=pPnj0tZGbFIwKWtMMvma0QZwuuMHiJQHa81KjSiyKYk9CtWlRokiX2Au8v7keywu0Lv6fJET0Wpr0KTgo/H7RVMsa81CD9l6btrtAvO5L6xlDZnCwPMKwuDDUOrUMsX4oV9VRcTJJDOSChk7qzQPa5Ku0xTklSdcSQ5VAx/29oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076466; c=relaxed/simple;
	bh=gk+1cIVkTapO9VD0ARf7xDZpqBvkVnn702fQDxQmTCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFa0gBACLfWpyIeMOQNeEf6ga2b2d9usGiIU+tViIUvHsYgxk7Kdr+k19xwgVDWyw+Vuc/zx0gjz0hGyiKJXhA3FRRWePnakxcQnBoWbS5cvuGvd53lZr10ddPw6Fn20fb0nTptciDuMRR4uqTV+G39epO53utJezWYf76Pj3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uh7FdMaX; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uh7FdMaX"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so85495e9.0
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766076463; x=1766681263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71/t+zukONFmhteBzEJIyiLt6qukZUCn3lZ8Jl+QJWQ=;
        b=Uh7FdMaXRhfYBbSOkIG9mhfOpOJ32ihxCTrkjhqg42GmZGqYCdHht2z14x3Hf9sHZ6
         rv0RnmD+bbU7ESk1hmgUilpkL78WOojfYmY5HEHl4vV9ohKK07mqcrKdCyrOqB6lEpNr
         la1aJvZsOsc6gjXSRiZSZl2SEfGGcPMcoGmaMT5f9JtC5sGZBZDBC2r3Gg5X1fie26bL
         dIqRQRHFTFN796jMxs3+sb29jsH5P1g5n+Pb6aRrxjXpBPWMUJa3d88m30/h51K1DKBf
         o15ofzpL9Mz1pY+7q7ApRK48o9xY2hbVbTvFG3ieUOJ2YKrC5hbMWVR/oTIbS6IX2F0u
         lUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076463; x=1766681263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71/t+zukONFmhteBzEJIyiLt6qukZUCn3lZ8Jl+QJWQ=;
        b=FK4UCxbufrTPZtzrxiOBQ8jHZHEyfy5zWfu+7Ngu/Z4F/d720gH7sY4ThocZnY05cn
         2MoVxBAH4Cgcv6JnWnfEMRRVABWK+oqUKNinjUh4IC1GmYE4/wNv1vTlr0DvnPUeyjnW
         yOdCa/YRZq0gMlQwDrTIZSZMqDQmZw2ckJCp8hMayfpO6S7NeGI5OLI7Mfytc6LyZmFm
         KWyIel27oIIpxCvn6LZWV88XYOFj/W+Emi673/QUuctSNiBOezDRrbt+ZUPzmSrBjTXZ
         NYO17c3rk+x5fbOWwUutL24SfvYdPJewr6yaDZIR0AiY7jdlGbfO4bs8NK6TFtOx9z4W
         ZgqA==
X-Forwarded-Encrypted: i=1; AJvYcCXZdjDP12hmATR1MHhE7ZFRFmkHKzDZ/1xjqtpA8adBY2eVTUcx7CKLKG3b5+pqXG6sKBygeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZKULj7AdZsCcEptPtQojrPIxXRFqzPFqrOHezptB8bckLy3DE
	sWQb1aeDsB0kHzn0KOZ51QnY6J4Pm0RWV5ACdz2dEuZWKTFJf56maKbMD4oPBsHbAg==
X-Gm-Gg: AY/fxX5IP3NPnyjSmlHEFIbK1GxRIfMM+GX/KYswK5Td83tF4o9YlvLYt+aSUKU2pvP
	UJknN3TEfeWPQ4f6+vM/2YENWRqEIqTEiBrQAAOSypsPTYK/x+5WjQ1NdsAbcl8RogUwLn+gqib
	f5D7he94XVCIXe2aqhOBn/75Kksqkh3f8oG7ZZW2QTsq/dR5OOs5YZhz0ypxn24oFH7VxVhkFTZ
	AcNXgaUxnjP9rDOherVpWByrAAYeRjw86HiMGJYAhlIMCenBxo3e9HAeMCcqIPoyL7WG8aCPdOh
	KO7WdLJI6L5rGlOvM5nyVBGiNrPx0r4MqR4zHxCo60RynP15T7oxvsd6cdA81TFk1UD/N7U7dFT
	cRKC5wlGvtYdcJ+I6rMscwURp423s/aw8frUvTtEhf7BpQqfc7zskzdm2zi6JfLoG7ROGIOLA6F
	zCNGPLZurbgcb+xtyDw610V2DA1L4v7CkSZBtW3/LhlxvyBe8ODSX4tL1+sIU5kDQ=
X-Google-Smtp-Source: AGHT+IEwA6XXBbBrnkNpDSyMMUjDvcXJmGq2sfYYfcaOAM4R5To9TrPd6uo2ODMIhod3ttVZXOF0Qw==
X-Received: by 2002:a05:600c:8888:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-47c97d92b03mr513515e9.2.1766076462804;
        Thu, 18 Dec 2025 08:47:42 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3ac4c1esm16379985e9.14.2025.12.18.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:47:41 -0800 (PST)
Date: Thu, 18 Dec 2025 16:47:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
Message-ID: <aUQwKot1Ao0lE-C1@google.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <6fcdd663d62dcab4005401bac2d23d18dd28e0c4.1765945258.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fcdd663d62dcab4005401bac2d23d18dd28e0c4.1765945258.git.nicolinc@nvidia.com>

On Tue, Dec 16, 2025 at 08:26:02PM -0800, Nicolin Chen wrote:
> STE in a nested case requires both S1 and S2 fields. And this makes the use
> case different from the existing one.
> 
> Add coverage for previously failed cases shifting between S2-only and S1+S2
> STEs.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index 5db14718fdd6..8255a02f4efa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -33,8 +33,12 @@ static struct mm_struct sva_mm = {
>  enum arm_smmu_test_master_feat {
>  	ARM_SMMU_MASTER_TEST_ATS = BIT(0),
>  	ARM_SMMU_MASTER_TEST_STALL = BIT(1),
> +	ARM_SMMU_MASTER_TEST_NESTED = BIT(2),
>  };
>  
> +static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
> +				      enum arm_smmu_test_master_feat feat);
> +
>  static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
>  						const __le64 *used_bits,
>  						const __le64 *target,
> @@ -197,6 +201,17 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
>  	};
>  
>  	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
> +	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
> +		struct arm_smmu_ste s2ste;
> +		int i;
> +
> +		arm_smmu_test_make_s2_ste(&s2ste, ARM_SMMU_MASTER_TEST_ATS);

Shouldn't that be conditional on "ats_enabled", I see the callers of the
new tests already set ARM_SMMU_MASTER_TEST_ATS.

Thanks,
Mostafa

> +		ste->data[0] |= cpu_to_le64(
> +			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
> +		ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +		for (i = 2; i < NUM_ENTRY_QWORDS; i++)
> +			ste->data[i] = s2ste.data[i];
> +	}
>  }
>  
>  static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
> @@ -554,6 +569,35 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
>  						       NUM_EXPECTED_SYNCS(3));
>  }
>  
> +static void
> +arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
> +{
> +	struct arm_smmu_ste s1_ste;
> +	struct arm_smmu_ste s2_ste;
> +
> +	arm_smmu_test_make_cdtable_ste(
> +		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
> +		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
> +	arm_smmu_test_make_s2_ste(&s2_ste, 0);
> +	/* Expect an additional sync to unset ignored bits: EATS and MEV */
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
> +	arm_smmu_test_make_cdtable_ste(
> +		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
> +		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
> +	arm_smmu_test_make_s2_ste(&s2_ste, 0);
> +	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
> +						       NUM_EXPECTED_SYNCS(2));
> +}
> +
>  static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
>  {
>  	struct arm_smmu_cd cd = {};
> @@ -600,6 +644,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
>  	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_change_asid),
>  	KUNIT_CASE(arm_smmu_v3_write_ste_test_s1_to_s2_stall),
>  	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
> +	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass),
> +	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass),
>  	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
>  	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
>  	{},
> -- 
> 2.43.0
> 
