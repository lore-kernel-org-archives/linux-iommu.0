Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDD3A784A
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145849; cv=none; b=fBgA7bq794yNxzexWqsgyq7gKpmLd1L8akUY+TcP0Gmgx8lEtLHzpW9fBFol7W8mQt934oejlPbz544eZOSCEWsnFk/bhQn2CLx4IA0BqwKNcSSjk17kPfg4jj1pXWykO0c5SQOc8eHqXhqtkNBqiyTkR5wJ9cr+vseSz9sHEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145849; c=relaxed/simple;
	bh=M3fdg2OVLkaqEmAgzm/LRLcs2o2aITu9jTal0ullgWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0nFzcNa0yTzTox83lEv2j4B3CyDClEqduGkst/OlsINGFcZQV4rI5vUr7TfWNQ1WCRonNpwUkliIam4RdcXGVg2FICIDEHwkPUu5OW01I4KiLmHgoFodyaVvcpipAujWcIzABnTvzZnERs6yRir+NtK5IFgxnTey8hRvqMAczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PF7+lKnH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PF7+lKnH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d1c670255so78145e9.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778145846; x=1778750646; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai1mjdaGlVBkCBIP9diG+ogiRNDiO8yYkk2TUIEuBxM=;
        b=PF7+lKnHdBrdyCOrsHM7Gmn3wOzL6+yXVjIlpEcrVQZ9S+pSxNm+JPHlWtFsZs08sh
         gqdx46y8XBU0EDMqR9zR0ShfRs1t9QvcmKuYZQt4Aobp/aHrOc5S2iDybWlXewILxlEw
         IUas6RlOZlrUs3IH6ICeCR/zHWXI8VbsDjPjzl+mYYd2G/0nrFVTmB7nDpF8CdXM7Kyj
         lgHpZeYbm1SYFxZK4y2O77HPy+/eU3MRWmaVoIM6igQn8bKF7B270/eblrH3vhCTgmNf
         jMc4fWN2Ej4mpCqbLbcMJVFIaYpAyxBlqkCk/MgiHpGgMNMF8eMaw4WKVZMsJjZh7X0P
         pyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145846; x=1778750646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai1mjdaGlVBkCBIP9diG+ogiRNDiO8yYkk2TUIEuBxM=;
        b=lFYZrXlZh7nq7rP9hSjGdQ4u5qnXGeHxkWIx3gwuIFhAQp2m6qbZXPCYlJt/0mfUcR
         8Wwu/+LYKQUDsNKoOrQd8tnjeHQ31R5yLlF/F29Y7jXinkd10OFxkVeVEfEaiNjU9iE8
         azNIRv242flKHeDuo2oQpoeQ/X7f5HD+5PhO3tMJNBC3kWLISK182Amh8hzuxTgFPh7e
         3QV7tbRfZp4ALsmTfVfKQOppYhoY19H3MIGXqjBMdlvxqHn9sYefJzxkp+IazTcxUh2l
         rLQXlYeaghivMtV18sSAnN9B3393dpNgdMQpS3In1n/zhZj9yyuc29NP1TqqXTZ6pAY2
         8pJQ==
X-Gm-Message-State: AOJu0YwgdRfksum9kqBkNCkjGj9iEZVOkiTk5QA3wKviBj2LTX1VC/AW
	An0E94UPbSelnnVGfxb+a7yE3DnM95chILBKVzVYQqj247UpmOjRC5haL+/x/jW2fyr5OWvABXl
	pGFdC7A==
X-Gm-Gg: AeBDiev7SlyUOWqD2o3rrPJSdOCtjxj2b4NasG8JK/fApGif5/T01nj2qCVbS9XQ7kP
	0RZDHBkPRtgKpj49O7TWEF7Jd1NbALriBeSFSma395Hl5tHSi5n7tsbYGpPxSR8MqhEEex/Xyhk
	19fL7IJrRRxu2MiCvjVUqLB4PVG0sMJPWMRFQXPl8UAj1qC+jON7NXYSKOd7WUGrRjlKvQkovGS
	LWGEfsCBsfATuiAQqQGiUPMURcfAcCyzt0UPRtllT3hxmL7D2eoAtG3qhCwZcXamJUw5xGomb3w
	FM+r75qoPDSRrGlUgikauZ2Cp3dFBHbQ2n24fnkf+Ls6DGxL0Bzf5ZsoHIIF09YJfooBC8YDzZz
	C85tWiOyMwn3Bvi0LPvelRErXI1/eFepAnJeuxQgf41Q9WdLfEf0r4HjrUDyiBxQH9fXwndqcI5
	BeTTWjg/p+lhue8elNxMNYNEetN5G2QLQW2esUwmp4CpSSFDaKhCzR9A2MjQJ8GXEThOW9dSexD
	TyGiA==
X-Received: by 2002:a05:600c:290b:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-48e5d44ad60mr815245e9.2.1778145845209;
        Thu, 07 May 2026 02:24:05 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e531578c8sm38692025e9.34.2026.05.07.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:24:03 -0700 (PDT)
