Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78876335BB7
	for <iommu@lists.linux.dev>; Mon,  1 Sep 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733849; cv=none; b=hglr7Gucd7Fs1ZNaCWRNeUs/uN4Y6qWQT4oZadWJ0mLaezIjdB0ldePHCx5MyyVdXSqH7DNr/s6fzROXyjBy08JTCIPXIe49FMPoj698HVkgR/Mq6x4ynq2DfwRtXSeVgrekUwb4at7pY8w50FReAUd8Qr41+b2dlOEVCab0yPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733849; c=relaxed/simple;
	bh=PPLZtw3Qg0EbySxzgSRxnPUep8TDYcM5w1uhilf3DXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lz1BlguirtpC/hIFTfH+rU/hPfIxz/8AwA+w/svRiVxkQM/TlBTpHCNzjdHi9NT31zVRZxkg3EjSKCkAjY+DSsw8Fd0P4B3EVxYM1xgB07eci59mUC1GpzHIHj41/hzf3/YU3/0jpuvc3c84zWrRXnGr53DABOL8vJHvv2jy+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PQoAnWOc; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PQoAnWOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NF
	pR6ok6bqJwalFjFmoTWIfA/y6t00m5bKO/H591X14=; b=PQoAnWOcEmcr5FztZw
	WcLAX/jkwamLGx35GgA2v48m0SmYsd162pfiixVcy8Ps2+B9Bhu5DMeGKJNQXk2/
	dj8LOcsaQFFqjpTzfWR1moIdZQ0/PzZHl+Aeu9XqsgEqbCPF0ZBAOYgO2X3dAXqG
	XHkR0bzlfP0XtsIsttuK6FZow=
Received: from nilq-virtual-machine.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDn72JdobVo9G7cAA--.40462S2;
	Mon, 01 Sep 2025 21:36:31 +0800 (CST)
From: niliqiang <ni_liqiang@126.com>
To: zong.li@sifive.com
Cc: aou@eecs.berkeley.edu,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org,
	chenruisust@gmail.com
Subject: Re: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
Date: Mon,  1 Sep 2025 21:36:29 +0800
Message-Id: <20250901133629.87310-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614142156.29420-3-zong.li@sifive.com>
References: <20240614142156.29420-3-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn72JdobVo9G7cAA--.40462S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFW8CFWftF13tryxuw13twb_yoW5GF1DpF
	Z8CrZIkr18JryxJ3W3J3W8CrZ0qan2kFWYvF1fC398Xw4UKrWUWF1DG3yFyrn8GrWDA3W2
	qa1Y9FsxCF15trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UY9aPUUUUU=
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbiJAW25WiuVI1HCQABsi

Hi Zong

Fri, 14 Jun 2024 22:21:48 +0800, Zong Li <zong.li@sifive.com> wrote:

> This patch initialize the pmu stuff and uninitialize it when driver
> removing. The interrupt handling is also provided, this handler need to
> be primary handler instead of thread function, because pt_regs is empty
> when threading the IRQ, but pt_regs is necessary by perf_event_overflow.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8b6a64c1ad8d..1716b2251f38 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
>   return IRQ_HANDLED;
>  }
>  
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +
> +/* HPM interrupt primary handler */
> +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> +{
> + struct riscv_iommu_device *iommu = (struct riscv_iommu_device *)dev_id;
> +
> + /* Process pmu irq */
> + riscv_iommu_pmu_handle_irq(&iommu->pmu);
> +
> + /* Clear performance monitoring interrupt pending */
> + riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
> +
> + return IRQ_HANDLED;
> +}
> +
> +/* HPM initialization */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> + int rc;
> +
> + if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +     return 0;
> +
> + /*
> +  * pt_regs is empty when threading the IRQ, but pt_regs is necessary
> +  * by perf_event_overflow. Use primary handler instead of thread
> +  * function for PM IRQ.
> +  *
> +  * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> +  * other threaded IRQs by other queues.
> +  */
> + rc = devm_request_irq(iommu->dev,
> +               iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
> +               riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED, NULL, iommu);
> + if (rc)
> +     return rc;
> +
> + return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
> +}
> +

What are the benefits of initializing the iommu-pmu driver in the iommu driver? 

It might be better for the RISC-V IOMMU PMU driver to be loaded as a separate module, as this would allow greater flexibility since different vendors may need to add custom events.

Also, I'm not quite clear on how custom events should be added if the RISC-V iommu-pmu is placed within the iommu driver.


Best regards,
Liqiang

