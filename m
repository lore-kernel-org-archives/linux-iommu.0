Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC8367B76
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324614; cv=none; b=Virtn7N3GxU0ULjg7gSEffaBFjUWSlsZST+jAdY3btwCN81K6gpa0gYf8fPtzB9JXoOhAnawracesmO2jmynaVX8J2hXHYpFMpwPW5MdGwfkQPsAZ7owppLTkr/bTLFr7FnZYC9Qfq4+RTNQ7GWrOhm+HCCubCe+QXHx+Q6KCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324614; c=relaxed/simple;
	bh=hnpcUpkk///hUDHKjCL3LkQz9YwT/XI/fDVujSOOcRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpMBFMnMOfFDwh7CS1Amq0HOcRBVcuSm3hFhTPoSaFaxMdceclhC2k4a+z5Y5iCDTOU9TfwmvtpQ904riI5Ma76/lutBu+IICDbJk6mseKdXlEhrWAzUSTgtAXPLtlALN7PJ9TpO4gj4w72v3Maw/BLIYlpq1RvHLpJrtrW0Kz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blPDLjut; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blPDLjut"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacef7d299so223195ad.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784324612; x=1784929412; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IOoEkiQgKR8GN4dBbuTr1zjhYxhyxaeDiS2y4HIEAzc=;
        b=blPDLjutyaLv++s5jtV0qTvhIRoQr8DAPqVFIbmPxQSmay2mgpj4uEm7a9i0skdJB/
         uFTdtfPUMXdtbGhxEPUqcz7HoF3LMZzq1zfYhoBVoPJemz8Hi7gp4j1B8dZI41y1/JLc
         7FG9KKVha1XutHfU/QeqxmZBUra37AG0jblkge20lmkjYBg1yvGzNqUgbe34Wh1WTv83
         moOUy4fwWq/AVMuCjwLq1WEN2iBqxAF2y0zfd6/wM0rsgGaJZGlsDGmcI34BVpmGBm8Z
         o9ubI5G25QhCyPJiPugXHM3DRZiepGItMmo8BQcXUg7+aRR/u8N1ykUAe67aw6WKJmVB
         W0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324612; x=1784929412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOoEkiQgKR8GN4dBbuTr1zjhYxhyxaeDiS2y4HIEAzc=;
        b=pQt/OzIMbdEZwhynw3ugo45ILID0KDBIOd3ohh7VH53fF47b5XjlW5OOZ8p1VPMMv+
         PcnluA4DNMNxA4mMsgwhxabkZZYzg/1Pq007Un6HR0ND+V8K9yEbsvvWkQ//pgrT3Qtj
         LYHx2LLeeDWk2s2w/HUBoTiVQfUld90tc1jOUFkbiO3bGhOj+/S5xzBiUCk882WBrWai
         Ro5SSffpSnid287I43TpMgKey9jZfQC8eEMCNL3Hn4Bd5kzZtgRoFSUNXE/45CbnN+BO
         cS0k411UXUXov6sw/NQDEcaDhn4xDO1SpGkS0iPP6rG82QiRc45TKvNmR2lnCpc1jkVh
         Mm4A==
X-Forwarded-Encrypted: i=1; AHgh+RoFXAAi0A3jfIEIUrwHfP9LzLm1XjE+OXjdqKXdWYrVybiAgvecf6EXtbp0BSBQiMQxi6K0Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN2oGLtxAnIOREyuvu0ulb2vAbKK6df2jIsK+BmPnXUpjC1GPm
	PpFQBeswT2GVEGpKARkcFwh05d0yCkTHf2arS8XLVqqzWMCt7P5s9JW/WHF995KVBQ==
X-Gm-Gg: AfdE7clmnyrC4yYnbWLsWLXRhnccWj+eHOhnSXlhQbaqDVLYSib5X9AkG7M+88jByHQ
	K0cpLIFy8ab52O2aRHVIO4q/LrYMFzmRymUkyIO7qqTKMHzGFmqFWFGwRXX1VpvuRSv9QT1F+/6
	cFktmO09NoWck39h2ucvPa93E33qndM4eAQ/R6futPt1wfCtwl3YUrVph4bH07TdWJK5LcDfZ/X
	1+9yAatUhgPYnK5wzTnS4qPDD9kAXaUjhmErWFCnvM8RR3TuBioxuqaQWOzXMui5VOxd0fx9shW
	wJ/6imwcjtJVNC9aGDwIQiUU8TdfujcCwsfsKHFD8/a9wuyT8E5830P2of4zQ2zjs/LDgUfsQIm
	C8lXOBcbuhBkuNo3hp+/D0Y+0YbZ6dFtKBeV88Pe7iZNOk8tRDR1t2HaZcFyYx7r/tk4GjiNpYG
	Zr5y2Rv2BSPzcHA/tJNp0WFyFErr/prVD9fWcmYrkkjSUuwOQ=
