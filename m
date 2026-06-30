Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056E372067
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825459; cv=none; b=PSEFO7pkO7sF9uLF2OJqqIPxPkRSHtBQSQ74NtSgxSnwKy5u587sYnHQWRouwfCsidRSajKZbMVEKEsMp5NgTekjtE1RokAT9yGfl7LunIoZEpKPgnYJcN2TFhA9ZjypZAYbF6DkflyAjEk/5tsFUN5Ph0ixgB+U8Gje309dDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825459; c=relaxed/simple;
	bh=xJzJE6JcIfh29mENEET4zmI5xlhI0ypkw6NGz/Hgyj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7eUZh/gClwXvqI9TTvoMbakmBs0l0jiCPv3TNn95SXY5KVn9bKxnvo+qZSEuAXXPgNwaiLHgeZFxiJuKx9CoDMdgo25ugxxGVlPyHvn1yQPEwu2VxPpk6ujqgQQygYKAis6htP3PQ3/msKCL8bh+W7rF6Bd2H29jAjrrK9ockI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGZDyetr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGZDyetr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49242f97da7so51355e9.0
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782825455; x=1783430255; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lMFOK57Iz7WMkmkcRIKxg4m8SX0OyWW/vWHhXqpi1uY=;
        b=fGZDyetrNjvysgH7bYQMp/CoByWlNSS33JhVCR4iCuZv5eVbY/PV+qMDP2PwAyJHJJ
         3GkRZywlC9GV8cctCTp7YLYz2+8vDnYmikBmwMfZH2Od1nqbzK2tD5VeqG0J5g8J0eCw
         5dkMyIiTIjAXyWeHsutgETpFyOjaDNzslpOND1JytlhRR60LoUKzfMrXQfEJg/udKa8o
         wH5lPgZd7kAd5ymk5elY7+P05e+iyEcXsVSymBoSulviE06EUgc/ZLIrB59yQgwo7eaK
         Xaos6dNbphvF9jE/CJ5XgyqoPDAzSxiSKKVYIrhIZcWyonKhJ8BW13rkjqSe0kFeJGWl
         s+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782825455; x=1783430255;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMFOK57Iz7WMkmkcRIKxg4m8SX0OyWW/vWHhXqpi1uY=;
        b=Ja2LSgPKQ6dZezqhGBFyGoylVqsayjysZ5FH4MCkmdyv3hvDm02MggJANMdoAfsSEw
         sPGl7/wIXtn6lt8OPJsvPhO2U6ZTbRAMGu9NLn/Svq+uQ4frn3JSa7F+TkPWCbIAXG2G
         z0uOGXuNFurk6iYYlEZ0QxH68sIcUebgiaw6OiQrnCwZ1YpPxYsudIq/rNBDer2EpVOB
         ccbrSY82YDzbZO1QSUBp2HSg5W3S0fznefrKn7eQar1JMOCvqLBQwUmBWbAciIvwdigu
         wRV5T5iHL+zX1NPLqMYUlfUor8AK/isZFfA2WjuPFiihMujCckk6DY5yey57r5uHCLKI
         1cRg==
X-Forwarded-Encrypted: i=1; AFNElJ8xAIed4P0EqOG/ej3KnV5pbP/idxJWrRFVRinFlZiLg9a9HkCEL/oNnlBf2t6uWrpk3Mhqrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYKF7ZYEThQg7FZYwxCBited1tWeWWYfRlYGG7np024IilBDhc
	Yg389CvmNoY5IKva3o2mlp4E/mL7knIKWZxjhzcShk/3jv4kBsLCRJgCJPXXwT5mcg==
X-Gm-Gg: AfdE7cl7sZmrDDlD/ZG6+jk93sCSUL3xwxp5rE4e/j6qzHEnipj+Fp142llrKLFb5QR
	ixcoBIl9Dnj3U/V7VGyr2JMgF/pONicuSzESeYONTPAKTyxi4AGxozbfqwnff+dpvXMOVgGfwob
	7Ggnm0BZmfpAhrAqCB2ZG3UXnaagDVarQ+yqAzXVh1gy6VdAvzhFhNtrPPZfqgdb2mahleubF3N
	tWCBGgnrtkTx5ob1JjkXWIOraJcWtPMO1anc8XNpfkSR80uOEcaHuKGqMOEWDaqJM7b5cd3nZAu
	+jJN3LkQ5v5oglGzXHeRPjWtQy8atvBQaflvfzfrMS3Yc4LB10hiPm2hra6r8d/kdNuXHjTismm
	4dXLNJiGWA2raNey6RlxRoy8SFE/VrXgkvpCjr4KA7Q808/GoqGyjhWF9c6sEl6BNDvFIWi1vMl
	+cAepp17Va8Z6wDt8IqhGEkzv6uhy7v8SlMedNT0MMAs7EkIXGb5U=
X-Received: by 2002:a05:600c:638f:b0:493:ae5f:d29f with SMTP id 5b1f17b1804b1-493bde0d921mr57485e9.3.1782825455000;
        Tue, 30 Jun 2026 06:17:35 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0496csm63329035e9.10.2026.06.30.06.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:17:33 -0700 (PDT)
Date: Tue, 30 Jun 2026 13:17:30 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akPB6l-fuJUcg4a2@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782799827.git.nicolinc@nvidia.com>

On Mon, Jun 29, 2026 at 11:15:33PM -0700, Nicolin Chen wrote:
> When transitioning to a kdump kernel, the primary kernel might have crashed
> while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> and setting the Global Bypass Attribute (GBPA) to ABORT.
> 
> In a kdump scenario, this aggressive reset is highly destructive:
> a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
>    PCIe AER or SErrors that may panic the kdump kernel

