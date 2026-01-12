Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A433F8D8
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207834; cv=none; b=rMlMfIWnt5meRnp4I0TbJ78ysbym0UHXE5/G95IDmArMjEURj9j4xKjrzt/WB7rVjf8pZysISoo0brJ+dRz74Bu/Yh/QcbxjODOj49nCImpVSvP6wa//7KyG6twvAzyuskN6qdJrcSUSdMYAuLh23hJtWSKceTgy0WLA2u9WedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207834; c=relaxed/simple;
	bh=KBh2VGMiAKoBEPh7WK/cCTQYLo60PWasLr0KpPGdRng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhT52jeoE33rdzIKwi4E0AbalLlHbxXzL/iyfc7IzUH+tv49KoDBX5K9R1MxkO11GhHhNtNhRoNYOgKxzXvFZYwA5WixYbHulwE9xNyFdBqJ69j7+FNIyO9IJnQdDk6GYp24IlIkCOvKM9tl1nhpiZyuQCGGACWaTwuNJvE8jcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxVtMO9e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxVtMO9e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a35ae38bdfso108525ad.1
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768207833; x=1768812633; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6icVsS/JOfLDbhb/eh2kauTNT3pE3BapoikbmqDP82M=;
        b=FxVtMO9eIrwL7z4fPlLZcicV4VKYGCo1C2LV/fHeJ9/UUHIUl4R4E4T4EOTS74hu+1
         9esfxfQEqZ7feE/ie2/pPKswR5anzQ6NtkCOQ4+xvO8HulTEVEh8GhOsurU6X145tCQw
         fqFWV0iQQh9RXM0uvgsGjaNLIUZsMmAI1vJBgA58J8uC2s4GFm46fo9FockssU2z+1RK
         soLKl1Qv3brwX1mdPKi0R9m8/P17YRR9aJrZBNF74rfSF30n3DnPbPjX9gX7hJpZ+6X6
         nSBWgXJ+XV6fefdaVGEuk9R6eSw8EaL+Rs6lUg26qqazCIhwubWxiHgM2qhpA6Sb44IK
         dokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207833; x=1768812633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6icVsS/JOfLDbhb/eh2kauTNT3pE3BapoikbmqDP82M=;
        b=DqQnm4yGiuHew1RRWCgY0afYriMLq+Fw9OTec2GJ+v/LTmQnWBFdpBbcy3aC/2N6g+
         KhO+Oz+miNf3M92kK07J/MQP2OxCJ72Hq8aJALi4dwA86T/JdQk8Y0aISBwe71rJfjB/
         TuZj64jRkK/9zN0amKOGLRhcadPmQPRGlTWj8B6rc8rRIrc02vAQa3deRYCxp0A9AvjP
         MBTIoSGUxvKK/E3ztAFjLX4R2ADMl809JN+wgf3I9MJeuvCR0zxAm7Bw8ql75SigASzE
         4mRcQ74Jjk3CHc4IWx0n/oyNAz/o7lELoZ0AXUx1uq8ZMqrkBMxSpWfWnNN9h/48X2ne
         XM1Q==
X-Gm-Message-State: AOJu0Yw0jHm1rAz6XWU5U5xzd55swcLCzWlXGqFJ9UREWCWb20kvEnhP
	LpnGP52oSsIiVVbSQX5P0ctfkZ3uC7rS9WEeTtlzuxeq2EJSptCLxJD40lZ2KvRAPQ==
X-Gm-Gg: AY/fxX7OskBgC9r+qndbeX3h2U6a45FNHNfZ39z3w//h20ZwIowHdGIwWSEYE1lD9NM
	I4aHqTxP/ypNa5U82zQUbZtuvxNKDFZRH7XdTdFp9lHEHUf7GvMhBCk+H7B5TjqOR0TuGgyiT+i
	ByELw+wmr5CbjJCoRQAYU+ZuSoC23qt8b0ydMjTiQTzAJXaQLxXe8UIXLzc98FmIjkE3Y/DQB+r
	8sp1E+VNL8LLNtbNeDux2hHqVIG6G0yQNFulM30gsuLPk0zdLNrjyijpgfpVfvYELx0RXqpfqD3
	3rc7j5+2exXHMwDcA4phwQuPvRs2D0rDZNjhiBssxbIv/r00BRCBQ78hl0EFL/xDn9ZFrExio4W
	CmBLKRYo2TUww11vUqu5z8KIBU8YJJMbkY4/+auijgjsUbfhlBJ2ZQBHBi9NKyu1sGMHYgh289L
	hPL8+oPioEEzwPrCbk8rEkNO1zw4lcp5NhsluTyiGiFnsCtmPF
X-Received: by 2002:a17:903:11c6:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2a4155c374amr3313995ad.7.1768207832163;
        Mon, 12 Jan 2026 00:50:32 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52fc9bdsm17014276b3a.32.2026.01.12.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:50:31 -0800 (PST)
Date: Mon, 12 Jan 2026 08:50:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: iommu@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, amhetre@nvidia.com
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <aWS10XTF20qqvnBf@google.com>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-7-praan@google.com>
 <6afc3e46-489e-4741-96d5-8a2f72a8b431@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6afc3e46-489e-4741-96d5-8a2f72a8b431@nvidia.com>

