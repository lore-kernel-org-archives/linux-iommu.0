Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49A331200
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182816; cv=none; b=Bu0VHOMMjFj4Pa8TPzdl84jAF+14ztdKCtN6KFB2Dv/mhvDZk6E2p8Zek0NhEIHANuf0/OMGe2s19ndTdUVQBlPbLU+d62kUu8WvLCKLIHIvs6osMU8l7fcshOcR5FD8u56VKeT1mrvBgjv/OCVSFxfj0dHJky9yRiqOVehXbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182816; c=relaxed/simple;
	bh=bda+2S/CRRI24v+0YtjXyLzM6YHcwsrVhQlTDGYXBi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQpMd1kel8JH32DBhzbQElX/W2TJ9H2bXZ84u37211rgq9G7bd/6mTJzO/7wVMNEfj7V8z7gO/DM+rwZTntXq9CXBBqEgqlNivrlnqjwv+KqpVbhGjgMEi3PYfMX0d7BZ47VeafkUOIhLjwCB9p7ob0XSbpwUo6QMdZcrlC8BU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNnxCfxR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNnxCfxR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b243198058so23825ad.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 19:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775182814; x=1775787614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLyfrpphk/pri+vsSR8ZKPbndfkUJotLPgfVmPM7TEQ=;
        b=QNnxCfxROPwndtt7VrTwEeXDkCr75vQKxkV15bcCE/9Dq6ma6p/Rn6WWq5KonaUwsy
         rJdk1Z6IPXCPHQGadsGN6K1scKQVXYxkemIvbbyMgVAv5hgShxTbZThU6qpdkhgT74cC
         6HFAPyOBA7edZrUsrJtrMGESylvySmmY1p7O6M3T4MybkTgO28qxONijUBRjf25R6p1y
         uXl1aRkMeWCtmV4fKajDFVsMzPpHB95gztm0dBiChCzrvQVBsZuXx/PUWYmDgVsbJQB0
         zG9f382yR7vkW1nIZwqLepLvmXqnmXMcUrKlC3Qj7dLEap4lkshXtu/TE9g0cz+oqLT4
         GanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775182814; x=1775787614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLyfrpphk/pri+vsSR8ZKPbndfkUJotLPgfVmPM7TEQ=;
        b=YdL+bs5CLhgyrRQjrQlnBQJ3hB225e3i6GZjfEZL+iJoZQsI+RVzp3N87XLs+MAfLe
         WkKTmeg8/QBlkqr5089+9cgp820/rSR45VXPBW+PChJm1Rz9qS2IPCqNf35QoDDCO8Ng
         G9mr3zJ8Vsx9v2BmqjaILrVsAR46DcN725KhJrPgPSllIPYDxACUO1BASIpgdnQJePNq
         hmKh48lyxPHEXGsPQ9sXErUypfS9/NDqJ+2eaIBbtKAJQdPqLBI3VhR30ihkzRQS/1MP
         mA2oy2p+AeyVdBvomWqbjvnGLPDkRbLHF+RtgLnSqKkRVnn86E1ZMdFVPKfdkI0HHKvs
         hL5w==
X-Forwarded-Encrypted: i=1; AJvYcCUnTD2DXL3PDK2FBmHIp/ttzuboWhOatncHKF8QlYWSAy1huTPsr8adbyM7No+SWaMc5oyPsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRWTNHA7SyipIG0w5hZ+QqUvRjmnFTtAmExpjbFzUYyKUoWOsp
	uQAheNE6X5AV2dWhFKjyC0HO4MOb1FGZ7sZ3CA534dY8OpDo0PJnl9f9E0RwRDhhkg==
