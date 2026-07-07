Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D63ED132
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424822; cv=none; b=YJGO1lDTIdUFonCjWGvyqe8zS1o7Y7KU8aoNszKGraOV/voTR0nw/UhColUY4b7SA94+PhqauCBo2bcMaEQzZtgx88xJOOQkUklCzN9jfxJAIjNHENoqf3bgYYYhdBujINvrFl4TkJPgswr7430/mr+XBeiIVtq/RrImve1FTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424822; c=relaxed/simple;
	bh=8VqmA/RfqjlTktvlCswxt/OoKdHFMqpb/V2Joz8bZ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOMHqoZIsQfWi6ff2wzRkyDxABkKAKLyos4Ud7wC3/n4p/XQa+ZkUrYXsvkQ217gzL3ZzXj9rK6BlgRV7SN7zo8l5AVlrr1YTS80LYB5duct8ZVFhfHbo6F7UZeMKsBNVbm0qZRKGBqb6rtcfGZZY720h7XaZE1fp5CIwcU2YPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNIS6s1v; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNIS6s1v"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c556ada3so34825e9.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783424819; x=1784029619; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCHfMn1isXXOGBYF1cLNW7WhWweWyXtBiUjIq8H8qFU=;
        b=oNIS6s1vVokdeRyVJAn+8IyVN+DBSUTfSAkDGqlKPzg2YebqjtLTFrdt319Z2eLfIY
         k/CmLBU8lj5vjb4Mf19q/3zCyWRNd7VHR5zqOnzR8gwm1nyRrsIFWyIBwRJ2dNkgmbqu
         +g9uNF/DwAwjmnwkQdqKF9kyzni40tPJRkw1co+eIt+9p3no/fwhbAdsz/cUoCbUGFUm
         KtPjJDQz2ng08UYPrOWV5eksrvWdUX4tNARYOW/rvnQu4wRZFnsReWT/UnsDjYCZ09bL
         amsz/aEzLMSfOqXrGntHnhk8f7ArGrZWUxHK8b0KYYUdzekOE8Nwvlx260nxZngfwG+g
         S1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424819; x=1784029619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCHfMn1isXXOGBYF1cLNW7WhWweWyXtBiUjIq8H8qFU=;
        b=mzwJFNPj138jFl6yNrtyYyekdj8d+6Xx7nMxuhXqqBtXO466/1WOIlD/XOvZN45SJZ
         8/5FWXCXfM/JofV8ejDHzumgxd3apfVngcZpfqiXF5HEocVuQ+NWuYHgHjBxVVIHOBtl
         ChcHbAAEVu7GqrCSHaDhDOPiVAkoIxtoBIN/dm2eoAbNHKe1SSlvfk1kZ+008fui5R3x
         yTcVplZLk5OkeVOJMLb2S7NOBGtVKh3VDJDcDkkWFZDAZgXDQ6Vuvl7qY9XBSL7Bo+Ow
         tk0LXhQKsqzGTkhAE0uM7nIM021nM78wJLZdVgWV0KdZfJorc6RmXDm1jG4/TPg3uZsH
         85Rg==
X-Gm-Message-State: AOJu0YzpHhFnzcU8d0jNKCzzvjLP4Rbt0MOl0Y32EG6zVTpPhx/H6GxP
	+ivjS5UkZHGMWMw6Kx65sMbRe86GZykPz2GfuSJ11/TCghor/VYucyNq1tmPg75Qcw==
X-Gm-Gg: AfdE7cl7m0NXVIx4r6zAyQrsoSA80OX1Elvw2IcqgwWDH9CIL3vLNddEwJtAUX0LiG5
	qrROZ8dI+2FglyGG7d2q66G0xd7YTD32OLQgwLyEblUdPRY/q4jYyvErKomoPHBAvcS2G4z21GJ
	f8zn9DafVLBCV3AhN9G8YxFdwNnCqwXQzzzxhsOj1DfVSKEOJ5Pa2lEKYsucP0QojhWyD3J1CXh
	PQZPpGuzUE3xgnKswGotd5OXtXyDGQWE6bIzlEXEKS4Z+f3XKvm+Tg2pdI5u19MMA6e6QId4u2k
	xLMNavINbuZkoiaZ9nHPzh792MAzgBEtsz5ZuSV+hpr9MQdSFvIFk2E0Y/VAmN5TWzsFVvyGE2p
	Er1BHiJbHCkV5JrubKMrM+ho+++24tdbKskvGRTh51bMGBvwkw5dAGxoyj5f0p2lVXOo4as6QXf
	duyLPmHHwsMyfQId0aQjletBIec3kC22jKWpfj2M8K3HX1XlUx
X-Received: by 2002:a05:600c:604a:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-493e14ef934mr557925e9.2.1783424818179;
        Tue, 07 Jul 2026 04:46:58 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm32893908f8f.24.2026.07.07.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 04:46:57 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:46:51 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: Keep track in the
 arm_smmu_invs if RIL is used
