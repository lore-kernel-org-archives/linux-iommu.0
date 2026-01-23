Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E237D12C
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162091; cv=none; b=PkAqtZNMT3vbClhBR0b7GyIWc/cU1MAE0yev8F3E5ddvIn7pfyNDWVOQxDtLdqrGmXV3jcIsrWc4GsxwAo18Z6LITLfahvMTF9pCA0gVai3EW3Fzd0uKXkCa6V8tjv9gZsMmNYhadWi/GnV33xC1YYQqojZXFxIGrcfu5Q5lfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162091; c=relaxed/simple;
	bh=7jP8H/Jfn0/rI3MbEn++2nxKkgZ6bWFHg2NXMRv1Mms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwuFAxHRA7w4qNj1WQo1csRRVGLNumNSj/tYzWBowCGB9TTgRjd/8whI3Mjz/PtLuZRHV+riPJEF/rg7MGEid98JpAdNftwk9n8pndf7s9skV6qZbWYIPBcjshk6Sq/FAPSy1vBwfobheDbW2xQ9+5YtLJhtdHOzoJrvJQYJwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCvrMLQL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCvrMLQL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a76b39587aso95995ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769162083; x=1769766883; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTYFAMmhtE4NKQmdzfuC730nwqhs3VcPytU8c4s1NEc=;
        b=iCvrMLQL5MhEhtFNj9L00IusOJvBgxZ+35cCQHtLkgdsCjXw5idUIH+wth8hyYn/w8
         Fut4Vy13LU5sLdwaq2f+bqs5jyZ0j6Wq5Ke9y23n86PpDzTAWKgTKgFJKFWqaR9+QHnA
         N8pCBDr3Xz8Tki23L/RjD8b/+Hul0Qrz/wkdSgENXTjYstzoN4QYMyqDO+wMGXLqetdu
         i0B82xOKMM15E5ibJaiU1sX0rgWWw6MBiOUX/SfEtJNqAv9txii/zYcQqdE3kpFH5XJZ
         7dQGuFR33x4xtaPq3f7v6F0O736cPMMDJ8KCe/W5EIKZ0PoDQTfh/VouaAXXf/7FAb1z
         FxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769162083; x=1769766883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTYFAMmhtE4NKQmdzfuC730nwqhs3VcPytU8c4s1NEc=;
        b=llX2Hg2XH1K0V8bcU8g9/lMKUdihgKWi/Q1eS4BoaFSS7kRF7ZOBQpa0eMWYsNblpS
         PTWtCL1UlDIr1lVrPTkYlVYowVd+AYpAhx4KOA2pjMbF5qzwSUomu6MBk8y4WgPtuNiU
         KeEXWdtFxN9g12cY/P9MOvKni6J4i17Xul2gQeTwtG6rQIB/hn5xLitOw4vGqHc2d0MM
         IPkYt8ngvXh6LlQ9oEVQCqTKkChQ8QO4P6esQUw5DtmMI6p5S7PKG2SEXuEKQWesKQXy
         A0+J6B286m/8P2UK97+VRThfw1QccgwqboBEwz8x3vWHww875/YroR8YyuB1mraIxQii
         dmrA==
X-Forwarded-Encrypted: i=1; AJvYcCXsya7xQWlUriUCxudUv1sctdNq+nF/5BxfdktBRGWrmeCYGyTFHSJvum9JFZ2kbKXGstsThQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykcArVtL3h7O3zdfM+iX/c8FmnCStBjMlz3BZf/P21TA0UK7B8
	NctwVHlAXTpLk/QWbBAa6kUUAf3RhZufB3RBVF3CquJ1RAyWb5uYWH0sesR+Bfcblw==
X-Gm-Gg: AZuq6aJcZZQcqXprxnbA5TgYg08J33Opzv9KguTIyD/wyblGvy9oO8DKX9yZPM5UynJ
	yPMEDdco3frEXrWcOlnsPTUNdXVeGp+eLTkChwSfFfWo/5VBKx7m35X+VEfVOSKiI9/S4G2sgpv
	Ga0OIJFTIjBxhJ7koEszQCGsVXZTn36YEAM6Ep3T9XV/Fp2qLunT4u9MudW6FAvITcetoX2OeFl
	dyW/iW9EnQ6iSeqFiV/EOlmESvxvrINGlNflYu6rYmriq+o5ddTvefpVYOTXo11Gl3szNmzrSrG
	UqOagR/WAowNEiUG7kcpmPTh50M/oeCSvETl/g3VZMb7q+h+ztVVGGvp+pyiblvAfnk2kMeu58g
	qN85b9NuFELrqdFYu2Zs4sYFHWUf2WdCP/wcljJ1KVh9VpSleeC6dQ3F5b18WCFNrdXE8i1gFsh
	rmj+ZhggqKUMS3iNtQfEYRhioHK4AQRrcHQJqVEAYH0DldQIv7
X-Received: by 2002:a17:902:e548:b0:294:ecba:c8e with SMTP id d9443c01a7336-2a805c9abbfmr2227345ad.3.1769162082816;
        Fri, 23 Jan 2026 01:54:42 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871d57csm1719570b3a.41.2026.01.23.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:54:42 -0800 (PST)
Date: Fri, 23 Jan 2026 09:54:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master
 invalidation array
Message-ID: <aXNFXJ5SWuiQvJK8@google.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <d6565a84698d93d6a2842b32bed492f87179af5e.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6565a84698d93d6a2842b32bed492f87179af5e.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:26PM -0800, Nicolin Chen wrote:
> When a master is attached from an old domain to a new domain, it needs to
> build an invalidation array to delete and add the array entries from/onto
> the invalidation arrays of those two domains, passed via the to_merge and
> to_unref arguments into arm_smmu_invs_merge/unref() respectively.
> 
> Since the master->num_streams might differ across masters, a memory would
> have to be allocated when building an to_merge/to_unref array which might
> fail with -ENOMEM.
> 
> On the other hand, an attachment to arm_smmu_blocked_domain must not fail
> so it's the best to avoid any memory allocation in that path.
> 
> Pre-allocate a fixed size invalidation array for every master. This array
> will be used as a scratch to fill dynamically when building a to_merge or
> to_unref invs array. Sort fwspec->ids in an ascending order to fit to the
> arm_smmu_invs_merge() function.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++--
>  2 files changed, 45 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks
Praan
