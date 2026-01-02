Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F165279DCC
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378409; cv=none; b=BlxFOOwKWmwp4KXKbNNLU95afsGHtVOurij6Jrc7tlX3bbEnzIhSfHbX72Ty9S15J8EWxAF6zMliqbIgYMYlx0zBj+9WFgbPSwwqF5UKzMkliR32zyUAHKSF69eCO6ZeOrrgIUMDekRp8abLyq6CBkS4h/OJU97c1v8R8sZKHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378409; c=relaxed/simple;
	bh=5nM+eL5LamiqbxWTUlEwUuzZAZDl05AsANtahARrgQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXRwrqzn2YvfsABQxQyvOaDela5NUhmf+z6NzVf3fh1IlNkm27q2EQXnbrUA45v0CRgQGBclGSR9788C0ZjFWmooLSrEd7kf3FjT7YVzDlr0uo1FsPKIuBZx0XsVDPEHI4rHXAqR5hDTKXCJt/+WlYeycJSySvHhcPpdWxgovac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdZn9XNd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdZn9XNd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so2595e9.0
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767378405; x=1767983205; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6VmRE84hy1tV7GxjuvF11hL7eqNjgvI2Nm6sb2SoCM=;
        b=xdZn9XNdPhjXEk+lcrToFHdxscrhQVb/HPZWyCIgdIPZv+pR04LqXl0By8e6yEb5Kf
         lZArEmayC/O5104U42BmNTAxtzdFPT6j/ThBx/LpzfjKVlD0op/SykLNYMyrssaa/rS0
         tdj/Nd+Y6ZyCu2SE8eEXcvqDo0Y2QvqedAKVOUHpT7ynt5/FVsdVVSvFL0+kph4fHQvu
         ZirJvw6C+brnPkwoiyrGunyP5efPsbFT4IhrxzR/x4ohLyQpnAJ69VqQHV+OR0iSLJv9
         r6AUmlIldlVaPM7NC+CVOcHpsX3ewvPMMyIdGr135FgOsDduq+IazbxcflCkL+JgbjFp
         z6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767378405; x=1767983205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6VmRE84hy1tV7GxjuvF11hL7eqNjgvI2Nm6sb2SoCM=;
        b=so7Ochl49n1GWlfHl9XQn/S8qydR4SSOo1wPKkCfYZ6BLHtEQzppjUDwQYmt+bHLHk
         InlAaWOFYOM7MqI+5KcEBsU9ptYcI6aUoFN+t1wuUkYQdLCU+VctQjsLrQu1ZoijQKyI
         ZsAhJGum8YWyErzj6i+4ADedBzWc0+Ss6oPubBAn7tjDCafsiE/ix2cRFwU644+WjGlJ
         mfFWSIBrv/4LEO8c8wv+x0+Q/exzvSNVcjoAQ5YGknYargTo2LLQYDC7Pq2wpjuEwwVA
         3AZ/3q+d+ehVA2wj2stT3G2gCgTjTSP1XmgdtEjlSlVG72qd5oWmSxLOw5k4yxrZvbTp
         b1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWaYP+N6C5Oqw959LXRGTop3vuyBq8LH8QEk1L9C0vPQdGeyah2+U6SIuDwkCVhgmaL/oVhJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8uXVpgmlEHJRovre/Dz/fbkyw4G84nfIHlO+cph2g0flfGStH
	GvpW8vpm77VXVsrJE+4BWeBQF4YH7OozLfy6hs4iO5x5UZV3a3pSMgxcXMEuKOuEBg==
