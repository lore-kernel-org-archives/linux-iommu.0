Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13802DE70D
	for <iommu@lists.linux.dev>; Sun, 14 Dec 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751563; cv=none; b=cYvw4jXwMl1xuOAI4iLYmGl6SfFk0n3Kt1JsOF1aEw3G6oYm20UXmEPYuO5YD5GOOsuw+3PzhXr3A2G+JhBSIFgojxKh4x2Xg5eAhIA4IC3I7NtavbZ2oppPu01ePqBuijJl9lePXV+7Rfxdkvyl+ZhXF3qU9mO+myIDcskZmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751563; c=relaxed/simple;
	bh=hRO5aCgoa8UV07o3viCbY7ZAYG07ytOBFMZZzD+wX3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs8Vggl/eiNjqWRhfz/XE108sYqM3I4ViFPh8bRLVlvJyALWFeqy7HYQHy1K6DtYp/jFh//erqkO98gNFAHDLEIwkIo2Xig9WwsdkTF4P8KZOnOCicVP3w8gzrgHX22wadV9+YEgLoem3wq0qbMVE0ty2JPBP+YzB7ZOWAA4XEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pcA+TfRF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcA+TfRF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so243945e9.0
        for <iommu@lists.linux.dev>; Sun, 14 Dec 2025 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765751560; x=1766356360; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KcFIYG8pThrquY7+bXzMj2jE6v828zltZDO7Yqjwkw8=;
        b=pcA+TfRFn77pS7u2ca8BhT3fMvBRtC6Fdxgnu8Ha/mzSiyyAFDx/KWw3Edj8+CQZ0g
         5G0jySVu7RMRAHwxIv4Xs5+O7xLiExkqKPhmhJcvuUYbb1ciOny9Ik5gQYEZfRsvE1eL
         hKvAI4I0FJclO4gxfuzZcmugupCuee/IsN+aCuE0+DxFzKVP5ZejdATrLhYjcGpwZBvu
         6j5TYTl7hamE7Et6doDNKII7IsWRQp/RfXnD7++V5SBZ9406Yd2GLpB/AwKwoIHZocNf
         bW0f5CmDTI76LVj40h8rWOF1rqQHAUx+JR4G6fNm8MWIE3N7bZb8QF2cev1U1DAFRkIL
         PoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765751560; x=1766356360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcFIYG8pThrquY7+bXzMj2jE6v828zltZDO7Yqjwkw8=;
        b=oeiF/4cwRpte93jq4Bu8jCNB4O08HJqNPvGwap4loge5UGoBMGZ97UXBDQEEHPtYOZ
         E7JxMf0yLYUmQJeQwBrMwKrLuVsAl9NlpkeJCPgvexDkFfL37HSAtRK6nDlp2oy8x5YI
         O3P9tozVNZVTmug9DOTOEod1TkCcKhbUhE8YXm5BQ67BSE/4Yj2yQ1AQsgPmWKM69hoo
         mKmOAu7fawGUy8Ddi9YDMqk5+0tZfwfUcAO8AruFkY3BMO5aiuYGF/pJAUyIsnkLXaXv
         UF7sgwVahrxj5iDjveBXvJ1RRzcWxnQ1CoG0GkyNTQngzHYjOm9tiXxfQXc7/NZkVp09
         TXQA==
X-Forwarded-Encrypted: i=1; AJvYcCXIIbN7cGnK6/FsNNnz9kIjvW1PkfHG1eHQlUP1ehQLz1/bbbcERa0SY7Q+vYGB2H4c1MG3AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJJJRXRI08GYlMX69zP1SBBSrp97iio5ZzUqxuMLLfTVicPr4w
	4bsfM4Q8NZRQymjbb6WjrRds9oVKY/0tRqhr7rtXDMluwC/oS2SOvSqBcGOoreei4w==
