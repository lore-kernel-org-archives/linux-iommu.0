Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE61CF7AE
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771172; cv=none; b=YE5FpKBR1oJoB10lIgwxiXCCFtvWrdA/LZm0j3kSySRokQLDfHIh5bcIQ/ZwavSPFUPDl7Lrmesvwol1Ib/N40ltuZxcwcmCvha/Yg7lHtxe5Vmn/ovOae1s9C7isdJsHwe6X/Ybgn+PpocwtuK1v0ooywpo1rRVQK8Tf56FK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771172; c=relaxed/simple;
	bh=EntLZ7vvs1T2Fpr72EUN6/Yo75b7KQb/Q6c7X9WnGq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZaCA50kvdGTwGKIwlFjDmZYKJVjbMvRwhThJkcT2ePmWzcxGQji5p1Wfw0x3nPmZY0iMvV//zNQaw1ciPMUDoqIIw1GU6PqqzqEN/FPB0GZLBOk5VwjPESdTFOSEh/l+YEXv5b0qrIarQ2cfehG7GzT4GE/TdRrV/oMSdkn4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37453339;
	Thu, 24 Oct 2024 04:59:58 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F2F3F71E;
	Thu, 24 Oct 2024 04:59:27 -0700 (PDT)
Message-ID: <aa763283-97fc-4b50-828d-8b64aa749bdd@arm.com>
Date: Thu, 24 Oct 2024 12:59:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Add judgment on the size and granule
 parameters passed in
To: goutongchen <goutongchen@uniontech.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Rob Clark <robdclark@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: =?UTF-8?B?6Iuf5rWp?= <gouhao@uniontech.com>
References: <20241024100224.62942-1-goutongchen@uniontech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241024100224.62942-1-goutongchen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2024 11:02 am, goutongchen wrote:
> In the arm_smmu_tlb_inv_range_s1 and arm_smmu_tlb_inv_range_s2
> functions, the size and granule passed in must be judged.
> It must be ensured that the passed in parameter is not 0 and
> the size is an integer multiple of the granule, otherwise it
> will cause an infinite while loop.
> 
> This was encountered during testing, and was initially triggered
> by passing in a size value of 0, causing the kernel to crash.
> 
> [    8.214378][  T675] xhci_hcd 0000:0b:00.0: new USB bus registered, assigned bus number 1
> [   68.246185][    C0] rcu: INFO: rcu_sched self-detected stall on CPU
> [   68.246866][    C0] rcu:     0-....: (5999 ticks this GP) idle=796c/1/0x4000000000000000 softirq=161/161 fqs=2999
> [   68.247924][    C0] rcu:     (t=6000 jiffies g=-699 q=1 ncpus=128)
> [   68.248452][    C0] CPU: 0 PID: 675 Comm: kworker/0:2 Not tainted 6.6.0-25.02.2500.002.uos25.aarch64 #1
> [   68.249237][    C0] Hardware name: Inspur     CS5260F     /CS5260F          , BIOS 4.0.16 05/31/22 16:53:51
> [   68.250029][    C0] Workqueue: events work_for_cpu_fn
> [   68.250497][    C0] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   68.251188][    C0] pc : arm_smmu_tlb_inv_range_s1+0xf0/0x158
> [   68.251704][    C0] lr : arm_smmu_tlb_inv_walk_s1+0x44/0x68
> [   68.252189][    C0] sp : ffff80008044b780
> [   68.252530][    C0] x29: ffff80008044b780 x28: 0000000000000000 x27: 0000000000001000
> [   68.253212][    C0] x26: 0000000000000600 x25: 0000000000000001 x24: 0000000000000600
> [   68.253857][    C0] x23: 0000000000000000 x22: 0000000000001000 x21: fffffc64e2e59000
> [   68.254544][    C0] x20: 0000000039c1d1a6 x19: ffff3fe944c40280 x18: 0000000000000000
> [   68.255240][    C0] x17: 626d756e20737562 x16: ffffb0e7e08c1008 x15: 0000000000000000
> [   68.255930][    C0] x14: ffff3ef8c1ea15cd x13: ffff3ef8c1ea15cb x12: fffffcfba30e3880
> [   68.256538][    C0] x11: 00000000ffff7fff x10: ffff80008044b6b0 x9 : ffffb0e7decd1b5c
> [   68.257126][    C0] x8 : 0000000000000dc0 x7 : ffff3ee8c4148000 x6 : ffff3ee8c4148000
> [   68.257822][    C0] x5 : 0000000000000008 x4 : 0000000000000000 x3 : ffff3fe944c40800
> [   68.258497][    C0] x2 : 0000000000000010 x1 : 0000000000000020 x0 : ffffb0e7dfd6c3d0
> [   68.259185][    C0] Call trace:
> [   68.259451][    C0]  arm_smmu_tlb_inv_range_s1+0xf0/0x158
> [   68.259933][    C0]  arm_smmu_tlb_inv_walk_s1+0x44/0x68
> [   68.260384][    C0]  __arm_lpae_map+0x1f0/0x2c0

