Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03D1A9FA4
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378473; cv=none; b=CldeThFFHOiqqIT08LgtzCe357QYkBKL52o5sCrkYBeE2kWj8fN9jh4KHrOyl12pEZ51Q6pflUmKDVYWOYGa+3Gju+DXtJ+lN8W0w6dPJFiNKGPVfOvd78q8tiR9Fa7796Aj4TPft+g4QRDM8Td/KZSEGcWcuFnEKxdMkDh+z3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378473; c=relaxed/simple;
	bh=5C8UwB9QZ7O+Mrj6n2zJugT9nynkIHNO+mInG9SkFXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg02xiweD3hzKBalerwOcRLZ2m/JdQeE/i0pwmSFRNVqg4sRoC8CMl08EUtZz5cKaoJyvQjHfFRWHhgawZxXP+r1dJIazVj0QZeWuLMbMJUedyUDBGboccEINO96BBiX5JHYCWGeP5ZmcRPRZGaXl7Irk2UQqqYxt8HIjlyhYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU/rfZzH; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU/rfZzH"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso2525e9.0
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767378470; x=1767983270; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdgCAqNkZh5ZPsycE8zm74NWIwUscD6iQ05BC6RkYo4=;
        b=KU/rfZzHIZ9kvTMVLC16nto8EN5zZNzsRF8vVOz12ZyLgLWl1n2C1fRplnIJoo308q
         91gLkQgcHXTzFa//bwGBWyJExjVc4O1YBwNO9GDJpbo0bedCB/1eD6WYuqCMnuYgysxA
         oTU2P82Rk7tRvL94UDYU8fVU4DJWVRytAoyplLeDH5biKhQUnAKfw06wSZ2y6TUwcKUm
         /EJ+qBUJKAxGESD8b8gJEtXxCt5jGV11yWYHMJfsvYrmZvpCFa0LXDsZAVst+a7I6G6P
         gRcph5JdtUJMCPA1aKeQcg2xQHHGFQgrWe9b/BhmgyqweGoNBKElOkuRNEIE3PjEkDg7
         lX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767378470; x=1767983270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdgCAqNkZh5ZPsycE8zm74NWIwUscD6iQ05BC6RkYo4=;
        b=db7AewiSU/cVzP3jlJ4d1G09I/Zi+HAv9c27+AWJWrQe4DiQ9Gf+I/LPvjORF1Knp2
         Ss6eFNOuTi/xUdXzaz5/4LpFf8gp3FUKbj7n4TuAdehlYApqqeI89RWDEyq8RlVSiV9o
         yJ3bljz5rQn0U0TXCFZFaiFKMgRmERYhaNoG8ANyxwaLoE2PfulpRo/7LnFQReQEFjkH
         HVzWEqvCRgggqrNP9P6NWeb2wLaUFoIzAaFFM1gtS/ml0H0X22MGbPcxEdzr+6k3fxKa
         CG8HJ3z3rZvDvZtGYf9MSht7v5SI/H9Xpw9x3B1BwOMPluox5E+6bQCcnh7hQSs/pgPt
         A0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZZjn+NMhx13F1cHj17qUEhuO5GDKVtm2QgiV5S5sbn+bEfXGimZJYb+A4x4e2V4o6fIWoFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIIAo4i3XlorltjYdqYCulYM/GR1Cll4OTA6A/KKOOMGFnzEXa
	1A/fZdjCsP3d8nYN5b6BOjnxvANsVFK0swe5ULeA6r8zQ9lpNB3yq6z7a2g3Lxn4TA==
X-Gm-Gg: AY/fxX4ehYoFVxskzv0aS2W4WqOjVczBzZI/Ks4IAn3BlqpxNsEtOudNqNMHVBJ4g2W
	V07IN6+1ZvNTscd2ng7pF7xrophPLrmmctotc/JViYZ+UWU7qtNes5crLMc9R6P6T5wLlXUQW5A
	aZ0wBUUCo9I4UjDiWS80Z+D1G5Zvtjv1vnP961B3dSOhwKm8dEn+UvobfX5dGg6iDO6doblVENx
	f1D7qeaYpcJVEjQWWV+0m4eNDzjxi3dJyoy/s3fiFIloGsMksIsq4iJNd4MLFQ4HiDz7wsi0O5A
	sBAShP/pHaQeyM8QInNhE1qY2qo5A/Sq4zawDEumh8ddqq/5EHqJf6rrjih8310fyDRwBsbuPur
	RpvIo4svexCgfIZRTNmazgMMZAKLWqygFD6K41k0sZ2XEiE5A71ohZyGI9DDba2rKiu8+6BJ9GP
	ox3zxOkCc8jfYUS2C7K8WoKjfbpmTrShYvzgPvaM9ZMf97VtFBq2K+
X-Google-Smtp-Source: AGHT+IEx91EhhV8c0GunswPgms6CpKa884g+uF8BO4bQNAeeUoTI6cnVz5taHMhdrNBCz6Dt0KZDDw==
X-Received: by 2002:a7b:cd82:0:b0:453:672b:5b64 with SMTP id 5b1f17b1804b1-47d6c328d28mr15475e9.2.1767378470275;
        Fri, 02 Jan 2026 10:27:50 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm85164260f8f.15.2026.01.02.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:27:49 -0800 (PST)
Date: Fri, 2 Jan 2026 18:27:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v5 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
Message-ID: <aVgOImSnVorozaJH@google.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <68d48a88a64223a1d9b76b59c05f4743f1953c9c.1766093909.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d48a88a64223a1d9b76b59c05f4743f1953c9c.1766093909.git.nicolinc@nvidia.com>

On Thu, Dec 18, 2025 at 01:41:59PM -0800, Nicolin Chen wrote:
> STE in a nested case requires both S1 and S2 fields. And this makes the use
> case different from the existing one.
> 
> Add coverage for previously failed cases shifting between S2-only and S1+S2
> STEs.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index 5db14718fdd6..4a072c2c367c 100644
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
> @@ -197,6 +201,18 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
>  	};
>  
>  	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
> +	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
> +		struct arm_smmu_ste s2ste;
> +		int i;
> +
> +		arm_smmu_test_make_s2_ste(&s2ste,
> +					  feat & ~ARM_SMMU_MASTER_TEST_NESTED);
> +		ste->data[0] |= cpu_to_le64(
> +			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
> +		ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +		for (i = 2; i < NUM_ENTRY_QWORDS; i++)
> +			ste->data[i] = s2ste.data[i];
> +	}
>  }
>  
>  static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
> @@ -554,6 +570,35 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
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
> @@ -600,6 +645,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
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
