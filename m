Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38930C164
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234496; cv=none; b=IgKzx2qifKe3iWUxSrozUrGDcfsgfRxSCS6G1isUsufTfthYkXYo4ZwrAgTgw8wC7FSflHHUEuGZBnLLCBbU0BRVGG7RK42nknAWhWP3xkWFHksXtKXHZnIz9pyUUx5fwTFokzgGLAItAniuGcHXbth3+ryW5pGeUM2FaYLRqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234496; c=relaxed/simple;
	bh=ADQsnugpFHOxuOxzTph2IW6GGFQJ6O5IwKd6BdjGweM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlbclNRrg7+lonmcZMwpsut7jRB8sq9f8DqXFvBwT+mMy5S3MtF3He96yAolWhD0zBxcjtXjWUxR2gVkpyog8D3Xb5MEltj/ZAJtviRKvbTrtqIdK9xNtbnOCX26ChXuc+o90KHzOBK9/g63Pg7QL83Dm84Omdm3nwWOtUFUxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QhyoxRA7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QhyoxRA7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F22B14BF;
	Tue, 23 Jun 2026 10:08:08 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D7B3F62B;
	Tue, 23 Jun 2026 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782234492; bh=ADQsnugpFHOxuOxzTph2IW6GGFQJ6O5IwKd6BdjGweM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QhyoxRA7HjCf8/agBkdHSW4FjaPUxoIO2W2pmMUtZ318jEYJfOnK/ZBEtsdyTPH7T
	 ACSjdThyLAFzSuwkDruxCYsK2sQRa3zvNt2wpaZh1LamZmZYEAAW5MNvJa5gr7cAtC
	 wyU0cVSBm5o6W/adqj6i8O6EXBxX4UuqBLYxrA7Y=
Message-ID: <3463e5cf-05d3-4e4b-ac22-699e5f95589b@arm.com>
Date: Tue, 23 Jun 2026 18:08:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] iommu/qcom: Add NULL ctx check in TLB invalidation
 paths
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-7-mukesh.ojha@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260623122034.1166295-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/06/2026 1:20 pm, Mukesh Ojha wrote:
> to_ctx() returns qcom_iommu->ctxs[asid], which can be NULL if the
> corresponding context bank failed to probe or was already removed.
> qcom_iommu_tlb_sync(), qcom_iommu_tlb_inv_context(), and
> qcom_iommu_tlb_inv_range_nosync() all dereference the returned pointer
> directly, risking a NULL pointer dereference.

But if there's no context bank, then how has a domain been allocated in 
order to permit io-pgtable operations that would eventually call into 
qcom_flush_ops at all? Can you please clarify whether you've actually 
observed a real-world issue here, and if so how?

Thanks,
Robin.

> Add WARN_ON(!ctx) guards with continue so TLB operations skip
> broken context banks without crashing.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 40fb0408dc07..51b60b296bb8 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -121,6 +121,9 @@ static void qcom_iommu_tlb_sync(void *cookie)
>   		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>   		unsigned int val, ret;
>   
> +		if (WARN_ON(!ctx))
> +			continue;
> +
>   		iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
>   
>   		ret = readl_poll_timeout(ctx->base + ARM_SMMU_CB_TLBSTATUS, val,
> @@ -138,6 +141,10 @@ static void qcom_iommu_tlb_inv_context(void *cookie)
>   
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
> +
> +		if (WARN_ON(!ctx))
> +			continue;
> +
>   		iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
>   	}
>   
> @@ -157,6 +164,9 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>   		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>   		size_t s = size;
>   
> +		if (WARN_ON(!ctx))
> +			continue;
> +
>   		iova = (iova >> 12) << 12;
>   		iova |= ctx->asid;
>   		do {

