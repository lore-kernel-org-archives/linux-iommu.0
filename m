Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E63ACA6F
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145879; cv=none; b=X8jI9qMYKJEVWUa78bZENg/oGMlB/6wxN0E28b9XcHMW1QzTXq2lTabuxLE4F0oyUUMXsLUnbVVna4TmvXGSNb5xEhmpfPfPTgHp38Gw3YjO0ejFZxv2Gm7Jo++jQbAuf4UsLoIdOWicsqIOn/yofePcVjzDLwPYIhIRtB6km7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145879; c=relaxed/simple;
	bh=ZwEoVimMXyE4WlIXQ9b1+/5W8MUhjiOVVdxJbXLc/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/q6uF5iGtb3GDW+1xPRRMHG8KUl/KM2PGASiB4igmKJx/W5ueGqVD7ywjDZFCZVirQnglZjl4i7o2iyf0kHeuwpYGm6mDTORjZLC2y3HkJgG5XMpBt7hTNXdceqUjfGFG60LrLKyuDXDDRM5BFaAHL/y6EvkKaqTpT2/bUX68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VghnKETS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VghnKETS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so65425e9.1
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 02:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778145875; x=1778750675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzfafLrMIPWU1uCMoM0mHCI24IB19rl5qj1B8HXqG0o=;
        b=VghnKETS5Fh/Yt0Qaz1YpV181Z2GAiPGpS3PWjRW8ILWuDEkJrcNmcUVjdVr8UoDwX
         n+larSd6nOw+vhujdC+sht+nOyS2z5xg7f2TRfaYRKabehlH1ZMSwM36CPjXkI1qPTBB
         kQJ4KXWdwg7FXCdlhNbKzEg9tRgAJVYAbTZvjgDuMxHOhPuguvrwbxvLhPlcZOjpnCmP
         P2P+B44TTqKT4Ny59HPwrgh2BwOfqLGJOuJRl11XCHmb/FqEdmJD/u5ZVfZFXG2hQw4y
         hcbikdWVMmOeUkHr9mwn80fCjqIxMFy5IiTzhYKafQEhn7rzXSFCBLh+tW349taZeXUU
         0GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145875; x=1778750675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzfafLrMIPWU1uCMoM0mHCI24IB19rl5qj1B8HXqG0o=;
        b=e6jK444RinKSJMe0+2aFADfJ+iZq7Qex8uvgP2WICqX95XizV0X72Oi+ICc8iyL6ER
         U3fTg9rwIuEdRvSovJoZN9PE1eMukVm7nz3zDWTn6aGnqFs1i8AuLkogR5bs8m2ESc23
         W8johVbOhqxoVYGVQHfUHJg4wasRIC/uroNqXYbesP6X639gP3QpTE3xMHbP2rjsz8Xd
         TEfn+WFCjV6L16J2YbKQBTyUNbwWOFlp+B+cdJ0SGj3VMhDBYRa8TT0SYrI7WwXRI18F
         WXSVjtCSuNEanxJIAQpENRIccEuCfTED4vZDNPF1xgTufocRu4uxSxbzJEs/CVdv1Usu
         RwHw==
X-Gm-Message-State: AOJu0Ywj7Aq7yFVp0/ewh2kC8c5pI8BCui4NvLrGT2FQO0nGCVYpM5do
	u+h9BvVYL1n6QFn+tGoVAG5r9H76uKDkBOs1ChEGPetuI2Yss+u1zeJ30HtWP1p3Qw==
X-Gm-Gg: AeBDieviR8G/Mp2Oax3NPrZSJF8oAUP4zTAGjaHwHCARoyRaq6+LcehigJa3R7C7GrC
	YvctzmYC/zLUZiXF3IBNm+Rd7MoKk/0TTcHNV1gDpgzltRpwCztVgSAa+P7hP1MBFZquhYDu/VU
	GX2FTWHCDxFey3f1iHEdmJmwaCFdGEJiPoRinkZ2SfHtjwRnUwjtsjqEJtVZ1AkZrv6d1Ww8r03
	01yAbYw6hoNicXoKIeHQ2p7GJXi8z08nRDv+mt/K4+4fg1V5niT1bd3r/6aaBoj1O6WMzENy2Sm
	Lv8xuzTIgDAKq+zPh5kXzQedmxJjawLQtMcqPlcQKoQJEnF9vZSkeZjH/3ErYRnvum8QxzseLZ8
	UKJtzjdu5j19XVnqOlOPeB38Ws/nZC+DfTH9lW/1xCuLhBZHivb4iTS8w5nizR6hvOOEwdra3jS
	hyYbOIEdpD01lzJxmq72RO0YM0DPwMEyuN7iLAgbaMLwa36ePGjXs6rCCa4qxZtPn/eRMdJjS6t
	Bk2aQ==
