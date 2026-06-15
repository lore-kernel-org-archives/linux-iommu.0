Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4230D3F2
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547635; cv=none; b=SJQIesmWt/5Z3rXwOtDJyF/vQlTHsRnb79ZbBSxQOxWnv3l35fonQTI5+tDWmja3wV+BrbrWWJg7GFnLO9RSz8ATyY8ROwdXudsE2dRMjQcY3nMcr2YW5lK4TRXVisJO/u+qBrk62W8GxWad9eYKWo89MVFy7L12QJRVlCcq8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547635; c=relaxed/simple;
	bh=HK6ZVXrYbQTgmPfdllTHMKCHRGbrh9ntjZNYTJMEiTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQRZ8k4uVdDTEs3/I0xtyhp7BjhGADmWQyV5CP/mHw2L0u9YIsZ8yI175Mom72HfFyxDkObXFka0qSAtF3nJy6Tigq3jitxz31VWQjXZMmAxSLIexwXAgsu0khLwLuTtxbxCgbaeNioSXFYASMIMy2t+NwD2Euaer4AWjTkqUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WaEpF2Ny; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WaEpF2Ny"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bb5ad3bdso8315e9.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781547632; x=1782152432; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QQFE4Q78ROfwCE6RiQR0WbwEbAFg2bEgRUVC0vIbxA=;
        b=WaEpF2NyqJL5anJxFpCDuWA8DSowpdxgJTLTvFTBdhKfTYbPf/zXBeFv9pOhmFaNLK
         +gfr+BdgsJ4xJQiOmD28q32M11n74VByUokx8wGk+lW5MeKihDfjBmpF1lRo769BcGv6
         gIyTayXTui2InqF2ibBjtuifV/k9VR/Xm2ar1hy7RwrKmrY0ass90ugvAgwAnlUW/QFR
         DgneH3FB6VL8t1PKw1q6EJXcGa2FNtS9X7YssyhW9Edsci4wer4x8WiLvugAJ465njEM
         DOGUaMjYCRazz2AQ5bcbKa00rnmvMviozRo5EbIM32KWzbVJlvSlAI4DLtapF1Xb7Uw4
         KGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547632; x=1782152432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QQFE4Q78ROfwCE6RiQR0WbwEbAFg2bEgRUVC0vIbxA=;
        b=NZI0zz12OO63GyvNndoIO+pRccONUJWNmib3z9G2k5ebuSVQ4yZJd4urjBMnxfEZag
         xXYgMQbkUrCYpI5rg6DB4PMkJlMqMoLXgAacmvmhxaJR2yIAY0cYn3LSJ6U/LK0q5agc
         F7e9LiaPVkOzoV0HYcw95MznphoaAJX97pp1GKVR3pg06q8qtbFOfFpGCiNx8vglotSi
         wn9DUYglSX9TPR2tOnZCDcMj7h+2ENnvPbx/4gBqMbreKaaFooKiluqvotL7agpoGP7W
         Uj32wQrDHbsX1bqRA1zjysWsZ9DdZOZspIIYbROBLLoa3ZjbhK87oK5s9Vhsg1YFPKr6
         Ip2Q==
X-Gm-Message-State: AOJu0YyWZpPnwCR7c2vt2P+6pQOKSOBFAR46K5o9+l2atBuH57mXOn2m
	4MuvdLCGHrgHwfk83RjWRPVoasqdI7a9LS/odhZeMx4vdCgsprom5iTTc51I3Hp1ag==
X-Gm-Gg: Acq92OHjJexgK9goFdbUj7g8yIz7Vd6Xs4hNdcYIfyzGczH3rmje9eGXyihtULF+nOY
	YuG93fd59SBAuOKULdCh7M75DELksz1BqUqhDuIbGFPrU9HXliNgYXA5N+Mm7MVWC28ouroAAzd
	cNf/+Il4+zbX0o7R+qryW+B+xvcwUz/fY7JfdwaEHy+lbfIP/VuXkxYI4N9cMHug6UtBPQi0Omn
	JTAU0XkaswPUtHZuZPWWHrdGicil9wJOLgwY9n0gOalAqWjFlq54m5NIj0FQhoKslB/b8isGQBa
	Fn6EN+PoE2UokWZ7UJt+YnIWoWROhyw3gf3ejytDK8oD0wVmoxgFpsInvwm/+EZG5lZAe5pqqF5
	kme93dUDleY7Oxliu9pCfDTRDwqR9KA/jYY6KEGr1WUsi4sY+cX1xDThh2K2FH92ncTdA3OLlr0
	TlxRdWH3tV/bKgPLMLJND8LtF268TcE9I4bQT0Xob2P5TQ8xLJy+CbI1UrAjA1xQ==
X-Received: by 2002:a05:600c:8a09:10b0:490:b2ae:44ca with SMTP id 5b1f17b1804b1-4922ffea1dcmr122675e9.5.1781547631529;
        Mon, 15 Jun 2026 11:20:31 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa50e97sm12797275e9.8.2026.06.15.11.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:20:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:20:27 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ajBCazla1VoJX9Ms@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-10-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-10-praan@google.com>

