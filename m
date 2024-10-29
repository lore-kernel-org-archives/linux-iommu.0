Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE0206518
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208998; cv=none; b=u5nkPSv5ZZNF/FW6lV33ijIDFrqBeRZXcvqQpWyPDumpbMo55R2ZuNlFTTbIPabbwvd//Dwx+qCPtJC/+mUxeraYQo6GQW8im68uQeASXZCYPyo6eGnZNF/mzoQPWduu91as9BITgE2wAyAfeN05PnT/MmdLhvcU49W2z0hdLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208998; c=relaxed/simple;
	bh=x1jLr3vWrmltIQyQARGx1z8Pz2x/BNhjT643z7wYiAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mS00oeu4UNbvduTCYnG5Pc2mqfBjXB4V9cDGgSaq7xRrhdF/wdLx//J1dbuNGExWhoIbp7IovX7nqpVbiJ8YHn9QM99V5+orFl3XRYc3xr1j/TLmJBAqtDo2s3KtLKkTpGRng6Zp6lYyeekVxZImU04nHbsHXXDp9qiMSbjMQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C24113E;
	Tue, 29 Oct 2024 06:37:03 -0700 (PDT)
Received: from [10.57.89.81] (unknown [10.57.89.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEFE43F528;
	Tue, 29 Oct 2024 06:36:31 -0700 (PDT)
Message-ID: <7f172651-7bc0-4c3b-8d33-1c796e016c84@arm.com>
Date: Tue, 29 Oct 2024 13:36:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/5] iommu/arm-smmu: add ACTLR data and support for
 qcom_smmu_500
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, robdclark@gmail.com,
 will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com,
 robh@kernel.org, krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
 dmitry.baryshkov@linaro.org
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-6-quic_bibekkum@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241008125410.3422512-6-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-08 1:54 pm, Bibek Kumar Patro wrote:
> Add ACTLR data table for qcom_smmu_500 including
> corresponding data entry and set prefetch value by
> way of a list of compatible strings.

Hmm, I'd still be inclined to combine this into the existing 
qcom_smmu_client_of_match table by generalising the match data (i.e. 
make an explicit "wants an identity domain" flag as well), but that 
could always be tried later. This is pleasantly inoffensive enough as it 
is, compared to the previous idea :)

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 2d2c1e75632c..dd4fb883ebcd 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -25,8 +25,31 @@
> 
>   #define CPRE			(1 << 1)
>   #define CMTLB			(1 << 0)
> +#define PREFETCH_SHIFT		8
> +#define PREFETCH_DEFAULT	0
> +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
> +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
> +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
>   #define GFX_ACTLR_PRR		(1 << 5)
> 
> +static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
> +	{ .compatible = "qcom,adreno",
> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,adreno-gmu",
> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,adreno-smmu",
> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,fastrpc",
> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sc7280-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sc7280-venus",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8550-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ }
> +};
> +
>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>   {
>   	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -640,6 +663,7 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>   	.impl = &qcom_smmu_500_impl,
>   	.adreno_impl = &qcom_adreno_smmu_500_impl,
>   	.cfg = &qcom_smmu_impl0_cfg,
> +	.client_match = qcom_smmu_actlr_client_of_match,
>   };
> 
>   /*
> --
> 2.34.1
> 

