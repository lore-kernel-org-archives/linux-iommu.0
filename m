Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D33D5672
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778240023; cv=none; b=GUVK1hv+x/BalQMPBjReSbiK6cZI0+VdSUNGHqdlOO1wqzs378GOkHGCga+4N5QvbfIAWXgb10mZD96S9Km7CzKWK9CfAxZFlDrcLN29GKK0V3qjPS1j0CGwsTnmVbCI3/shbdau6oNlHq/mAdzGA+0G9vKyNPR4Eu7gXwM5MLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778240023; c=relaxed/simple;
	bh=/8zJOScllfY27di+rf/OBgDiO9wjXvpqeL1239cUesc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nhoox/TMPr4Bce5tVAybZ87RILRp1UXBOGBfFXUPR4oXoyI8FXKTEyuOZ5fh9pe806edgexOYtd1zmKL4BL1e2/1AbPsUxRQ4BL7HNGro17g9aFVJnjYG2hVbexbEsED8e7MBwIQYrzqkLPzTuJhDR7ejv1EhxCP6fEgGhGwXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7SclNCR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7SclNCR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba180a022dso73715ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778240020; x=1778844820; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HLt/hxOkl7aSPqpAf1bFw2IFuOfV/t7jCK+Ije+pMc=;
        b=r7SclNCRJC8gCP9DVtDVPzW/I/FNXlUllqXr3bKEqQ47YxI7zf7cwE0m0dxMapRObp
         lYlY+JZygelUFo9wz+rBFqgiYJIRD4lnSqS2FPr2aa8eaF9+H8A7CCaKQg4yaVhiAy5d
         3KxUHS3kYT5ArHSj/Px/qU2alMLhU4UH+EZldLX3igSX/lD1Uf40Vradz8ASxgIizoLg
         v3UPqDfPDkmwhe3SHidY9h/ua4XImQhsUWhJYuxCTl22UNn/BFiTSwPuxWhxQKEY8iUS
         iAaOug1/pZh0/Ipj5d8SPU6VDGr9PoL5mEUq7VEgJO9kpgZVrx2VxFEy7vQmt5qW3w2p
         afgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778240020; x=1778844820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HLt/hxOkl7aSPqpAf1bFw2IFuOfV/t7jCK+Ije+pMc=;
        b=QpO4wQekH+coAAK5CQkKnGnvLtsPOfmhOKA6OUOQXoHPvhCM+5UOb+zRulxDkj+IIz
         jxPl9qW+LdBVQXWPJAmFy1G9cTXustgV7Lre34swa3GOcF3R4inqwJHbfhOxjUZ1imtG
         I6Q6uSIvTNq4vBdXnihUfPjqynG0KuyVjPEPGpLCSKC0k3diWcYxFLzfg9J5OPQ1SsKu
         APSWGnxxJP+SkqQz9aT6hJOeMigPEQOu0iRsoL5SrGXvkYwL9d2Mk+XfHxIKTKsZTH+S
         AWPX8hEyn8k3IV2FT3tLaZClzUVln57AsNCZTwXq16S3KmX4QroR7tF+OnIgOZrFvDib
         +eBg==
X-Gm-Message-State: AOJu0Yyq8K3u9/V9trTXG0j7EjTW+8mW201bvBF/dqq6UdRW6IIZcQjo
	gPfpk+/2NNPW9WY4g+d+oFw7oxT7DaRLBYvl9Hibexv07+wbt/gH0neXY8LDWz6VJw==
