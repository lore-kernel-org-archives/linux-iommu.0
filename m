Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E83A1A5F
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893948; cv=none; b=VG3S+dYEuOjKksXOxjij4e/hlVa5qBc/Ei7KiznDmgMIGURVq4xbTum/u/UsAEWjDJhmd6aGZZ8Ypjk9ZIA2NbjqBWkJn56iw0A4f8B3fQsBgC83FHu/cRhm60l/P1zDWkBMZtdK68M37eTM1pFJVHg3fC7NjRNdf1DAzyVoG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893948; c=relaxed/simple;
	bh=qM2Pjww8pxRD61/kVoZb79d0u/T1AD77dPP9pHfrP6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeKgD0Mknh8tl+MTI7M+tgm77z+41KOcnpXjONFcfMvGVbWoORonzMphuNSB/k1OETXGFy0AE7CUjlPNvBkNnHeQYfOspZc4xlsqOq2tWRttvwltoCJQh8pbm/qtrfNQOYuP8f+FQgqcaxMRqAD36ivgkPTr09pkkb9ErVuRp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMsp9984; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMsp9984"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a35ae38bdfso55425ad.1
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 23:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768893938; x=1769498738; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYk5VbQOx8qeK5j+I6exldUJy66Tz0nREUA5btGygaA=;
        b=cMsp99841jrZhL9YdLkTDTE1Up+gQ9W6a9chOHvkgQMIayWaKUpOiEME0C5wQNNYPJ
         XzyXZp6Hj+0WTvz9jHYs1Y7Px5bqnc2qyJhd+3GReSfwFRSZkKCNCvldFNVnips6wl2a
         KFMhdTxmjt6urUQ4TOsRcp6UmKeavqq3cYiwMVZHxaZZwyZCGVyjtw2Mb5zRKMHl8VlI
         5Bh6C//am8efHWeVgWZp5Qmts1EYCACLFnziKopayniybF39m2RQ/7baWbYxqOLVl0Ay
         3bQiF3BgNmg2m+pVSINbWwpNzB6Et5x3zyyLHzOtUvjAkNIuI6/CvvB6aCTLBG1TqfQj
         oKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768893938; x=1769498738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYk5VbQOx8qeK5j+I6exldUJy66Tz0nREUA5btGygaA=;
        b=vCcBJg/pUVRmxmRMcdloqgmNjNDckFA9uwmH2PYUsN4AswEXdClEYeWv/8kPxzRX6g
         sevXMjhzocbVRieh7U3rV/TpKhiZ/iHfyZZ9Mmyj728JMYjTA8GtnRplCQPeKelV/zWz
         0FmU+ZRd1pDH7zu2cab3x0HqoB/Yg0Jqlix+EPS1xieL/ksnHdgoh6hU+j58exi54L1S
         n2skExrQSe+nkp5nXQXAa9d6PbGEA5G76p2xlulLBNtjYuwEdTo2BfYTxOPEGUmKA99c
         05dOFOui72RYaqROWJb3GFl7pqaePoMEtaV7gJCWOMFnUQczN587YX/s/XsIvHLYbyjZ
         yk7g==
X-Forwarded-Encrypted: i=1; AJvYcCX0l7HBV85EOxm19tTJRBBhfFnyn09eVpDF/IlIm2VZL/VL2Qhmaa6kLCnFHgcLcpr8jMR7TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySpCLfte9zTA7kzpqorlgUSOyDKrOHOmy8jOJu0WHcRDRj51iO
	VdfcQx4twibfc2+itFAsAqXwgBsal9YVkZ3quUaGNBw8+PWd51GlZTahbvuWELBelA==
X-Gm-Gg: AZuq6aLx5+uqCL8cstOjw4SCuWnyz+Yog0WZ5KW9NlX2RN5+oI+8c9yoo6AkZlPdY9n
	X3pBJ5MFYSqvBMTv1EMgmr/ZeSHS8PmMR6SZwbgDgXum3F8UJo12D3SaLKBW2gAJ6uJ9WIR9+DD
	HO7Qx9AE8dbFBH8k2SbkmFkYz6ft0Yi43zSfDH6CioeiWhprQRpiuY29LmZVWGnPWU3HRyQOaeQ
	hUKzNHWWhVPwsATVLYFbNrKr0RBwjbp+7s9I1dj/bLpWHWtpK7dazPiUFkAsjqabR+X5qNH7mR3
	wIt+Xe5msu4yta0v5zb5kxTHLxKB6qjHpR+imdBtfD7xPstPhqRjkJT92thPSbcSh5b5D+XcIN2
	6jAm5oEckU6dY7XasUZMJcgsgrBonjSMWPpQxEYSGZnXjJ5t4dmofhH6GuxIrrRFIrNcGzyzMNv
	qcxHSxnV1MQqjbbHJMXwfv6whJQYdk7WGae8+lgXWOJrcx4rrW
X-Received: by 2002:a17:903:2289:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2a76c4e5f06mr647805ad.6.1768893937263;
        Mon, 19 Jan 2026 23:25:37 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c5502sm11275223b3a.24.2026.01.19.23.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:25:36 -0800 (PST)
Date: Tue, 20 Jan 2026 07:25:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE
 is Translate
Message-ID: <aW8t609h-7yDi033@google.com>
References: <20260115011243.1302402-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115011243.1302402-1-nicolinc@nvidia.com>

On Wed, Jan 14, 2026 at 05:12:43PM -0800, Nicolin Chen wrote:
> A vSTE may have three configuration types: Abort, Bypass, and Translate.
> 
> An Abort vSTE wouldn't enable ATS, but the other two might.
> 
> It makes sense for a Transalte vSTE to rely on the guest vSTE.EATS field.
> 
> For a Bypass vSTE, it would end up with an S2-only physical STE, similar
> to an attachment to a regular S2 domain. However, the nested case always
> disables ATS following the Bypass vSTE, while the regular S2 case always
> enables ATS so long as arm_smmu_ats_supported(master) == true.
> 
> Note that ATS is needed for certain VM centric workloads and historically
> non-vSMMU cases have relied on this automatic enablement. So, having the
> nested case behave differently causes problems.
> 
> To fix that, add a condition to disable_ats, so that it might enable ATS
> for a Bypass vSTE, aligning with the regular S2 case.
> 
> Fixes: f27298a82ba0 ("iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 93fdadd07431..823461a26659 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -177,7 +177,9 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  	 * config bit here base this off the EATS value in the STE. If the EATS
>  	 * is set then the VM must generate ATC flushes.
>  	 */
> -	state.disable_ats = !nested_domain->enable_ats;
> +	if (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0])) ==
> +	    STRTAB_STE_0_CFG_S1_TRANS)
> +		state.disable_ats = !nested_domain->enable_ats;
>  	ret = arm_smmu_attach_prepare(&state, domain);
>  	if (ret) {
>  		mutex_unlock(&arm_smmu_asid_lock);

This makes sense. The nested_domain->enable_ats should indeed only be
checked for Translate configs.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

