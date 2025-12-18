Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3505224244
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076009; cv=none; b=HG74AGwLVwqFf6ajAvCVRDz8K7cUVVHT61NlnrrNuzBs4vHRDLIKWGfZnsswte4eTuZl6yaotck7bg2x4SGA+0+UJPJ9tmlaOwZAxqn4ZkRL/Qq1+0tOQR69W/LWtw/Yu/58MiL4BkDXn5ERqeYmAmq8nDc5AWzqAi7KBsi+y8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076009; c=relaxed/simple;
	bh=2/MaXKfhxqyVxj9QayJwVoxVAYlRySMV7B2ZT/KMvyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqK8IZY254upjeku5s1lYD/wKXypDY0+NI/T0kSKFn4JabUVNSg65UGtWeZirIWedcAiT5HT58BdZ0CVuKn41wIcJpOLXAFodc5GLEJyu6aRpM4wBOlUJpdGfP2gOkZROFxmusPNYbXtUm8zXz/Ew5zo93RyYrWPvKZOld+uMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuZvA/L5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuZvA/L5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so73035e9.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766076006; x=1766680806; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRFRUlPQs8MYfoHIvjqzyVwd6BTDQoSUt9sR2u7yUCw=;
        b=KuZvA/L5SDRqTLV3FzTk/qXPd9gBx9PBXOAa9XmzRBfXIDLtVimWG07SnMOEz1No57
         RM+fYjZj4pmrPXcVraWGp4Owp2Cx8uDdCu8KRlZz7mJfRw+9xWnjSUCu/ZVeom7cvKI6
         Bqnjt0G1J5Tg82YaBHrPy2CDxYSQrfbzX9RgDZW1nBXnykJO9e8QSqpENv0R6Z05guRn
         qdG0VJwsNSmjR/lNu6fQKOnzU/uoq4bImTRduHfj3wHas/JdvhjjKTD48B2wTt34BIMP
         dFpgQoINXzuCA+ojUqzNLLWj6jkBPRdZWp8rpLqRZfjaRNkEWbUht/Jc1s10OnzuRQIB
         +4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076006; x=1766680806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRFRUlPQs8MYfoHIvjqzyVwd6BTDQoSUt9sR2u7yUCw=;
        b=lNEMSsqzo5p+qDwY7AYEf6nz/wJWtwCEdrDuQscPKR6kItHgs1aXpYTRyaB0S6U+rY
         v5clOvSrjG7BaVtTW/Wssmx+3vETqbuQisMHgLwnBNu6xtOpPbz2z0t33sBAsyKvMVdY
         VFuGoi5lvZu9ZD1jRvDsFd6qVdKlZwx7JEH7hD6tFSc12ZXNSHxMwx6ReIzAO87pM1gC
         BGLLQy5IYq14pUhNnZj0RgT/ZOHpdeKuaMaUhnxj/Gic3m3KMF3vrA3l3Wbtvg/3ugYC
         GIAlkzrLUrO4YYK4bKCejFbKA4a6n2A6/qphqhz3/shukzsnfxi3aEor4svHQnbfS8U5
         LqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUfXai2+bsUS4gLbMhhM2k783Am6NtqywUwlLWgWFYkdIyPxqWnDpVK+HRccfKaWXljRiMbmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1ND+fEMwUfUE6MGVa06pmaN7GnIipuPj7T+9XqJvs+Q2b1T3q
	wWbd9qYt0ZDdXtB5GZ4PvPjhxNMDSpYONgA3qutLWQyPGxLK3JV1g9VYLO6tk4+MEQ==
X-Gm-Gg: AY/fxX4qDUbAIzO7HD28aEX4JqXNs/OLq3UV/IuE9gFP3maaDqFdGWIrAgjpl+mZBtc
	oI8mkhLOcxikEyT+/ep8RTMHtR72hN3LCVdBEy4zjX3iEwx7jnPNxa0TD+J18vVMJdC0KXScCuk
	j+xfBPAJZ7kcNipwrOmMRPzNx94uO/bbym/DeiUtf1kHqSHzChiZg1cSyalvupURSuv2+oICo0U
	sS4hhIlMeGeuBrTLYKhdtbi97rdTI+Hvg1EcS3wBCj+rf07sw/0DAOKfcWC4zeiK4S9dUCofEkL
	ZjeSsG1F9mOmbI2T0+z5KS9XFuNZFdNEIozLIfBEPqxLov6LKRpbYPLCwhy6eh1i2Z424ORH/be
	G7YGS1RZJ+E7D4xSHzMM7vTP9KiH3HLN2g8f0yTXm9OoBZHtB5naJX8djdq9ko6qn8TZjq3OD4C
	C61CywkfiG1v3kVdaTVAJkBCKzAxwJRMdbdEzyT2pCc/kAsrva51VXQrzBXOQqjwQ=
X-Google-Smtp-Source: AGHT+IEnzK0PXYLJ2CtrM/k+L6oaX+v8+Z0MPC6Rku7+YPKhOOkiOz08QlgBURzh2lCV3l64uptpTw==
X-Received: by 2002:a05:600c:c0dc:b0:477:95a8:2565 with SMTP id 5b1f17b1804b1-47be3cb2944mr935195e9.16.1766076005857;
        Thu, 18 Dec 2025 08:40:05 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244998ca0sm5816810f8f.32.2025.12.18.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:40:05 -0800 (PST)
Date: Thu, 18 Dec 2025 16:40:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aUQuYdFKYlFeQGCg@google.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1765945258.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1765945258.git.nicolinc@nvidia.com>

On Tue, Dec 16, 2025 at 08:25:59PM -0800, Nicolin Chen wrote:
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

I have been looking at this, as before, target was not masked at all, so
I'd expect it would be only masked with (~safe[i]) and not used.

But I think that is OK, as we only care about the used bits in the cur
entry and how it's different from target, and target is either the
acutal target or the initial STE so it musn't have any unused bits set.
So that should be fine I believe,

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

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
