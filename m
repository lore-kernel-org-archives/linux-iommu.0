Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45379403142
	for <iommu@lists.linux.dev>; Mon,  3 Aug 2026 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756883; cv=none; b=VhH/cRykn9WS/pXfSCknr/BlY7u35lJmXRTDGQQ2REyJvQVKvjAlCvsJeEiSpSpVRW9cVzG1A2UF/hOIs+AXlW1G0LpLXLt+ueqT/bS2dfIS5bfV131+xNFj1hGC0VhSpKLkO3ihWlGGK11DL+qA+4KayZHrtflKp8W/sDQ7UoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756883; c=relaxed/simple;
	bh=hvUjH62FMs4eWRYreksi0y6ODe1YRla6sWjuNOUTH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlBtydyLPZd0hy6FW8jZbUh3b8TjEsHOz9lWMcmEX+2NInrRUDGQbkuG+KxQoudgwEVjiGU1p+EyixsAKMgbEFvYMmc0UEVQlJBINRIbA4a5MtgNAB9rHRDFaBZcMZXbto3dHgyIc4gzqeXVZ5mnAkE9xnId3iC5XPOX+TkSF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcFka6aR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcFka6aR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdf36f63dso130365ad.0
        for <iommu@lists.linux.dev>; Mon, 03 Aug 2026 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785756881; x=1786361681; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wni3Q+wShyY65f0uKlTNx2h4S9tj48PjL0JpbjcW/Q=;
        b=UcFka6aRoK4/3fv1HL8HhAydIKDX717d2D+2YXfwhuSLXJNlfSXvR22ZefzFxLsoVV
         QpeZ8FRvJ4trjkZndi2D9ZGPC6l1YQl9okrvKQ37oFqUkKQFZdGCx9jfJY6uMFkAZsrd
         3xCvLy1+zSynIo0vzbIYpzPjtTNdpSvmlLZIAPdjj4DfYSMO5c6Pg/P6A75WlSDMK4ln
         hSs+EuVE7U1uxoxlDTRTKIIdJGt6wJ4jLZIr5kn+nC/8X4F/gIr19bPIROXAZLfzFbJu
         rK9onC+saoQ+uC2On48BglMUc+w7jrEUBWa4KlOiQIElVg5JHunRnn1vp67sb8VNcjnz
         VRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756881; x=1786361681;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wni3Q+wShyY65f0uKlTNx2h4S9tj48PjL0JpbjcW/Q=;
        b=UWmCBCQjAK5lS5za0NBr24b5+WXuHXVNFOhUJIP4IsAEQzKf+w14SJCYHxCVMLgpgk
         f9XQYYFOy8sivfJe8zU7NCM24Y31U1M2oqDpedeNMyl5LBZvrfpvf2sZqJkGO1FFh0bK
         4gc0aI7XoUm7tFXncnxwxHQhBBFG0PLWBQOyyUicBOL2R5lLLA+4Epil/dsjbELj9JEM
         6IeW2H+b6ptCpG8b+hhd/JUxuqj945Ps0X0OpauW42/A0dTBMk6PveqEQ4b3pUo1fHe9
         b7X/121iG4Hbp4b86FiRVD1iWy0adPqv48AkQipxofF20V1e/ejcgSrNN5DrcAr4qcDB
         GCkg==
X-Forwarded-Encrypted: i=1; AHgh+RqvOsTrRIxUJATltpgOEi5B0p6VxWj2ktYLBFgjjvV0XiygMrmDkM0rO2BU3T7QdIJ/083ZTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiZf7DP+zBJHK1Csod8mSEwuDNHZi/VEjoJwvQktJY2CDRbMbZ
	dm+2OTaO4Uf3UzE9QMTwA5qFgM4cSDAGdGObMmO58+nn5mySVkg4fTGG4gz3e1mNVw==
X-Gm-Gg: AR+sD135T14QpLcvDrb0SrFdwpQ3eEjdwMZ8TKdjRVZvE1vQdd32vRirsatHDX+Jhvj
	lvt5vwe9SYa8LrP5cPiDvi1coQxAFZYxW05Od6BKjqh0gcJUoPrq1pM9nUcXWv+JsXzM5VfRAsy
	g1loVOU3uTE+4qx7wScp3+JS7ewPMgObNpGVQ9xP60/qTJemlIhLaFJ6sxsyjSXOMYmhCBTfyFB
	yO9zzs/FZ85rK1KkHXAVj1C9XDsT9ZbzBFwYPiWkt6g3ptQVy2OzgXm0nhg/KX0MWC9NQ4IVucD
	BWoJFtHNibZ/2J4kw75JYDnN622IwgO9YEMbrEYa4pTxlTM081BpTIL/13CKNYvYkQaq5LSeAkA
	YoBAXQ1ZahWZy+7vyX85KUbGTMEla8zJAqKCyFQ4kuZXlD4ONxuY+XaOxhxRUteobY2ZAguUeIi
	dSX/lZM0HXapxr1ono6t8fMRl+DR+rWy78n5OS0tm+zEjWABK9W/as9+MBnAfuHrCYYebMdeyRo
	FDP1AiJueDJ+3AYGXLzFBc=