Message-ID: <akznKwVE-Rc8ZjJN@google.com>
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <4-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:26:41PM -0300, Jason Gunthorpe wrote:
> Summarize if any of the inv entries will use RIL. The next patch will use
> this to avoid RIL pre-calculations unless RIL is being used by the
> invalidation.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 30 +++++++++----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 18 ++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
>  3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index add671363c828c..785dd21bd68b7a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -655,37 +655,37 @@ static void arm_smmu_v3_invs_test_verify(struct kunit *test,
>  
>  static struct arm_smmu_invs invs1 = {
>  	.num_invs = 3,
> -	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, },
> -		 { .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
> -		 { .type = INV_TYPE_ATS, .id = 3, }, },
> +	.inv = { { .smmu = &smmu, .type = INV_TYPE_S2_VMID, .id = 1, },
> +		 { .smmu = &smmu, .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 3, }, },
>  };
>  
>  static struct arm_smmu_invs invs2 = {
>  	.num_invs = 3,
> -	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
> -		 { .type = INV_TYPE_ATS, .id = 4, },
> -		 { .type = INV_TYPE_ATS, .id = 5, }, },
> +	.inv = { { .smmu = &smmu, .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 4, },
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 5, }, },
>  };
>  
>  static struct arm_smmu_invs invs3 = {
>  	.num_invs = 3,
> -	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
> -		 { .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
> -		 { .type = INV_TYPE_ATS, .id = 6, }, },
> +	.inv = { { .smmu = &smmu, .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 6, }, },
>  };
>  
>  static struct arm_smmu_invs invs4 = {
>  	.num_invs = 3,
> -	.inv = { { .type = INV_TYPE_ATS, .id = 10, .ssid = 1 },
> -		 { .type = INV_TYPE_ATS, .id = 10, .ssid = 3 },
> -		 { .type = INV_TYPE_ATS, .id = 12, .ssid = 1 }, },
> +	.inv = { { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 10, .ssid = 1 },
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 10, .ssid = 3 },
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 12, .ssid = 1 }, },
>  };
>  
>  static struct arm_smmu_invs invs5 = {
>  	.num_invs = 3,
> -	.inv = { { .type = INV_TYPE_ATS, .id = 10, .ssid = 2 },
> -		 { .type = INV_TYPE_ATS, .id = 10, .ssid = 3 }, /* duplicate */
> -		 { .type = INV_TYPE_ATS, .id = 12, .ssid = 2 }, },
> +	.inv = { { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 10, .ssid = 2 },
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 10, .ssid = 3 }, /* duplicate */
> +		 { .smmu = &smmu, .type = INV_TYPE_ATS, .id = 12, .ssid = 2 }, },
>  };
>  
>  static void arm_smmu_v3_invs_test(struct kunit *test)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 1ad642e09eb92d..02323fd7709f07 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -988,6 +988,18 @@ static inline int arm_smmu_invs_iter_next_cmp(struct arm_smmu_invs *invs_l,
>  	return arm_smmu_inv_cmp(cur_l, &invs_r->inv[next_r]);
>  }
>  
> +static void arm_smmu_invs_update_caps(struct arm_smmu_invs *invs,
> +				      const struct arm_smmu_inv *inv)
> +{
> +	if (arm_smmu_inv_is_ats(inv))
> +		invs->has_ats = true;
> +
> +	if (!(inv->smmu->features & ARM_SMMU_FEAT_RANGE_INV))
> +		return;
> +
> +	invs->has_range_inv = true;
> +}
> +
>  /**
>   * arm_smmu_invs_for_each_cmp - Iterate over two sorted arrays computing for
>   *                              arm_smmu_invs_merge() or arm_smmu_invs_unref()
> @@ -1058,8 +1070,7 @@ struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
>  		 */
>  		if (new != new_invs->inv)
>  			WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);
> -		if (arm_smmu_inv_is_ats(new))
> -			new_invs->has_ats = true;
> +		arm_smmu_invs_update_caps(new_invs, new);
>  		new++;
>  	}
>  
> @@ -1169,8 +1180,7 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
>  
>  	arm_smmu_invs_for_each_entry(invs, i, inv) {
>  		new_invs->inv[num_invs] = *inv;
> -		if (arm_smmu_inv_is_ats(inv))
> -			new_invs->has_ats = true;
> +		arm_smmu_invs_update_caps(new_invs, inv);
>  		num_invs++;
>  	}
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 2fc695817671fe..3ef55f8af63d90 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -755,6 +755,7 @@ static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
>   *               Must not be greater than @num_invs
>   * @rwlock: optional rwlock to fence ATS operations
>   * @has_ats: flag if the array contains an INV_TYPE_ATS or INV_TYPE_ATS_FULL
> + * @has_range_inv: flag if any entry's SMMU supports range invalidation
>   * @rcu: rcu head for kfree_rcu()
>   * @inv: flexible invalidation array
>   *
> @@ -784,6 +785,7 @@ struct arm_smmu_invs {
>  	size_t num_trashes;
>  	rwlock_t rwlock;
>  	bool has_ats;
> +	bool has_range_inv;
>  	struct rcu_head rcu;
>  	struct arm_smmu_inv inv[] __counted_by(max_invs);
>  };
> -- 
> 2.43.0
> 
