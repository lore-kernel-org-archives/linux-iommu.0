Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5CF212D82
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553974; cv=none; b=dxltpMZukC+r/ucWAQZ6rY0Ws5nTG0Zp437vPle1+yu0B4FomlcdwGsdDc8KKI0meSueLStag/iWE9ekANNzFg1ivDb9nHWZVyRpIqJ32HFwVfzeJX/5fzA0mv6ZveBP8SLKiv2JMS4eIANGpoJwXeP+UFbeOKIiqa95BIiG1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553974; c=relaxed/simple;
	bh=bCZQUPgbAAU9qPX5h5uFUJDAeWiyMGqVWreCFXQ+PWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuVW7Z2H5qIrmN9t67c6IPCv9dwpEKfQNBSwwWOm9crlnyQQO8FOQ86l58oLGvr1rDCGOXyT62sZjqHeT1fdY+pPfToxHtMFubxrB9V0wvbcH5MiC+BRTg9G4ULPBwOViS6OItdlHRCSiyrkgoCQB34bWg+6Oa6RLEd20uW1xQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A5C1007;
	Wed, 22 Jan 2025 05:53:18 -0800 (PST)
Received: from [10.57.6.202] (unknown [10.57.6.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0933F738;
	Wed, 22 Jan 2025 05:52:48 -0800 (PST)
Message-ID: <79061537-9550-45ad-8bd3-26fe7423f16f@arm.com>
Date: Wed, 22 Jan 2025 13:52:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: Fix spurious interrupts with
 stall-on-fault
To: Connor Abbott <cwabbott0@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org
References: <20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com>
 <20250120-msm-gpu-fault-fixes-next-v2-1-d636c4027042@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250120-msm-gpu-fault-fixes-next-v2-1-d636c4027042@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-20 3:46 pm, Connor Abbott wrote:
> On some SMMUv2 implementations, including MMU-500, SMMU_CBn_FSR.SS
> asserts an interrupt. The only way to clear that bit is to resume the
> transaction by writing SMMU_CBn_RESUME, but typically resuming the
> transaction requires complex operations (copying in pages, etc.) that
> can't be done in IRQ context. drm/msm already has a problem, because
> its fault handler sometimes schedules a job to dump the GPU state and
> doesn't resume translation until this is complete.
> 
> Work around this by disabling context fault interrupts until after the
> transaction is resumed. Because other context banks can share an IRQ
> line, we may still get an interrupt intended for another context bank,
> but in this case only SMMU_CBn_FSR.SS will be asserted and we can skip
> it assuming that interrupts are disabled which is accomplished by
> removing the bit from ARM_SMMU_CB_FSR_FAULT.

...and we won't see SS set *unless* an external user has gone out of 
their way to set CFCFG, so it's fair to assume they must have a fault 
handler and expect it to reenable CFIE. Good enough for me (and thanks 
for a nice comprehensive writeup). Now let's see how many more bugs we 
might uncover in MMU-500 and/or QCom firmware's emulation thereof :)

Reviewed-by Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 15 ++++++++++++++-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c      | 30 ++++++++++++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 -
>   3 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 59d02687280e8d37b5e944619fcfe4ebd1bd6926..7d86e9972094eb4d304b24259f4ed9a4820cabc7 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -125,12 +125,25 @@ static void qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
>   	struct arm_smmu_domain *smmu_domain = (void *)cookie;
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	u32 reg = 0;
> +	u32 reg = 0, sctlr;
> +	unsigned long flags;
>   
>   	if (terminate)
>   		reg |= ARM_SMMU_RESUME_TERMINATE;
>   
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +
>   	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
> +
> +	/*
> +	 * Re-enable interrupts after they were disabled by
> +	 * arm_smmu_context_fault().
> +	 */
> +	sctlr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR);
> +	sctlr |= ARM_SMMU_SCTLR_CFIE;
> +	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, sctlr);
> +
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
>   }
>   
>   static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool set)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 79afc92e1d8b984dd35c469a3f283ad0c78f3d26..fe3d77984533eb1a0e0e211021598bc808f2a6b2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -463,6 +463,36 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
>   		return IRQ_NONE;
>   
> +	/*
> +	 * On some implementations FSR.SS asserts a context fault
> +	 * interrupt. We do not want this behavior, because resolving the
> +	 * original context fault typically requires operations that cannot be
> +	 * performed in IRQ context but leaving the stall unacknowledged will
> +	 * immediately lead to another spurious interrupt as FSR.SS is still
> +	 * set. Work around this by disabling interrupts for this context bank.
> +	 * It's expected that interrupts are re-enabled after resuming the
> +	 * translation.
> +	 *
> +	 * We have to do this before report_iommu_fault() so that we don't
> +	 * leave interrupts disabled in case the downstream user decides the
> +	 * fault can be resolved inside its fault handler.
> +	 *
> +	 * There is a possible race if there are multiple context banks sharing
> +	 * the same interrupt and both signal an interrupt in between writing
> +	 * RESUME and SCTLR. We could disable interrupts here before we
> +	 * re-enable them in the resume handler, leaving interrupts enabled.
> +	 * Lock the write to serialize it with the resume handler.
> +	 */
> +	if (cfi.fsr & ARM_SMMU_CB_FSR_SS) {
> +		u32 val;
> +
> +		spin_lock(&smmu_domain->cb_lock);
> +		val = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR);
> +		val &= ~ARM_SMMU_SCTLR_CFIE;
> +		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, val);
> +		spin_unlock(&smmu_domain->cb_lock);
> +	}
> +
>   	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
>   		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
>   
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 2dbf3243b5ad2db01e17fb26c26c838942a491be..789c64ff3eb9944c8af37426e005241a8288da20 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -216,7 +216,6 @@ enum arm_smmu_cbar_type {
>   					 ARM_SMMU_CB_FSR_TLBLKF)
>   
>   #define ARM_SMMU_CB_FSR_FAULT		(ARM_SMMU_CB_FSR_MULTI |	\
> -					 ARM_SMMU_CB_FSR_SS |		\
>   					 ARM_SMMU_CB_FSR_UUT |		\
>   					 ARM_SMMU_CB_FSR_EF |		\
>   					 ARM_SMMU_CB_FSR_PF |		\
> 