X-Gm-Gg: AeBDievrT/rlc1yTlzBzzeuLfygiQX02lEjge8DrgG+Uz8NYas2cNVH8AjiYM6GkUeg
	VWelndo1qvsD5F4G58iBn3N9pWnhrZqYDN6W2Ck1WrO4pAWVVI1I74okqmNHReY010EPr6sD9yV
	iXT8IoFjqEmsdycUtAvIjtblJCoUYkXaSAQ4q3nFwxhiCORvIGbR3jF4EvSARLghtQJlGkHCWPm
	q9JpkOQbBGexMPn4V+xh5bPnqQyxaZxE8qnh9c7i/5KER93G0GMG6u6Aea5cXV/25WFi/gPihpS
	CKYmZbT/vhMUNm/DqXfxofGs9tSc/3q+AJxKgUMjl04FU9+SES978z2uyzxU48P/C2LNYx1n27v
	KmEOJhL7SP2d0GMZj6P/L7wkNaIQhxyNutpcipN6qkPwHVMdWshuEepJXuC40iOD7jooXvdaODb
	1BBEO/PWyAQzCrKsU4u6VT4g+ya81lYTXY8utDG7mVsghCw3gguv3ZrxPDbQ==
X-Received: by 2002:a17:903:2f0d:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b282ed3780mr1613755ad.2.1775182813067;
        Thu, 02 Apr 2026 19:20:13 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c71e62sm4165949b3a.44.2026.04.02.19.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 19:20:12 -0700 (PDT)
Date: Fri, 3 Apr 2026 02:20:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <ac8j1jlFNxgZWzzK@google.com>
References: <20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com>

On Fri, Mar 13, 2026 at 03:53:53PM +0530, Prakash Gupta wrote:
> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
> sits in a power domain, all register accesses must be done while the
> device is runtime active to avoid unclocked register reads and
> potential NoC errors.
> 
> So far, this has not been an issue for most SMMU clients because
> stall-on-fault is enabled by default. While a translation fault is
> being handled, the SMMU stalls further translations for that context
> bank, so the fault handler would not race with a powered-down
> SMMU.
> 
> Adreno SMMU now disables stall-on-fault in the presence of fault
> storms to avoid saturating SMMU resources and hanging the GMU. With
> stall-on-fault disabled, the SMMU can generate faults while its power
> domain may no longer be enabled, which makes unclocked accesses to
> fault-status registers in the SMMU fault handlers possible.
> 
> Guard the context and global fault handlers with pm_runtime_get_if_active()
> and pm_runtime_put_autosuspend() so that all SMMU fault register accesses
> are done with the SMMU powered. In case pm_runtime is not active we can
> safely ignore the fault as for pm runtime resume the smmu device is
> reset and fault registers are cleared.
> 
> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Switched from arm_smmu_rpm_get()/arm_smmu_rpm_put() wrappers to
>   pm_runtime_get_if_active()/pm_runtime_put_autosuspend() APIs
> - Added support for smmu->impl->global_fault callback in global fault handler
> - Remove threaded irq context fault restriction to allow modifying stall
>   mode for adreno smmu
> - Link to v1: https://patch.msgid.link/20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 60 +++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 5e690cf85ec9..f4c46491a03d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -462,10 +462,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	int idx = smmu_domain->cfg.cbndx;
>  	int ret;
>  
> +	if (!pm_runtime_get_if_active(smmu->dev))

Note that the pm_runtime_get_if_active(dev) only returns a positive
value if the device state is exactly RPM_ACTIVE. If the device is in the
middle of its runtime_suspend callback, its state is RPM_SUSPENDING.

Thus, if a fault races with the suspend callback, we'll return IRQ_NONE
and the suspend callback doesn't seem to be disabling interrupts.

This isn't any better if we're in a fault-storm caused by
level-triggered interrupts, we'd simply keep entering this handler and
return.

I believe we should clear / handle any pending faults/interrupts or
atleast mask interrupt in the suspend handler to avoid this situation.

> +		return IRQ_NONE;
> +

Maybe we could add another wrapped-helper to maintain consistency:

static inline int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
{
     if (!pm_runtime_enabled(smmu->dev))
         return 1; // Assume active/powered if RPM is not used
     return pm_runtime_get_if_active(smmu->dev);
}

This returns -EINVAL otherwise which isn't a problem for the if
condition but slightly cleaner.

> +	if (smmu->impl && smmu->impl->context_fault) {
> +		ret = smmu->impl->context_fault(irq, dev);
> +		goto out_power_off;
> +	}
> +