X-Gm-Gg: Acq92OHxH6OqNlvNZQUM0DqbKc7EN+3mjYCNSIQ2L+V5cyqmy0ITTxFR76EmwzYNq3n
	3Bbtlwk33OGeGXUPupafWf/gZpG2A/l2l6GHIvUbdwkxIjp2XnOHkGX51wFAE32CEYTllIZOAjY
	Tmf9FTN4q3xw6FDYD0z0NjWgMJ/qP1t83mvA8Sbrrayw9dYkX+D/CY7A2KtG4XK8ieeozRiPsza
	6yM77YxV7Dd2R+g7y6AH8t8kEGxLYVzlAWAGjT5ansWJFLN2J7DVgt4q1q/b02Vwyb+qlPnqL6P
	N+Ic3U2iAam+CEZqhopOtB8v9avKFGx1N8Xq0NM2tLeXUHJsHeSsyBtL8C+7gX1wmDWJgCI+W16
	bm3zW62qrZ5Cs7VfAGwKt56arRrVG4dOEvLWQ/RNYbYL5ku0I6OHkjWKUkz3XJoqOpQR37fYptO
	7tRGNw1hAkfloU/PgwWOc+fIuSp7KpeXT7quukdv9kYFoAnvQZ35eHl2xuKB9Zq8416Y/J
X-Received: by 2002:a17:903:2c9:b0:2ba:30f:33e0 with SMTP id d9443c01a7336-2bae9e99284mr2894105ad.20.1778240019615;
        Fri, 08 May 2026 04:33:39 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d36c10sm14982546b3a.25.2026.05.08.04.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:33:39 -0700 (PDT)
Date: Fri, 8 May 2026 11:33:32 +0000
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
Subject: Re: [PATCH 6/9] iommu/arm-smmu-v3: Directly encode simple commands
Message-ID: <af3KDBt8vhClSKEF@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <6-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:15AM -0300, Jason Gunthorpe wrote:
> Add make functions to build commands for
> 
>  CMDQ_OP_TLBI_EL2_ALL
>  CMDQ_OP_TLBI_NSNH_ALL
>  CMDQ_OP_CFGI_ALL
>  CMDQ_OP_PREFETCH_CFG
>  CMDQ_OP_CFGI_STE
>  CMDQ_OP_CFGI_CD
>  CMDQ_OP_RESUME
>  CMDQ_OP_PRI_RESP
> 
> Convert all of these call sites to use the make function instead of
> going through arm_smmu_cmdq_build_cmd(). Use a #define so the general
> pattern is always:
> 
>    arm_smmu_cmdq_issue_cmd(smmu, arm_smmu_make_cmd_XX(..));
> 
> Add arm_smmu_cmdq_batch_add_cmd() which takes struct arm_smmu_cmd
> directly to match the new flow.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 213 +++++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 109 +++++++---
>  2 files changed, 151 insertions(+), 171 deletions(-)
>

[----- >8 ------]

>  
> -static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> -				     struct arm_smmu_cmd *cmd,
> -				     bool sync)
> +static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
> +				     struct arm_smmu_cmd *cmd, bool sync)

Nit: I'm not sure why we need to rename this? We can still define the 
rest of the helpers like:

#define arm_smmu_cmdq_issue_cmd(smmu, cmd)                      \
	({                                                      \
		struct arm_smmu_cmd __cmd = cmd;                \
		__arm_smmu_cmdq_issue_cmd(smmu, &__cmd, false); \
	})

>  {
>  	return arm_smmu_cmdq_issue_cmdlist(
>  		smmu, arm_smmu_get_cmdq(smmu, cmd), cmd, 1, sync);
>  }
>  
> -static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> -				   struct arm_smmu_cmd *cmd)
> -{
> -	return __arm_smmu_cmdq_issue_cmd(smmu, cmd, false);
> -}
> +#define arm_smmu_cmdq_issue_cmd(smmu, cmd)                      \
> +	({                                                      \
> +		struct arm_smmu_cmd __cmd = cmd;                \
> +		arm_smmu_cmdq_issue_cmd_p(smmu, &__cmd, false); \
> +	})
> 
> -static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> -					     struct arm_smmu_cmd *cmd)
> -{
> -	return __arm_smmu_cmdq_issue_cmd(smmu, cmd, true);
> -}
> +#define arm_smmu_cmdq_issue_cmd_with_sync(smmu, cmd)           \
> +	({                                                     \
> +		struct arm_smmu_cmd __cmd = cmd;               \
> +		arm_smmu_cmdq_issue_cmd_p(smmu, &__cmd, true); \
> +	})
>  
>  static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
>  					 struct arm_smmu_cmdq_batch *cmds,
> @@ -962,14 +924,41 @@ static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
>  	arm_smmu_cmdq_batch_init_cmd(smmu, cmds, &cmd);
>  }
>  
> +static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
> +					  struct arm_smmu_cmdq_batch *cmds,
> +					  struct arm_smmu_cmd *cmd)

