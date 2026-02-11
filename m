Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B119E819
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816845; cv=none; b=WJtPrsJGRQPBklEeblu8DHM4F6d9Rax+JZEjaLnDIoB2gltOA/gRGLg8a6Erqpbi36n2DHGXNuyl/VnvEg05ks1xn20UPC8WMywOFsC9Wj8dCJvDih0Vd38SByZZ17W3rYbr9pjnvAzSvc+DEWZPwh4DJ1GA8vRqqAF6odlgPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816845; c=relaxed/simple;
	bh=rmNvQT2QG7gG48+T4V+IGfOdF4/NtEXv28tfbs7HCU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH58x47VG4olSUbgaHolpoQ8oDzeHtxcTLJTJ7q6FaDoaTiS5NhPZsENaay6GN7KmsbABzNuLgYPEvDreLjSOXMCQ3V51QM0MATEApiHAHluLFj/uwZSOl+ivCfAun4G6HPuG1GSZPMI4Atz2jI5mwISYtQyJAPyURCAGPXaUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+qos58o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+qos58o"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a964077671so75935ad.0
        for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770816843; x=1771421643; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MpH4N8jYjyoMkqt5JqaZ+3caBW09Fyf22uQvva/iOM=;
        b=e+qos58oV9ArST0wrnPQBS8erKC9uYg7L4t/uzgxCXRU9gDlaqN4aj56eDMiIhppLY
         RH9GFSzmuJcBkNERAQMNke4wC+iDpOMzN5uxtKFu1djx3xJrk2m+D9UT0PWsVpBeOZbt
         aEPKM4/Kkp9nLV21zTG3Q6OHvxEbbHyjSSYYlbp+ysaq9AmZ/NdqQytmZm9zTfGNoLbE
         MEwR6tIuyOTvFInloyaRIdx0sag5BRIia+zb8UwMfYweDS9zpvmzrCk6DyGLa/7ipxeT
         SmvkQmPbQwCZmkXU+s9qc4g8kAGO1Fcm+4PeljaCOkawLuJ0ZALj41CgwaCjNWCSbhBT
         M03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770816843; x=1771421643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MpH4N8jYjyoMkqt5JqaZ+3caBW09Fyf22uQvva/iOM=;
        b=RJEPkax/NCiFd0qvmlsi1FXGULVYysnXxSm7aGyeag0dcuchohYEGWguSeVPMK4xKE
         Qd5MNjgr9D3wK1gPeRUwQicWfb/zL5izuEIRIKgjGEDOkvu5pXiPLKRbjTKg405Px6m8
         DnSw2SUf/FFTcoPX/AOZqKG7J9lNngQjIVlAJvgtGyhVMV8hIuWWDlcDOXEDSVnTl///
         KZ2m3i29LA/6fTpFfYfD5rNwewrO5vDx8s0yBWgr8R66+5JEZJEIHllJEnBZ3BG+YOI2
         OGAExia1ElVYsCEuEaaA740eoekCeoKYyC1RGxUJ4bDLZwn2R/gnTnnMjsCv/qWVeL4P
         lBNw==
X-Gm-Message-State: AOJu0YwvQpFfKqSgQpYedJYjGp9GHQb3PJfWXHnY5mZAc0WWckQ8CCOc
	HgBWdyxTMqpN0nEM/+QLwOtU7Z4z4DfvptRuSzJQeIBi2Vv2JUHKgeNhK3+tmz0mqPS+3uRSjPe
	ZJAFJqA==
X-Gm-Gg: AZuq6aJRwGh3XiAoP3MwCxfE0f9EgkLLrFC4WNaGr8o/QibwIm3VNiDLDRHsWUDfRMB
	rd1x3lImhacYNwoEEZjfztNyhz3ylgCdjhnVMsL1gNN8lJHGEPvKKxc0TZF/kHmxLLm4Kmnioz1
	DSvm0SqeCpZT/VJop6hPP5Fn1iHlsPsBtRQ9vJvVA1cs/W71xA8vGzvvPy4Eab2fDcsiB5jW20F
	kCj887qPcpfm7FgaVWEF/HQ6fchVUvqnYO/8SdDWJNx8wlCMEDPoP12X0wLPAhT0TN/sYX8M2UA
	bhmiHn1Mrao3fhPutcufs1r6FsxmYHv/5knKkkFEnJ31d9j/8NVt8foPtsrtIsQeOSdvJUnx+2h
	LBNdnfwNM6JUDleRPQM50gIOi6vkPVX6E34FN6bLuKIRGIpeST+OPuL/tLhfIxzSfxt7kanptxd
	u9cbiEPjeBAsIY/48SGp4+utVHQN4Umd+Nt0DfMFCZq3MAegKIxz/ubz0bM4ze