X-Gm-Gg: AY/fxX6Z9BRQiHrsk29b/vRCer1hcHI+ScJiHy/3XY4gQhQTWUSIPefjYCPy8IBtZBc
	LUvU7UnjN/V9aEi8hFs4Lo0Am13Mp4B4WTDGIkQP1iqhwCi21MjrcBX6AVgG4Xad53r69qzF/Pg
	Cdm77xUxT7I21VVumQqr2HXZAOa3W6Pu8CpOPe8qsR7tifrq8FrImTsP5XRQnoB0ZBk6A8MJKwc
	XRX4gVcPnHdvrTqXV33pGoyago5/PvJqjEsJOpTfZzjpOjTgZoEJvC1nT0AriqnDx/yTtyrTP61
	rp/WJrE4pxMWFBmRmqKIMhOZbxoWZx2hrGnG8FkPonPTMLwyCjHwpTayuDU0uZ57KgpMmjTyJsT
	T3L08twhcHVrie1RcFa2HE2izjB1pv8Ad9FmFXkUoLiaF6If7+1vD+h/icLjdko/QLmfBJfuNQo
	mtcnByoo9oTCcXxBlA9EsKD1Cek9gmlI+UfgFFNgshwky/1pUQdQwSveltw3HBARI=
X-Google-Smtp-Source: AGHT+IGwg8Fa4ecp7Nausir70D/wkitZs+xtIWbvFB+O66NW8MoGvR5fFj6DnKi9U+mtSuI4iqzZiw==
X-Received: by 2002:a05:600c:207:b0:47a:80ec:b2f7 with SMTP id 5b1f17b1804b1-47d6c367ecemr12085e9.14.1767378404531;
        Fri, 02 Jan 2026 10:26:44 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm751447155e9.7.2026.01.02.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:26:43 -0800 (PST)
Date: Fri, 2 Jan 2026 18:26:40 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aVgN4KrTEw4qGz5L@google.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>

