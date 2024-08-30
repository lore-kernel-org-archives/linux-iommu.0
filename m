Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62517BB0C
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022443; cv=none; b=IKIQfQ5q320bh17fXBaGyYBWe7Z7nM5bqQi4XpJHIz2RHvJ7NX7V/4+ANCMRiG2J4THzbJgnL3J88ICncwYhjY21vfOkYeLXF5HAaJfjpuN/SaFPsKgrruN6OnC3vDHJvQigaftP/JPzfxJugGhmtlqu8HLvJkaQoLwHoz0+MvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022443; c=relaxed/simple;
	bh=Zq61/A7v10LBO9Fzob+2az5/LlVNojC3XIEiFP1NTi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YU8IF4oxii6BovxnC9KQKVyJc3Tozr93RWDOR784Xt2oOswlil3IKzc7k0P/K6cmjuykSFAAdqDAXpdgUZf2N7fNlAzZyDHo46XfwZVcdqey/VN4SELIq6aSch9JfW26Doy3a0oTWVruhyN48jNPmgeQc8f2+T1nEtUCd72PEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D46A1063;
	Fri, 30 Aug 2024 05:54:27 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12D83F66E;
	Fri, 30 Aug 2024 05:53:58 -0700 (PDT)
Message-ID: <fe5fcd06-ff28-4171-aa22-1bdc1e8510d0@arm.com>
Date: Fri, 30 Aug 2024 13:53:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/6] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, robdclark@gmail.com,
 will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com,
 robh@kernel.org, krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
 dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240816174259.2056829-1-quic_bibekkum@quicinc.com>
 <20240816174259.2056829-2-quic_bibekkum@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240816174259.2056829-2-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 6:42 pm, Bibek Kumar Patro wrote:
> Default MMU-500 reset operation disables context caching in
> prefetch buffer. It is however expected for context banks using
> the ACTLR register to retain their prefetch value during reset
> and runtime suspend.
> 
> Replace default MMU-500 reset operation with Qualcomm specific reset
> operation which envelope the default reset operation and re-enables
> context caching in prefetch buffer for Qualcomm SoCs.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 36 ++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 36c6b36ad4ff..8ac1850b852f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -16,6 +16,16 @@
> 
>   #define QCOM_DUMMY_VAL	-1
> 
> +/*
> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> + * buffer). The remaining bits are implementation defined and vary across
> + * SoCs.
> + */
> +
> +#define CPRE			(1 << 1)
> +#define CMTLB			(1 << 0)
> +
>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>   {
>   	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -381,11 +391,31 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
>   }
> 
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +	u32 val;
> +	int i;
> +
> +	ret = arm_mmu500_reset(smmu);
> +	if (ret)
> +		return ret;
> +
> +	/* arm_mmu500_reset() disables CPRE which is re-enabled here */

I still think it would be good to document why we think this is OK, 
given the reasons for disabling CPRE to begin with.

Thanks,
Robin.

> +	for (i = 0; i < smmu->num_context_banks; ++i) {
> +		val = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +		val |= CPRE;
> +		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
> +	}
> +
> +	return 0;
> +}
> +
>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> 
> -	arm_mmu500_reset(smmu);
> +	qcom_smmu500_reset(smmu);
> 
>   	/*
>   	 * To address performance degradation in non-real time clients,
> @@ -412,7 +442,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>   	.init_context = qcom_smmu_init_context,
>   	.cfg_probe = qcom_smmu_cfg_probe,
>   	.def_domain_type = qcom_smmu_def_domain_type,
> -	.reset = arm_mmu500_reset,
> +	.reset = qcom_smmu500_reset,
>   	.write_s2cr = qcom_smmu_write_s2cr,
>   	.tlb_sync = qcom_smmu_tlb_sync,
>   #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
> @@ -445,7 +475,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>   static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>   	.init_context = qcom_adreno_smmu_init_context,
>   	.def_domain_type = qcom_smmu_def_domain_type,
> -	.reset = arm_mmu500_reset,
> +	.reset = qcom_smmu500_reset,
>   	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>   	.write_sctlr = qcom_adreno_smmu_write_sctlr,
>   	.tlb_sync = qcom_smmu_tlb_sync,
> --
> 2.34.1
> 
