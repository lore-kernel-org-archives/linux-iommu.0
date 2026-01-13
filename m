Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F734DB71
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333203; cv=none; b=q9jlXYKZy6Fxi8fuIHXrpC/6vfoYYVEtUzX7XcNnjhjbIlRzHSqOXXnxLgU1vWPA9pOaeFCsizGJirLXOaHB7hqDoh/z6Js/djiHtSDV6BMtDBSedC3Iqc+CJA9VYJlBXn1DmjrDYIJxso77VfSmsDGWzMtFIUNzg0nUrLVUi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333203; c=relaxed/simple;
	bh=L9pvL4tIvKrnNs5LLk1jav5JRIDbp3PLudE2GD4ueYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7EQk6R5xeX5+M4MkWlhxVVYKERSrOUGxE5haCRLfDI1lvPkGudD6Y8ymKnFMPDN5L2N3PHrHXpY0IYJ4wXU6iKTYQXyAhXDHisFrny2qrJ9AAZDRFYRTmCw4+/cMeut6mL0obEujBotvQRgd9Fi0Q2Z/ew/C+XKkuWyfsK0KBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EssQOT5l; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EssQOT5l"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3271744a12.3
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 11:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768333200; x=1768938000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1swaDKlG6h6/scfSPdkxcEPVWHzeELaeTZfxa+csNlI=;
        b=EssQOT5lo3nLMiA12oHnzWtkjXHOUkAp82u1svZD8Bc+j3M/5vQiKv9Kfde4wJELQP
         ppzi+7ZiBsqPHp3Mv0cQsigGVd4pfsCsMylYm77dDNx98sZRZIaCgMYAZStRlJstOHWL
         HfRfGzi0u6RRlHJTYOf3sEPwY2/AQV9zY8TKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768333200; x=1768938000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1swaDKlG6h6/scfSPdkxcEPVWHzeELaeTZfxa+csNlI=;
        b=rjX6r6ljBnLBMqfaNpSx3YEBUG856xnUnx4EaeOoeuQuY67SrwaldOdFCspaPckY7Y
         421WjSbH/SeXPqtUvaCw/gKxHGC/iskOQ6s7tT0pzeZF9BxOI/xb+7tsdyAjyVE5Irme
         hA6z9vtUy9sm1lCpFDwYmhjZ5opRKzwTO+cTQRGM2PSAEHJyccub6MpfWs/gB88kDFNO
         eomMdPMWToRKZ6RteYreWQvHtaCCnxTFCw6QPsO+QlQIdlnVKbcv/UjzRJJ/JfNHSQPM
         m3PQkueH6ED022941hGkHAyefxiVaa9SoGZRaKnPzGkw/RaOmFqxT2DHPCxumrS0jNlN
         tZBw==
X-Forwarded-Encrypted: i=1; AJvYcCWcm+dDOh3PQyIuqBu6DMuvkGoCryeFdxkJPiffVo/nFypmSGuw2m4mf4fajDaFmy+w5vDdMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx075G1gKN7Y8nID3eascc6LjkoxdkWSYv3dOdY8zd9b7pGiqOH
	VL2EAyTWpjUQgougAgVZgqylZ5hBekiFtAsVk6kpqtH2Z567vCd7bF7WUlcUr7Jp1A==
X-Gm-Gg: AY/fxX5EaoCvYI0M+Pb/teJhwKs0EA6okb50fTBISmi21EeJvV8lf8fTm98IXKTsjMJ
	7ALUa3eMrCoWShK+acu31sz4aDP36++NHB3UPyUZsH5dFCI5l/ikk56YV6Tvips/lI576UgCsnT
	26SWOCrcEFh9fPsVWOXPMK7YTDLfJhdWwfn/BhgAFfShi+OixsEGP9CEHgSiShyneQb6yeYHIPX
	0iKQufqMHBJQIrJplkvefCWKauINoE8NGl0/ULjnNXpuIfs8AIi09wjKg2z92hBLUYjV8PSZm8Z
	zZHUh63RKCcbIZtjTOmpuLb2ksOuYz9q1dSI/LGWI5BHRzrZn4O10jer1+xxUDcapf5qdHv49Vw
	W0SFc29LBrty+yYgBjS6ASDDPyDsvz3gNe9fi6s3JcO6jPyjcUgxySHXSMlC2aQGd7/S9sw==