On Mon, Jun 01, 2026 at 09:59:06PM +0000, Pranjal Shrivastava wrote:
> Implement pm_runtime and system sleep ops for arm-smmu-v3.
> 
> The suspend callback configures the SMMU to abort new transactions,
> disables the main translation unit and then drains the command queue
> to ensure completion of any in-flight commands. A software gate
> (STOP_FLAG) and synchronization barriers are used to quiesce the command
> submission pipeline and ensure state consistency before power-off.
> 
> To prevent software metadata flags from leaking into physical registers
> or polluting the tracking pointer, a newly introduced bitmask
> (CMDQ_PROD_IDX_MASK) is applied to all register writes and tracking
> updates.
> 
> The resume callback restores the MSI configuration and performs a full
> device reset via `arm_smmu_device_reset` to bring the SMMU back to an
> operational state. The MSIs are cached during the msi_write and are
> restored during the resume operation by using the helper. The STOP_FLAG
> is cleared only after the CMDQ is enabled in hardware.
> 
> Suggested-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 172 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  18 ++
>  2 files changed, 188 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d31e50b64b50..542de3a3173a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sort.h>
>  #include <linux/string_choices.h>
> +#include <linux/pm_runtime.h>
>  #include <kunit/visibility.h>
>  #include <uapi/linux/iommufd.h>
>  
> @@ -110,6 +111,40 @@ static const char * const event_class_str[] = {
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>  static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
>  
> +/* Runtime PM helpers */
> +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_enabled(smmu->dev))
> +		return 0;
> +
> +	ret = pm_runtime_resume_and_get(smmu->dev);
> +	if (ret < 0) {
> +		dev_err(smmu->dev, "failed to resume device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_enabled(smmu->dev))
> +		return;
> +
> +	ret = pm_runtime_put_autosuspend(smmu->dev);
> +	if (ret < 0)
> +		dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
> +}
> +
> +static inline u32 arm_smmu_cmdq_owner_prod_idx(struct arm_smmu_cmdq *cmdq)
> +{
> +	return atomic_read(&cmdq->owner_prod) & CMDQ_PROD_IDX_MASK;
> +}
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -789,7 +824,8 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  		/* b. Stop gathering work by clearing the owned flag */
>  		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
>  						   &cmdq->q.llq.atomic.prod);
> -		prod &= ~CMDQ_PROD_OWNED_FLAG;
> +		/* Strip all metadata flags */
> +		prod &= CMDQ_PROD_IDX_MASK;
>  
>  		/*
>  		 * c. Wait for any gathered work to be written to the queue.
> @@ -4828,7 +4864,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  
>  	/* Command queue */
>  	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
> -	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> +	writel_relaxed(smmu->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
> +		       smmu->base + ARM_SMMU_CMDQ_PROD);
>  	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
>  
>  	enables = CR0_CMDQEN;
> @@ -4839,6 +4876,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> +	/* Clear any flags from the previous life */
> +	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.owner_prod);
> +	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod);

Should not that be done from the suspend call?

> +
>  	/* Invalidate any cached configuration */
>  	arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_all());
>  
> @@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	if (is_kdump_kernel())
>  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>  
> +	/*
> +	 * While the SMMU was suspended, concurrent CPU threads may have
> +	 * updated in-memory structures (such as STEs, CDs, and PTEs).
> +	 * Any invalidations corresponding to those updates were safely
> +	 * elided because the command queue was stopped (STOP_FLAG == 1).
> +	 *
> +	 * Since the reset invalidate-all commands above have fully cleared
> +	 * the HW TLBs and config caches, the SMMU will fetch these descriptors
> +	 * directly from RAM as soon as translation is enabled.
> +	 *
> +	 * Add a memory barrier to collect all prior RAM writes to ensure the
> +	 * SMMU sees a consistent view of memory before translation is enabled.
> +	 */
> +	smp_mb();

Should not that be dma_wmb() as this is syncing with the HW?

> +
>  	/* Enable the SMMU interface */
>  	enables |= CR0_SMMUEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -5580,6 +5636,117 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>  	arm_smmu_device_disable(smmu);
>  }
>  
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> +	int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> +	u32 enables, target;
> +	int ret;
> +
> +	/* Abort all transactions before disable to avoid spurious bypass */
> +	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
> +	enables = CR0_CMDQEN;
> +	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to disable SMMU\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * At this point the SMMU is completely disabled and won't access
> +	 * any translation/config structures, even speculative accesses
> +	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> +	 */
> +
> +	/* Mark the CMDQ to stop and get the target index before the stop */
> +	target = atomic_fetch_or_relaxed(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);

As Daniel mentioned, I think this shouldn't be relaxed.

> +	target &= CMDQ_PROD_IDX_MASK;
> +
> +
> +	/* Wait for the last committed owner to reach the hardware */
> +	while ((arm_smmu_cmdq_owner_prod_idx(cmdq) != target) && --timeout)
> +		udelay(1);

I think --timeout has an off-by-one.

Thanks,
Mostafa

