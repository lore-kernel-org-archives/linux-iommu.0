Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653E22A7E8
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015446; cv=none; b=JnmDldTU7QTkK4OX9QcbYbge4TrzZa2EFAZUaWG0AxECWl7k2krzMFY0ayhnhMY4BHzo9jWw4Bw1Qu0dLKnYHlCIBC3polUlz1afYo16fYeUI5Q/zOf/NFBIAlkbHrI2v7A/zPJWyfsadBwrZaUlxobhZHmlfamIMMZEh14ulv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015446; c=relaxed/simple;
	bh=HE9aqzr8e2stgYa2HwRFP2Sto99ygzQH+LuBXRw+IdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b520N1LwP6VHDDjmQUIohCBf7UY6orKos4iNEPaZrRq8pFsvrwsoL2+V7mFjTAynVPTXFVsiBOyXF9QDT8K2uzhU7zxvxix4xgeB2aq20Ejij/iDUu3Mjg92/FCorV7N+Ir8NvCFDFl2QVZVeZEvgKc5+wVZDrL17eii02yrCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMWTuIml; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMWTuIml"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2263428c8baso325145ad.1
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744015444; x=1744620244; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZGfkkPmnNx5Vcse4K7FbD7duuc9vXIWCD4w41JK8tg=;
        b=FMWTuImlI+USWcV9IgcnVYf8h5zZIkCwgdSG4X4Oj7pykWPgM5kG0zF4IU+K9mfE+b
         hOopwJS/JU/y9lIL6EC90iy3m0zor4JL9p4eVtaWVRTEORSKP1gbM/5Dw+y5ptYaHhNf
         g8VtnYCyX2roAd8I25nQFvOr13urSpK0QBHM8oi2Ost06ewkgDlUSj+ra/xFTLVvb+0X
         a8E/iBZXxBVgpKXRYCx7wXe69l9ERMYWnKCNps4q+5f+FBkY49B9AzTAT9vPvewbcvGP
         Qrh+OokB6C3k4DFA6zt0Vm3zLK87zOpP7wX4iSIxSPp2W/MCqSauy9Ti0NM4zfIni6n0
         9Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015444; x=1744620244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZGfkkPmnNx5Vcse4K7FbD7duuc9vXIWCD4w41JK8tg=;
        b=FfYFEHjdKfc/45RcCChX9VLjh9t6M2IH5uGwn2ZQ2wbJvoIlBOdWdO9ekvyjwuYGpd
         YHbT6baORHz9IoANV5bGjr8bm/jO6XhfjeuuuP17tt9+hkiFeIXqsOZE4MFwrnv/U+W+
         oVb5OEJeFp/1r3erNVZz7ODuz1ZLwN7x6Mxki/JXCmrPPf4zmCetxd15eFS/FVRdd3za
         SEPQChWBw/DB6PW+ujUxDCdo0hezZXziaTRTQitibL/2tuCpVkiYwiImy3Ne22Gy+m1p
         SiegJ4ywhyz1f4vPqNJNVyGeHEf6iKOcfopheXALb9hUJhlafPySTkhna9IdAKzzi234
         TLDw==
X-Forwarded-Encrypted: i=1; AJvYcCU7OZOQCBW43G9HK8eDJmw9dI1b53/pMeHyNIfmV3Ti3/kyfYFsjDWEWF5JcO/1E8Ydv8ye4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8ZRELhWRSZWJbMCyyLB6RjbBiIvp7pgQVz8wJBTRAoMNtF7bJ
	jsL+pR2fN81VQbMt7WcMALS6/58pRa4DOOm8UULkPAppkPpN+YtGqZQFUSI0Hg==
X-Gm-Gg: ASbGnctS4Cl0MfBpZj8vuuU1dkw/7A5MO+ef2ChCRYER25xRwVRTXS6F9j+jUyD9aCi
	1ffSS1OGphhypBn4KBO1+pY4ni9ayLMJw8OjzDVQGLjWxHm//OSJ0l0+GwsP5GwtUTc/mLbmT5F
	SF+dEbGKmAmbm0o1ITAU1SU2AkRZfF0ivLrzZujELECtppmvEX9ghE8AihNYX4tMBp9EQqJozUa
	KlwgFaSSzLcDubcG3+Q+1ROWCciQ8PTbLLQtVsadL5yP+gipDTd73KR98XaUgei56Nfgxpyge7H
	6cGSM9+2kOSmTAU/dM+EUBnAv8Qi3aKIdSnj2V2UXlhM9ZPcOtZZMnviW07dHbJuLS07cH4NAnX
	LzBmKfeGO2bXrjA==
X-Google-Smtp-Source: AGHT+IG8wjhur4IfqDYDYICfFUkplKu7lJpQ3Db3dou+cam/uidrheTR7PdDzM6iKfGDeqVg7o/0Iw==
X-Received: by 2002:a17:902:c3c1:b0:223:37ec:63be with SMTP id d9443c01a7336-22a95e499damr3284425ad.4.1744015443341;
        Mon, 07 Apr 2025 01:44:03 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3058494a321sm8298964a91.19.2025.04.07.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:44:02 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:43:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 2/4] iommu/arm-smmu-v3: Share
 arm_smmu_cmdq_issue_cmd_with_sync() with vsmmu
Message-ID: <Z_OQS-4P8HfL7M4s@google.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <e9e8df0b9dadfb8c716b8b9072657327ab14898c.1741150594.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e8df0b9dadfb8c716b8b9072657327ab14898c.1741150594.git.nicolinc@nvidia.com>

On Tue, Mar 04, 2025 at 09:04:01PM -0800, Nicolin Chen wrote:
> Allow arm-smmu-v3-iommufd to call it for S2 cache invalidations.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Thanks
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index e08c4ede4b2d..3336d196062c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -984,6 +984,8 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
>  int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
>  				bool sync);
> +int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_cmdq_ent *ent);
>  
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 310bb4109ec9..0462eb1b2912 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -929,8 +929,8 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  	return __arm_smmu_cmdq_issue_cmd(smmu, ent, false);
>  }
>  
> -static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> -					     struct arm_smmu_cmdq_ent *ent)
> +int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_cmdq_ent *ent)
>  {
>  	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
>  }
> -- 
> 2.43.0
> 
> 
