Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507F400E1E
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542715; cv=none; b=D7RXA9FN+zSipojFL6hJhWDrGKmjDwtpG3lxqRML91FzSZOTWswJKnwS8ylhx0XeNcAeolYg/osUN31pl6rL/dKP5TAHjDewn2yMdk8oPQjUFaHnfC+x8Tfg/KofwRZcwqsXPJXtQwEHV4cn8vHRClnO/K99lHeeoJOch6j5AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542715; c=relaxed/simple;
	bh=3e/jUSYZKbzJDjESnJG2wB/6ofViemCD+FyDj5JgVwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT1HGhLHVXH41tX3s+XnFuXJuCs2xl8DlmD8W6JeLvHUYG+ml4CBb91OAZTasi2ilB7JkiNk+AInoCHfiTrVs6aC2EKfSd/NqOV57PDDj2JCcwycsjpeQteviXfmif2C9NsKpBWOYYtOIBTOlq4zYpUT2LffKSi2XC4iFBohYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3DWxq3H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3DWxq3H"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bb5ad3bdso1505e9.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542712; x=1782147512; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRde05t57TYKLH/mElqBxXibIHpq+CO80Mfo9j1+ysc=;
        b=I3DWxq3H9bxswhS9GKaOtFBOOiYCTgLgo2aLHPPnMOVaCrPsi4amQH8eqOwPlPoCrT
         0E4fIFcdCyRsJ4esW/84wEQQ/KNQChQM34omAcFXCraZUzrJSNKiqD/RibKu0nE5oHgj
         6A5xX5Mcv3Z7azUiUPZ5WskanUscpBow07cH1OQqwkekPNQsQFMo/okh1TgMNnqy+Yt3
         fMYM33HbvpLedL7wN6MB7RIIeRp007ECzebKfg/INWmHgMpXz36tiOxyIXdEKl7csDf4
         tYWvq14mdd7gB17NkGOx0GOhEyZLnZk/nKUvUz8oeOyUb+dck2ZV7ZoI6RUsXgFvrI/J
         TLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542712; x=1782147512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRde05t57TYKLH/mElqBxXibIHpq+CO80Mfo9j1+ysc=;
        b=QF5Aej1hf5hHaI5QzegD3IRC2l4BnvPu+gI7UBDHSbLlSDXWOH4w/ip8EhQE2mqr+M
         tcb/46kOSHt+8GLVScbXu9qPiGnz/LrCgyKSzdIOIZgq01KcoWai823xP9j+vDnwTGUr
         EdJalAS6JX3kXsfNT7O1d11FwmgIuahUYEbhv7a1EjZW2uDH+IgFqK6Hhd/tSTQDSRU+
         BQReVekvBinC6WyJZWI3MWZQdmE48idR0T8yQbEac2F0L+VRaPQ69V8HTGFJLLXPGzTu
         AA+kosysXbIXX7L1g5KTWVg2o5B1M/tNdd6rlPrJDBEIh+Hyxd4CmplhmJ1RRCIsHgJ3
         Kh9g==
X-Gm-Message-State: AOJu0Yzzvdg92XeiYpEtMDXP1QmeRNCn2vqYdlbc2lgK3BYzC74erqtH
	acp6P6LCo2XzyWURk1gpwYRoc81+TjW7qZt3so2KBxhWsmLZR6UOhGSbyYzXuLu5yw==
X-Gm-Gg: Acq92OFyukdlGLIo7jK1SqicvnY0J0Ppw6Y94kw+N3YqP5dEpDVhufA/iq5b5FYxNHI
	f2KZcxHRo0bWQQ0rXp0YAh2Ua49QmT0RTAKmROe+OFKHsCB6YWUOOONhIVFDcAUzlpHbx0c3IJw
	8MiRCTD9PMQwyK7QaipBHd4AvvzuHT7YVzHE/ykHSiHAPLtN/YBLylLXD13aRVzIIXuMa8w8WVn
	ZTw/xlO/5dkrWln+TZqkhqKiJYAC79Yzf91RegI1CUCusDgdqR5qZD23p+VKettmx0kOav85lib
	3Ocb9zhvQt1CnrNbI6r+udFClKa1BkUWUePi6andc71AcDJ/8cKGzTFZI7x9krviuknkm5jjvyE
	pcypF2t+t9IobFDUSc9svp7tDwdUH8ygEmFpMV4mwtBwqESj+Rq9O5rknCvPijaGsjxoXDJ/fcX
	gGd42IEmyMCG/2FlcRNGaR4cXhKIUhI8FQNBzL2ukCXjp1eqhApqXL43rcg55Nor+eDII1+dcM
