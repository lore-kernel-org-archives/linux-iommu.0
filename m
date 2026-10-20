Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495022;
	b=yfGGE9Pif+N8ENQ0zB12Ra68jYPFllk4/1MYEer1ehIzvZXco9trngw9BCfOR3gMH2/w
	 AhkC2tQ59Py6/tjSD5vufKVM9KslEELJpfTA76zWZ3lsYzjAOvSK5iTvI3elKR1dkqQOL
	 bi/RfbNGQfalMoYQNzTHk4VPMXvFdQN+k5DNrv/8yufont3vqyt9msv/55YcSwv8J8und
	 SNcfCV3f4eUlIxjOI2JIyeOrdPe6waCt+lgNxD3tME6rTfZeG/bqxQXADWvGmYdVhmMf3
	 /LBpkDEbyXN3ejR1GrAqa88x6QlCKaeTfXOmvYQjMGjrcNuw0Ig1Fbwcu5ON5WTTGFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=bVNQzZPkVhaJesZfY8LQ/WfX4unos7POmP6IgKPN9ZE=;
	b=5oSZF/EbkbBd+sflPB/DYjT24+jtp74EkUROQQm/Iz1XPl6QIDPycBF+3DQMT6VQSAEz
	 oJiQxN3pP+yH4v4Aq0Z1lAZXCnOw+MiCUrxQ5/+niOA42ONu9AxPO80/XGSG+1LL5irD9
	 VgHzkSUZlxRiz+2fSR6z04fKKcohA/g9q7vlxsoNUiXn52f8K/aTzI4+b2ovioijnYHE+
	 5Cy/RHwtiVJ07FUDSsEkLCJvvEnao2F5MI0Mb+kZg9Dan4yucqb22YI44hcgrqF0XXKmk
	 i2rkfZQb86YWAZ8MKmGE7EJ7F7vON0aQyRmJYUxLloYTO/6YSAkBXNB5SKZ1adzVDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iekBfk1c;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63521606A319
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63521606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iekBfk1c
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1d2ec9aadso41135e9.1
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792495020; x=1793099820; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVNQzZPkVhaJesZfY8LQ/WfX4unos7POmP6IgKPN9ZE=;
        b=iekBfk1caDpxtapwLDVhX0oSm/RHkMJAOSTd62NOfb5+lurL4R0Nra3JX2sG1JIMc5
         EaF0ReUtVjkZt5XHs9Upu3HutIlL5YEJucwUapbLt+Es/WLvh+51pNkUdMiVYZTokpOq
         LJpk07uYqgu++dTJ714BkpNDuxgorDj112pZVVU/sBquUNHp0r8vj3icvPvDpChi6btt
         aNqFiEMnFLPLWBH+Lyk6OMPWvv+yMBDRe9VFpH9ox36Z80dMs0eSDh2yslxUSv10KXq/
         8y47H+cdpbsxmsRC1CDRonmIxlQyOn5oM68qPdCnK6K4U4jhVw4a1IuMTt4wNfe720V2
         hxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792495020; x=1793099820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bVNQzZPkVhaJesZfY8LQ/WfX4unos7POmP6IgKPN9ZE=;
        b=E1+ek2GL29DtzT71k2/yH5yYM5xuPY5gw+slCG50/+wYE8MnaRpLbv/1VgCvvVW9Bc
         c7YncFHne6zzSsHHfpJ5yidw1dy46jnUg7OXcuGgWaCpHZr2wkanmKbLmp+zU6sD99Ma
         UiQWq0aDW59Ic3iHSrckX0sBdceOJHPCxbvST+sbaZjOkZz8yrVzQtGlfbBJmd3pkAQ/
         aZlvQ+clztXcbeFInBrd91NLrneK7GR0FRcMQPrnNFjETK+KTT76bNUpJGGQPI2vZCX8
         zBiRr6UNXDBpWzHxHCrxn8WcKykal1UyWN9bqIMDyjDLMDHGmzTpx+hQia0dGa+9Ch3K
         X/Zg==
