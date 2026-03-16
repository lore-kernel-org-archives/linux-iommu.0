Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888D1A76BB
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674402; cv=none; b=MzNh+GMg6tqShVnHKC3sNOX9Fv240awBjOxLjtPY7MzMxTsCOINw9LAAAqe8lqZPnPRo8LY8lnuJxnmsQyw0Aks4+KAUCrjC6ufLWCBOWMdSbnNxuI5J9/QfDoUqu4I7Mh+Ho2gfeacQPQ0j1Z0sSg6zRjYzJ12K8w0HBnjpMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674402; c=relaxed/simple;
	bh=qYoIjOaXG9E/hy6KFf1HIpMd/U24NDI5Rp0qcmOBZoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgAzp93VREbMbKvQ5ch2OO3izWt5iMHbZro0XoEhunnL6CkOx+PNu4XscqgKpNOgkzia4SS41TKieQJ+3iIPctKw5Q5yXH9Jd+3jevTRdL4bloHZRY8jV8DmUJmAVGNKTrtH6qLhVTpjy3/W/o8T3xsEs5y0Rt5Dwj6KfMOQd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732A61477;
	Mon, 16 Mar 2026 08:19:53 -0700 (PDT)
Received: from [10.57.61.116] (unknown [10.57.61.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E0F3F778;
	Mon, 16 Mar 2026 08:19:58 -0700 (PDT)
Message-ID: <68add41b-bafa-4884-be70-c03d6ce851eb@arm.com>
Date: Mon, 16 Mar 2026 15:19:53 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add register display to
 debugfs
To: Qinxin Xia <xiaqinxin@huawei.com>, will@kernel.org, jpb@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 wangzhou1@hisilicon.com, prime.zeng@hisilicon.com, fanghao11@huawei.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-3-xiaqinxin@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260313104351.3502293-3-xiaqinxin@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-03-13 10:43 am, Qinxin Xia wrote:
> Add register display functionality to debugfs.This allows reading
> and displaying key SMMU register values including control registers
> and queue pointers.
> 
> The registers file shows:
> - CR0, CR1, CR2 control registers
> - Command and Event queue pointers
> 
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>   .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 68 ++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
> index 542bd6047f26..f9bf955f3351 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
> @@ -12,11 +12,20 @@
>    * - Capability reporting covering all major SMMU features and configuration
>    * - Extensible architecture designed for adding future debug functionality
>    * - Comprehensive error handling and resource cleanup
> + * - Display of control registers (CR0, CR1, CR2) with bitfield decoding
> + * - Command and Event queue pointer monitoring (PROD/CONS)
> + *
> + * Register Information Displayed:
> + * - CR0: SMMU global control with enable states and queue enables
> + * - CR1/CR2: Additional control and configuration registers
> + * - CMDQ_PROD/CONS: Command queue producer and consumer pointers
> + * - EVTQ_PROD/CONS: Event queue producer and consumer pointers
>    *
>    * Directory Structure:
>    * /sys/kernel/debug/iommu/arm_smmu_v3/
>    * └── smmu0/
> - *     └── capabilities    # SMMU feature capabilities and configuration
> + *     ├── capabilities    # SMMU feature capabilities and configuration
> + *     └── registers	   # SMMU Key registers
>    *
>    * The capabilities file provides detailed information about:
>    * - Architecture version and translation stage support (Stage1/Stage2)
> @@ -24,6 +33,11 @@
>    * - Stream table size and command/event queue depths
>    * - All feature bits from the SMMU device structure
>    *
> + * The register display provides crucial visibility into:
> + * - SMMU operational state (enabled/disabled)
> + * - Queue operation and potential stalls
> + * - Configuration settings affecting all streams
> + *
>    * Copyright (C) 2025 HiSilicon Limited.
>    * Author: Qinxin Xia <xiaqinxin@huawei.com>
>    */
> @@ -69,6 +83,54 @@ static int smmu_debugfs_capabilities_show(struct seq_file *seq, void *v)
>   }
>   DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_capabilities);
>   
> +/**
> + * smmu_debugfs_registers_show() - Display SMMU register values
> + * @seq: seq_file to write to
> + * @v: private data (SMMU device)
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int smmu_debugfs_registers_show(struct seq_file *seq, void *v)
> +{
> +	struct arm_smmu_device *smmu = seq->private;
> +	void __iomem *base;
> +
> +	if (!smmu || !smmu->base) {
> +		seq_puts(seq, "SMMU not available\n");
> +		return 0;
> +	}
> +
> +	base = smmu->base;
> +
> +	seq_puts(seq, "SMMUv3 Key Registers:\n");
> +
> +	/* 32-bit control registers */
> +	seq_printf(seq, "CR0: 0x%08x [%s%s%s]\n",
> +		   readl_relaxed(base + ARM_SMMU_CR0),
> +		   readl_relaxed(base + ARM_SMMU_CR0) & CR0_SMMUEN ?
> +		   "Enabled " : "Disabled ",
> +		   readl_relaxed(base + ARM_SMMU_CR0) & CR0_EVTQEN ?
> +		   "EventQ " : "",
> +		   readl_relaxed(base + ARM_SMMU_CR0) & CR0_CMDQEN ?
> +		   "CmdQ " : "");

There's really no point printing these extra strings, since if any of 
those were *not* enabled then we'd have already failed probe and never 
created the debugfs entry. And if anyone ever were to be trying to 
change the driver behaviour at that level, I'd very much expect them to 
be able to be able to read the bottom 4 bits of a CR0 value in hex anyway ;)

Thanks,
Robin.

> +
> +	seq_printf(seq, "CR1: 0x%08x\n", readl_relaxed(base + ARM_SMMU_CR1));
> +	seq_printf(seq, "CR2: 0x%08x\n", readl_relaxed(base + ARM_SMMU_CR2));
> +
> +	/* 32-bit queue pointer registers */
> +	seq_printf(seq, "CMDQ_PROD: 0x%08x\n",
> +		   readl_relaxed(base + ARM_SMMU_CMDQ_PROD));
> +	seq_printf(seq, "CMDQ_CONS: 0x%08x\n",
> +		   readl_relaxed(base + ARM_SMMU_CMDQ_CONS));
> +	seq_printf(seq, "EVTQ_PROD: 0x%08x\n",
> +		   readl_relaxed(base + ARM_SMMU_EVTQ_PROD));
> +	seq_printf(seq, "EVTQ_CONS: 0x%08x\n",
> +		   readl_relaxed(base + ARM_SMMU_EVTQ_CONS));
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_registers);
> +
>   /**
>    * arm_smmu_debugfs_setup() - Initialize debugfs for SMMU device
>    * @smmu: SMMU device to setup debugfs for
> @@ -120,6 +182,10 @@ int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, phys_addr_t ioaddr)
>   				 &smmu_debugfs_capabilities_fops))
>   		goto err_cleanup;
>   
> +	if (!debugfs_create_file("registers", 0444, smmu_dir, smmu,
> +				 &smmu_debugfs_registers_fops))
> +		goto err_cleanup;
> +
>   	pr_info("SMMUv3 debugfs initialized for smmu%pa\n", &ioaddr);
>   	return 0;
>   