Huh? This invalidation path is for mapping a block entry, and the size 
is the size of that block per ARM_LPAE_BLOCK_SIZE(lvl, data) - how can 
it possibly be 0?

Thanks,
Robin.

> [   68.260796][    C0]  arm_lpae_map_pages+0xec/0x150
> [   68.261215][    C0]  arm_smmu_map_pages+0x48/0x130
> [   68.261654][    C0]  __iommu_map+0x134/0x2a8
> [   68.262098][    C0]  iommu_map_sg+0xb8/0x1c8
> [   68.262500][    C0]  __iommu_dma_alloc_noncontiguous.constprop.0+0x180/0x270
> [   68.263145][    C0]  iommu_dma_alloc+0x178/0x238
> [   68.263557][    C0]  dma_alloc_attrs+0xf8/0x108
> [   68.263962][    C0]  xhci_mem_init+0x1e8/0x6d0
> [   68.264372][    C0]  xhci_init+0x88/0x1d0
> [   68.264736][    C0]  xhci_gen_setup+0x284/0x468
> [   68.265121][    C0]  xhci_pci_setup+0x60/0x1f8
> [   68.265506][    C0]  usb_add_hcd+0x278/0x650
> [   68.265860][    C0]  usb_hcd_pci_probe+0x218/0x458
> [   68.266256][    C0]  xhci_pci_probe+0x7c/0x270
> [   68.266660][    C0]  local_pci_probe+0x48/0xb8
> [   68.267074][    C0]  work_for_cpu_fn+0x24/0x40
> [   68.267548][    C0]  process_one_work+0x170/0x3c0
> [   68.267999][    C0]  worker_thread+0x234/0x3b8
> [   68.268383][    C0]  kthread+0xf0/0x108
> [   68.268704][    C0]  ret_from_fork+0x10/0x20
> 
> Signed-off-by: goutongchen <goutongchen@uniontech.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 8321962b3714..16b2e9ec0e60 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -282,6 +282,13 @@ static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	int idx = cfg->cbndx;
>   
> +	if (size == 0 || granule == 0 || (size % granule) != 0) {
> +		dev_err(smmu->dev,
> +				 "The size or granule passed in is err. size=%lu, granule=%lu\n",
> +				 size, granule);
> +		return;
> +	}
> +
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>   		wmb();
>   
> @@ -309,6 +316,13 @@ static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	int idx = smmu_domain->cfg.cbndx;
>   
> +	if (size == 0 || granule == 0 || (size % granule) != 0) {
> +		dev_err(smmu->dev,
> +				 "The size or granule passed in is err. size=%lu, granule=%lu\n",
> +				 size, granule);
> +		return;
> +	}
> +
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>   		wmb();
>   