X-Forwarded-Encrypted: i=1; AKwUvBx8qNfPhQSrbIeyltPn9olTfg9PuzDBw+Jrj/5Xd3N9qINxRJOHIx5jl66dW9S5853D7gO3yQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYILstNu8uBM5c1R4LdIboVQ3f7wg2FcuURVrHlX2SqcJdt0Qtv3
	g0zPmTIE2fZS1tQI7XbKsxxySiZRd/56x/VG33R944BrDEltkW/gmfcyf3YhID1J8Q==
X-Gm-Gg: AYBFou2CNMBtdsepb2kJNvlkkxKoUXA8d6pqBByR+39zPWZ/j6lqMGQKKCLQIPQMCAO
	dqSX6v04dL9dLDYSbXz3UfdTMe5kVxCCGeJpC3ZUvHUMkSVStNsvCTEUSJJjvu+IeXVQUgiayZW
	cfjACyU8Z8n1MfUFmdsqsov3P4rfRYwiRF42ONOU2+zjmLvS6m42n8vxAweHr0gVmcZvKbXOIHk
	TP7Cd1YkUzgCjb8vMAOEiz6FiCCzFZDw/d2joXduJvd2N+STAoN3TRnFZyc9qVZxMVPgMoY/Y1U
	aY+7UbfYRZOVW74becfYQbw6ZSGVL1uQ4w8WLoq+OaBAzLyHtEC6ccbwpULd4QD7I+wNRMtojcA
	FpEtw3DO1zsntIb9UxPH2tai+bvaZNrR+uS9JisPMxj/bbElk1QwXX2GdS+q3ZX2jNQiwgYgKIn
	paOqAYE+9D8eL8B9S2+n/2HvcYekl8KDvw3o4tg0/gxAKRfMcHh9NbRiQQ/MvS+H6GrPmorIt+c
	cnQlwtJg3He5xskW3mUxmWrwA==
X-Received: by 2002:a05:600c:a3a5:b0:4a1:a48c:17eb with SMTP id 5b1f17b1804b1-4a1f59a5836mr572995e9.11.1792495019224;
        Tue, 20 Oct 2026 04:16:59 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82fe82sm5139903f8f.51.2026.10.20.04.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:16:58 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:16:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	praan@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 04/11] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for
 the event queue
Message-ID: <atdNpl732M7D4dXz@google.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <250a57bbdd232bbb1e3511b7768a1c9ae3d204e6.1791226953.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <250a57bbdd232bbb1e3511b7768a1c9ae3d204e6.1791226953.git.nicolinc@nvidia.com>

On Mon, Oct 05, 2026 at 12:30:47PM -0700, Nicolin Chen wrote:
> The driver programs and enables the event queue unconditionally, while the
> PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
> kdump kernel wants to leave both of the queues alone, which would take an
> is_kdump_kernel() test at every one of those places.
> 
> Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
> architecturally mandatory, and gate the queue's allocation, its interrupt,
> its MSI vector, and its CR0 and IRQ_CTRL enables on it. A subsequent change
> will turn the queue off in a single place.
> 
> No functional change intended.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

