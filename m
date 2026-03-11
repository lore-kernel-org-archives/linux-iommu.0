Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA0373BEC
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238978; cv=none; b=FyWAa35/1G04lS9HDFbcA4tXZkvPAh7Gb47DHm642PE13JrQO0Z/eYuFLFja7HDIRhkWbgjPnxG0G4MLFQ+BTBFZldryt9vRlSRtB9jcjXchvH08mrBo4+Q+kNQZ5boI+TX3pUSCIrwPeaQa8d0QnNZsSxkeyuHOPDYL5Ds7Ag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238978; c=relaxed/simple;
	bh=lps2ch6Ezxhbawsw9SvfC8YTWq7frNFTuH84VLMxdXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMjzOMEKECbgoa2LSqTzsYU4HL4d0dindWBYhh4fCz4MXDiojFfC+sIWuGL534G8cUoDVZ8rZn2XuGY85l8VlC8AUbcCmIbjleKGFZx9eCy5A3Wi7W0IYKRSJvfaaT7wlPFcN7cO59pWEE3kJsIbx+X6Zy3Lhpl/MzOyXEPoJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smCwVrCg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smCwVrCg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509069a7a7fso623811cf.0
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773238975; x=1773843775; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGXKk+XZV5OUBibd4BfhKYW1ym362esonYfB9+F4Duc=;
        b=smCwVrCgSbQpx0MdFqEnrpyJzzzKiY3TlHgObqoDW2w1cAdqrN+OIwK8NcAORpdRHo
         /tSSz9CUC7B5OIbX2PyU9qilz5hTvt2H0j3NhGXw965c0Lxobfqr+dzHte5ZQbqCApzu
         EjHuWMkOwXx/UER9rLt7qSQgLqcSqY+ztgyGFP/c+UNGsjKxZiUVgwAana5uBrOFjXT2
         Di/Ep1shdkBw3+DFUFVIBAwJxk80uTkpFiVwzxx4cJZIFshrXfg5ET5wxe7paCS7ggJ/
         EF3UiawtHMectxG6DVjVUWYH8Vc+REghgDCmn8fIvD3TW31Umt7zyKH2AWo2/6CozJI2
         /Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238975; x=1773843775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGXKk+XZV5OUBibd4BfhKYW1ym362esonYfB9+F4Duc=;
        b=lXkIhxw4rpv/8EH3VK/jZ9J50qeeoZ5N4hnyY/W9+FFWcCxILV4drkyDElPcZ9rFNH
         Bb6xc+LLLDTlYNb0GVDlG47jymergA5DYaqbFI/xg04D0OYhpQ71GbA4OpUIWnPhIqTp
         K2ZaTDbUMb28uox1DOCNjodRiQyygehFavor7nl69oYUPXfxpcY59rRNrTah1v849D2S
         JPw79Wb+SNP2qvqzmMTS2PRgE5pFn4E9JUGFSYWHxVJHQzJ68IMCshmq8UEZ/XXcJnBP
         a/alLM7dQba97DXhK1xPVyhP9BZegbXXEgPYWXGxrGlbc6dAXMPIIdC24eZBMk0gOAfj
         kcUg==
X-Forwarded-Encrypted: i=1; AJvYcCUHqUNnsRB61rzfuQIjXkMls6flwAwNtUjd3t8HYAvFoWbpOpG1LPoJNqkz4LNjqvEzx9WhrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydZxuXe6yxlypWpOGEqwDXmKmkAwXzoIxu1yFUlUzIwo38elGy
	AqB7ZEdfmFNicgkSHflvwRnU0tTpeXF43cJqBP6Xavhsm5FHrMW0WtSnHoPzqwAofw==