We've moved impl-specific handlers here, I don't see a functional change.
This looks fine.

>  	arm_smmu_read_context_fault_info(smmu, idx, &cfi);
>  
> -	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
> -		return IRQ_NONE;
> +	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT)) {
> +		ret = IRQ_NONE;
> +		goto out_power_off;
> +	}
>  
>  	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
>  		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> @@ -480,7 +490,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  				  ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
>  	}
>  
> -	return IRQ_HANDLED;
> +	ret = IRQ_HANDLED;
> +
> +out_power_off:
> +	pm_runtime_put_autosuspend(smmu->dev);

Nit: Please use arm_smmu_rpm_put() here.. while at it, I guess we can
also bring back pm_runtime_put_autosuspend() in arm_smmu_rpm_put() since
it is updated now to also mark last busy.

> +
> +	return ret;
>  }
>  
>  static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> @@ -489,14 +504,25 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  	struct arm_smmu_device *smmu = dev;
>  	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
> +	int ret;
> +
> +	if (!pm_runtime_get_if_active(smmu->dev))
> +		return IRQ_NONE;
> +

Same here.

> +	if (smmu->impl && smmu->impl->global_fault) {
> +		ret = smmu->impl->global_fault(irq, dev);
> +		goto out_power_off;
> +	}
>  
>  	gfsr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSR);
>  	gfsynr0 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR0);
>  	gfsynr1 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR1);
>  	gfsynr2 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR2);
>  
> -	if (!gfsr)
> -		return IRQ_NONE;
> +	if (!gfsr) {
> +		ret = IRQ_NONE;
> +		goto out_power_off;
> +	}
>  
>  	if (__ratelimit(&rs)) {
>  		if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> @@ -513,7 +539,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  	}
>  
>  	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
> -	return IRQ_HANDLED;
> +	ret = IRQ_HANDLED;
> +
> +out_power_off:
> +	pm_runtime_put_autosuspend(smmu->dev);
> +	return ret;
>  }
>  
>  static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> @@ -683,7 +713,6 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
>  	enum io_pgtable_fmt fmt;
>  	struct iommu_domain *domain = &smmu_domain->domain;
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -	irqreturn_t (*context_fault)(int irq, void *dev);
>  
>  	mutex_lock(&smmu_domain->init_mutex);
>  	if (smmu_domain->smmu)
> @@ -850,19 +879,14 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
>  	 */
>  	irq = smmu->irqs[cfg->irptndx];
>  
> -	if (smmu->impl && smmu->impl->context_fault)
> -		context_fault = smmu->impl->context_fault;
> -	else
> -		context_fault = arm_smmu_context_fault;
> -
>  	if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
>  		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
> -						context_fault,
> +						arm_smmu_context_fault,
>  						IRQF_ONESHOT | IRQF_SHARED,
>  						"arm-smmu-context-fault",
>  						smmu_domain);
>  	else
> -		ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
> +		ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault, IRQF_SHARED,
>  				       "arm-smmu-context-fault", smmu_domain);
>  
>  	if (ret < 0) {
> @@ -2125,7 +2149,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int num_irqs, i, err;
>  	u32 global_irqs, pmu_irqs;
> -	irqreturn_t (*global_fault)(int irq, void *dev);
>  
>  	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>  	if (!smmu) {
> @@ -2205,18 +2228,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		smmu->num_context_irqs = smmu->num_context_banks;
>  	}
>  
> -	if (smmu->impl && smmu->impl->global_fault)
> -		global_fault = smmu->impl->global_fault;
> -	else
> -		global_fault = arm_smmu_global_fault;
> -
>  	for (i = 0; i < global_irqs; i++) {
>  		int irq = platform_get_irq(pdev, i);
>  
>  		if (irq < 0)
>  			return irq;
>  
> -		err = devm_request_irq(dev, irq, global_fault, IRQF_SHARED,
> +		err = devm_request_irq(dev, irq, arm_smmu_global_fault, IRQF_SHARED,
>  				       "arm-smmu global fault", smmu);
>  		if (err)
>  			return dev_err_probe(dev, err,
> 

Thanks,
Praan