X-Received: by 2002:a17:903:1b46:b0:299:c368:6b1f with SMTP id d9443c01a7336-2ab28250f85mr3213795ad.18.1770816842752;
        Wed, 11 Feb 2026 05:34:02 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e816fbbsm2073200b3a.49.2026.02.11.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 05:34:02 -0800 (PST)
Date: Wed, 11 Feb 2026 13:33:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 00/10] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <aYyFRa4ZtQGlNQ2t@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <5a69ec64-87ed-4b62-97c1-94ddd4ae1553@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a69ec64-87ed-4b62-97c1-94ddd4ae1553@nvidia.com>

On Fri, Feb 06, 2026 at 09:18:06PM +0530, Ashish Mhetre wrote:
> 
> 
> On 1/26/2026 8:41 PM, Pranjal Shrivastava wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
> > devices, power management capabilities, similar to its predecessors, are
> > crucial for these applications. This series introduces power management
> > support for the arm-smmu-v3 driver.
> > 
> > Design
> > =======
> > The arm-smmu-v3 primarily operates with in-memory data structures
> > through HW registers pointing to these data structures. The proposed design
> > makes use of this fact for implementing suspend and resume ops, centered
> > around a driver-specific biased usage counter.
> > 
> > 1. Biased Usage Counter
> > To safely manage runtime PM state, this series introduces an atomic
> > `nr_cmdq_users` counter. This counter is "biased" by being initialized to
> > 1, representing an "idle but active" state.
> > 
> > The suspend callback waits for this counter to be exactly 1 and then
> > atomically transitions it to 0, signifying a "suspended" state. Any
> > other value indicates that the command queue is in use, and the suspend
> > operation is aborted.
> > 
> > Code paths that submit commands to the hardware (the "fast path") use
> > `atomic_inc_not_zero()` to acquire a reference. This operation only
> > succeeds if the counter is not zero (i.e., not suspended), effectively
> > gating hardware access. The reference is dropped using
> > `atomic_dec_return_release()` after the hardware interaction is
> > complete.
> > 
> > 2. Suspend / Resume Flow
> > The "suspend" op now polls for a short period (100us) for the usage
> > counter to become 1. Once successful, it configures the GBPA register
> > to abort new transactions and disables the SMMU, EVTQ, and PRIQ, leaving
> > only the CMDQ enabled to drain any in-flight commands.
> > 
> > The "resume" operation uses the `arm_smmu_device_reset` function, which
> > re-initializes the HW using the SW-copies maintained by the driver
> > (e.g., prod/cons pointers, queue base addresses) and clears all cached
> > configurations.
> > 
> > 3. Guarding Hardware Access
> > Instead of eliding operations, the driver now ensures the SMMU is active
> > before any hardware access. This is managed by `arm_smmu_rpm_get()` and
> > `arm_smmu_rpm_put()` helpers, which wrap the standard runtime PM calls.
> > These wrappers are now used throughout the driver in interrupt handlers,
> > TLB invalidation paths, and any other function that touches hardware
> > registers. This ensures that operations are implicitly queued until the
> > device resumes.
> > 
> > 4. Interrupt Re-config
> > a. Wired irqs: The series refactors the `arm_smmu_setup_irqs` to be
> > able to enable/disable irqs and install their handlers separately to
> > help with the re-initialization of the interrupts correctly.
> > 
> > b. MSIs: The series relies on caching the `msi_msg` and retrieving it
> > through a newly introduced helper `arm_smmu_resume_msis()` which
> > re-configures the *_IRQ_CFGn registers by writing back the cached msi_msg.
> > 
> > Call for review
> > Any insights/comments on the proposed changes are appreciated,
> > especially in areas related to locking, atomic contexts, and potential
> > optimizations.
> > 
> > Note: The series isn't tested with MSIs and is weakly tested for PCIe
> > clients. The same holds true for tegra241_cmdv changes. Any help in
> > reviewing and testing these parts is much appreciated.
> > 
> > [v5]
> >   - Refactored GERROR handling into a helper function and invoked it during
> >     runtime suspend after disabling the SMMU to capture any late-breaking
> >     gerrors as suggested by Jason.
> >   - Updated `arm_smmu_page_response` to be power-state aware and drop
> >     page faults received while suspended.
> >   - Included a patch from Ashish to correctly restore PROD and CONS
> >     indices for tegra241-cmdqv after a hardware reset.
> >   - Collected Reviewed-bys from Mostafa and Nicolin.
> > 
> > [v4]
> >   - https://lore.kernel.org/all/20251117191433.3360130-1-praan@google.com/
> >   - Dropped the `pm_runtime_get_if_not_suspended()` API in favor of a
> >     simpler, driver-specific biased counter (`nr_cmdq_users`) to manage
> >     runtime PM state.
> >   - Reworked the suspend callback to poll on the biased counter before
> >     disabling the SMMU.
> >   - Addressed comments for the MSI refactor.
> > 
> > [v3]
> >   - https://lore.kernel.org/all/20250616203149.2649118-1-praan@google.com/
> >   - Introduced `pm_runtime_get_if_not_suspended` API to avoid races due
> >     to bouncing RPM states while eliding TLBIs as pointed out by Daniel.
> >   - Addressed Nicolin's comments regarding msi_resume and CMDQV flush
> >   - Addressed Daniel's comments about CMDQ locking and draining
> >   - Addressed issues related to draining the evtq and priq
> >   - Dropped the code to identify and track user-space attachments
> > 
> > [v2]
> >   - https://lore.kernel.org/all/20250418233409.3926715-1-praan@google.com/
> >   - Introduced `arm_smmu_rpm_get_if_active` for eliding TLBIs & CFGIs
> >   - Updated the rpm helper invocation strategy.
> >   - Drained all queues in suspend callback (including tegra241-cmdv)
> >   - Cache and restore msi_msg instead of free-ing realloc-ing on resume
> >   - Added support to identify and track user-space attachments
> >   - Fixed the setup_irqs as per Nicolin & Mostafa's suggestions
> >   - Used force_runtime_suspend/resume instead as per Mostafa's suggestion.
> >   - Added "Reviewed-by" line from Mostafa on an unchanged patch
> > 
> > [v1]
> >   - https://lore.kernel.org/all/20250319004254.2547950-1-praan@google.com/
> > 
> > Ashish Mhetre (1):
> >    iommu/tegra241-cmdqv: Restore PROD and CONS after resume
> > 
> > Pranjal Shrivastava (9):
> >    iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
> >    iommu/arm-smmu-v3: Add a helper to drain cmd queues
> >    iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
> >    iommu/arm-smmu-v3: Cache and restore MSI config
> >    iommu/arm-smmu-v3: Add a usage counter for cmdq
> >    iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
> >    iommu/arm-smmu-v3: Handle gerror during suspend
> >    iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
> >    iommu/arm-smmu-v3: Invoke pm_runtime before hw access
> > 
> >   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  10 +-
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 429 ++++++++++++++++--
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  13 +
> >   .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  29 ++
> >   4 files changed, 445 insertions(+), 36 deletions(-)
> > 
> > --
> > 2.52.0.457.g6b5491de43-goog
> > 
> 
> Hi Pranjal,
> 
> I have pulled this series and tested on Tegra264 with CMDQV enabled
> and 16 vcmdqs assigned to guest. I ran multiple iterations of system
> suspend and resume with each iteration following by SMMU tests for
> multiple client devices. Everything worked as expected and tests
> were passing.
> 
> Tested-by: Ashish Mhetre <amhetre@nvidia.com>
> 

Thanks a lot for helping test this, Ashish, especially on Tegra CMDQV!

Regards,
Praan