X-Received: by 2002:a05:600c:686:b0:485:b6e4:9808 with SMTP id 5b1f17b1804b1-48e52d0a2b6mr1541565e9.1.1778145875033;
        Thu, 07 May 2026 02:24:35 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2487dsm19179164f8f.35.2026.05.07.02.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:24:34 -0700 (PDT)
Date: Thu, 7 May 2026 09:24:30 +0000
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
Subject: Re: [PATCH 9/9] iommu/arm-smmu-v3: Directly encode TLBI commands
Message-ID: <afxaTs-RK_8hbMLO@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <9-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:18AM -0300, Jason Gunthorpe wrote:
> TLBI is more complicated than all the other commands because the
> invalidation loop builds a template command from the struct
> arm_smmu_inv which is then expanded into many TLBI commands for the
> invalidation.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 170 +++++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  35 ++--
>  2 files changed, 71 insertions(+), 134 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8147b9cdcc6b99..9be589d14a3bd4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -268,53 +268,6 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>  }
>  
>  /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(struct arm_smmu_cmd *cmd_out,
> -				   struct arm_smmu_cmdq_ent *ent)
> -{
> -	u64 *cmd = cmd_out->data;
> -
> -	memset(cmd_out, 0, sizeof(*cmd_out));
> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> -
> -	switch (ent->opcode) {
> -	case CMDQ_OP_TLBI_NH_VA:
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
> -		fallthrough;
> -	case CMDQ_OP_TLBI_EL2_VA:
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
> -		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> -		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> -		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
> -		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
> -		break;
> -	case CMDQ_OP_TLBI_S2_IPA:
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
> -		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> -		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> -		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
> -		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
> -		break;
> -	case CMDQ_OP_TLBI_NH_ASID:
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
> -		fallthrough;
> -	case CMDQ_OP_TLBI_NH_ALL:
> -	case CMDQ_OP_TLBI_S12_VMALL:
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
> -		break;
> -	case CMDQ_OP_TLBI_EL2_ASID:
> -		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
> -		break;
> -	default:
> -		return -ENOENT;
> -	}
> -
> -	return 0;
> -}
> -
>  static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
>  					       struct arm_smmu_cmd *cmd)
>  {
> @@ -894,16 +847,6 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
>  	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
>  }
>  
> -static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
> -				     struct arm_smmu_cmdq_batch *cmds,
> -				     struct arm_smmu_cmdq_ent *ent)
> -{
> -	struct arm_smmu_cmd cmd;
> -
> -	arm_smmu_cmdq_build_cmd(&cmd, ent);
> -	arm_smmu_cmdq_batch_init_cmd(smmu, cmds, &cmd);
> -}
> -
>  static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
>  					  struct arm_smmu_cmdq_batch *cmds,
>  					  struct arm_smmu_cmd *cmd)
> @@ -934,21 +877,6 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
>  		arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, &__cmd); \
>  	})
>  
> -static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
> -				    struct arm_smmu_cmdq_batch *cmds,
> -				    struct arm_smmu_cmdq_ent *ent)
> -{
> -	struct arm_smmu_cmd cmd;
> -
> -	if (unlikely(arm_smmu_cmdq_build_cmd(&cmd, ent))) {
> -		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> -			 ent->opcode);
> -		return;
> -	}
> -
> -	arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, &cmd);
> -}
> -
>  static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  				      struct arm_smmu_cmdq_batch *cmds)
>  {
> @@ -2450,12 +2378,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  
>  static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  					  struct arm_smmu_cmdq_batch *cmds,
> -					  struct arm_smmu_cmdq_ent *cmd,
> +					  struct arm_smmu_cmd *cmd, bool leaf,
>  					  unsigned long iova, size_t size,
>  					  size_t granule, size_t pgsize)
>  {
>  	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
> +	u64 orig_data0 = cmd->data[0];
>  	size_t inv_range = granule;
> +	u8 ttl = 0, tg_enc = 0;
>  
>  	if (WARN_ON_ONCE(!size))
>  		return;
> @@ -2464,7 +2394,7 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  		num_pages = size >> tg;
>  
>  		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
> -		cmd->tlbi.tg = (tg - 10) / 2;
> +		tg_enc = (tg - 10) / 2;
>  
>  		/*
>  		 * Determine what level the granule is at. For non-leaf, both
> @@ -2474,8 +2404,8 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  		 * want to use a range command, so avoid the SVA corner case
>  		 * where both scale and num could be 0 as well.
>  		 */
> -		if (cmd->tlbi.leaf)
> -			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> +		if (leaf)
> +			ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>  		else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
>  			num_pages++;
>  	}
> @@ -2493,11 +2423,13 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  
>  			/* Determine the power of 2 multiple number of pages */
>  			scale = __ffs(num_pages);
> -			cmd->tlbi.scale = scale;
>  
>  			/* Determine how many chunks of 2^scale size we have */
>  			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> -			cmd->tlbi.num = num - 1;
> +
> +			cmd->data[0] = orig_data0 |
> +				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
> +				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
>  
>  			/* range is num * 2^scale * pgsize */
>  			inv_range = num << (scale + tg);
> @@ -2506,8 +2438,17 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  			num_pages -= num << scale;
>  		}
>  
> -		cmd->tlbi.addr = iova;
> -		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
> +		/*
> +		 * IPA has fewer bits than VA, but they are reserved in the
> +		 * command and something would be very broken if iova had them
> +		 * set.
> +		 */
> +		cmd->data[1] = FIELD_PREP(CMDQ_TLBI_1_LEAF, leaf) |
> +			       FIELD_PREP(CMDQ_TLBI_1_TTL, ttl) |
> +			       FIELD_PREP(CMDQ_TLBI_1_TG, tg_enc) |
> +			       (iova & ~GENMASK_U64(11, 0));
> +
> +		arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, cmd);
>  		iova += inv_range;
>  	}
>  }
> @@ -2538,19 +2479,22 @@ static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
>  /* Used by non INV_TYPE_ATS* invalidations */
>  static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
>  				       struct arm_smmu_cmdq_batch *cmds,
> -				       struct arm_smmu_cmdq_ent *cmd,
> +				       struct arm_smmu_cmd *cmd,
> +				       bool leaf,
>  				       unsigned long iova, size_t size,
>  				       unsigned int granule)
>  {
>  	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
> -		cmd->opcode = inv->nsize_opcode;
> -		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
> +		struct arm_smmu_cmd nsize_cmd = *cmd;
> +
> +		u64p_replace_bits(&nsize_cmd.data[0], inv->nsize_opcode,
> +				  CMDQ_0_OP);
> +		arm_smmu_cmdq_batch_add_cmd_p(inv->smmu, cmds, &nsize_cmd);
>  		return;
>  	}
>  
> -	cmd->opcode = inv->size_opcode;
> -	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
> -				      inv->pgsize);
> +	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, leaf,
> +				      iova, size, granule, inv->pgsize);
>  }
>  
>  static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
> @@ -2585,38 +2529,39 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
>  			break;
>  	while (cur != end) {
>  		struct arm_smmu_device *smmu = cur->smmu;
> -		struct arm_smmu_cmdq_ent cmd = {
> -			/*
> -			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
> -			 * be changed to nsize_opcode, which would result in the
> -			 * same CMDQ pointer.
> -			 */
> -			.opcode = cur->size_opcode,
> -		};
> +		/*
> +		 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
> +		 * be changed to nsize_opcode, which would result in the
> +		 * same CMDQ pointer.
> +		 */
> +		struct arm_smmu_cmd cmd =
> +			arm_smmu_make_cmd_op(cur->size_opcode);
>  		struct arm_smmu_inv *next;
>  
>  		if (!cmds.num)
> -			arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
> +			arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
>  
>  		switch (cur->type) {
>  		case INV_TYPE_S1_ASID:
> -			cmd.tlbi.asid = cur->id;
> -			cmd.tlbi.leaf = leaf;
> -			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
> -						   granule);
> +			cmd = arm_smmu_make_cmd_tlbi(cur->size_opcode,
> +						     cur->id, 0);
> +			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, leaf,
> +						   iova, size, granule);
>  			break;
>  		case INV_TYPE_S2_VMID:
> -			cmd.tlbi.vmid = cur->id;
> -			cmd.tlbi.leaf = leaf;
> -			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
> -						   granule);
> +			cmd = arm_smmu_make_cmd_tlbi(cur->size_opcode,
> +						     0, cur->id);
> +			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, leaf,
> +						   iova, size, granule);
>  			break;
>  		case INV_TYPE_S2_VMID_S1_CLEAR:
>  			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
>  			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
>  				break;
> -			cmd.tlbi.vmid = cur->id;
> -			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
> +			arm_smmu_cmdq_batch_add_cmd(
> +				smmu, &cmds,
> +				arm_smmu_make_cmd_tlbi(cur->size_opcode, 0,
> +						       cur->id));
>  			break;
>  		case INV_TYPE_ATS:
>  			arm_smmu_cmdq_batch_add_cmd(
> @@ -3359,24 +3304,21 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
>  
>  static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
>  {
> -	struct arm_smmu_cmdq_ent cmd = {};
> -	struct arm_smmu_cmd hw_cmd;
> -
>  	switch (inv->type) {
>  	case INV_TYPE_S1_ASID:
> -		cmd.tlbi.asid = inv->id;
> +		arm_smmu_cmdq_issue_cmd_with_sync(
> +			inv->smmu,
> +			arm_smmu_make_cmd_tlbi(inv->nsize_opcode, inv->id, 0));
>  		break;
>  	case INV_TYPE_S2_VMID:
>  		/* S2_VMID using nsize_opcode covers S2_VMID_S1_CLEAR */
> -		cmd.tlbi.vmid = inv->id;
> +		arm_smmu_cmdq_issue_cmd_with_sync(
> +			inv->smmu,
> +			arm_smmu_make_cmd_tlbi(inv->nsize_opcode, 0, inv->id));
>  		break;
>  	default:
>  		return;
>  	}
> -
> -	cmd.opcode = inv->nsize_opcode;
> -	arm_smmu_cmdq_build_cmd(&hw_cmd, &cmd);
> -	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, hw_cmd);
>  }
>  
>  /* Should be installed after arm_smmu_install_ste_for_dev() */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 538380de7d48a0..16353596e08ad8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -583,6 +583,21 @@ static inline struct arm_smmu_cmd arm_smmu_make_cmd_sync(unsigned int cs,
>  	return cmd;
>  }
>  
> +/*
> + * TLBI commands - the non-sized variants just need opcode + asid/vmid.
> + * For sized variants the caller sets up data[0] with the immutable fields
> + * (opcode + asid/vmid) and the range loop fills in per-iteration fields.
> + */
> +static inline struct arm_smmu_cmd
> +arm_smmu_make_cmd_tlbi(enum arm_smmu_cmdq_opcode op, u16 asid, u16 vmid)
> +{
> +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(op);
> +
> +	cmd.data[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, asid) |
> +		       FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
> +	return cmd;
> +}
> +
>  /* Event queue */
>  #define EVTQ_ENT_SZ_SHIFT		5
>  #define EVTQ_ENT_DWORDS			((1 << EVTQ_ENT_SZ_SHIFT) >> 3)
> @@ -643,26 +658,6 @@ static inline struct arm_smmu_cmd arm_smmu_make_cmd_sync(unsigned int cs,
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
>  
> -struct arm_smmu_cmdq_ent {
> -	/* Common fields */
> -	u8				opcode;
> -	bool				substream_valid;
> -
> -	/* Command-specific fields */
> -	union {
> -		struct {
> -			u8			num;
> -			u8			scale;
> -			u16			asid;
> -			u16			vmid;
> -			bool			leaf;
> -			u8			ttl;
> -			u8			tg;
> -			u64			addr;
> -		} tlbi;
> -	};
> -};
> -
>  struct arm_smmu_ll_queue {
>  	union {
>  		u64			val;
> -- 
> 2.43.0
> 
