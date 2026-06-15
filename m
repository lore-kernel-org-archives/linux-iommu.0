Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56934DB56
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543050; cv=none; b=GJ0RkS2N7l4Vsg+Xo4BkHo7h6Rpht3bxstjbIiQMjnkwVQntWVhU81YreyD7sUFd2aU7y5auSdrC6ksaqE0gQguOizTDnPtbIv8QdQE/Q30sFtpuUwP/3LQTFbWjd5cu1+X4U5cipsECEydfM46jPmC75wPON8TV+2IqiQ9IBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543050; c=relaxed/simple;
	bh=rkAsG2upNEaaxLJruJV5hBL92aAN54sHCGF22EcViFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfRxw+cupbvR0U7HasG6nFBeFMEi1KwmKr57Vb3xjCUVqgpWZH0/bGImH1SltkmC7DXB1wJQjBrFHBIdyR7yNbYVolef0uPDPuuufi4LoNRWdOkGjsQ2MGZp0fw465MUgZWiGpcVkVebcL6UN4sa6s5PDVlev4OFDaUOLawU/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxGLsF2H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxGLsF2H"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490bb5ad3bdso2035e9.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543048; x=1782147848; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgnKfmS6z6l4miIjnb0HLgh5uoK/WiMJTbt1y/kDYuI=;
        b=QxGLsF2Htt9/LkEmQLy56bZjNVywpEaFprk5yjcpIoo7SPdCtkRd6WhK2jUNvYg5rp
         ZSL6CPF2vp+jxhZKKp/eyaYzCKxe4fMVKSNSAWFMhqcojKyd60y7H2SC/ad1PCBJCk+z
         N4EMR0pi03/jUXYIAl0wxrhXzXTtXxQioIuffoqR/12BhFdftKWVAHI3DpSUuAG2YvCR
         zTDrhvIBDj8nxGCNZNigRSU+SqymvkJApeMJDYp6vr0hFBzWSv5DApnV+ZRl5XhbUTl0
         GIOCgJgkR5ILr/zA7vrlXhnjbfZl8pQE0WMwi+NkpsNmUwYcrdDwZStDTbvGwWThKm7V
         7sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543048; x=1782147848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgnKfmS6z6l4miIjnb0HLgh5uoK/WiMJTbt1y/kDYuI=;
        b=e7PnZAMcqIAW+WlFWwocTb84mw/nseiDK7reFyS28ki9IRit3JSHtAUKNlD+hcSM3A
         PlUwpxDjFqW2p9bzvLkYa+k26ARXo1JVt3PKztxo8N4qhZ6ulNLnp5CwpDFo9Rw5TESa
         RRNc+wpWjjALMdghlwA8jW/potqq/gH317GOT9hMlEq1ygaua5ux2ufuQBRB9PVtKTqL
         JVeedFSPLkN2TTlOwwZOhE8VE07ot0wmVcXO7a1SEbE95q50RNy1l/RUbGVA7MU1e9Sj
         LMlaldQA2AUPmT4B+8cFhCoxQtZXnruTuw0Y+3oiPNvBWAM5OCZTZtWFvAQP6bx+fUAC
         h/fQ==
X-Gm-Message-State: AOJu0Yzctz+Tl9vkEKoFCEzjJF98gpuaObcMGEgsKhTHyz8Yf6WoTZp4
	jbTgkZYn4IQniWMUnWjfStBMSazysBw4lY+jCpDQx20dXBy1aFjSoZgd6r/rcz/33A==
X-Gm-Gg: Acq92OHh27WehtQ3Ky5jlseulbSYNDCnCSqzPIjv7/y5I9NE+xgHc9zIXd6IElG0C0U
	J0jSO7x3U8IaPDHi6exZ5pkwBaG0Jx3xQ1IkFCfYX3zWcx7k2R9bXzuuHAhfdreFIIgcwCjMpiU
	maVYmZzwRCVSHCBA5CzApELR2/NPEPkjde0gtROtceTyUGi+w8p+MIn/MAY2ZPomO+RudEsEv0o
	UZolAa4HHrQq+xhZ4RaXZefRKrQNFY3PYlwHcvw/ckGw6Qgswi4G0qdM8YBF6OpAI47qbgPrK2E
	+VJ7RJXJMQdmyDCXUv2vIl383dzZq5FDxUjLBaudzGbTVdgCCw77Ca5lgb+a4L+UJd5dyBV/UIA
	84VJNSkGjWFhd6EIUqWDZBddXWae0DXWh2hpfgdjZYFNlm+qSGsVwRn+QFT6VKXYHhkUsLxobuk
	pkpMWdW2sYEUnPxrolXnFOek/9bpFaODkiKq90gB35kilM1J5ZLF0PhevG+TVJqeTHS4Qg+pkP
X-Received: by 2002:a05:600c:5254:b0:490:c2b6:de6a with SMTP id 5b1f17b1804b1-4922fcc2476mr52405e9.11.1781543046944;
        Mon, 15 Jun 2026 10:04:06 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm31931222f8f.32.2026.06.15.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:04:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:04:02 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 05/12] iommu/arm-smmu-v3: Cache and restore MSI config
Message-ID: <ajAwgvSr1EbSj0tP@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-6-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-6-praan@google.com>

On Mon, Jun 01, 2026 at 09:59:02PM +0000, Pranjal Shrivastava wrote:
> The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
> address, data and memory attributes lose their state when the SMMU is
> powered down. We'll need to cache and restore their contents to ensure
> that MSIs work after the system resumes.
> 
> To address this, cache the original `msi_msg` within the `msi_desc`
> when the configuration is first written by `arm_smmu_write_msi_msg`.
> This primarily includes the target address and data since the memory
> attributes are fixed.
> 
> Introduce a new helper `arm_smmu_resume_msis` which will later be called
> during the driver's resume callback. The helper would retrieve the
> cached MSI message for each relevant interrupt (evtq, gerr, priq) via
> get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8682be5060ed..93cee32f6c99 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4551,6 +4551,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>  	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
>  
> +	/* Cache the msi_msg for resume */
> +	desc->msg = *msg;
> +
>  	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>  	doorbell &= MSI_CFG0_ADDR_MASK;
>  
> @@ -4559,6 +4562,40 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>  }
>  
> +static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
> +				unsigned int irq, const char *name)
> +{
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!irq)
> +		return;
> +
> +	desc = irq_get_msi_desc(irq);
> +	if (!desc) {
> +		dev_err(smmu->dev, "Failed to resume msi: %s", name);
> +		return;
> +	}
> +
> +	get_cached_msi_msg(irq, &msg);
> +	arm_smmu_write_msi_msg(desc, &msg);
> +}
> +
> +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> +{
> +	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> +		return;
> +
> +	if (!dev_get_msi_domain(smmu->dev))
> +		return;
> +
> +	arm_smmu_resume_msi(smmu, smmu->gerr_irq, "gerror");
> +	arm_smmu_resume_msi(smmu, smmu->evtq.q.irq, "evtq");
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		arm_smmu_resume_msi(smmu, smmu->priq.q.irq, "priq");
> +}
> +
>  static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  {
>  	int ret, nvec = ARM_SMMU_MAX_MSIS;
> -- 
> 2.54.0.1013.g208068f2d8-goog
> 
> 