X-Received: by 2002:a05:600c:e555:20b0:48f:d634:b18d with SMTP id 5b1f17b1804b1-4922fcb119dmr16525e9.8.1781542711740;
        Mon, 15 Jun 2026 09:58:31 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9ccd86sm7626165e9.0.2026.06.15.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:58:31 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:58:27 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 03/12] iommu/tegra241-cmdqv: Add a helper to drain
 VCMDQs
Message-ID: <ajAvM5tJ4Ae17Lk8@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601215909.3958732-4-praan@google.com>

On Mon, Jun 01, 2026 at 09:59:00PM +0000, Pranjal Shrivastava wrote:
> The tegra241-cmdqv driver supports vCMDQs which need to be drained
> before suspending the SMMU. The current driver implementation only uses
> VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
> helper that drains all the enabled vCMDQs under VINTF0.
> 
> Add another function ptr to arm_smmu_impl_ops to drain implementation
> specified queues and call it within `arm_smmu_drain_queues`.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  7 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 27 +++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0e77ef1e4523..8682be5060ed 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -915,6 +915,13 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
>  	 */
>  	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
>  
> +	if (ret)
> +		goto out;
> +
> +	/* Drain all implementation-specific queues */
> +	if (smmu->impl_ops && smmu->impl_ops->drain_queues)
> +		ret = smmu->impl_ops->drain_queues(smmu);
> +out:
>  	return ret;
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index c855ab4962ed..24d5e28eea88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -885,6 +885,7 @@ struct arm_smmu_impl_ops {
>  	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
>  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
>  			  const struct iommu_user_data *user_data);
> +	int (*drain_queues)(struct arm_smmu_device *smmu);
>  };
>  
>  /* An SMMUv3 instance */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 67be62a6e764..cb1e75e4ee91 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -414,6 +414,32 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
>  	return &vcmdq->cmdq;
>  }
>  
> +static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
> +{
> +	struct tegra241_cmdqv *cmdqv =
> +		container_of(smmu, struct tegra241_cmdqv, smmu);
> +	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
> +	int ret = 0;
> +	u16 lidx;
> +
> +	/* Kernel only uses VINTF0. Return if it's disabled */
> +	if (!READ_ONCE(vintf->enabled))
> +		return 0;

I am not familiar with this driver, but the READ_ONCE() caught my eye,
I see that’s already what is the existing code is doing, but it is not
clear to me why, it seems to be an attempt to make this path lockless.

However, won’t we need some aquire/release semantics?

For example in tegra241_vintf_hw_deinit() it WRITE_ONCE() cmdq and then
vintf and finally writel() with a write memory barrier.

While in tegra241_cmdqv_drain_vintf0_lvcmdqs() (or in
tegra241_cmdqv_get_cmdq()) it checks READ_ONCE(vintf->enabled) then
READ_ONCE(vcmdq->enabled)

Now it is possible that this executes in any order, due to the lack
of barriers,which means you can see:
Thread#1: READ_ONCE(vintf->enabled) => TRUE
Thread#2: Writes both vintf->enabled and vcmdq->enabled to FALSE
Thread#1: Still sees vcmdq->enabled as TRUE because it was speculated.

Am I missing something?

Thanks,
Mostafa

> +
> +	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
> +		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
> +
> +		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
> +			continue;
> +
> +		ret = arm_smmu_queue_poll_until_empty(smmu, &vcmdq->cmdq.q);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  /* HW Reset Functions */
>  
>  /*
> @@ -845,6 +871,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>  	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
>  	.device_reset = tegra241_cmdqv_hw_reset,
>  	.device_remove = tegra241_cmdqv_remove,
> +	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
>  	/* For user-space use */
>  	.hw_info = tegra241_cmdqv_hw_info,
>  	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
> -- 
> 2.54.0.1013.g208068f2d8-goog
> 
> 