X-Received: by 2002:a17:903:1aec:b0:2ca:cbe5:c3af with SMTP id d9443c01a7336-2d056f884a0mr11365075ad.7.1785756880556;
        Mon, 03 Aug 2026 04:34:40 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae67d0esm36522585ad.30.2026.08.03.04.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:34:40 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:34:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH v3] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <anB8ydWLQw0KZxqT@google.com>
References: <20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com>

On Tue, Jun 30, 2026 at 02:32:46PM +0530, Prakash Gupta wrote:

Hi Prakash, 

On a second thought, I'd like to discuss one more thing

> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
> sits in a power domain, all register accesses must be done while the
> device is runtime active to avoid unclocked register reads and
> potential NoC errors.
> 
> So far, this has not been an issue for most SMMU clients because
> stall-on-fault is enabled by default. While a translation fault is
> being handled, the SMMU stalls further translations for that context
> bank, so the fault handler would not race with a powered-down SMMU.
> 
> Adreno SMMU now disables stall-on-fault in the presence of fault
> storms to avoid saturating SMMU resources and hanging the GMU. With
> stall-on-fault disabled, the SMMU can generate faults while its power
> domain may no longer be enabled, which makes unclocked accesses to
> fault-status registers in the SMMU fault handlers possible.
> 
> Guard the context and global fault handlers with
> arm_smmu_rpm_get_if_active() and arm_smmu_rpm_put() so that all SMMU
> fault register accesses are done with the SMMU powered. If the SMMU is
> not runtime active, the fault can be safely ignored as
> arm_smmu_device_reset() clears fault registers on resume.
> 
> Additionally, disable fault reporting in arm_smmu_runtime_suspend()
> before powering down. pm_runtime_get_if_active() returns 0 during
> RPM_SUSPENDING, so without this, level-triggered fault interrupts would
> cause an interrupt storm while the device is being suspended.
> arm_smmu_device_reset() re-enables fault reporting on resume.
> 
> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> @@ -2306,6 +2329,25 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)

[...]

I believe, there is a small race condition in the suspend path that can
lead to unclocked register access crashes. (Something similar to what
I've attempted to handle in arm-smmu-v3 [1])

In arm_smmu_runtime_suspend(), we disable interrupt reporting in sCR0 and
SCTLR, and then immediately call clk_bulk_disable(). This disables the
interrupt generation but what about the interrupt handlers running
*during* suspend? I believe we could have this race:

CPU 0 (Suspend Context)                    CPU 1 (Interrupt/ISR Context)
-----------------------                    -----------------------------
                                        1. arm_smmu_context_fault() starts.
                                        2. rpm_get_if_active() returns 1.
                                           (Clocks are ON)
3. arm_smmu_runtime_suspend()
   - Clears CFIE/GFIE in registers
     (stops new IRQs from firing)
4. clk_bulk_disable()
   (Clocks are CUT)
                                        5. Attempts MMIO access (e.g, to
                                           clear CB_FSR or CB_RESUME).
                                           --> [CRASH] Unclocked MMIO access

I believe similar to arm-smmu-v3 [1], we must call synchronize_irq()
on context interrupts after disabling them in the SCTLR but before
we cut the clocks. This forces CPU 0's suspend thread to sleep and wait
for any active ISRs to safely drain while the SMMU still has clocks.

We can simply add this loop to arm_smmu_runtime_suspend():

>  static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>  {
>  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	int i;
> +	u32 reg;
> +
> +	/*
> +	 * Disable fault reporting before powering down to prevent unclocked
> +	 * register accesses in the fault handlers if an interrupt races with
> +	 * the suspend callback (e.g. device in RPM_SUSPENDING state).
> +	 * arm_smmu_device_reset() re-enables fault reporting on resume.
> +	 */
> +	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +	reg &= ~(ARM_SMMU_sCR0_GFRE | ARM_SMMU_sCR0_GFIE |
> +		 ARM_SMMU_sCR0_GCFGFRE | ARM_SMMU_sCR0_GCFGFIE);
> +	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
> +
> +	for (i = 0; i < smmu->num_context_banks; i++) {
> +		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_SCTLR);
> +		reg &= ~(ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE);
> +		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_SCTLR, reg);
> +	}

    for (i = 0; i < smmu->num_context_irqs; i++)
        synchronize_irq(smmu->irqs[i]);

>  
>  	clk_bulk_disable(smmu->num_clks, smmu->clks);
>  

Since we're disabling those interrupts and fixing concurrency, 
this seems like the perfect opportunity to add the sync_irq too..

What do you think?

With that loop added:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260728210928.1050849-10-praan@google.com/

