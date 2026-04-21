Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D3279DC3
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787017; cv=none; b=JdYAkw5UdK5Aar5KLr0idOBQPAHnbsqQOebOTPOibbxdxXdtrV5xd0P89jYUSLQOujEPXjFZe7Q8MOPSb4VJ01TJf3r7y6Iud9Kl2kWKXMsvLNFAN8racDb2tTUcostDK6gvWOTNtdGqFv17P64C0cuVuoWMDPMuRvElHGZ77iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787017; c=relaxed/simple;
	bh=D3W8mI+PUSgL8Ci0Ng3HSt4aWC16NYcoiFjJr0+hrC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apZHQvRtKlc9hKI0ieewQCXTzDbtQjenqHF4HGCA2yQrM0QqpHt96moS4QqnO1OqSg2Fb433MtLr4j7whOXPXbiA9ZJa5P7RinrYSyp0v1X7rugcmchlyL2CoTnkNSimcRjWjSgPYpSjsZDGrrrCwqMN/ru7zs3vjdHcbMP2Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aYrhviLf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aYrhviLf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21A0627B5;
	Tue, 21 Apr 2026 08:56:49 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0223FAF5;
	Tue, 21 Apr 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776787014; bh=D3W8mI+PUSgL8Ci0Ng3HSt4aWC16NYcoiFjJr0+hrC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aYrhviLfI3Fg5ruouPOBbG6V0sHMDezGjatQJpbBbCfe/K4aGUJLj7ruZDfkxJf2O
	 5fF96QfrTySz/D8Lc0aOUU+jSuShuxYCmWYIqCZvVYA4db2GaZQvPxf+IZ1vUXcuT2
	 8t+sZb3VRjG1jZx+zICs1KFQBNEvb+C7UIbbCah0=
Message-ID: <0fdf4b1f-90f2-4f69-9d2b-dc5f608e9c1c@arm.com>
Date: Tue, 21 Apr 2026 16:56:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at
 PAGE_SIZE
To: leo.jiang1224@foxmail.com, will@kernel.org
Cc: joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2026 6:31 am, leo.jiang1224@foxmail.com wrote:
> From: LoserJL <leo.jiang1224@foxmail.com>
> 
> In arm_smmu_init_one_queue(), the loop reduces max_n_shift if
> dmam_alloc_coherent() fails. However, since dmam_alloc_coherent()
> allocates at least PAGE_SIZE, retrying with a smaller size after
> a PAGE_SIZE failure is logically redundant.

Says who? It's certainly not a guarantee offered by the DMA API itself, 
and indeed some allocation paths can definitely still allocate less than 
a page - e.g. anything which hits a per-device or global coherent pool.

> Moreover, if a sub-page retry were to succeed due to concurrent memory
> release, the hardware would be configured with a smaller queue depth
> despite a full page being allocated. This leads to inefficient memory
> usage and unnecessary hardware performance limitation.
> 
> Terminate the loop once qsz reaches PAGE_SIZE to ensure logical
> consistency and optimal hardware configuration.

That's really not an argument - even if an allocator does happen to 
over-allocate for the requested size, that is hardly the caller's 
concern; and as far as "optimal" queue sizes go in this case, those very 
much depend on the number of CPUs issuing commands and volume of 
expected stall/PRI events - in many cases PAGE_SIZE would already be far 
too small to really work well.

Also note that if we _were_ to fail to allocate a PAGE_SIZE or smaller 
queue, there would be very little chance of the subsequent allocation(s) 
for the stream table succeeding, so realistically the driver is probably 
going to end up failing to probe in such circumstances anyway.

Thanks,
Robin.

> Signed-off-by: LoserJL <leo.jiang1224@foxmail.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f0..e0ec118ff560 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4418,7 +4418,14 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>   		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
>   		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
>   					      GFP_KERNEL);
> -		if (q->base || qsz < PAGE_SIZE)
> +		/*
> +		 * If allocation succeeds, we're done. If it fails, only retry
> +		 * if the requested size is still larger than a page. Since
> +		 * dmam_alloc_coherent() allocates at least PAGE_SIZE, retrying
> +		 * with a sub-page size is logically redundant and could lead
> +		 * to sub-optimal hardware configuration.
> +		 */
> +		if (q->base || qsz <= PAGE_SIZE)
>   			break;
>   
>   		q->llq.max_n_shift--;

