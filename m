Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8591D5178
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546893; cv=none; b=Y9XlyHwOQUHhHhgKuOcL/LX2d5ScsyZXh+S5t7RrNB94Xcet1/DRj45tR76jM7JJjOaAr2+YHDcapgM4Kvi9vxvXShfwFEOe0mrJkYHvL4LW6enWci2cfWun2s6xXOMPaJVs6PfwKiYRGOJr1sXFQrYcqqSzOnWjY6y5luLJasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546893; c=relaxed/simple;
	bh=M8oDGYfMvAN/T/wVbfMqlbdpRKyUZJa7C+Yxro0oVJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pghILIiG/YkndlZ9l3Ltb4P41PNPIsZBbW35q0Os96GsH6nEXNB0iGPPTnzHSLy1C0AM6TDy5WETpl4bo6oS1i1Y0M6NKLQtsMfT03uLGh3ghyfsIol3TjgEYVI9ocpisr8mRydAl+0G4Fakfp4EDZCyWkfR4jSqwa+SCXT9BkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 770561688;
	Wed, 15 Oct 2025 09:48:01 -0700 (PDT)
Received: from [10.57.36.191] (unknown [10.57.36.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA24C3F66E;
	Wed, 15 Oct 2025 09:48:07 -0700 (PDT)
Message-ID: <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
Date: Wed, 15 Oct 2025 17:48:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
To: Konrad Dybcio <konradybcio@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20251015-topic-qciommu_bindings_fix-v2-1-a0f3c705d0f3@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251015-topic-qciommu_bindings_fix-v2-1-a0f3c705d0f3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-15 5:41 pm, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Some IOMMUs on some platforms (there doesn't seem to be a good denominator
> for this) require the presence of a third clock, specifically for
> accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.

Hmmm, but isn't the only thing that accesses TBUs the consumer of the 
qcom,tbu binding, which already has its own clock?

Thanks,
Robin.

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Resending from a 2023 megaseries, no changes
> 
> v1: https://lore.kernel.org/lkml/20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org/
> ---
>   Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> index 3e5623edd207..93a489025317 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> @@ -32,14 +32,18 @@ properties:
>             - const: qcom,msm-iommu-v2
>   
>     clocks:
> +    minItems: 2
>       items:
>         - description: Clock required for IOMMU register group access
>         - description: Clock required for underlying bus access
> +      - description: Clock required for Translation Buffer Unit access
>   
>     clock-names:
> +    minItems: 2
>       items:
>         - const: iface
>         - const: bus
> +      - const: tbu
>   
>     power-domains:
>       maxItems: 1
> 
> ---
> base-commit: f5450b214b2440192a238d0c4af9f725810f8e01
> change-id: 20251015-topic-qciommu_bindings_fix-3bf3904041b9
> 
> Best regards,
