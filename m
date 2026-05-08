Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20D3D5662
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249043; cv=none; b=C+ecVOue5ofK69B8qnDlw0eKFYsjYCnXSPzt336uCaI7beJOM1M1sWE1ZCMvKXRHz5dlVqtX5wqTW/dRjHXlcTcvDQpdRgEBQcWq5CMY5xFZiZsHi8YSvqJLYMT+GXURN0SDrPyT8hdlIWaLW0QwPqVTa2Dz32fyF7hh3xMLljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249043; c=relaxed/simple;
	bh=zRCXLtmf6B0Fx0w1OYUY0vGdVNOOAYbhxzHWj5UHbJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=latWlhVGDmGGClJ9i8SL6pivPMDlq/DYxN1ugv9qnu1PLjQO4OSvEuQ0LW8L6I31m5rhzy6UUof+80tPvUyA6jszwYtdSpC+5WEbDdL0T9hAkREoHZrrt8QHi8gp0zsgTZEGIe4tFm41mqbUUTBfCcDcNyE/6InHPoPsBfTILvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fy2OJifW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fy2OJifW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba180a022dso88405ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778249041; x=1778853841; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jV748N849RYQi6RggjQ0XmU2FvPCrHd7ojXmcuhGvG8=;
        b=Fy2OJifWRCc0ymcrASKIY31SN6TmQd1i7OwF+sxJw0hj/E5vliIwGd7KQ9emZ13VlU
         KSVTqGI0aDrgxC2zQhMqmmTeTLU3iHChyM07JDRZEiMfJQ3L8P+KUKuSZ8JSpWbpzWye
         p23+aQDOjxfhvcD4zouQPddKjEgsc3jId8mMJc9P5KMXrcApRJlhCknlblKGKefoAz8H
         /Cecxx28MtdeQpQTIzrH575PcgOzIK//1h1nKWGedJHqCQbZZcmxCEDDP1tTMuvkqAAt
         viHQ6vO0+PFGmM9jvQs5AAG5BkevwhAPrJzMHMpamBv9a48Ka/b1XO2KFplL5jGYrGRZ
         8p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249041; x=1778853841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV748N849RYQi6RggjQ0XmU2FvPCrHd7ojXmcuhGvG8=;
        b=VidbFsrUYRuHxh5lpMJig1x/RMXpBu+aaVMOlcJo0floQSfro1HTjeQ1Q44yw9vWnN
         +Y4DFcRcJXMMbR4q2sp8JEdch81ji1RR2UxhHZXu5yI6fd/3ch/CdggTeIRyk5iVAYbk
         GMON1ZhqmwQiyaw670XAu5/hAhDiE/39AF6r04by60y20kth97Q9E4f2+MC3qlMCU/0S
         fCSF53k4OAVQUBMbrywqQn1w6D1wadxOJx5Z5Jejasx0yKSfd/YkpADZhVD2oEI+UBk7
         vrLfL3Ejxzn67NOIGhpLyhWejfwDf5jzjcuFPMZIcvrxHXn0SXZF9vtY2Wy99bq2He5/
         /RmQ==
X-Gm-Message-State: AOJu0YxiHk3pkV5c18AmMRBHR0rQsjBeOsJKrCLwJ+w54E9UTSUQrEMd
	3YoO/iJ4ZM3PO7CzFcGXSJ3TaqEDdaNsdrQ6OdpAb3jVT5xeCTlAhroNUMubL+SNSw==
