Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04343422550
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207382; cv=none; b=T/c2RZKtXu4EIWyrjtvNsFsEcFBe0HyJbimxUqmDv9kRLKtR6KlaTjImzVZB1hGFaib/ZyBJVjb3HiMGvzgHTc8L4GwOBxfUTLoGQYDR2l9MTKowJgnZBg0MQLbAdc8rw8AkLKQNKNfgam1Etdmehbw1H/n6ChgCpOHVbvsISK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207382; c=relaxed/simple;
	bh=XhpvexryAh1HFBU8MAXPYUlkIzW12Wg+/TI9/A+/jM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SJPPwzJIE3mnFqIunp8oAziL4vVr3TmvFbBFOP7Si0wEg/kw8oiwdUf0sHEZi4WskRdf7kLOjXd1hWzq+luohyJYrJfEB17ZTymTtcd0f8J1Nzl+XZX1advAu1wnVqk8CXeQbxT1X3ZTt9SOPr7GG/FfPYKjcLVXkIVtsHFLu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eatQ5NIf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eatQ5NIf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D731476;
	Thu, 16 Jul 2026 06:09:35 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1EE03F905;
	Thu, 16 Jul 2026 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784207379; bh=XhpvexryAh1HFBU8MAXPYUlkIzW12Wg+/TI9/A+/jM8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eatQ5NIfTjWDJY8nZuTno5h2B6yKkgBeiKhNZ0hSekJs/WYcshz1H3ItRnLcVIFXt
	 anMYbp+Y7cGDwuvLwLw6d/WLX1MlcjX0TqJUx5FIh0q6cIcZ/h2JgULhYueqEZ7Kkm
	 59MDXcuqCQiujxDcXxi1WNvMb1qpByQZjih8NJB4=
Message-ID: <38a1a39d-b72e-4433-815e-a01c691c0249@arm.com>
Date: Thu, 16 Jul 2026 14:09:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: arm: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>, Will Deacon <will@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Joerg Roedel
 <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Kees Cook <kees@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:QUALCOMM IOMMU" <linux-arm-msm@vger.kernel.org>
References: <20260714133246.575556-1-panchuang@vivo.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260714133246.575556-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2026 2:32 pm, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
> automatically log detailed error messages on failure. Remove
> the now-redundant driver-specific dev_err() and dev_err_probe() calls.

FWIW, the arm-smmu messages do provide contextual information about 
precisely *which* IRQ in SMMU terms was at fault, which generic code 
cannot do - the context/global index gives the developer enough to go 
and directly check the relevant DT/ACPI entry, without first having to 
figure out what hardware resource the Linux vIRQ number represents. 
However I do concur that the generic code is now more than enough for 
the general "something is terribly wrong" case, and beyond that we 
really don't need to optimise Linux for people writing bad firmware...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c   | 9 ++-------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 4 +---
>   2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0bd21d206eb3..889a0966d36c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -865,11 +865,8 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
>   		ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
>   				       "arm-smmu-context-fault", smmu_domain);
>   
> -	if (ret < 0) {
> -		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> -			cfg->irptndx, irq);
> +	if (ret < 0)
>   		cfg->irptndx = ARM_SMMU_INVALID_IRPTNDX;
> -	}
>   
>   	mutex_unlock(&smmu_domain->init_mutex);
>   
> @@ -2219,9 +2216,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		err = devm_request_irq(dev, irq, global_fault, IRQF_SHARED,
>   				       "arm-smmu global fault", smmu);
>   		if (err)
> -			return dev_err_probe(dev, err,
> -					"failed to request global IRQ %d (%u)\n",
> -					i, irq);
> +			return err;
>   	}
>   
>   	platform_set_drvdata(pdev, smmu);
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index a1e8cf29f594..2b57262b076f 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -712,10 +712,8 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>   			       IRQF_SHARED,
>   			       "qcom-iommu-fault",
>   			       ctx);
> -	if (ret) {
> -		dev_err(dev, "failed to request IRQ %u\n", irq);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	ret = get_asid(dev->of_node);
>   	if (ret < 0) {

