Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C59472556
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389149; cv=none; b=OD+WAxUd5AHxJLJWLyarcozQRhKQtUWBpjdy1eQiKx7QUtCDqYHNRuyU9kmxMv4NyALJIw7FsYu8aMhjAVwYtkBqDvwX1CKjSqSMkMSVEUIRJXNqo0ibaQ/yXunfJZ26pEn2w9qtnL2vWpF0wdHzsO7CoFVqR3LbZc/BLDg2deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389149; c=relaxed/simple;
	bh=//mVfT+cS6bsEEtaMcIXiUoj03Wbk2JdXzrCu9QKdyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdnEAWJ+w3K3y4dYqH95jAisjSpB0NrPyqQWsAzkHZx/zilrJehhNMjTCpI98LCDn3P+kZ6x2LYhzzaFdApzZ9W9GgYosrrBRKeE2ZIGZyS/TFd04VQQGZ9b0avgJfEeB+fQqr+FVLNi/hOL1JLpxM38AaNegg88VnzS/tMLeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vzKnHSdK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vzKnHSdK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 856191570;
	Mon, 14 Sep 2026 05:32:18 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC8D3F86F;
	Mon, 14 Sep 2026 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789389142; bh=//mVfT+cS6bsEEtaMcIXiUoj03Wbk2JdXzrCu9QKdyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vzKnHSdKbin0VxCTUDozy936CXwnZ/R6yHiNneZhuEooJRckC2b3b/3cDvQz6g7NQ
	 EDbJ4v+G1Disjqeycfm076iot2cIQi216QhEGxfBgTwPMeZPQww1CDLP4/uTNYKQ3/
	 9uIii6KCKAS7CGPMY9JU2rgfVNqlhesVxcszDx6M=
Message-ID: <fe22fb3d-77dd-4b34-9dd8-aafe11f36988@arm.com>
Date: Mon, 14 Sep 2026 13:32:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: arm-smmu-qcom: Skip fault-info reads when
 suspended
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260912-priv_call_runtime_handlers-v1-1-fc0c3a17523f@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260912-priv_call_runtime_handlers-v1-1-fc0c3a17523f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2026 11:25 pm, Bibek Kumar Patro wrote:
> qcom_adreno_smmu_get_fault_info() accesses SMMU registers without
> holding a runtime PM reference. A fault is raised while the SMMU is
> active, but the GPU may drop its power vote before the threaded fault
> handler reaches the callback, allowing the SMMU to runtime suspend.
> 
> Accessing the SMMU registers after suspend has started is unsafe and
> may cause subsequent register accesses during runtime resume to fail
> with a NoC error and an asynchronous SError.

But hang on, if I'm following the code correctly, the callchain would be:

arm_smmu_context_fault
   report_iommu_fault
     msm_gpu_fault_handler
      qcom_adreno_smmu_get_fault_info

and from here we still need to return to arm_smmu_context_fault() to 
clear the FSR, so surely that still has the same problem in itself?

Thanks,
Robin.

> Use pm_runtime_get_if_active() to keep the SMMU active while collecting
> the fault information, and skip the register reads if suspend has
> already started.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
> qcom_adreno_smmu_get_fault_info() accesses SMMU registers without
> holding a runtime PM reference. A fault is raised while the SMMU is
> active, but the GPU may drop its power vote before the threaded fault
> handler reaches the callback, allowing the SMMU to runtime suspend.
> 
> The failure sequence:
> 
>    GPU context fault
>            |
>            v
>    qcom_adreno_smmu_get_fault_info()
>            |
>            | GPU drops its power vote
>            | SMMU starts runtime suspend
>            v
>    SMMU register access without an active RPM reference
>            |
>            v
>    later Adreno PRR private-interface operation
>            |
>            v
>    pm_runtime_resume_and_get()
>            |
>            v
>    arm_smmu_runtime_resume()
>            |
>            v
>    arm_smmu_device_reset()
>            |
>            v
>    SMMU register access
>            |
>            v
>    NoC error / asynchronous SError
> 
> Use pm_runtime_get_if_active() to keep the SMMU active while collecting
> the fault information. If suspend has already started, skip the register
> reads instead of accessing the SMMU while it is being powered down.
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 795e8ec7e8fa..b1787a4ba0d3 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -129,6 +129,18 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   
> +	/*
> +	 * A fault can only fire while the SMMU is active (GPU is issuing
> +	 * transactions). Use get_if_active so that if by a rare race the
> +	 * device has already suspended, we skip the register reads rather
> +	 * than triggering a cold resume which would call device_reset and
> +	 * destroy the fault state we are trying to capture.
> +	 */
> +	if (pm_runtime_get_if_active(smmu->dev) <= 0) {
> +		dev_warn(smmu->dev, "get_fault_info: device not active, skipping\n");
> +		return;
> +	}
> +
>   	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
>   	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
>   	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
> @@ -136,6 +148,8 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>   	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
>   	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
>   	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
> +
> +	pm_runtime_put_autosuspend(smmu->dev);
>   }
>   
>   static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
> 
> ---
> base-commit: f61bb3920fa8cb44b84d32e0fa9fbaab4eb00c80
> change-id: 20260912-priv_call_runtime_handlers-7f3547544040
> 
> Best regards,
> --
> Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 

