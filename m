Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8E3783AA
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161806; cv=none; b=Gp6Cb5EpD66oQhYhFbqPkij/f5vwaz6B7qxbma7ErcMT2FflJo7yat9M7zghoMefVM++ur6jfRPefARFKMU7Ss+YIff9I0lopzugNL3jy1CeLoZbTq2kA1i/XTD3tEPSLHNiGolwhbhYqRcq5hTqm4lBlbl9rataxpjQnoRTNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161806; c=relaxed/simple;
	bh=MubRBxJrfaCqb3jr4DoPZ8EBnSLYvpqW8Qwzw3pC9Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rod7XamQMazMNtDOm/EQLu/FGbkmycRyMBwyMTOTJo8VdvGTDR+o1TDfyFSG+AJ13UrpgzHPGHdiimHLICGtu7oLGthaVBNfncibiajuR3ZinHnW4PHGUUSsGRyLjbqIslcVnor/RuZWnf5aHCCKp2wscx5TBU3H+v2k9KH9VXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFHWRPDy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFHWRPDy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a35ae38bdfso99115ad.1
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769161796; x=1769766596; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyWsTfJZcYK//5wQfcKhofWEgkaqMSSIFZwYXzEmD0A=;
        b=FFHWRPDywethJGwb6DMQEsp7a6/f2Fa1Jv5bvjIrmQgr/nfaiqkmUO9bVFWH6RUvbn
         URT751io/3BJl+t9u7REYYipfmpUeB3fPp/WIcV0mE9mQrpZBVWLWHqlZ8StaguG1Mly
         wp9rEp49FbXbwhF5ZyykI6dtkp/mS6CE9UR7ZwyBh/1XQ3BAN2NO7pzgQfdPTshf5KDT
         VExI3AuItP/q1k6GG5ExsUoE27c5HdyaluHzKFlB9IKMozEDTzZ1DHbjPczko1S52leC
         zZjP9Nc/1kWQubd6q+vpG38JaKeu5l2FPbzQwMwDqPh0Psii+Uxw99MdI77CCookr67M
         ZMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769161796; x=1769766596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyWsTfJZcYK//5wQfcKhofWEgkaqMSSIFZwYXzEmD0A=;
        b=NT2wEGaYI5BDef7BWbQxtHQxt7zSN9tIdpgDXykLg0oANprde+PmOzixsIIRNCIGq6
         FrW8B7nTa4Ddr50ShP3w5bi1p7/6JqwCSMRe+0oH1/2bw+z6WhFdI2TuWz3WiLkBuzM6
         Je/vbBFJxNNsS+uPtWMZJBwvA+MFRBI/ja1s2vYHTVRPQd8G19OvxiiPhYFerfF4mRcl
         N/p70LsC0KKoCjZSDHTahFOr8FYAoKYgO1BLffGGylDZBosSjgW37QplHxgAvAbKucCs
         pTocMAu0Iwvv6b0o3VK2LCVfrqgyz/CEu3qXpErH0E5iPYyH/rL9jPwkwZEj5yn6P9g+
         wJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgNcdt66YVysnOjDb6sYiz9KFxNo76nh2694TkP9SLz+XSERjNk571Wxj15hZX2bGBAfTngw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw35A6s3VE7NJun7JDb8/HNVsk+ki8n3tDmzYNR8DTtY2w3Hv4u
	YQdV7bzgANc02OygBtMiqTefjLAReasGWYHLfqwV1Pugso/XTCLOHs0O4w6DOYv73g==
X-Gm-Gg: AZuq6aIeSt/9sfyxRqXOayHYISzYNXTlnYhim1JtAi0BuGD3njQQofI+sLcu944q2XK
	H2ycVjvB72Q92Vdy+8k2Y9fa6AEgE1T4cLuqohNuC6QuN4rS4i7P1bQVcuRBUfG2Wv0EiDJB3pp
	Foj+lqeqeTZAbi2PnorIe43CwTi4GJ8FrLL3RWgYAIWRmydBfdZP+4nyXtZqmD6KBTug0QGpzSb
	lvLNpukMYam4oKUsaZEHUb4P+WWgPhXKf9mLaJlKeomLW1daihA4YhU4TwshalbOISrDfjTeIL2
	Fchyk5GpiSkExBx/sDsFy/1cm914AIM8WICcPIS7FcS6feqKKNtT3/y0TfxTe4BtdpsprXxwKYU
	dyA56G7/mgKrmxvsxk+3PVBuNam0zNceedVkGiIXwh9lIGntmZZvKSEU2IkQd4U4T7vB6d7dJUl
	ClBcISsMu1QzsBcz5V7RdOkCs6d1y5sYWPSG7uzvXYAAWTDLhe
X-Received: by 2002:a17:902:cf01:b0:2a1:3cda:8e99 with SMTP id d9443c01a7336-2a805d45517mr1730985ad.21.1769161795998;
        Fri, 23 Jan 2026 01:49:55 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fd929asm15517935ad.90.2026.01.23.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:49:55 -0800 (PST)
Date: Fri, 23 Jan 2026 09:49:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/7] iommu/arm-smmu-v3: Explicitly set
 smmu_domain->stage for SVA
Message-ID: <aXNEPTBNGq7sK9Bz@google.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <df4b8cbc0d67a0bfcccb09be868e0da5f0cbb743.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4b8cbc0d67a0bfcccb09be868e0da5f0cbb743.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:23PM -0800, Nicolin Chen wrote:
> Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
> based invalidation commands to flush the TLB.
> 
> Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
> path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
> to build a new per-domain invalidation array.
> 
> There is no function change.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>  3 files changed, 5 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
