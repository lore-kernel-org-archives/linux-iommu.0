Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8D14A4F9
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090254; cv=none; b=NzZTlyuNHX+wwNUHNPvdhRE3i75LFQtTFV+ujmH6jAEAzIDEoOllbfTwNaEOeb6Bp4mQjN71D2yhTzOMNJvyD5/1bfNPTV4RaZrdds3qEFINqgU46dYHi76M3WovpVRuSSfclgepXAcY6g1Z8pHzBjT/0dm+P0xMoGfa1UJZllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090254; c=relaxed/simple;
	bh=vs7thu9ZGjlYIf6x+aITyKdaIi50BAkOES4aa0JW7Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXungOZiYzzOuA0HYVzxRl0Q8p0Yq9Tt1t0RpTKb59tm+bCgvEl5xB+Eto1VVpHqCUYLI5/gfAUAlRRX88MlKmUW5W9EGm5yXxVmnt9m20/dLYw8eDkbtT/Fg3lqtVDlu2kjUaMRSy54ITmp09Zbr2pfyZhT3tugjDz9rSRxDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuN8dFXM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuN8dFXM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso79655ad.1
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744090250; x=1744695050; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIblNaCDqbuIOdoWiMsvT5bzQtdq7ut/Mrgb9e4M8PA=;
        b=UuN8dFXM/nzVnylL4Q0SxnZ2nNajcRh6qlDt7F10IguDFrRatAkXg+KS6gNauFhzf3
         mhw8tdLb7+TpjSAt13dnKpBoOqgqH8VXvbgdtAdKAu7UNq4MQGIoLbK8m08j3VNgH6HE
         DyNV6sX/ftwasGHupRXrADoCgZIl0QT5DScCXSI3tkxh6mHWS2JG4EqY3YBRCd1yZSBA
         sTnzuJ5Ti540vo1ExD6sXIq3VogGsueUkl0ecd4524Y/qe47qaIs/DTcPVYcsZKYQohI
         9lz71XeW2a+d4JTfAr87QqsWP7OftEBJREBy8ybxRfcYQd9i7PmZOCPwDHhigM8pBIsF
         qtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090250; x=1744695050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIblNaCDqbuIOdoWiMsvT5bzQtdq7ut/Mrgb9e4M8PA=;
        b=BnOZ7tUSbjF9OeTdEWXPFckFqhWOHabeYlvcuQ4AXeZgM3J5A7XApvQKZ/L3SIo/Ah
         RKSZYqWG4uvPimikyOJKyvVcx1+2GFXV3QKLVZdnBBEqIt7vPNwQ/B570mRDALRAdjHB
         1+7eaNzdmFiY09y/egJaSHaDrZ7rJH+jUwb3hMGmc+OXr44TEChm2SkyIc1MSGr6nLi1
         1ndHr6ryH7ytrZZWQ+NLEVGb9nK5Rb5T9nQsfjEU3fu+SXpaHHt/He5cou7DA9iKgwFH
         PWEQcRhqL1hILtyEObwx/THyvdvhW7AYwoJS9lDFF/qu/waJpaniUwPVqFFMO8h8EWHz
         kMaA==
X-Gm-Message-State: AOJu0YyYFE1PAMRVLcL4BkmEPABzNyB2gQud6WFhR4Wn/p9y6IHj849k
	Hlv8gIE4lHMw9QdnhpVIwkePjkA1EtNfcw0T08O+pXszxu4RPR9Ka77mILTSRQ==
X-Gm-Gg: ASbGncsQBBC/fsz6eEGi728CAYiybg9G6n84JG6DPwhXB7bNG9vW+DUN1qyOM5iUGkK
	xfO7eq1EsHwZlDz2GO19tqL2HU1Ku7s35KBHqbT/w+dh41ZDrq5LZfggwAf5GCKFsS0tvckz9Oa
	v8POz1Fm2I6AbXZADIID5dq7r7SvgCJ2kGGT9yjpA4OEhKDVytSEmRU7KRDfBrAZsta2BYTEPqL
	cdIG8PO6OXOUjJHOn3DnSQYytZ73IbzAR1C7WXMUEy7WeWt7dpisUmFhpIRLsogHi/qHpf6002N
	bxrHJT4wLdY8zxJwmwv2EoTcc/A4VU6m2wGJp4STN2Uz0hfJ5VLjzC8s9cNNXseJ0GbISHjDQuA
	uzrc=
X-Google-Smtp-Source: AGHT+IEVENxuSQ9koyTDCtEVC43uFdSdVMF6wPG/+02fUSwR03JHFDiN0ICdqRcuMfCQhrHrrYOGyQ==
X-Received: by 2002:a17:903:22d2:b0:223:3b76:4e25 with SMTP id d9443c01a7336-22ab804c493mr1114505ad.17.1744090250071;
        Mon, 07 Apr 2025 22:30:50 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee90asm9907314b3a.57.2025.04.07.22.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:30:49 -0700 (PDT)
Date: Tue, 8 Apr 2025 05:30:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	jsnitsel@redhat.com, kevin.tian@intel.com, ddutile@redhat.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add missing S2FWB feature detection
Message-ID: <Z_S0gVMuAqrv3R_v@google.com>
References: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408033351.1012411-1-aneesh.kumar@kernel.org>

On Tue, Apr 08, 2025 at 09:03:51AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> introduced S2FWB usage but omitted the corresponding feature detection.
> As a result, vIOMMU allocation fails on FVP in arm_vsmmu_alloc(), due to
> the following check:
> 
> 	if (!arm_smmu_master_canwbs(master) &&
> 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> 		return ERR_PTR(-EOPNOTSUPP);
> 
> This patch adds the missing detection logic to prevent allocation
> failure when S2FWB is supported.
> 
> Fixes: 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 358072b4e293..c7d297ceabdb 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4405,6 +4405,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
>  	if (FIELD_GET(IDR3_RIL, reg))
>  		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
> +	if (FIELD_GET(IDR3_FWB, reg))
> +		smmu->features |= ARM_SMMU_FEAT_S2FWB;
>  
>  	/* IDR5 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);

Indeed. Looks like setting the feature flag was missed previously.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
