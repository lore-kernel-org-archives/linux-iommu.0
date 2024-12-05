Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38B226EF2
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422424; cv=none; b=oPP6/xjI2/rWBBzbM7XJa+nGo/5uzPKCQBV9GXdvnKjxeqxMEQFonVLajETCMf6UN6Yu6mRrKW+RiqgW1b4O+PqhDQ864MZYHtE3duYJBtFVvNU1E1f6sPhw3mRLUABqtnVibo1Fkjsu1vQ0HJGOOwY3VuZhe/ZmCzziUAz0GcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422424; c=relaxed/simple;
	bh=LVGRsvusP6Y9N5hIumtpCgjWRoUZ3a65SEeOJ0J8lLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPfIpcsFVy5W714SYJEK6G420aDc/spR0/a1OqW4TMlYpYHPKY/eXLaBBFIm37k29Ei+yD/IzaFpjZfyZLKJNIyo0m0TeacA3rQ7AdhgcJcbhXyKiMpbx/nxGzWwG7o6N3xG4LcR0uX9ptTwIUFRiSqadW57dAcEEmko0NmcRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h54mILrf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h54mILrf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso8828445e9.1
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733422420; x=1734027220; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1unPXMZbH7h5cW8eJggnz5tqss4o788EkVvHmHsyGXk=;
        b=h54mILrfrYop95ePR1z9EfEoh8AhrGSbM7pk4sqCBRbjj/QLcMBkPPSB+/+GDib4d0
         W7zFBWXciH/yl/DT85EW+4+ht8s6almClcL4pv7nN7iNy6imGJyNY6lCM/4kpyDbQ+yK
         lNxCsUTGLu84RUdsaDWjdC3n+OsaJ1i/uqrnMs3dx+Pr+qHNvU7/GHOkyQqKDBACrJ07
         uJeC75zK0rqf0YXaedpKswTNtiyIrc8tg5tdp0TGh6oV0/GArIHFG+U1KwvjESP1D05Y
         h7fOoQPx3hIWnKnD8nomhTaQgp0Vv2JscgIACr+tlGLxSpwhWqTMlgtawvSz6oLhiZGI
         kaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733422420; x=1734027220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1unPXMZbH7h5cW8eJggnz5tqss4o788EkVvHmHsyGXk=;
        b=oY0SwyUSFeXNA2nDA0EZo+ZMUhZqkPHeJcC7W9kF+WKgEyQIJwnuRKumAleXNfU0C9
         SLbbl5hqogc1uvHyI26lAdOcsj1MaU/CmIXoUpHQ7TcyIox4gt6BTBWiFtbghVeWxMSe
         j5+qAUPHF6HjYdiaG3dBWrfNDTwQdEbP+XkRa6+dYmDplWr7uaMil6I6X0UIC9R0Ga9t
         AF90ecOjPDw2R+rs6YbmYtkoA85MGRCpxdeqquLkWpM892AZi4PU1H0LyI2VVtdSIWYY
         9PNl7pGjCWBNpRTabjjAhi0Mv8/kiBi6Bk2GQ++lgkFKO7tHY+1rC4aRVYYlJdbZMFaF
         EkWg==
X-Forwarded-Encrypted: i=1; AJvYcCUzucwKw5O4IRFXcTFpYkHlBoi18VB4PW0zpyXXGAgqAeBJZnLfjFaMUcYxK/uOixB2QzqBAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHunrEbFJXgr/ChGqkDyoA517qYAa9Z+YlsVSigRFEMOWelWWX
	4klhfsLe/Ebw0EP0pPSPJvNlipw3BBzyHfcYYl37UIM4/OLJV7Xwob/bz43J2Zk=
X-Gm-Gg: ASbGncuPq7Xn7rXDs3TtHxNeCA7lsxUlPfpXQVqXHfLzAtf2uZlHsMWL5/HJl1QXwnF
	gpwI+y//u9ZljUpkTD0Xx0IrBNJZqKnrnptDHkj5RIVg/ZWsxOuib07BpjSaHi1lEcFhQwdgbMY
	5gC1B0kzsvnhchOs4sNl0ZBlkpnJk4f0uqlizXeH4Lvfc+DPElV/9210bIYVvpeTCOLayfGZU+c
	dFR7vdjTuNTvC+AhUQ762UzvmkaarkOkDz/uPVjkFTx8W8O
