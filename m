Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328B37EFE9
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193023; cv=none; b=WiApmFRpnkItJP1g2SFaKVkhPw4+FhA1jf3/1WUh42otdarK8vzk4/QauwkAGALNcDtkUONOM1aNSTC6lG/QXG5qiBmdf84525rIO10l++3HyNmDh91FkEA+YaO/PHBgUjxTK7anSFmaOXfsah2l2DVyZNfKK/dbDAGA2zfafkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193023; c=relaxed/simple;
	bh=eE8jrM0QRPca72lZGV0GJXKtyNBiadEN4gyfA07sIEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBkDVcmXhbWxIK9iz+9JmUuv864qXgBrdU3vMNrzDmcyQ5yHv+apc284aX6BPEmNwray8ufKjhWQfVOng3ddaLbIbsqxvCcAQJhW/nmui3n+Na2MUPQBqZsOdXKfALbyTY+8jHKXa4BKiX/3ma4UbMRv3Ty6rAdU91otEweYe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEsz+1Dd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEsz+1Dd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso19235ad.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778193022; x=1778797822; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXLiYME2DQTxz2pd/kx7mapaCXMWwSBAZuumfi0p9Io=;
        b=kEsz+1Ddg0IZ3N/0nXDN6s/GpanBf4flg0c9cI2uph7S5SLeDarjAoIGQCDF/UrKjc
         Glpbl9ASDMRBrWFSMtVyvefU4H+y0PkV14l7vY65hGpWN1c+gaVw2b4Y7VY7Xhesv18T
         pLvDw26tttUcGRbAfqsHQ2eR5viqAHN/EAythySTISGKxi9coa0dOvLoTniaHvILGm3M
         mg3qkUWZqjg0GZ2inDXkeXSc4QNQ3An0YWM3biCMMIX8fTTLQx04W16zQESvECNojZkD
         BnS+3Tv8VmrPszCLZIwEKiAeOoveXHAdASidiJksOLQ03GiZEuttdOtHUAqCs9WzZTiM
         0HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778193022; x=1778797822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXLiYME2DQTxz2pd/kx7mapaCXMWwSBAZuumfi0p9Io=;
        b=V9jTRBNNnEKKEyO0UxXC7Cpha/Ev5p+0hXedn810d8BlbJxlf2pjnb3gBQ+QIzJicx
         wNKke4kKiQ8oM/H/eZ4zQWhoRwG9akaI2y2ZnI2dyF243shXbZyrcNfSzLS7FvA6U3eC
         Kns0m8iUBrWXDgxCcV/IL9iE0jP4YC5AQ4y1BSnhgXLMrnZdesiEHWkzD3iIGuvJZ25f
         DlV7Cx0KvXKfDU4F3Mq15NuKhjj1N8Rae+yoN81VqXOihH+5wnXb/Jw0DwXg9PiEozob
         5c+/3coZ5ONLZlmD6+eJQMKcS7whuFGbdD6ALzczfs3ev1VpyQ/cZU4IqxPFrrTvTzGI
         I5Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+d55H+NVM0LZEmCPogzIU9FyqGEeh5s1R1TamHBLHCVSmw5FH2cL6K9xQBRBZ4mPILp6gaPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUvcHiF3EBLVkORGOXai4j1fZaJgR34I3DXS4lc20tG2HQjGX0
	h2EacDKna8NHlDpRQISXGkXPvz6ZtjSR4ynzUdGb8v4Vybzw5Dvzg6MQoCIKOCRrEA==
X-Gm-Gg: Acq92OGYRAymIsYnSCBR6G9eccaZFOA0z8nIqnIQYbV7qjVhg+Iw4BRUiXYjeu2v2XT
	udXkoMh2k2dRjn0bcB7FukM0d5ScI2jvaX05xac5pgrhWcuOJKh7MD1c+W8O/94fGjmKq8Y2jwD
	GapgNtQW9comCnDg+ZxpuFWbDobyOc98VMZy8WQJNXLe9t/c0x8E3UbhDf0QVR46NzDQMMTi5WX
	9egvxnGpIe23d8kh+LMVcbtnaztZcp1ojRJns9piVem6/7BUUVtgzd+ij+X4B6rFPAyTWQePljZ
	GHYssG8j5K1qxggqZyMxF5EdcST7FqVNuArIjEsTHOg+tuow7M+CuzevYz6Dzu255+UuPAaT5w5
	2C9KndNcDhJjnz1q0A/WsPa0WRXGFf9V1vi3GmrlCE239UyfBteXVUIZXq603WbJ2YDF9vuaSOr
	+HSQDDLbLDUqdlmlk2l0BBBEKcSoTzjddF62dHC4Rl47SJSIcL8PeFxLvcKSM0GHMqff4b
X-Received: by 2002:a17:902:d50d:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2bae9e68566mr1529465ad.16.1778193020571;
        Thu, 07 May 2026 15:30:20 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae788e042sm7614555ad.79.2026.05.07.15.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:30:19 -0700 (PDT)
Date: Thu, 7 May 2026 22:30:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <af0SdkjQOZxnnaQb@google.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503135413.1108138-1-nicolinc@nvidia.com>

On Sun, May 03, 2026 at 06:54:12AM -0700, Nicolin Chen wrote:
> HTTU is introduced by utilizing the Dirty Bit Modifier (DBM) in the PTE.
> When kernel maps a clean but writable page, it will set PTE_READONLY and
> PTE_DBM (aka PTE_WRITE) at the same time. When a write occurs, an HTTU-
> capable MMU will automatically clear the PTE_RDONLY bit without software
> intervention.
> 
> On the other hand, SMMU has the same HTTU feature, yet it is not enabled
> in the SVA CD. As a result, SMMU will not clear the PTE_RDONLY bit while
> sharing the CPU page table, resulting in unnecessary stalls.
> 
> Thus, enable CTXDESC_CD_0_TCR_HA and CTXDESC_CD_0_TCR_HD in the SVA CD.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index f1f8e01a7e914..1ed8a6f29dc44 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  
>  		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
>  					      CTXDESC_CD_1_TTB0_MASK);
> +
> +		/*
> +		 * Enable Hardware Access and Dirty updates (DBM) if supported.
> +		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
> +		 * share the same bit.
> +		 */
> +		if (master->smmu->features & ARM_SMMU_FEAT_HA)
> +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> +		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);

IIUC, we should be setting these if IO_PGTABLE_QUIRK_ARM_HD is present?

I think the driver maintains a clear distinction between HW capability 
(FEAT_HA/HD) and feature enablement (IO_PGTABLE_QUIRK_ARM_HD). 

We set IO_PGTABLE_QUIRK_ARM_HD during S1 domain finalize if 
IOMMU_HWPT_ALLOC_DIRTY_TRACKING flag is passed. Hence, we should check
for that flag OR IO_PGTABLE_QUIRK_ARM_HD before enabling these in CD..

Thanks,
Praan