Date: Thu, 7 May 2026 09:23:58 +0000
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
Subject: Re: [PATCH 8/9] iommu/arm-smmu-v3: Directly encode CMDQ_OP_SYNC
Message-ID: <afxaLqckXhW_BUnw@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <8-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:17AM -0300, Jason Gunthorpe wrote:
> Change the flow so the caller controls the CS field and remove the
> weird u64p_replace_bits() thing to override it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 ++++++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 16 ++++++--
>  2 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0cdf0752ff6d62..8147b9cdcc6b99 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -308,16 +308,6 @@ static int arm_smmu_cmdq_build_cmd(struct arm_smmu_cmd *cmd_out,
>  	case CMDQ_OP_TLBI_EL2_ASID:
>  		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>  		break;
> -	case CMDQ_OP_CMD_SYNC:
> -		if (ent->sync.msiaddr) {
> -			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
> -			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
> -		} else {
> -			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> -		}
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> -		break;
>  	default:
>  		return -ENOENT;
>  	}
> @@ -350,23 +340,24 @@ static void arm_smmu_cmdq_build_sync_cmd(struct arm_smmu_cmd *cmd,
>  					 struct arm_smmu_cmdq *cmdq, u32 prod)
>  {
>  	struct arm_smmu_queue *q = &cmdq->q;
> -	struct arm_smmu_cmdq_ent ent = {
> -		.opcode = CMDQ_OP_CMD_SYNC,
> -	};
> +	u64 msiaddr = 0;
> +	unsigned int cs;
>  
>  	/*
>  	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
>  	 * payload, so the write will zero the entire command on that platform.
>  	 */
> -	if (smmu->options & ARM_SMMU_OPT_MSIPOLL) {
> -		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
> -				   q->ent_dwords * 8;
> +	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq)) {
> +		cs = CMDQ_SYNC_0_CS_NONE;
> +	} else if (smmu->options & ARM_SMMU_OPT_MSIPOLL) {
> +		cs = CMDQ_SYNC_0_CS_IRQ;
> +		msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
> +			  q->ent_dwords * 8;
> +	} else {
> +		cs = CMDQ_SYNC_0_CS_SEV;
>  	}
>  
> -	arm_smmu_cmdq_build_cmd(cmd, &ent);
> -	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
> -		u64p_replace_bits(&cmd->data[0], CMDQ_SYNC_0_CS_NONE,
> -				  CMDQ_SYNC_0_CS);
> +	*cmd = arm_smmu_make_cmd_sync(cs, msiaddr);
>  }
>  
>  void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> @@ -383,9 +374,6 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>  	struct arm_smmu_cmd cmd;
>  	u32 cons = readl_relaxed(q->cons_reg);
>  	u32 idx = FIELD_GET(CMDQ_CONS_ERR, cons);
> -	struct arm_smmu_cmdq_ent cmd_sync = {
> -		.opcode = CMDQ_OP_CMD_SYNC,
> -	};
>  
>  	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
>  		idx < ARRAY_SIZE(cerror_str) ?  cerror_str[idx] : "Unknown");
> @@ -419,10 +407,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>  		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd.data[i]);
>  
>  	/* Convert the erroneous command into a CMD_SYNC */
> -	arm_smmu_cmdq_build_cmd(&cmd, &cmd_sync);
> -	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
> -		u64p_replace_bits(&cmd.data[0], CMDQ_SYNC_0_CS_NONE,
> -				  CMDQ_SYNC_0_CS);
> +	cmd = arm_smmu_make_cmd_sync(
> +		arm_smmu_cmdq_needs_busy_polling(smmu, cmdq) ?
> +			CMDQ_SYNC_0_CS_NONE : CMDQ_SYNC_0_CS_SEV,
> +		0);
>  
>  	queue_write(Q_ENT(q, cons), cmd.data, q->ent_dwords);
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 194f73cabef5c9..538380de7d48a0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -571,6 +571,18 @@ static inline struct arm_smmu_cmd arm_smmu_make_cmd_atc_inv_all(u32 sid,
>  	return arm_smmu_make_cmd_atc_inv(sid, ssid, 0, ATC_INV_SIZE_ALL);
>  }
>  
> +static inline struct arm_smmu_cmd arm_smmu_make_cmd_sync(unsigned int cs,
> +							 u64 msiaddr)
> +{
> +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(CMDQ_OP_CMD_SYNC);
> +
> +	cmd.data[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, cs) |
> +		       FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> +		       FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> +	cmd.data[1] |= msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
> +	return cmd;
> +}
> +
>  /* Event queue */
>  #define EVTQ_ENT_SZ_SHIFT		5
>  #define EVTQ_ENT_DWORDS			((1 << EVTQ_ENT_SZ_SHIFT) >> 3)
> @@ -648,10 +660,6 @@ struct arm_smmu_cmdq_ent {
>  			u8			tg;
>  			u64			addr;
>  		} tlbi;
> -
> -		struct {
> -			u64			msiaddr;
> -		} sync;
>  	};
>  };
>  
> -- 
> 2.43.0
> 