There is a nit below though.

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 ++++++++++++++-------
>  2 files changed, 61 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8f2c0b1cc4a8d..559bfa8cbc5e0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -972,6 +972,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_BBML2		(1 << 24)
>  #define ARM_SMMU_FEAT_HAFT		(1 << 25)
>  #define ARM_SMMU_FEAT_DS		(1 << 26)
> +#define ARM_SMMU_FEAT_EVTQ		(1 << 27)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6ff61565f7583..756825e004774 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2381,7 +2381,8 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
>  {
>  	struct arm_smmu_device *smmu = dev;
>  
> -	arm_smmu_evtq_thread(irq, dev);
> +	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
> +		arm_smmu_evtq_thread(irq, dev);
>  	if (smmu->features & ARM_SMMU_FEAT_PRI)
>  		arm_smmu_priq_thread(irq, dev);
>  
> @@ -2390,7 +2391,12 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
>  
>  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>  {
> -	arm_smmu_gerror_handler(irq, dev);
> +	struct arm_smmu_device *smmu = dev;
> +	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
> +
> +	/* Without either queue, the thread would have nothing to drain */
> +	if (!(smmu->features & (ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI)))
> +		return ret;
>  	return IRQ_WAKE_THREAD;
>  }
>  
> @@ -4763,11 +4769,14 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  		return ret;
>  
>  	/* evtq */
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
> -				      ARM_SMMU_EVTQ_PROD, ARM_SMMU_EVTQ_CONS,
> -				      EVTQ_ENT_DWORDS, "evtq");
> -	if (ret)
> -		return ret;
> +	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
> +		ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
> +					      ARM_SMMU_EVTQ_PROD,
> +					      ARM_SMMU_EVTQ_CONS,
> +					      EVTQ_ENT_DWORDS, "evtq");
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
>  	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
> @@ -4950,7 +4959,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  
>  	/* Clear the MSI address regs */
>  	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> -	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> +
> +	/* PRIQ's vector needs EVTQ's to be kept */
> +	WARN_ON_ONCE(!(smmu->features & ARM_SMMU_FEAT_EVTQ) &&
> +		     (smmu->features & ARM_SMMU_FEAT_PRI));
> +

I can't see how we can end up in this case, I’d suggest dropping it
if I am not missing something.


> +	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
> +		writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> +	else
> +		nvec--;
>  
>  	if (smmu->features & ARM_SMMU_FEAT_PRI)
>  		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
> @@ -4987,16 +5004,20 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  	arm_smmu_setup_msis(smmu);
>  
>  	/* Request interrupt lines */
> -	irq = smmu->evtq.q.irq;
> -	if (irq) {
> -		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
> -						arm_smmu_evtq_thread,
> -						IRQF_ONESHOT,
> -						"arm-smmu-v3-evtq", smmu);
> -		if (ret < 0)
> -			dev_warn(smmu->dev, "failed to enable evtq irq\n");
> -	} else {
> -		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
> +	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
> +		irq = smmu->evtq.q.irq;
> +		if (irq) {
> +			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
> +							arm_smmu_evtq_thread,
> +							IRQF_ONESHOT,
> +							"arm-smmu-v3-evtq", smmu);
> +			if (ret < 0)
> +				dev_warn(smmu->dev,
> +					 "failed to enable evtq irq\n");
> +		} else {
> +			dev_warn(smmu->dev,
> +				 "no evtq irq - events will not be reported!\n");
> +		}
>  	}
>  
>  	irq = smmu->gerr_irq;
> @@ -5029,7 +5050,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  {
>  	int ret, irq;
> -	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
>  
>  	/* Disable IRQs first */
>  	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> @@ -5055,6 +5076,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  	} else
>  		arm_smmu_setup_unique_irqs(smmu);
>  
> +	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
> +		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
>  	if (smmu->features & ARM_SMMU_FEAT_PRI)
>  		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
>  
> @@ -5173,16 +5196,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		smmu, arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL));
>  
>  	/* Event queue */
> -	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
> -	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
> -
> -	enables |= CR0_EVTQEN;
> -	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> -				      ARM_SMMU_CR0ACK);
> -	if (ret) {
> -		dev_err(smmu->dev, "failed to enable event queue\n");
> -		return ret;
> +	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
> +		writeq_relaxed(smmu->evtq.q.q_base,
> +			       smmu->base + ARM_SMMU_EVTQ_BASE);
> +		writel_relaxed(smmu->evtq.q.llq.prod,
> +			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
> +		writel_relaxed(smmu->evtq.q.llq.cons,
> +			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
> +
> +		enables |= CR0_EVTQEN;
> +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> +					      ARM_SMMU_CR0ACK);
> +		if (ret) {
> +			dev_err(smmu->dev, "failed to enable event queue\n");
> +			return ret;
> +		}
>  	}
>  
>  	/* PRI queue */
> @@ -5330,6 +5358,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	u32 reg;
>  	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
>  
> +	/* The event queue is architecturally mandatory, unlike the PRI queue */
> +	smmu->features |= ARM_SMMU_FEAT_EVTQ;
> +
>  	/* IDR0 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
>  
> -- 
> 2.43.0
> 