X-Google-Smtp-Source: AGHT+IHKsHgIdjWajIbHdYgI8g5SeKEyxiZvjxt64/im4qNjm8LREHx8tkyIsq6B6xmkfdQuB8t1Ng==
X-Received: by 2002:a05:600c:1d21:b0:434:9cc4:5139 with SMTP id 5b1f17b1804b1-434ddeb0492mr3060455e9.17.1733422420375;
        Thu, 05 Dec 2024 10:13:40 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113458sm32078165e9.27.2024.12.05.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:13:39 -0800 (PST)
Date: Thu, 5 Dec 2024 18:14:04 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com, joey.gouly@arm.com, ryan.roberts@arm.com,
	broonie@kernel.org
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Document SVA interaction with new
 pagetable features
Message-ID: <20241205181404.GB664340@myrica>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>

On Thu, Dec 05, 2024 at 01:48:09PM +0000, Robin Murphy wrote:
> Process pagetables may now be using new permission-indirection-based
> features which an SMMU may not understand when given such a table for
> SVA. Although SMMUv3.4 does add its own S1PIE feature, realistically
> we're still going to have to cope with feature mismatches between CPUs
> and SMMUs, so let's start simple and essentially just document the
> expectations for what falls out as-is. Although it seems unlikely for
> SVA applications to also depend on memory-hardening features, or
> vice-versa,

Hard to predict, but SVA could be indirectly enabled by some common
library: for example a libcrypto plugin that shares the address space with
an accelerator when one is available (see uadk_engine). I'm not familiar
with the POE use-cases, but I guess a common library could also enable
those memory-hardening features, such that unsuspecting applications have
everything enabled.

> the relative lifecycles make it tricky to enforce mutual
> exclusivity. Thankfully our PIE index allocation makes it relatively
> benign for an SMMU to keep interpreting them as direct permissions, the
> only real implication is that an SVA application cannot harden itself
> against its own devices with these features. Thus, inform the user about
> that just in case they have other expectations.
> 
> Also we don't (yet) support LPA2, so deny SVA entirely if we're going to
> misunderstand the pagetable format altogether.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 1d3e71569775..9ba596430e7c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -112,6 +112,15 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  	 * from the current CPU register
>  	 */
>  	target->data[3] = cpu_to_le64(read_sysreg(mair_el1));
> +
> +	/*
> +	 * Note that we don't bother with S1PIE on the SMMU, we just rely on
> +	 * our default encoding scheme matching direct permissions anyway.
> +	 * SMMU has no notion of S1POE nor GCS, so make sure that is clear if
> +	 * either is enabled for CPUs, just in case anyone imagines otherwise.
> +	 */
> +	if (system_supports_poe() || system_supports_gcs())
> +		dev_warn_once(master->smmu->dev, "SVA devices ignore permission overlays and GCS\n");

If POE tightens the page permissions, enabling SVA on top lets the
application easily bypass the POE protection. Could we actually return
false in arm_smmu_sva_supported() instead of displaying a warning that
likely no one will notice?

I guess enforcing !(SVA & POE) on an address space would be too much work?

Thanks,
Jean

>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_sva_cd);
>  
> @@ -206,8 +215,12 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  	unsigned long asid_bits;
>  	u32 feat_mask = ARM_SMMU_FEAT_COHERENCY;
>  
> -	if (vabits_actual == 52)
> +	if (vabits_actual == 52) {
> +		/* We don't support LPA2 */
> +		if (PAGE_SIZE != SZ_64K)
> +			return false;
>  		feat_mask |= ARM_SMMU_FEAT_VAX;
> +	}
>  
>  	if ((smmu->features & feat_mask) != feat_mask)
>  		return false;
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
