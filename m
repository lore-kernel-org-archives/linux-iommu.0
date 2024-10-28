Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE61BDA8C
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115739; cv=none; b=fPU3kp0avlaQaQiuOBuo/MIbcO3wXpb47ksnbr6OykXL6HZ4IZMy/ifQ3CogNmanyokgmgEfXMym2v3a4wdwV9qIgbvh9hoH0mzJywpplvDf2J7jRM6am2op6c4A3AWj6D8TUwJuMhHFDJji7ywvhlK2/adi+Cat5qaRz7iOt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115739; c=relaxed/simple;
	bh=UlEo/D0PYwaOTSjDIdE48t8eIJw1DEC00/1qLQKjeHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC7EBS69yCeA5MNq9CV1SVPZx+4ml3M5mbk+MHRgXykkSu04qsHnFKNa/7fkg7o2854C+ia3EI7tKJ/rOBbkU1Y3P3qA3DQX3zQC57bjfbVwctIHR08i+wU6U7klld/Y/jPRQip+nbSNVnOnjXWfTuzkwkQ8i9eG8fqwEDElYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A52B497;
	Mon, 28 Oct 2024 04:42:44 -0700 (PDT)
Received: from [10.57.89.58] (unknown [10.57.89.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E0C3F73B;
	Mon, 28 Oct 2024 04:42:12 -0700 (PDT)
Message-ID: <3d2041e7-95eb-4d60-92ab-d67e2f46531e@arm.com>
Date: Mon, 28 Oct 2024 11:41:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Add judgment on the size and granule
 parameters passed in
To: goutongchen@uniontech.com
Cc: dmitry.baryshkov@linaro.org, gouhao@uniontech.com, iommu@lists.linux.dev,
 jgg@ziepe.ca, joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robdclark@chromium.org, will@kernel.org
References: <20241024100224.62942-1-goutongchen@uniontech.com>
 <20241028034823.22838-1-goutongchen@uniontech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241028034823.22838-1-goutongchen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-28 3:48 am, goutongchen@uniontech.com wrote:
> From: goutongchen <goutongchen@uniontech.com>
> 
> In the arm_smmu_tlb_inv_range_s1 and arm_smmu_tlb_inv_range_s2
> functions, the size and granule passed in must be judged.
> It must be ensured that the passed in parameter is not 0 and
> the size is an integer multiple of the granule, otherwise it
> will cause an infinite while loop.
> 
> This was encountered during testing, and was initially triggered
> by passing in a size value of 0, causing the kernel to crash.

Still NAK. If there is a bug in the upstream io-pgtable-arm code which 
can actually cause this, please send a patch to fix *that* bug. 
Otherwise, if you've made a broken downstream change then it is not 
upstream's responsibility to maintain unnecessary code in a questionable 
attempt to paper over (some small subset of) such brokenness.

If you pass any sufficiently large size value which *does* happen to be 
a multiple of the granule, you're still going to see the same RCU stalls 
and failure to progress within reasonable time. If you pass something 
inappropriate for the "cookie" pointer, you're likely to corrupt memory 
or really crash. If you pass arguments which all look plausible but 
still don't match what actually needs invalidating, the consequences of 
under-invalidation can be even more subtle, nasty and hard to debug.

The iommu_flush_ops are not a public interface intended to be called 
arbitrarily from anywhere in the kernel with unchecked input, they are a 
low-level private interface between IOMMU drivers and their respective 
io-pgtable implementations, and as such they are designed for their 
callers to call them correctly by construction. Calling them incorrectly 
indicates a serious bug in the caller, since getting mapping and/or TLB 
invalidation wrong often leads to memory corruption or other issues down 
the line. Hence I'm not convinced this change is actually even desirable 
as a downstream debugging aid - if you're lucky enough to get stuck on 
an obviously-wrong call here, that's surely the clearest possible 
indication of the source of the bug in its calling context, far better 
than trying to ignore it and then having it drowned out by more distant 
things blowing up later due to 2nd- and 3rd-order effects.

Thanks,
Robin.

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
> index 8321962b3714..fdd7d7e9ce06 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -282,6 +282,13 @@ static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	int idx = cfg->cbndx;
>   
> +	if (size == 0 || granule == 0 || (size % granule) != 0) {
> +		dev_err(smmu->dev,
> +				 "The size or granule passed in is err. size=%zu, granule=%zu\n",
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
> +				 "The size or granule passed in is err. size=%zu, granule=%zu\n",
> +				 size, granule);
> +		return;
> +	}
> +
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>   		wmb();
>   