Can you please clarify more on those errors, what conditions will
trigger that?
For example, patch 4 disables the EVTQ to avoid events as there might
be a lot, why are they not fatal also?

> b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
>    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> 
> To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> flight DMA using the crashed kernel's page tables until the endpoint device
> drivers probe and quiesce their respective hardware.
> 
> However, the ARM SMMUv3 architecture specification states that updating the
> SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> 
> This leaves a kdump kernel no choice but to adopt the stream table from the
> crashed kernel.

In many cases the patches assume that the CDs/STE might be corrupted,
but still attempt to retrieve them with some validation
(log2size/split...)
However, the base address might be broken, TLBs state is unknown...

IMO, although that might improve the status quo, there are still
heuristics, in addition to noticeable complexity to transition the
stream tables. I wonder if FW can deal with AER in that case before
booting the kdump kernel.

Thanks,
Mostafa

> 
> In this series:
>  - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
>  - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
>  - Skip EVENTQ/PRIQ setup including interrupts and their handlers
>  - Memremap the crashed kernel's stream tables into the kdump kernel [*]
>  - Defer any default domain attachment to retain STEs until device drivers
>    explicitly request it.
> 
> [*] For verification reasons, this series only fixes coherent SMMUs.
> 
> For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
> 3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
> full reset followed by driver-initiated reattach, potentially rejecting any
> in-flight DMA.
> 
> Note that the series requires Jason's work that was merged in v6.12: commit
> 85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
> I have a backported version that is verified with a v6.8 kernel. I can send
> if we see a strong need after this version is accepted.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v7
> 
> Changelog
> v7
>  * Rebase v7.2-rc1
>  * Add Reviewed-by from Pranjal
>  * Reword the linear stream table adoption comment
>  * Use dev_dbg for the stream table adoption message
>  * Document why the lazy L2 adoption uses devm_memremap()
>  * Drop redundant FEAT_COHERENCY checks in the adopt functions
>  * Use feature bit instead of STRTAB_BASE_CFG in adopt cleanup
>  * Skip CR0_ATSCHK update in adopt mode to retain the crashed policy
>  * Restore FEAT_2_LVL_STRTAB if the cleanup action fails to register
> v6
>  https://lore.kernel.org/all/cover.1779265413.git.nicolinc@nvidia.com/
>  * Rebase v7.1-rc3
>  * Add Reviewed-by from Jason
>  * Replace dma_addr_t with phys_addr_t
>  * Drop arm_smmu_kdump_phys_is_corrupted()
>  * Skip threaded IRQ handlers for EVTQ and PRIQ
>  * Bypass arm_smmu_rmr_install_bypass_ste() in kdump case
>  * Drop devm_ for adopt-time allocations; set up cleanup function via
>    devm_add_action_or_reset()
> v5
>  https://lore.kernel.org/all/cover.1778416609.git.nicolinc@nvidia.com/
>  * Add Reviewed-by from Kevin
>  * Drop READ_ONCE on lazy-attach L1 read
>  * Split "Skip EVTQ/PRIQ setup" into two patches
>  * Tighten kdump probe comment and dev_warn message
>  * Use MEM + BUSY in arm_smmu_kdump_phys_is_corrupted
> v4
>  https://lore.kernel.org/all/cover.1777446969.git.nicolinc@nvidia.com/
>  * Rebase v7.1-rc1
>  * s/arm_smmu_adopt/arm_smmu_kdump_adopt
>  * Revert alloc/memremap/fmt on fallback
>  * Reorder patches to avoid bisect regression
>  * Use IRQ_NONE for spurious evtq/priq entries
>  * Cap linear log2size by kdump's allocation bound
>  * Defer clearing FEAT_2_LVL_STRTAB on linear adopt
>  * Add arm_smmu_kdump_phys_is_corrupted() validation
>  * Defer l2 stream table memremap till master inserts
>  * Re-validate L1 desc on master insert with READ_ONCE
> v3
>  https://lore.kernel.org/all/cover.1777150307.git.nicolinc@nvidia.com/
>  * s/OPT_KDUMP/OPT_KDUMP_ADOPT
>  * Do not adopt if GERROR_SFM_ERR
>  * Retain CR0_ATSCHK beside CR0_SMMUEN
>  * Clear latched GERROR bits (e.g. CMDQ_ERR)
>  * Assert ARM_SMMU_FEAT_COHERENCY in adopt functions
>  * Add STE.Cfg check in arm_smmu_is_attach_deferred()
>  * Fix validations on return codes from devm_memremap()
>  * Sanitize crashed kernel register values in adopt functions
>  * Drop unnecessary l2ptrs guard in arm_smmu_is_attach_deferred()
>  * Don't enable PRIQ/EVTQ irqs and guard the irq functions for combined
>    irq cases
> v2
>  https://lore.kernel.org/all/cover.1776286352.git.nicolinc@nvidia.com/
>  * Add warning in non-coherent SMMU cases
>  * Keep eventq/priq disabled vs. enabling-and-disabling-later
>  * Check KDUMP option in the beginning of arm_smmu_device_reset()
>  * Validate STRTAB format matches HW capability instead of forcing flags
> v1:
>  https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/
> 
> Nicolin Chen (7):
>   iommu/arm-smmu-v3: Add arm_smmu_kdump_adopt_strtab() for kdump
>   iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
>   iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
>   iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
>   iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
>   iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
>   iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 467 ++++++++++++++++++--
>  2 files changed, 422 insertions(+), 46 deletions(-)
> 
> -- 
> 2.43.0
> 
