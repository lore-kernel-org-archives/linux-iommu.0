Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD523BF684
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145722; cv=none; b=o7eS4gN/WqdL7xo375dm6lCgS7Qy1SgUfepFMEKLpSZAoEiB+0QFbkVzJmJvjQ80k6u8vB0EmihWc5HXFC7K04r2tfLdsKM/8MZvlPPysCZOBUcThFaSi74zOtyRQQTvQ86w5mOYVujkKKyYRzcn4B9at3Ou077Oj1jxiKndj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145722; c=relaxed/simple;
	bh=Y+2uaDuH043UZZOsd5GAUdfC443ZMhzc9LRqy42EnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlSNIbgNJfsGZoEz0xM+qGQ7snV8BZuBXhim7zx9nEILBjdV2uUx5xK+tq5oPuT51VZ0GwVEO6nGcQ2ibR7w8NtAxfEujPJv/ATrWiJQeBwuH+hanKvXknuhn2wVKLzPYtltlN133vHHLZcwq/ML0pqiVNQ7wHzPbIODZYdgiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAcr2GmE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAcr2GmE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d1c670255so77655e9.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778145713; x=1778750513; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6/FxwSPka5p8DLF5a7pAUL11onK6T+zgOvQ6IlI4aw=;
        b=JAcr2GmE+djMWYRzi//MSfiWFr3sD+2W6G+4IGfp+UBU7PBqwHWtr0xQ7xB2TQga/w
         SLvluixTII5O3mw2T1Kzu1vnyAdt1uhdPUB4p1hOYvUzQfFePuvgzV65uN6NmdGOpvH8
         pkLqG+bX9mIAxW/N3fnlQGd0YPDYWX/gX1aA0E/5SiVtoSbRoyI8j6OHg9lKeFDOMKNK
         eEd1Qd7wsTZZtnLAnQnIYq7lIoSzZz3Nje+GeL/GxifQccsTTcShlkkYk9PX/eRtGdb7
         GXg+kjpO0QEE4T6L9BZ0f/i0gXOh5f1knN7ed9vxtJY0oOhOo/IRqqWDqbJAvJPXt2AK
         QYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145713; x=1778750513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6/FxwSPka5p8DLF5a7pAUL11onK6T+zgOvQ6IlI4aw=;
        b=KmT49muyQCCw4qI1tP8gSL41H06MlITugRet9GJ43/2X0gk6uELXw0ve/KoApXGr5L
         GFZ1i6/UE3CbwOihG93GEtbpqSab35ypTDk2xEK5CyqrjrU+oeOUPP62cLRI6K9zXu6G
         xap3mfQjdvUdnS6w5oW/UjUXW8eUU9152rVAShuuAEckBBTZwR8b5p8nC+0wH226wOJu
         jQFRRa7rWV0MbsKa/U8XAaHCQ3pIJPtr7pX3byt1qY7DnwyuV8ru5YKSI+dXqJxXIbOe
         7K1/fApNtUWNbb+uRwv0EjsW4eChnJpSNGIDOVGka0RW4gINnqz+YjBhIsDEws2GkeRk
         4iPQ==
X-Gm-Message-State: AOJu0YyDwk1qZRS3sSVFfu4X0aAdLUq1yUQKI8KLGA8NhxCamkrHpsup
	+tpaIfTDJAU8ofC6U7OuYBSSLjBahkJhNXmSiy8eRPSBMwTwSbUJW1W/zKEmSXjhwQ==
X-Gm-Gg: AeBDievaTohsjcl5E49r7yn+irYlt2vLr/PpW2vQ5vmsatGqcFJ39cT1YRyGJ50NSrv
	gDXMvgYaIME8vBJW4G5o2zkqSs8bn8FayNYzyeSDSC7zFE5U+t19vgYqnzBs0L2I8/e4wr2NaYl
	qXWEMHMISmCxy7rGGyZUNhJri51GWXzU2UyU3pIC9o/pG07VtCKpNDlCPWPTlm6Xv+lkdrIoDHJ
	3eolKvlWiw5wqyDKGggDva2DbycJ71ZCAoYzt60rj/X4VWl7W7NEo/Q9gzj453S7LiqybyIsvcf
	sKjR7kxCi9sPZTzeC2ffD0R86v7H2Zx/zvoarkPIpdVfk++HHdYAlx3dDoZVy1ptoKbZ0YjOsyw
	g4QwDSg17c2b2+Z01EBEttYR2vxa8a0kVyZUnaTfK6o3+tarSwTHG/cUOTzLi09GViQYLCZzOGe
	GPAIC9GdP5hYZCh6b9a00dCmktxGnWaTAH5Na05HmauIzHxuzlJP/x5lRo6fBeq1PFP9uIVVXv+
	+AopQ==
X-Received: by 2002:a05:600d:8450:10b0:489:1ace:d0d3 with SMTP id 5b1f17b1804b1-48e52d0a34fmr1539495e9.3.1778145712369;
        Thu, 07 May 2026 02:21:52 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960973sm18969938f8f.30.2026.05.07.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:21:51 -0700 (PDT)
Date: Thu, 7 May 2026 09:21:48 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 3/9] iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq
 submission functions