X-Gm-Gg: AY/fxX4gsveuZ973vbwbGmgwo1Py/TUO7AV6yxeQgcUc8VRfiVHwdzq5LivViIWSCA8
	Wgk0Zk0dCt7a/YwvyNyXatVUWw4jsg0j7stESGzUO6Ft6u08mKJYEVbw9lea2uYho/z/W5sQl9c
	ZvoR1M/RDPrWyjxogdUu83SnSgpUbljkVjptHQpRMWnVzGTCQ5vm+RAMyW5mdF35HQLCR9bQy8d
	C015FMM1vQeUKXTzVHgCPuk2qEby0rH8PaKrOus3pt0iujCEqUgtKLo9vsgzS2nrcmkuTQ+4ZZv
	Q/QIXF2FAp9a+qcG1cWVflR0tex4R47hYHeSrasH4ACf3Ppn23EvmRa6FVPqY2pLlLZkJwa/Yom
	OgjO2Qd/WDinX8xo0HWkF27QQ2X8Vm7LrNhWuUyitfdk/a6dnedwNIRr5ztcv1LfuZVkiZJFGsu
	afvjQwsJqtZPzPl8lpsgGEtmJX0ce7KCWfQ/07qoBD9mOKL6HoMg==
X-Google-Smtp-Source: AGHT+IE3eRhVbzGegcHa1xcNo46EdXefsnSGCiZbU0jrtHUdR0mYYs0/N/wqhHRGzTlCZ8FRslGcTw==
X-Received: by 2002:a05:600c:c3c1:20b0:477:b358:d7aa with SMTP id 5b1f17b1804b1-47a94876b6cmr1087625e9.18.1765751559808;
        Sun, 14 Dec 2025 14:32:39 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb38a977esm17818592f8f.12.2025.12.14.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:32:39 -0800 (PST)
Date: Sun, 14 Dec 2025 22:32:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aT87A1ur4htPjM5T@google.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
 <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>

Hi Nicolin,

