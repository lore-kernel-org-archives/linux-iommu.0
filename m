Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8901CAA72
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978187; cv=none; b=EZe2sBI0uNPAcngQi+tY7ItKAlaT2/qiUZ55wW9DEbFqNyL3MBBYtjRr0v/O6x5Rh/ZDzvyvwvZh2dVUyc/t68CiZAt5KLAgS6X2Vys7AfFlGmRTwV3+HZW0J/c6BK15McU6Enkg3tbZprrzysAveMs7xEl00ChIkIeF31dkJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978187; c=relaxed/simple;
	bh=yLPFibv7S6vH/zSBXAwCcb4MUSBDiEHJcQQLEGaVBaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CR9fBbq+BrrWWjx54Uc7AuhW0oJhaCgAYAUihjSU+38ghEX/9MlYuH/hwSSpxe5EmWwnEn98lonj5Dla2BoFlW3+bR+go2OVzTVfDe2XXULYGsZ7U6bfUm9OQ67jLmdfMIjrw0N/oCKYlhZPr/qOWXckyP8EhgwB4cJTkNX6U+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3C811FB;
	Wed, 15 Jan 2025 13:56:53 -0800 (PST)
Received: from [10.57.4.211] (unknown [10.57.4.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E85C93F673;
	Wed, 15 Jan 2025 13:56:22 -0800 (PST)
Message-ID: <6301d20b-d51d-4f96-94ea-134e065d398e@arm.com>
Date: Wed, 15 Jan 2025 21:56:21 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/riscv: support HPM and interrupt handling
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
 tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, luxu.kernel@bytedance.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org
References: <20250115030306.29735-1-zong.li@sifive.com>
 <20250115030306.29735-3-zong.li@sifive.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250115030306.29735-3-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-15 3:03 am, Zong Li wrote:
> Initialize the PMU and uninitialize it when driver is removed.
> Interrupt handling is also implemented, and the handler needs
> to be a primary handler instead of a threaded function because
> pt_regs is empty when threading the IRQ. However, pt_regs is
> required by perf_event_overflow.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>   drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8a05def774bd..20ae90471484 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -552,6 +552,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +
> +/* HPM interrupt primary handler */
> +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_device *iommu = (struct riscv_iommu_device *)dev_id;
> +
> +	/* Clear performance monitoring interrupt pending */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
> +
> +	/* Process pmu irq */
> +	riscv_iommu_pmu_handle_irq(&iommu->pmu);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* HPM initialization */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +	int rc;
> +
> +	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +		return 0;
> +
> +	/*
> +	 * pt_regs is empty when threading the IRQ, but pt_regs is necessary
> +	 * by perf_event_overflow. Use primary handler instead of thread
> +	 * function for PM IRQ.
> +	 *
> +	 * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> +	 * other threaded IRQs by other queues.
> +	 */
> +	rc = devm_request_irq(iommu->dev,
> +			      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
> +			      riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED, NULL, iommu);

Hmm, shared interrupts are tricky for PMUs, since perf requires any IRQ 
handler touching a PMU is running on pmu->cpu, so you have to be very 
careful about maintaining affinity and not letting anyone else change it 
behind your back.

The other thing is that if it really is shared, at this point you could 
now be in riscv_iommu_pmu_handle_irq() dereferencing NULL.

> +	if (rc)
> +		return rc;
> +
> +	return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
> +}
> +
> +/* HPM uninitialization */
> +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> +{
> +	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +		return;
> +
> +	devm_free_irq(iommu->dev,
> +		      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
> +		      iommu);
> +
> +	riscv_iommu_pmu_uninit(&iommu->pmu);
> +}
> +
>   /* Lookup and initialize device context info structure. */
>   static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
>   						 unsigned int devid)
> @@ -1596,6 +1652,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
>   	riscv_iommu_queue_disable(&iommu->cmdq);
>   	riscv_iommu_queue_disable(&iommu->fltq);
> +
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +		riscv_iommu_pmu_uninit(&iommu->pmu);
>   }
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -1635,6 +1694,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	if (rc)
>   		goto err_queue_disable;
>   
> +	rc = riscv_iommu_hpm_enable(iommu);
> +	if (rc)
> +		goto err_hpm_disable;
> +

I would leave this until after the whole IOMMU setup has succeeded. The 
PMU is not critical to IOMMU operation, so at that point an error is not 
fatal, it just means you don't get a PMU, thus there shouldn't need to 
be any cleanup outside riscv_iommu_hpm_enable() itself.

Thanks,
Robin.

>   	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
>   				    dev_name(iommu->dev));
>   	if (rc) {
> @@ -1653,6 +1716,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   err_remove_sysfs:
>   	iommu_device_sysfs_remove(&iommu->iommu);
>   err_iodir_off:
> +	riscv_iommu_hpm_disable(iommu);
> +err_hpm_disable:
>   	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
>   err_queue_disable:
>   	riscv_iommu_queue_disable(&iommu->fltq);

