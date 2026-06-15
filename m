Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F628725B
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565489; cv=none; b=edfrD7FhORPLzeQRe9nEX7Vny6xuyBpr0U/WIMiFqWa8IOSUjyBT6olqoifhD5iLfvAQqizYQoL95Hgxi51x0DDGSEiE595ZGXs6OMMx1uaWQjIjmDCZQ1A9cKG9ofqxNih+H1fr9F5uguusdXrTC+VfDmAicsQqOx5oV9yPtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565489; c=relaxed/simple;
	bh=1GcEs9TBS6irw+neqn3bWq/PpQaZkycM4UYW8z1vx6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXTgYk1Xp3H02Pv51sW0p/6giYIlfYPGY+kCK2Sw07SH9Y1pbsac66brR0I1mMzELOwqlq9jHFMiDVCcMqaUq/CiKKvXQf+FYHQJ6FSqCGaAXcEZhwUN+PlJcUzeO3Uln1NZEr2BmPxoJM21fRsYIE8WIVLGppYhvETZ3fRpt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnsYhZ6e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnsYhZ6e"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so24425ad.0
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781565488; x=1782170288; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2l4mkkLLimCM4pi/KAoPVgTmhgqbCjkATKF284xpI8=;
        b=pnsYhZ6eFI+AqZ4mBJtI8H5bc3ZBi9SR2WlpJSGPxp1ElpwNjZrzb4Vsrou0faUW8c
         9DsbvPOx9f+RLTFiZd5ylrXzheYMev/bSbMkNEfCcSk3JTdJF8/QNviKfu3/hRy7XhKH
         3mRuYZC+8/6swZ10K41gmZAYahC1BnXO870O2pDOclfTA6HnxZ7ixoSuxjXcnTQA+R4x
         vQNsJqzW1RgPyBVgx/8lz/WbonbWP7c0dKlFHV+FGK+AMDf/+NhV/1cm5/0DBILDXu47
         SBmUZswP7ASd56NUiJO7seEAaaCaoZxcxtCmIwUIzlswqLvf1PDza1t9UVNtDMJh0bS5
         z7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781565488; x=1782170288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2l4mkkLLimCM4pi/KAoPVgTmhgqbCjkATKF284xpI8=;
        b=WJx78qagUwdZVYUhpItTfPLYxNDLoAysZ5IzTBrV3qOO6F7/CeepeTcC51JSrn/n+G
         7dOw43270LR8lO1pJB3UReG6AoYHAdZVjeOG9D+lHzjd8F4hpiaCCiMhwaJ8lRb+4r/+
         LJWBxZHC7/3CvhglWuyMSMODzoD7OSOsNT+FVC5o//eUa68YeTVp0APFUJqmHY+GipmK
         FD03Fr8vwq0pWUG85NN4yw9qCQOeqvXE6JKpvQKgCoLGzSTs7fa/fdlpBOLtXByrbUSK
         d183rkE9u5Q/W0LVuifFCsYPS+rL+t3IBRilUxraVMugCjF+xWYlVzbMn+50dTAnxuQU
         pJsw==
X-Forwarded-Encrypted: i=1; AFNElJ+1scKNRpIDNhzNZfZBW1/7s9/TvLex5BLUuaTsrlnBV+eFFt+IAfTTtYqruKsovNV5kEurQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM/mW7V0HR7Tl897GWYcgZJl++bqi1FRo5S/EWmesUkELi0IIv
	l5e/A/BQDQzIJ+CwQCpt/3MNV4EcyU5BwWmeKQPdIBa6Ed0Nq0Azcw8c05S0P+PSCA==
X-Gm-Gg: Acq92OGquMocuuBW+yAMWa3fRGnlpfIRL5GkAM2Oz/3RKcVWrD/65fyVJdPTK/KJT0H
	is27gfQdt9GVo5Bb4YOYTcUdt2gK1N9/4l9YxRN7CAhvWdDONDH9f3Oc6f174GXyXncoSNFqCdA
	cQrWVPAd44zGTYY0TYpqLPGk4dEEbBxnD9ujAAnCuqN9Oks8dI/nWLnLW/dnv54JLPk+90oITJE
	QJ4GfbWRB8LVpWOnE5dXBXkPKap8hWE8/M4lt3otb1CunodWLIIWtqqGRWqMnSqHE6R8VXOBTRM
	2aysG01/mBSlduhEn30TTmbX+GlfZJrwpWGWoAY+i07NT2qgfQPnBqTDr843qstJDFn3x4QKLWY
	te0VK+Qe2krJN4FG7yTcb5+sY9w4e1MEB6z9GG93DG50/aQctU9HO+Hv9YDXHlzpKjffAqPRxT8
	OQOKS7aKavdDyhuvm5hSFrFq2n9BcCMasEZQihpqZ9JSRGkaEmJ2OLmZJFcXKFX9Ed2jWAvw8=
X-Received: by 2002:a17:902:ef02:b0:2bf:139c:dcf3 with SMTP id d9443c01a7336-2c69c30a460mr423675ad.19.1781565487498;
        Mon, 15 Jun 2026 16:18:07 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6511sm103213235ad.24.2026.06.15.16.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:18:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:18:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, Jason Gunthorpe <jgg@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as
 host-endian u64
Message-ID: <ajCIKXu3WXBcvBqr@google.com>
References: <20260615194533.3290010-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615194533.3290010-1-nicolinc@nvidia.com>

On Mon, Jun 15, 2026 at 12:45:33PM -0700, Nicolin Chen wrote:
> arm_smmu_get_ste_update_safe() declares the eats_s1chk and eats_trans
> locals as __le64, but initializes them from FIELD_PREP(), which returns a
> host-endian value, and passes them through cpu_to_le64() at the use sites.
> 
> Sparse reports the following warnings:
> 
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1122:38: sparse: sparse: cast from restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1124:33: sparse: sparse: cast from restricted __le64
> 
> Declare both locals as u64 so the type matches FIELD_PREP() and the
> existing cpu_to_le64() at the use sites performs the host-to-little-endian
> conversion. No functional change.
> 
> Fixes: 7cad80048595 ("iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202606151017.QU0evpH9-lkp@intel.com/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ce3e801eda3b..4c0f7b17b1f37 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1240,9 +1240,9 @@ VISIBLE_IF_KUNIT
>  void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
>  				  __le64 *safe_bits)
>  {
> -	const __le64 eats_s1chk =
> +	const u64 eats_s1chk =
>  		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_S1CHK);
> -	const __le64 eats_trans =
> +	const u64 eats_trans =
>  		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
