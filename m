Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676337B030
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228857; cv=none; b=btkMetpiWHRGREsLnxxep8rvApcK6dMW9oeQecwpY/em+AMADJ5a3Uvtdye9fdOyupW3VqEznk+iMnzS8bQX6LJX6BhclF64WCndugKyWG9j3T2wnSLeyj52Smb7zyKUKVWsLHLVcEDa2p3fPjpCoY1W19vlq3HVa7tT1LgjxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228857; c=relaxed/simple;
	bh=TPaZ33vKz8ckmmfqhsRhAsbf/FyT1EBhjrMlFwobtPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba+CME+6Aui6FNbgVBI5Ut1XRbDeYRoiBBC4CSKSBwma0NoiSbtAcXZHUZgVMvOW9GdPuJTJrLEcYn4SBWgnvsJFBfYg58slfQTbEKMm6PBhqKDPWdWHuLl2sOdfJnO3rbuuJeBtfA+6cczZtDPJxGGRrFbw+2IEYbKLMZM63lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoDlhmEp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoDlhmEp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so58275ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228853; x=1778833653; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TI/RPl3Hg34kw3CTOvuA/w8S/bd5TVv8Y9GL2bltAt8=;
        b=UoDlhmEpo1fpIMNFCiACejj4pIYMiPj2DIk5HmcYa6G8zSsm8fq4wm4+t/aWSvK75v
         5PL+EXP41nyDYvwd5q32CB31cnxr8JrqVUieIjo86urOfUoVsxubMnmn9zQfqdX2Tddr
         YlpHenNLJXvORQh65aWC7K1l7HD6zQSp7xhnjylcb/C3LYN2HICrADU1MSJElSxNKCFE
         HaPo14+H6hx9LIZ80MnUYu+knM9GoeYRvHYoqnTyCxiaV7y4Yo/0DZelCFEpq090g2y+
         5XRWtvmn/k2qJQ8O6UzHKUdrWSMcxaQluuE2zl05ct1Qnx82wDZbV+/0LkDtFf7qeBx8
         DOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228853; x=1778833653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI/RPl3Hg34kw3CTOvuA/w8S/bd5TVv8Y9GL2bltAt8=;
        b=RNVJkUcGVrRi3No/J8uE09mQDrsyPzRva/WYcYnuxxpluYLsXoM9vrVclFeYxZP51e
         EYEQeg7Rz19w5TWnDT8YzrHoHZDU2iuVEklGRKH7PfNUTgU7KFBUntn7G3D7Wnxqfz0d
         5dhrbmjDKVELUHGinPsByDKU9f8M/VSjP7naMYT6pd0g9nJl2MQN795ecsZ7bgtXC/X1
         unwfHMqmcCjFfCdqi3semXkoDtYyAGTpXIh85puKDjbCbTBI+S5cePCYBLsN59ys8Uz8
         pp1FkOVyzYIgyrNMXPTXLhovuO9CHyBKcy0o4ZiId7MZN61cmBbt8SroYsiXQRI/jMpu
         Q2CQ==
X-Gm-Message-State: AOJu0YxsxN3Q/y7gPvYKaB0R8cBwZ+JQzaQfxyY9TpDmuvXY/oVPVNLd
	QkedJhxTb1hhvoWR6BZV5e8/6uH5WbXvhkXSzgZuuVVoy+pD2KwmVbp2xhRX1uiGGg==
X-Gm-Gg: Acq92OFKZHCjSKgxDRlfgvaB8veopw9VA0p4IcT8DUhriGyySMINZSwv5CNVp1vxIO+
	K9cc4uHpSRSIWkiKHSuMFwRsK7uNP1ihgqmwdjt753JEGrYxy1IjUoCoY7E7W39WVrXxKFnCLNr
	SOQ1HOkT7szCRPf1DfaI1w/xi8rHGHRI8I4UP45Ron2pZEuqSRP1WbFB5/hRzfv+yUhgduPRKuT
	P94J0WdonGUBUHOFtMPzmJ2ZFfk/dr4WzmFhkDMppOYfB+23UhJWPXzxMaJTHNh2/33ySvENqn4
	WOkvSqpjpuseJC1SnLfuOVFnCfA3aKv/G7Sv3stlVioNOW2t/0V6NmFdIyjp6G/o554oop7hnBK
	eLgMpbV+gktUh80se7XS9TOsyxB3nxO2YmRchMn4dw8iciEFSvfOt0thSuIDnSw7+XAPreBa7Gg
	p8nAeDqMwExdz0361UdS1yIwz/gYLe3LaBqzOy5pvbYGgOATakg83a8tN3vPJR7ud9qL+J
X-Received: by 2002:a17:903:94d:b0:2ba:3b89:c3a5 with SMTP id d9443c01a7336-2bae9e68555mr3019705ad.12.1778228852902;
        Fri, 08 May 2026 01:27:32 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eac3afsm14480765ad.71.2026.05.08.01.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:27:32 -0700 (PDT)
Date: Fri, 8 May 2026 08:27:26 +0000
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
Subject: Re: [PATCH 3/9] iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq
 submission functions
Message-ID: <af2ebtfgOPzJMXFK@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <3-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:12AM -0300, Jason Gunthorpe wrote:
> Continue removing struct arm_smmu_cmdq_ent in favour of the HW based
> struct arm_smmu_cmd. Switch the lower level issue commands to work on
> the native struct by lifting arm_smmu_cmdq_build_cmd() into all the
> callers.
> 
> Following patches will revise each of the arm_smmu_cmdq_build_cmd()
> call sites to replace it with the HW struct.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 ++++++++++++---------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 

[----- >8 ------]

>  /* Should be installed after arm_smmu_install_ste_for_dev() */
> @@ -4823,7 +4826,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  	u32 reg, enables;
> -	struct arm_smmu_cmdq_ent cmd;
> +	struct arm_smmu_cmdq_ent ent;

This shouldn't be uninitialized, we only seem to be setting ent.opcode
later in the function. Since arm_smmu_cmdq_build_cmd reads other fields
of ent to build the cmd, we are potentially sending stack garbage in ent

At all other places we're correctly initializing ent. So, I believe only
in device_reset we must change it to struct arm_smmu_cmdq_ent ent = {};

> +	struct arm_smmu_cmd cmd;
>  
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
> @@ -4870,16 +4874,19 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	}
>  
>  	/* Invalidate any cached configuration */
> -	cmd.opcode = CMDQ_OP_CFGI_ALL;
> +	ent.opcode = CMDQ_OP_CFGI_ALL;
> +	arm_smmu_cmdq_build_cmd(cmd.data, &ent);
>  	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  
>  	/* Invalidate any stale TLB entries */
>  	if (smmu->features & ARM_SMMU_FEAT_HYP) {
> -		cmd.opcode = CMDQ_OP_TLBI_EL2_ALL;
> +		ent.opcode = CMDQ_OP_TLBI_EL2_ALL;
> +		arm_smmu_cmdq_build_cmd(cmd.data, &ent);
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  	}
>  
> -	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
> +	ent.opcode = CMDQ_OP_TLBI_NSNH_ALL;
> +	arm_smmu_cmdq_build_cmd(cmd.data, &ent);
>  	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  
>  	/* Event queue */

With ent initialization in device_reset addressed. 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