X-Received: by 2002:a17:903:3807:b0:29e:990f:26fc with SMTP id d9443c01a7336-2a599e1d255mr1305335ad.34.1768333200024;
        Tue, 13 Jan 2026 11:40:00 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:e42d:53cb:2a0f:636a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2e01sm205049135ad.46.2026.01.13.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:39:59 -0800 (PST)
Date: Tue, 13 Jan 2026 20:39:53 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <aWafiUwBI8togJvP@google.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113030052.977366-4-baolu.lu@linux.intel.com>

On Tue, Jan 13, 2026 at 11:00:48AM +0800, Lu Baolu wrote:
> The Intel VT-d PASID table entry is 512 bits (64 bytes). Because the
> hardware may fetch this entry in multiple 128-bit chunks, updating the
> entire entry while it is active (P=1) risks a "torn" read where the
> hardware observes an inconsistent state.
> 
> However, certain updates (e.g., changing page table pointers while
> keeping the translation type and domain ID the same) can be performed
> hitlessly. This is possible if the update is limited to a single
> 128-bit chunk while the other chunks remains stable.
> 
> Introduce a hitless replacement mechanism for PASID entries:
> 
> - Update 'struct pasid_entry' with a union to support 128-bit
>   access via the newly added val128[4] array.
> - Add pasid_support_hitless_replace() to determine if a transition
>   between an old and new entry is safe to perform atomically.
>   - For First-level/Nested translations: The first 128 bits (chunk 0)
>     must remain identical; chunk 1 is updated atomically.
>   - For Second-level/Pass-through: The second 128 bits (chunk 1)
>     must remain identical; chunk 0 is updated atomically.
> - If hitless replacement is supported, use intel_iommu_atomic128_set()
>   to commit the change in a single 16-byte burst.
> - If the changes are too extensive to be hitless, fall back to the
>   safe "tear down and re-setup" flow (clear present -> flush -> setup).
> 
> Fixes: 7543ee63e811 ("iommu/vt-d: Add pasid replace helpers")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h | 26 ++++++++++++++++-
>  drivers/iommu/intel/pasid.c | 57 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 35de1d77355f..b569e2828a8b 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -37,7 +37,10 @@ struct pasid_dir_entry {
>  };
>  
>  struct pasid_entry {
> -	u64 val[8];
> +	union {
> +		u64 val[8];
> +		u128 val128[4];
> +	};
>  };
>  
>  #define PASID_ENTRY_PGTT_FL_ONLY	(1)
> @@ -297,6 +300,27 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
>  	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
>  }
>  
> +static inline bool pasid_support_hitless_replace(struct pasid_entry *pte,
> +						 struct pasid_entry *new, int type)
> +{
> +	switch (type) {
> +	case PASID_ENTRY_PGTT_FL_ONLY:
> +	case PASID_ENTRY_PGTT_NESTED:
> +		/* The first 128 bits remain the same. */
> +		return READ_ONCE(pte->val[0]) == READ_ONCE(new->val[0]) &&
> +			READ_ONCE(pte->val[1]) == READ_ONCE(new->val[1]);
> +	case PASID_ENTRY_PGTT_SL_ONLY:
> +	case PASID_ENTRY_PGTT_PT:
> +		/* The second 128 bits remain the same. */
> +		return READ_ONCE(pte->val[2]) == READ_ONCE(new->val[2]) &&
> +			READ_ONCE(pte->val[3]) == READ_ONCE(new->val[3]);
> +	default:
> +		WARN_ON(true);

nit: WARN_ON(false) seems a bit more suitable?

> +	}
> +
> +	return false;
> +}
> +
>  extern unsigned int intel_pasid_max_id;
>  int intel_pasid_alloc_table(struct device *dev);
>  void intel_pasid_free_table(struct device *dev);
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 4f36138448d8..da7ab18d3bfe 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -452,7 +452,20 @@ int intel_pasid_replace_first_level(struct intel_iommu *iommu,
>  
>  	WARN_ON(old_did != pasid_get_domain_id(pte));
>  
> -	*pte = new_pte;
> +	if (!pasid_support_hitless_replace(pte, &new_pte,
> +					   PASID_ENTRY_PGTT_FL_ONLY)) {
> +		spin_unlock(&iommu->lock);
> +		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +		return intel_pasid_setup_first_level(iommu, dev, fsptptr,
> +						     pasid, did, flags);
> +	}
> +
> +	/*
> +	 * A first-only hitless replace requires the first 128 bits to remain
> +	 * the same. Only the second 128-bit chunk needs to be updated.
> +	 */
> +	intel_iommu_atomic128_set(&pte->val128[1], new_pte.val128[1]);
>  	spin_unlock(&iommu->lock);
>  
>  	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> @@ -563,7 +576,19 @@ int intel_pasid_replace_second_level(struct intel_iommu *iommu,
>  
>  	WARN_ON(old_did != pasid_get_domain_id(pte));
>  
> -	*pte = new_pte;
> +	if (!pasid_support_hitless_replace(pte, &new_pte,
> +					   PASID_ENTRY_PGTT_SL_ONLY)) {
> +		spin_unlock(&iommu->lock);
> +		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +		return intel_pasid_setup_second_level(iommu, domain, dev, pasid);
> +	}
> +
> +	/*
> +	 * A second-only hitless replace requires the second 128 bits to remain
> +	 * the same. Only the first 128-bit chunk needs to be updated.
> +	 */
> +	intel_iommu_atomic128_set(&pte->val128[0], new_pte.val128[0]);
>  	spin_unlock(&iommu->lock);
>  
>  	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> @@ -707,7 +732,19 @@ int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
>  
>  	WARN_ON(old_did != pasid_get_domain_id(pte));
>  
> -	*pte = new_pte;
> +	if (!pasid_support_hitless_replace(pte, &new_pte,
> +					   PASID_ENTRY_PGTT_PT)) {
> +		spin_unlock(&iommu->lock);
> +		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +		return intel_pasid_setup_pass_through(iommu, dev, pasid);
> +	}
> +
> +	/*
> +	 * A passthrough hitless replace requires the second 128 bits to remain
> +	 * the same. Only the first 128-bit chunk needs to be updated.
> +	 */
> +	intel_iommu_atomic128_set(&pte->val128[0], new_pte.val128[0]);
>  	spin_unlock(&iommu->lock);
>  
>  	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> @@ -903,7 +940,19 @@ int intel_pasid_replace_nested(struct intel_iommu *iommu,
>  
>  	WARN_ON(old_did != pasid_get_domain_id(pte));
>  
> -	*pte = new_pte;
> +	if (!pasid_support_hitless_replace(pte, &new_pte,
> +					   PASID_ENTRY_PGTT_NESTED)) {
> +		spin_unlock(&iommu->lock);
> +		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +		return intel_pasid_setup_nested(iommu, dev, pasid, domain);
> +	}
> +
> +	/*
> +	 * A nested hitless replace requires the first 128 bits to remain
> +	 * the same. Only the second 128-bit chunk needs to be updated.
> +	 */
> +	intel_iommu_atomic128_set(&pte->val128[1], new_pte.val128[1]);
>  	spin_unlock(&iommu->lock);
>  
>  	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> -- 
> 2.43.0
> 