X-Received: by 2002:a17:902:da85:b0:2cc:9473:97a1 with SMTP id d9443c01a7336-2cf45aa8fc1mr1052835ad.22.1784324611243;
        Fri, 17 Jul 2026 14:43:31 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b1f3sm10613093eec.26.2026.07.17.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:43:30 -0700 (PDT)
Date: Fri, 17 Jul 2026 21:43:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v8 0/9] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
Message-ID: <alqh_NVatGn84o0i@google.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>

On Fri, Jul 10, 2026 at 05:52:41PM -0700, Nicolin Chen wrote:

Hi Nicolin,

> When transitioning to a kdump kernel, the primary kernel might have crashed
> while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> and setting the Global Bypass Attribute (GBPA) to ABORT.
> 
> In a kdump scenario, this aggressive reset is highly destructive:
> a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
>    PCIe AER or SErrors that may panic the kdump kernel
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
> 
> In this series:
>  - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
>  - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
>  - Skip EVENTQ/PRIQ setup including interrupts and their handlers
>  - Memremap the crashed kernel's stream tables into the kdump kernel [*]
>  - Reserve the crashed kernel's in-use ASIDs and VMIDs, preventing any TLB
>    aliasing with the kdump kernel's own domains
>  - Defer any default domain attachment to retain STEs until device drivers
>    explicitly request it.
> Most of the kdump code is added to a new arm-smmu-v3-kdump.c that is only
> built when CONFIG_CRASH_DUMP is enabled.
> 
> [*] For verification reasons, this series only fixes coherent SMMUs.
> 
> For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
> 3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
> full reset followed by driver-initiated reattach, potentially rejecting any
> in-flight DMA.
> 
> Note that this series is no longer treated as a bug fix, since it has grown
> fairly big and most of the kdump code now resides in a separate file. For
> folks interested in back-porting the change: a v6.12+ kernel (since commit
> 85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg"))
> would be still compatible with this series.
>

[...]

> 
> Nicolin Chen (9):
>   iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
>   iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
>   iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
>   iommu/arm-smmu-v3: Destroy vmid_map ida via devres
>   iommu/arm-smmu-v3-kdump: Reserve crashed kernel's ASIDs and VMIDs
>   iommu/arm-smmu-v3-kdump: Implement is_attach_deferred()
>   iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
>   iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
>   iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
> 
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  48 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 579 ++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 246 ++++++--
>  4 files changed, 806 insertions(+), 68 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c

This series seems to align with the restore part of my SMMUv3 Live Update
(Kexec Handover) support. I have a WIP series in dev on github:
https://github.com/pran005/linux/tree/wip-arm-smmu-lu 

While going through the Stream Table adoption code in this series, I 
realized there is significant overlap between how kdump adopts a crashed
kernel's SMMU structures and how we restore preserved SMMU state via 
Kexec HandOver (KHO) during a live update

For e.g., the KHO preservation hook in my series explicitly tracks and
serializes the physical addresses of all active L1/L2 tables into the 
KHO Device Tree so the incoming kernel can kho_restore them.

However, looking at your approach, I think I can slightly rework my 
preservation logic and instead of bloating the KHO ABI with physical
addresses, I could re-use your exact table-walking logic during probe
to parse the live L1/L2 structures directly from registers, identify 
the valid tables, and kho/dma_restore them. There could me small 
differences though, for example instead of memremap stuff, we'd have to
use the kho/dma_restore API (which can be done by passing some op like 
the data structure writers we have?) Similarly, maybe reserving ASID/VMID 
can be potentially re-used as well..

Since, I plan to introduce another file: arm-smmu-v3-liveupdate.c and
given how much of this adoption and restoration logic is re-usable 
(parsing STRTAB_BASE, walking the L1 array, restoring L2s (not deferred
for KHO), I wanted to start a discussion to see if it makes sense to 
factor this common code out into an arm-smmu-v3-kexec.c (or similar)?

I'm not trying to delay this series by any chance and I would be more
than happy to rebase my Live Update series on top of this series and
refactor to share this core logic between the 2 new files: 
arm-smmu-v3-kdump.c & arm-smmu-v3-liveupdate.c 

I just wanted to start and early discussion since there's some overlap
and align on a way forward.

Thanks,
Praan