Nit: Same here, why not  __arm_smmu_cmdq_batch_add_cmd? I understand
that _p just means we'll aceept ptr.. but the name's kinda wonky.

> +{
> +	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
> +			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
> +	bool unsupported_cmd;
> +
> +	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
> +	if (force_sync || unsupported_cmd) {
> +		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
> +					    cmds->num, true);
> +		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
> +	}
> +
> +	if (cmds->num == CMDQ_BATCH_ENTRIES) {
> +		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
> +					    cmds->num, false);
> +		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
> +	}
> +
> +	cmds->cmds[cmds->num++] = *cmd;
> +}
> +
> +#define arm_smmu_cmdq_batch_add_cmd(smmu, cmds, cmd)               \
> +	({                                                         \
> +		struct arm_smmu_cmd __cmd = cmd;                   \
> +		arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, &__cmd); \
> +	})
> +
>

[----- >8 -----]

>  
>  static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
> @@ -3464,7 +3405,7 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
>  
>  	cmd.opcode = inv->nsize_opcode;
>  	arm_smmu_cmdq_build_cmd(&hw_cmd, &cmd);
> -	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &hw_cmd);
> +	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, hw_cmd);

Nit: are we passing it by value here? This would be a 16-byte stack
copy? As with the macro expansion this looks like:

{
	struct arm_smmu_cmd __cmd = hw_cmd; // <-- Redundant 16-byte copy
	arm_smmu_cmdq_issue_cmd_p(inv->smmu, &__cmd, true);
}

Why not use arm_smmu_cmdq_issue_cmd_p(inv->smmu, &hw_cmd, true) ?
Although, I see this is eventually cleaned up in Patch 9.

>  }
>  
>  /* Should be installed after arm_smmu_install_ste_for_dev() */
> @@ -4827,8 +4768,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  	u32 reg, enables;
> -	struct arm_smmu_cmdq_ent ent;

Ah, we remove this unitialized thing here. I guess we should still init
it in the previous patch for consistency.

[---- >8 ----]

>  #define CMDQ_RESUME_0_RESP_TERM		0UL
>  #define CMDQ_RESUME_0_RESP_RETRY	1UL
>  #define CMDQ_RESUME_0_RESP_ABORT	2UL
> @@ -475,6 +481,77 @@ enum arm_smmu_cmdq_opcode {
>  	CMDQ_OP_CMD_SYNC = 0x46,
>  };
>  
> +static inline struct arm_smmu_cmd
> +arm_smmu_make_cmd_op(enum arm_smmu_cmdq_opcode op)
> +{
> +	struct arm_smmu_cmd cmd = {};
> +
> +	cmd.data[0] = FIELD_PREP(CMDQ_0_OP, op);
> +	return cmd;
> +}
> +
> +static inline struct arm_smmu_cmd arm_smmu_make_cmd_cfgi_all(void)
> +{
> +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(CMDQ_OP_CFGI_ALL);
> +
> +	cmd.data[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);

Maybe this is a good opportunity to define "31"? We already have a 
similar definition for TLBI: #define CMDQ_TLBI_RANGE_NUM_MAX 31

Perhaps we could have: #define CMDQ_CFGI_RANGE_ALL 31

With the above nits:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