On Wed, Dec 24, 2025 at 01:09:32PM +0530, Ashish Mhetre wrote:
> 
> 
> On 11/18/2025 12:44 AM, Pranjal Shrivastava wrote:
> > Implement pm_runtime and system sleep ops for arm-smmu-v3.
> > 
> > The suspend callback configures the SMMU to abort new transactions,
> > disables the main translation unit and then drains the command queue
> > to ensure completion of any in-flight commands.
> > 
> > The resume callback restores the MSI configuration and performs a full
> > device reset via `arm_smmu_device_reset` to bring the SMMU back to an
> > operational state. The MSIs are cached during the msi_write and are
> > restored during the resume operation by using the helper.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++++
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   3 +
> >   2 files changed, 112 insertions(+)
> > 
> 
> Hi Pranjal, Nic,
> 
> I tested these patches on Tegra264 with CMDQV enabled and 16 vcmdqs
> assigned to guest. I found an issue in resume path of CMDQV.
> In tegra241_cmdqv_hw_reset() function, the PROD and CONS pointers for
> VCMDQs are being set to 0 on resume. Because of this, commands from
> VCMDQs we not being consumed post resume and I got CMD_SYNC timeouts.
> We need to restore the prod and cons indices for VCMDQs on resume.
> This is similar to what is done for SMMU's physical CMDQ.

Hi Ashish,

Thanks for testing this with Tegra, I'll include this patch for CMDQV.

> Also, current implementation uses pm_runtime_force_suspend/resume()
> which requires runtime PM to be enabled, but runtime PM is only enabled
> when dev->pm_domain exists. I had to use dedicated system sleep callbacks
> that directly call arm_smmu_runtime_suspend/resume(), bypassing the runtime
> PM dependency to get suspend/resume working on Tegra264.
> 

Thanks for pointing this out, I'll revert to the approach I had in v1:
https://lore.kernel.org/all/20250319004254.2547950-4-praan@google.com/

> I got it working by making following changes on top of your series and
> validated that after resume all commands are being consumed and SMMU clients
> are working fine:
> 
> 
> From 8ead50a7e2fbdfa30fbe2c927c47a440b447c864 Mon Sep 17 00:00:00 2001
> From: Ashish Mhetre<amhetre@nvidia.com>
> Date: Tue, 23 Dec 2025 08:42:31 +0000
> Subject: [PATCH] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
> X-NVConfidentiality: public
> 
> PROD and CONS indices for vcmdqs are getting set to 0 after resume.
> Because of this the vcmdq is not consuming commands after resume.
> Fix this by restoring PROD and CONS indices after resume from
> saved pointers.
> 
> Signed-off-by: Ashish Mhetre<amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 378104cd395e..00ec684fe3a4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -483,6 +483,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
> 
>         /* Configure and enable VCMDQ */
>         writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> +       writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
> +       writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
> 
>         ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
>         if (ret) {
> --
> 2.25.1
> 
> From 51a11812bb40d341e11233129a01ce248957bd25 Mon Sep 17 00:00:00 2001
> From: Ashish Mhetre <amhetre@nvidia.com>
> Date: Tue, 23 Dec 2025 09:30:04 +0000
> Subject: [PATCH] iommu/arm-smmu-v3: Fix system suspend/resume when runtime
> PM
>  is not enabled
> X-NVConfidentiality: public The current implementation uses
> pm_runtime_force_suspend() and
> pm_runtime_force_resume() as system sleep callbacks. These generic PM
> helpers are designed to bridge runtime PM with system sleep by forcing
> the device through the runtime PM path.
> However, these helpers only work correctly when runtime PM is enabled
> for the device. In arm_smmu_device_probe(), runtime PM is conditionally
> enabled:
>     if (dev->pm_domain) {
>         pm_runtime_set_active(dev);
>         pm_runtime_enable(dev);
>     }
> On platforms where the SMMU does not have an associated power domain,
> pm_runtime_enable() is never called. As a result, when the system
> enters suspend, pm_runtime_force_suspend() effectively becomes a
> no-op, it does not invoke arm_smmu_runtime_suspend(), leaving the
> SMMU hardware in an undefined state during system sleep. Fix this by
> introducing dedicated system sleep callbacks
> (arm_smmu_pm_suspend/resume) that directly invoke the existing runtime
> suspend/resume functions. This ensures the SMMU is properly suspended
> and resumed during system sleep, regardless of whether runtime PM is
> enabled.
> The pm_runtime_suspended() check ensures we don't double-suspend the
> device if it was already suspended via runtime PM during normal
> operation. Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b1c9c733ed8d..4707adc63d86 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5180,9 +5180,35 @@ static int __maybe_unused
> arm_smmu_runtime_resume(struct device *dev)
>         return ret;
>  }
> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +
> +       return arm_smmu_runtime_resume(dev);
> +}
> +
> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +
> +       return arm_smmu_runtime_suspend(dev);
> +}
> +
>  static const struct dev_pm_ops arm_smmu_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend,
> +                               arm_smmu_pm_resume)
>         SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
>                            arm_smmu_runtime_resume, NULL)
>  };
> --
> 2.25.1
> 
> 
> 
> 
> Please see if these changes make sense and squash to the series if they do.
> 

I'll include the CMDQV patch from you as is in my next version and 
revert to use the SLEEP_PM_OPS as in my v1. It'd be nice to have the
`Tested-by` from you for the next version too!

Thanks!
Praan