X-Gm-Gg: ATEYQzz/9VZJPKDoUcrl2LAj0y1EGbAav1qwkO5OuJNHUDzqB9fkVXbXXsf6LM08z+f
	XHd5IR9nHKXbFAMj4PhSt+cdSQZ+DrJ8gEHF/gTmf34KOMd6lVvaGPUC91PspgdOJkomdEsC/qV
	QrlGKQiYvukTqYJMASpORXdt7vCzj3Re1VB15mWi+bKxTRUJsFtgibO3rlW8WV2w4idmD9yrhrE
	+Sg8OSZBVFFoJW+19ID/oi+Ezf8FeM8VJ2rHS1xtMpSBqbqgX2VElG8yjKf4L5xGHucIPXWrR2F
	8l6Kt4FMW6f4t8xRnE1iHOj0XP9u/6tGisdF1PFqlVoIGPr5POxHkezS6bKkHsCiCKkRPbYDGfA
	h6X9aJORMRjR+Tc3SeHYH/IKRCNn4MQ91G6q2qlwStRMUKIb1TN/FVUvs8w4uJQvuwfZOKfp1jW
	ksNigXRmX7xzQ3CVlI8bYw9TpFq8qzE3axNkZrOVxCGOz+RzSmyLlkFA7n4A==
X-Received: by 2002:a05:622a:15c8:b0:4f3:5475:6b10 with SMTP id d75a77b69052e-5093827de9dmr13929241cf.8.1773238974789;
        Wed, 11 Mar 2026 07:22:54 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46734125bdasm1337658b6e.1.2026.03.11.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:22:54 -0700 (PDT)
Date: Wed, 11 Mar 2026 14:22:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allocate cmdq_batch on the heap
Message-ID: <abF6un_jrQ8zGZZ4@google.com>
References: <20260311094444.3714302-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311094444.3714302-1-yphbchou0911@gmail.com>

On Wed, Mar 11, 2026 at 05:44:44PM +0800, Cheng-Yang Chou wrote:
> The arm_smmu_cmdq_batch structure is large and was being allocated on
> the stack in four call sites, causing stack frame sizes to exceed the
> 1024-byte limit:
> 
> - arm_smmu_atc_inv_domain: 1120 bytes
> - arm_smmu_atc_inv_master: 1088 bytes
> - arm_smmu_sync_cd: 1088 bytes
> - __arm_smmu_tlb_inv_range: 1072 bytes
> 
> Move these allocations to the heap using kmalloc_obj() and kfree() to
> eliminate the -Wframe-larger-than=1024 warnings and prevent potential
> stack overflows.
> 

Thanks for the patch. I agree that we should address these warnings, but
moving these allocations to the heap via kmalloc_obj() in the fast path
is problematic. Introducing heap allocation adds unnecessary latency and
potential for allocation failure in hot paths.

So, yes, we are using a lot of stack but we're using it to do good
things.. 

IMO, if we really want to address these, instead of kmalloc, we could
potentially consider some pre-allocated per-CPU buffers (that's a lot of
additional book-keeping though) to keep the data off the stack or
something similar following a simple rule: The fast path must be 
deterministic- no SLAB allocations and no introducing new failure points

The last thing we'd want is a graphic driver's shrinker calling
dma-unmaps when the system is already under heavy memory pressure and 
calling kmalloc leading to a circular dependency or allocation failure
exactly when the system needs to perform the unmap the most.

Thanks,
Praan

> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 +++++++++++++++------
>  1 file changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f078..734546dc6a78 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1281,7 +1281,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>  			     int ssid, bool leaf)
>  {
>  	size_t i;
> -	struct arm_smmu_cmdq_batch cmds;
> +	struct arm_smmu_cmdq_batch *cmds;
>  	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_cmdq_ent cmd = {
>  		.opcode	= CMDQ_OP_CFGI_CD,
> @@ -1291,13 +1291,23 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>  		},
>  	};
>  
> -	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
> +	cmds = kmalloc_obj(*cmds);
> +	if (!cmds) {
> +		struct arm_smmu_cmdq_ent cmd_all = { .opcode = CMDQ_OP_CFGI_ALL };
> +
> +		WARN_ONCE(1, "arm-smmu-v3: failed to allocate cmdq_batch, falling back to full CD invalidation\n");
> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd_all);
> +		return;
> +	}
> +
> +	arm_smmu_cmdq_batch_init(smmu, cmds, &cmd);
>  	for (i = 0; i < master->num_streams; i++) {
>  		cmd.cfgi.sid = master->streams[i].id;
> -		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
> +		arm_smmu_cmdq_batch_add(smmu, cmds, &cmd);
>  	}
>  
> -	arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +	arm_smmu_cmdq_batch_submit(smmu, cmds);
> +	kfree(cmds);
>  }
>  
>  static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
> @@ -2225,31 +2235,37 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
>  static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>  				   ioasid_t ssid)
>  {
> -	int i;
> +	int i, ret;
>  	struct arm_smmu_cmdq_ent cmd;
> -	struct arm_smmu_cmdq_batch cmds;
> +	struct arm_smmu_cmdq_batch *cmds;
>  
>  	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
>  
> -	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
> +	cmds = kmalloc_obj(*cmds);
> +	if (!cmds)
> +		return -ENOMEM;
> +
> +	arm_smmu_cmdq_batch_init(master->smmu, cmds, &cmd);
>  	for (i = 0; i < master->num_streams; i++) {
>  		cmd.atc.sid = master->streams[i].id;
> -		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
> +		arm_smmu_cmdq_batch_add(master->smmu, cmds, &cmd);
>  	}
>  
> -	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
> +	ret = arm_smmu_cmdq_batch_submit(master->smmu, cmds);
> +	kfree(cmds);
> +	return ret;
>  }
>  
>  int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  			    unsigned long iova, size_t size)
>  {
>  	struct arm_smmu_master_domain *master_domain;
> -	int i;
> +	int i, ret;
>  	unsigned long flags;
>  	struct arm_smmu_cmdq_ent cmd = {
>  		.opcode = CMDQ_OP_ATC_INV,
>  	};
> -	struct arm_smmu_cmdq_batch cmds;
> +	struct arm_smmu_cmdq_batch *cmds;
>  
>  	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
>  		return 0;
> @@ -2271,7 +2287,11 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  	if (!atomic_read(&smmu_domain->nr_ats_masters))
>  		return 0;
>  
> -	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
> +	cmds = kmalloc_obj(*cmds);
> +	if (!cmds)
> +		return -ENOMEM;
> +
> +	arm_smmu_cmdq_batch_init(smmu_domain->smmu, cmds, &cmd);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>  	list_for_each_entry(master_domain, &smmu_domain->devices,
> @@ -2294,12 +2314,14 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  
>  		for (i = 0; i < master->num_streams; i++) {
>  			cmd.atc.sid = master->streams[i].id;
> -			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
> +			arm_smmu_cmdq_batch_add(smmu_domain->smmu, cmds, &cmd);
>  		}
>  	}
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
> +	ret = arm_smmu_cmdq_batch_submit(smmu_domain->smmu, cmds);
> +	kfree(cmds);
> +	return ret;
>  }
>  
>  /* IO_PGTABLE API */
> @@ -2334,7 +2356,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	unsigned long end = iova + size, num_pages = 0, tg = 0;
>  	size_t inv_range = granule;
> -	struct arm_smmu_cmdq_batch cmds;
> +	struct arm_smmu_cmdq_batch *cmds;
>  
>  	if (!size)
>  		return;
> @@ -2362,7 +2384,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>  			num_pages++;
>  	}
>  
> -	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
> +	cmds = kmalloc_obj(*cmds);
> +	if (!cmds) {
> +		WARN_ONCE(1, "arm-smmu-v3: failed to allocate cmdq_batch, falling back to full TLB invalidation\n");
> +		arm_smmu_tlb_inv_context(smmu_domain);
> +		return;
> +	}
> +
> +	arm_smmu_cmdq_batch_init(smmu, cmds, cmd);
>  
>  	while (iova < end) {
>  		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> @@ -2391,10 +2420,11 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>  		}
>  
>  		cmd->tlbi.addr = iova;
> -		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
> +		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
>  		iova += inv_range;
>  	}
> -	arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +	arm_smmu_cmdq_batch_submit(smmu, cmds);
> +	kfree(cmds);
>  }
>  
>  static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
> -- 
> 2.48.1
> 
> 
