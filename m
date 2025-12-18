Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CA2D7DD0
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076037; cv=none; b=m5ExOn5s6Q0Ri+vkVyxWBQx0J9eGk4F5BkFRUYNUPzfU4kDNSC0WwOs8cPP+n27koUpCtvIB8Wep/s2QW4Anj+toiNaC4eRyp6QzGRLbAFD9VUAb8DisXxWItncBRsIpbWH4Pyw7o+yYE94fK2u/EUYpKNdTndQeuUPQe6Rfvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076037; c=relaxed/simple;
	bh=awiaqiCZDp63bNwX+H3yrYRLubLpus6xlU3QTONpaMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGAzEkkKz6IAbPwAbUuyvuCFDBFemjRe8NMGtM4/zDbxALR4JFRYcKSERHYOmWTUn9iF5vGiIsZqf2+ypDwtUzw9DQsz4W5BjBVvtrkRPXTmyY/123/JmKTvIrCXwZlFbHtFFW06rrOjx8pq6TIg9S6pQm5EZYuxuNs02KDW9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuGQ0DHK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuGQ0DHK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso66095e9.0
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766076034; x=1766680834; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVStRMWg0rfP2fEwAd11bQqAyXNa+0/i9rP/tVPAzuw=;
        b=EuGQ0DHKc6sU/aGu9OuWqoKhOmwsqsJiAWq9P9eHYqyAXpBHCCeISe7WjtOla+Zh+8
         8YwxsrP+mgocRhbU4JV9iA3qRZYdYqn7guChJmeyEIoXSiB0su/Novm3tsvwm7ONbhtp
         ghZ00CCjxvH5Qnzpk9zTK2aU8GZJqRy8Fs+U/hC2ponYYYP21p2DuIeMuye+2dDecTkl
         D+4QVAvaG+MqR/s0Ebj5mCmBI/N4WDFgGmuQoCqTqE8ixfhCXgv0hFwtMj8gF2TBOe+V
         SZqQD18LnwTaK/EVI/zYKS2mNZoqL85T0lBWGxbXSTUsG4JQ7TeKlBzkzagR8IpTQNOC
         Yung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076034; x=1766680834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVStRMWg0rfP2fEwAd11bQqAyXNa+0/i9rP/tVPAzuw=;
        b=ofnLRMOMrY2B8s7BzgQdR4MW7+TO8aYB4CeLIkRKgxO9xhkGvZyXtFix5WWy4cAJwW
         pV1s3QmSRA4eGKpm0Lg557KKHu9WeBYnM0vBvnM9LpQae9dRMHzQmOD3k78MlDOa/nXY
         0ConhLemH4L7+38LhFwjNBKSDT86YPjM1pJL7UT1RXA+Yp4xFH5ktQKYjKtLXuA1Xyv5
         yxaymd1+gJOwGKeZzGhrNlAIMGQ8ySUD+Y5X6FHLjqEkyZdI8t+qb9aaja8wyhWYGSmw
         1AP6tpkIip0HDMDJ5eJS17kAM6I23TqO/zryPN+IfNWyHFedAITPE/1mcdgxWjxAdOBl
         vwnA==
X-Forwarded-Encrypted: i=1; AJvYcCUG1F7PkobR13Kp/sUyCdjG97WhAEV0zwOKah7yX9EYJRHsHbiC7tDbRB4Qg/mKc+z+5154vA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxEk2yLjhpVijqs8QTvXNEMVCNFcAuCNTXp2HCRUI2BSA8gO0I
	DywXB04fbsn9nUuIX9rH7zokjLK4ontDaLRRNMyF+s0AOX6lCCn2cvZ4SjKRfQCm9g==
X-Gm-Gg: AY/fxX7ksHY3kmI9SNWPBfFEK+0pZwWILWK6tAx0YKPKsbcntA+T2meQEjEdFkfcZVe
	B453N0V5KZoeXtN6NirLPf5CmX+VJ8wX0gMRhMxCPkScQGDSrAJyizNKRH3wGoUQlwovclCBZaF
	KGuhUltz4lT1Db6rJKjct9SLpAne0XK9lwmk16YEmkNKQ/78/iTm29idyJkFyXqWQIi04Wvb0iE
	BHmP1cze2N0s9e/JzeYXkzwE+9EaftQlAu9/yHdLzAVg8HlVGTsr+3bts+SIqv5dMIvW+X/16LA
	Bs2lSPpDKCxOU5JX75SMQ6/InS3tPwl16PpJIpSLGT+4ms95TjDHcu5zTFhKM8M4WZJKe7MfYlF
	b3Tr9aYc3b+XK5qFtF89EaZvPlmEv70/9RCFM5+EuX0qqppu+ff3aOOJhDo1z5+P6CR5Y34SNKB
	l//xLEBDXtZq+nag+BOTGyMpnEN9yMjs6+bEnmNcAZ63dv3ZqYxjer
X-Google-Smtp-Source: AGHT+IEo5WDa5tT3Thb5LCrx68hS9Zizs1jUbVh5VWo2CFXMBk1R2s+dqf9FAll8MkOddqKisw01vg==
X-Received: by 2002:a05:600c:686:b0:477:b358:c0cc with SMTP id 5b1f17b1804b1-47c010b90a8mr342415e9.17.1766076033956;
        Thu, 18 Dec 2025 08:40:33 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449987a4sm5776517f8f.31.2025.12.18.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:40:33 -0800 (PST)
Date: Thu, 18 Dec 2025 16:40:30 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 2/4] iommu/arm-smmu-v3: Mark STE MEV safe when
 computing the update sequence
Message-ID: <aUQufkkJYrOp0erD@google.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <83f991cbbb1331213aabe7c1fc5f725e79f60ecd.1765945258.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f991cbbb1331213aabe7c1fc5f725e79f60ecd.1765945258.git.nicolinc@nvidia.com>

On Tue, Dec 16, 2025 at 08:26:00PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
> the hypervisor. Since MEV is in STE word 1 this causes a breaking update
> sequence that is not required and impacts real workloads.
> 
> For the purposes of STE updates the value of MEV doesn't matter, if it is
> set/cleared early or late it just results in a change to the fault reports
> that must be supported by the kernel anyhow. The spec says:
> 
>  Note: Software must expect, and be able to deal with, coalesced fault
>  records even when MEV == 0.
> 
> So mark STE MEV safe when computing the update sequence, to avoid creating
> a breaking update.
> 
> Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8dbf4ad5b51e..12a9669bcc83 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1085,6 +1085,16 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
>  VISIBLE_IF_KUNIT
>  void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
>  {
> +	/*
> +	 * MEV does not meaningfully impact the operation of the HW, it only
> +	 * changes how many fault events are generated, thus we can relax it
> +	 * when computing the ordering. The spec notes the device can act like
> +	 * MEV=1 anyhow:
> +	 *
> +	 *  Note: Software must expect, and be able to deal with, coalesced
> +	 *  fault records even when MEV == 0.
> +	 */
> +	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
>  
> -- 
> 2.43.0
> 