X-Gm-Gg: Acq92OEX8q8gOoyIjIk6jWsbNTqQ32mEEmALGsNOQUG2jDKkAfg7LnJQPuEYfd81k/F
	k9zXFm6e41jkGL3BhrnGWDwb7Hlz5pUC1gruhd2agLXIbOUyVg3tQik4lKXDth7EPT/KetYVF3x
	Vrj03JO0WGFnAxR5SH6FXn/wuNZDsZkUBNUOLY+N2mugUVZTLgnJfCMAAlDFZ+XgwZnGh2fSbWR
	i8fsZQ88fu57hrG1B5QDuTTxGL3gsZ7Dahge8hv/hqtDreXROb+ZzWRG92EfnaYRvo0oEtPv1QZ
	X79v2rNh+AusjBEC8LzC8uvvp5Fera0wT2nryNeUpUbyyBN5g7R0C2HNRFtzBQCq3joSpNaO0h1
	UaRaD2b4BAhUL1PB2rIZXG9TET2p5Uwx7I70kcqKsm4jwTlXtqsOz1plyV4smQcOhs5xSxCVZsW
	FzXx1h+pIOTxaAoyrdgvNybZ/EVa8I2W0kKdsfsWHUmY/4Y77zWdEwb13ytZXQENFfUY6D
X-Received: by 2002:a17:903:1b66:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2bae9ab0221mr3993415ad.6.1778249040522;
        Fri, 08 May 2026 07:04:00 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367bed0ad05sm18255a91.12.2026.05.08.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:03:59 -0700 (PDT)
Date: Fri, 8 May 2026 14:03:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 0/9] Remove SMMUv3 struct arm_smmu_cmdq_ent
Message-ID: <af3tSOYMS-X43B4N@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:09AM -0300, Jason Gunthorpe wrote:
> [ This is part of the patch pile to move SMMUv3 over to the generic page
> table:
> 1) Introduction of new gather items and RISCV usage
>   https://patch.msgid.link/r/0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com
> 2) Remove SMMUv3 struct arm_smmu_cmdq_ent
> 3) Organize the SMMUv3 invalidation flow so iommupt can use it
> 4) Use the generic iommu page table for SMMUv3
> 
> The whole branch is here:
>    https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
> ]
> 
> The invalidation logic has this multi-step process where it first
> writes the command into a 32 byte struct arm_smmu_cmdq_ent, then it
> calls a function which converts it into a 16 byte HW struct, and
> sometimes it then edits the HW struct a little bit before passing it
> off to the batch or submission functions.
> 
> Instead just generate the HW struct directly by moving the FIELD_PREP
> blocks out of the big case statement and into helper functions. Call the
> right function in all the places that were building arm_smmu_cmdq_ent.
> 
> Add a type for the CMDQ entry similar to the STE/CD types that wraps the
> two u64s for clarity and use it everywhere.
> 
> This is intended to have no functional change. It makes the following
> patches work better and removes a bunch of LOC. I've run several AI tools
> with instruction to look for functional changes, which did find one subtle
> mistake in PRI response.
> 
> The removal of arm_smmu_cmdq_build_cmd() also achieves what Mostafa is
> doing in the pkvm series by making the command formation entirely header
> based with the arm_smmu_make_cmd_*() mini inlines.
> 
> This series has no dependencies. Several people have already tested this
> on various ARM systems along with the full iommupt conversion.
> 
> Jason Gunthorpe (9):
>   iommu/arm-smmu-v3: Add struct arm_smmu_cmd to represent the HW format
>     command
>   iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq selection functions
>   iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq submission
>     functions
>   iommu/arm-smmu-v3: Convert arm_smmu_cmdq_batch cmds to struct
>     arm_smmu_cmd
>   iommu/arm-smmu-v3: Remove CMDQ_OP_CFGI_CD_ALL from
>     arm_smmu_cmdq_build_cmd()
>   iommu/arm-smmu-v3: Directly encode simple commands
>   iommu/arm-smmu-v3: Directly encode CMDQ_OP_ATC_INV
>   iommu/arm-smmu-v3: Directly encode CMDQ_OP_SYNC
>   iommu/arm-smmu-v3: Directly encode TLBI commands
> 
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  24 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 475 +++++++-----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 248 +++++----
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  16 +-
>  4 files changed, 350 insertions(+), 413 deletions(-)
> 

I was able to test this with 7.1-rc3 on an Arm server with the 
iova_stress test [1]. For the series:

Tested-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://github.com/soleen/iova_stress