Message-ID: <afxZrBaz0YZ9XF2u@google.com>
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

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 ++++++++++++---------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5cdeaec890592f..67d23e9c54804e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -921,31 +921,23 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  }
>  
>  static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> -				     struct arm_smmu_cmdq_ent *ent,
> +				     struct arm_smmu_cmd *cmd,
>  				     bool sync)
>  {
> -	struct arm_smmu_cmd cmd;
> -
> -	if (unlikely(arm_smmu_cmdq_build_cmd(cmd.data, ent))) {
> -		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> -			 ent->opcode);
> -		return -EINVAL;
> -	}
> -
>  	return arm_smmu_cmdq_issue_cmdlist(
> -		smmu, arm_smmu_get_cmdq(smmu, &cmd), cmd.data, 1, sync);
> +		smmu, arm_smmu_get_cmdq(smmu, cmd), cmd->data, 1, sync);
>  }
>  
>  static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> -				   struct arm_smmu_cmdq_ent *ent)
> +				   struct arm_smmu_cmd *cmd)
>  {
> -	return __arm_smmu_cmdq_issue_cmd(smmu, ent, false);
> +	return __arm_smmu_cmdq_issue_cmd(smmu, cmd, false);
>  }
>  
>  static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> -					     struct arm_smmu_cmdq_ent *ent)
> +					     struct arm_smmu_cmd *cmd)
>  {
> -	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
> +	return __arm_smmu_cmdq_issue_cmd(smmu, cmd, true);
>  }
>  
>  static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
> @@ -1013,6 +1005,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  	struct arm_smmu_cmdq_ent cmd = {0};
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	int sid = master->streams[0].id;
> +	struct arm_smmu_cmd hw_cmd;
>  
>  	if (WARN_ON(!master->stall_enabled))
>  		return;
> @@ -1032,7 +1025,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  		break;
>  	}
>  
> -	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> +	arm_smmu_cmdq_build_cmd(hw_cmd.data, &cmd);
> +	arm_smmu_cmdq_issue_cmd(master->smmu, &hw_cmd);
> +
>  	/*
>  	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
>  	 * RESUME consumption guarantees that the stalled transaction will be
> @@ -1861,14 +1856,16 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
>  {
>  	struct arm_smmu_ste_writer *ste_writer =
>  		container_of(writer, struct arm_smmu_ste_writer, writer);
> -	struct arm_smmu_cmdq_ent cmd = {
> +	struct arm_smmu_cmdq_ent ent = {
>  		.opcode	= CMDQ_OP_CFGI_STE,
>  		.cfgi	= {
>  			.sid	= ste_writer->sid,
>  			.leaf	= true,
>  		},
>  	};
> +	struct arm_smmu_cmd cmd;
>  
> +	arm_smmu_cmdq_build_cmd(cmd.data, &ent);
>  	arm_smmu_cmdq_issue_cmd_with_sync(writer->master->smmu, &cmd);
>  }
>  
> @@ -1896,11 +1893,13 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
>  	/* It's likely that we'll want to use the new STE soon */
>  	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
>  		struct arm_smmu_cmdq_ent
> -			prefetch_cmd = { .opcode = CMDQ_OP_PREFETCH_CFG,
> +			prefetch_ent = { .opcode = CMDQ_OP_PREFETCH_CFG,
>  					 .prefetch = {
>  						 .sid = sid,
>  					 } };
> +		struct arm_smmu_cmd prefetch_cmd;
>  
> +		arm_smmu_cmdq_build_cmd(prefetch_cmd.data, &prefetch_ent);
>  		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
>  	}
>  }
> @@ -2328,7 +2327,7 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
>  		 evt[1] & PRIQ_1_ADDR_MASK);
>  
>  	if (last) {
> -		struct arm_smmu_cmdq_ent cmd = {
> +		struct arm_smmu_cmdq_ent ent = {
>  			.opcode			= CMDQ_OP_PRI_RESP,
>  			.substream_valid	= ssv,
>  			.pri			= {
> @@ -2338,7 +2337,9 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
>  				.resp	= PRI_RESP_DENY,
>  			},
>  		};
> +		struct arm_smmu_cmd cmd;
>  
> +		arm_smmu_cmdq_build_cmd(cmd.data, &ent);
>  		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
>  	}
>  }
> @@ -3446,6 +3447,7 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
>  static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
>  {
>  	struct arm_smmu_cmdq_ent cmd = {};
> +	struct arm_smmu_cmd hw_cmd;
>  
>  	switch (inv->type) {
>  	case INV_TYPE_S1_ASID:
> @@ -3460,7 +3462,8 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
>  	}
>  
>  	cmd.opcode = inv->nsize_opcode;
> -	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
> +	arm_smmu_cmdq_build_cmd(hw_cmd.data, &cmd);
> +	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &hw_cmd);
>  }
>  
>  /* Should be installed after arm_smmu_install_ste_for_dev() */
> @@ -4823,7 +4826,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  	u32 reg, enables;
> -	struct arm_smmu_cmdq_ent cmd;
> +	struct arm_smmu_cmdq_ent ent;
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
> -- 
> 2.43.0
> 