On Thu, Dec 18, 2025 at 01:41:56PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
> an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
> different than the normal S1-bypass and S1DSS-bypass modes. As a result,
> fields like MEV and EATS in S2's used list marked the word1 as a critical
> word that requested a STE.V=0. This breaks a hitless update.
> 
> However, both MEV and EATS aren't critical in terms of STE update. One
> controls the merge of the events and the other controls the ATS that is
> managed by the driver at the same time via pci_enable_ats().
> 
> Add an arm_smmu_get_ste_update_safe() to allow STE update algorithm to
> relax those fields, avoiding the STE update breakages.
> 
> After this change, entry_set has no caller checking its return value, so
> change it to void.
> 
> Note that this change is required by both MEV and EATS fields, which were
> introduced in different kernel versions. So add get_update_safe() first.
> MEV and EATS will be added to arm_smmu_get_ste_update_safe() separately.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 18 ++++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 ++++++++++++++-----
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ae23aacc3840..a6c976fa9df2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -900,6 +900,7 @@ struct arm_smmu_entry_writer {
>  
>  struct arm_smmu_entry_writer_ops {
>  	void (*get_used)(const __le64 *entry, __le64 *used);
> +	void (*get_update_safe)(__le64 *safe_bits);
>  	void (*sync)(struct arm_smmu_entry_writer *writer);
>  };
>  
> @@ -911,6 +912,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
> +void arm_smmu_get_ste_update_safe(__le64 *safe_bits);
>  void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
>  			  const __le64 *target);
>  void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index d2671bfd3798..5db14718fdd6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -38,13 +38,16 @@ enum arm_smmu_test_master_feat {
>  static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
>  						const __le64 *used_bits,
>  						const __le64 *target,
> +						const __le64 *safe,
>  						unsigned int length)
>  {
>  	bool differs = false;
>  	unsigned int i;
>  
>  	for (i = 0; i < length; i++) {
> -		if ((entry[i] & used_bits[i]) != target[i])
> +		__le64 used = used_bits[i] & ~safe[i];
> +
> +		if ((entry[i] & used) != (target[i] & used))
>  			differs = true;
>  	}
>  	return differs;
> @@ -56,12 +59,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
>  	struct arm_smmu_test_writer *test_writer =
>  		container_of(writer, struct arm_smmu_test_writer, writer);
>  	__le64 *entry_used_bits;
> +	__le64 *safe;
>  
>  	entry_used_bits = kunit_kzalloc(
>  		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
>  		GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
>  
> +	safe = kunit_kzalloc(test_writer->test,
> +			     sizeof(*safe) * NUM_ENTRY_QWORDS, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test_writer->test, safe);
> +
>  	pr_debug("STE value is now set to: ");
>  	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
>  			     test_writer->entry,
> @@ -79,14 +87,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
>  		 * configuration.
>  		 */
>  		writer->ops->get_used(test_writer->entry, entry_used_bits);
> +		if (writer->ops->get_update_safe)
> +			writer->ops->get_update_safe(safe);
>  		KUNIT_EXPECT_FALSE(
>  			test_writer->test,
>  			arm_smmu_entry_differs_in_used_bits(
>  				test_writer->entry, entry_used_bits,
> -				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
> +				test_writer->init_entry, safe,
> +				NUM_ENTRY_QWORDS) &&
>  				arm_smmu_entry_differs_in_used_bits(
>  					test_writer->entry, entry_used_bits,
> -					test_writer->target_entry,
> +					test_writer->target_entry, safe,
>  					NUM_ENTRY_QWORDS));
>  	}
>  }
> @@ -106,6 +117,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
>  static const struct arm_smmu_entry_writer_ops test_ste_ops = {
>  	.sync = arm_smmu_test_writer_record_syncs,
>  	.get_used = arm_smmu_get_ste_used,
> +	.get_update_safe = arm_smmu_get_ste_update_safe,
>  };
>  
>  static const struct arm_smmu_entry_writer_ops test_cd_ops = {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d16d35c78c06..8dbf4ad5b51e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1082,6 +1082,12 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
>  
> +VISIBLE_IF_KUNIT
> +void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
> +{
> +}
> +EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
> +
>  /*
>   * Figure out if we can do a hitless update of entry to become target. Returns a
>   * bit mask where 1 indicates that qword needs to be set disruptively.
> @@ -1094,13 +1100,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  {
>  	__le64 target_used[NUM_ENTRY_QWORDS] = {};
>  	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
> +	__le64 safe[NUM_ENTRY_QWORDS] = {};
>  	u8 used_qword_diff = 0;
>  	unsigned int i;
>  
>  	writer->ops->get_used(entry, cur_used);
>  	writer->ops->get_used(target, target_used);
> +	if (writer->ops->get_update_safe)
> +		writer->ops->get_update_safe(safe);
>  
>  	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
> +		/*
> +		 * Safe is only used for bits that are used by both entries,
> +		 * otherwise it is sequenced according to the unused entry.
> +		 */
> +		safe[i] &= target_used[i] & cur_used[i];
> +
>  		/*
>  		 * Check that masks are up to date, the make functions are not
>  		 * allowed to set a bit to 1 if the used function doesn't say it
> @@ -1109,6 +1124,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  		WARN_ON_ONCE(target[i] & ~target_used[i]);
>  
>  		/* Bits can change because they are not currently being used */
> +		cur_used[i] &= ~safe[i];
>  		unused_update[i] = (entry[i] & cur_used[i]) |
>  				   (target[i] & ~cur_used[i]);
>  		/*
> @@ -1121,7 +1137,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  	return used_qword_diff;
>  }
>  
> -static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
> +static void entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  		      const __le64 *target, unsigned int start,
>  		      unsigned int len)
>  {
> @@ -1137,7 +1153,6 @@ static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  
>  	if (changed)
>  		writer->ops->sync(writer);
> -	return changed;
>  }
>  
>  /*
> @@ -1207,12 +1222,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  		entry_set(writer, entry, target, 0, 1);
>  	} else {
>  		/*
> -		 * No inuse bit changed. Sanity check that all unused bits are 0
> -		 * in the entry. The target was already sanity checked by
> -		 * compute_qword_diff().
> +		 * No inuse bit changed, though safe bits may have changed.
>  		 */
> -		WARN_ON_ONCE(
> -			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
> +		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
>  	}
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
> @@ -1543,6 +1555,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
>  static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
>  	.sync = arm_smmu_ste_writer_sync_entry,
>  	.get_used = arm_smmu_get_ste_used,
> +	.get_update_safe = arm_smmu_get_ste_update_safe,
>  };
>  
>  static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
> -- 
> 2.43.0
> 