On Tue, Dec 09, 2025 at 06:45:16PM -0800, Nicolin Chen wrote:
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
> Add an arm_smmu_get_ste_ignored() to allow STE update algorithm to ignore
> those fields, avoiding the STE update breakages.
> 
> Note that this change is required by both MEV and EATS fields, which were
> introduced in different kernel versions. So add this get_ignored() first.
> The MEV and EATS will be added in arm_smmu_get_ste_ignored() separately.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 19 ++++++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 24 +++++++++++++++----
>  3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ae23aacc3840..d5f0e5407b9f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -900,6 +900,7 @@ struct arm_smmu_entry_writer {
>  
>  struct arm_smmu_entry_writer_ops {
>  	void (*get_used)(const __le64 *entry, __le64 *used);
> +	void (*get_ignored)(__le64 *ignored_bits);
>  	void (*sync)(struct arm_smmu_entry_writer *writer);
>  };
>  
> @@ -911,6 +912,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
> +void arm_smmu_get_ste_ignored(__le64 *ignored_bits);
>  void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
>  			  const __le64 *target);
>  void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index d2671bfd3798..3556e65cf9ac 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -38,13 +38,16 @@ enum arm_smmu_test_master_feat {
>  static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
>  						const __le64 *used_bits,
>  						const __le64 *target,
> +						const __le64 *ignored,
>  						unsigned int length)
>  {
>  	bool differs = false;
>  	unsigned int i;
>  
>  	for (i = 0; i < length; i++) {
> -		if ((entry[i] & used_bits[i]) != target[i])
> +		__le64 used = used_bits[i] & ~ignored[i];
> +
> +		if ((entry[i] & used) != (target[i] & used))
>  			differs = true;
>  	}
>  	return differs;
> @@ -56,12 +59,18 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
>  	struct arm_smmu_test_writer *test_writer =
>  		container_of(writer, struct arm_smmu_test_writer, writer);
>  	__le64 *entry_used_bits;
> +	__le64 *ignored;
>  
>  	entry_used_bits = kunit_kzalloc(
>  		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
>  		GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
>  
> +	ignored = kunit_kzalloc(test_writer->test,
> +				sizeof(*ignored) * NUM_ENTRY_QWORDS,
> +				GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test_writer->test, ignored);
> +
>  	pr_debug("STE value is now set to: ");
>  	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
>  			     test_writer->entry,
> @@ -79,14 +88,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
>  		 * configuration.
>  		 */
>  		writer->ops->get_used(test_writer->entry, entry_used_bits);
> +		if (writer->ops->get_ignored)
> +			writer->ops->get_ignored(ignored);
>  		KUNIT_EXPECT_FALSE(
>  			test_writer->test,
>  			arm_smmu_entry_differs_in_used_bits(
>  				test_writer->entry, entry_used_bits,
> -				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
> +				test_writer->init_entry, ignored,
> +				NUM_ENTRY_QWORDS) &&
>  				arm_smmu_entry_differs_in_used_bits(
>  					test_writer->entry, entry_used_bits,
> -					test_writer->target_entry,
> +					test_writer->target_entry, ignored,
>  					NUM_ENTRY_QWORDS));
>  	}
>  }
> @@ -106,6 +118,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
>  static const struct arm_smmu_entry_writer_ops test_ste_ops = {
>  	.sync = arm_smmu_test_writer_record_syncs,
>  	.get_used = arm_smmu_get_ste_used,
> +	.get_ignored = arm_smmu_get_ste_ignored,
>  };
>  
>  static const struct arm_smmu_entry_writer_ops test_cd_ops = {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d16d35c78c06..e22c0890041b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1082,6 +1082,12 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
>  
> +VISIBLE_IF_KUNIT
> +void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
> +{
> +}
> +EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
> +
>  /*
>   * Figure out if we can do a hitless update of entry to become target. Returns a
>   * bit mask where 1 indicates that qword needs to be set disruptively.
> @@ -1094,13 +1100,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  {
>  	__le64 target_used[NUM_ENTRY_QWORDS] = {};
>  	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
> +	__le64 ignored[NUM_ENTRY_QWORDS] = {};

I think we can avoid extra stack allocation for another STE, if we make
the function update cur_used directly, but no strong opinion.

>  	u8 used_qword_diff = 0;
>  	unsigned int i;
>  
>  	writer->ops->get_used(entry, cur_used);
>  	writer->ops->get_used(target, target_used);
> +	if (writer->ops->get_ignored)
> +		writer->ops->get_ignored(ignored);
>  
>  	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
> +		/*
> +		 * Ignored is only used for bits that are used by both entries,
> +		 * otherwise it is sequenced according to the unused entry.
> +		 */
> +		ignored[i] &= target_used[i] & cur_used[i];
> +
>  		/*
>  		 * Check that masks are up to date, the make functions are not
>  		 * allowed to set a bit to 1 if the used function doesn't say it
> @@ -1109,6 +1124,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  		WARN_ON_ONCE(target[i] & ~target_used[i]);
>  
>  		/* Bits can change because they are not currently being used */
> +		cur_used[i] &= ~ignored[i];
>  		unused_update[i] = (entry[i] & cur_used[i]) |
>  				   (target[i] & ~cur_used[i]);
>  		/*
> @@ -1207,12 +1223,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  		entry_set(writer, entry, target, 0, 1);
>  	} else {
>  		/*
> -		 * No inuse bit changed. Sanity check that all unused bits are 0
> -		 * in the entry. The target was already sanity checked by
> -		 * compute_qword_diff().
> +		 * No inuse bit changed, though ignored bits may have changed.
>  		 */
> -		WARN_ON_ONCE(
> -			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
> +		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);

After this change, no other caller uses the entry_set() return value, so it
can be changed to return void.

>  	}
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
> @@ -1543,6 +1556,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
>  static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
>  	.sync = arm_smmu_ste_writer_sync_entry,
>  	.get_used = arm_smmu_get_ste_used,
> +	.get_ignored = arm_smmu_get_ste_ignored,
>  };
>  

I have some mixed feelings about this, having get_used(), then get_ignored()
with the same bits set seems confusing to me, specially the get_ignored()
loops back to update cur_used, which is set from get_used()

My initial though was just to remove this bit from get_used() + some changes
to checks setting bits that are not used would be enough, and the semantics
of get_used() can be something as:
“Return bits used by the updated translation regime that MUST be observed
atomically” and in that case we can ignore things as MEV as it doesn’t
impact the translation.

However, this approach makes it a bit explicit which bits are ignored, if we
keep this logic, I think changing the name of get_ignored() might help, to
something as "get_allowed_break()" or "get_update_safe()"?

Thanks,
Mostafa

>  static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
> -- 
> 2.43.0
> 
