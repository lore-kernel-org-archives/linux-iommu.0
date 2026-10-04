Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B861F5821;
	Sun,  4 Oct 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791120314; cv=none; b=qmjZUF+OtSbiCzQiJYY4u/jloN+caZOWBDvkWYzk5207Nuah6P/KVR5wOGgko3ThjOrrqykBNJSjo+xc+Efl8ihlpp/dYZWY6EoktQ4pKKI3RaFc5hdkC66C2f/EHpVXUZhmWPaq45F7+LWEQuQWNGC1YApi0AbE/U/BmwLc/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791120314; c=relaxed/simple;
	bh=KHUX7DP5Hz7DZRHoaUZIOSzT1VpKb3R1L2CP9fea+Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmeECP0waQfzAEVsiDiQ+pkcuy7ilKIrDQVplSfyerWNq83a+iTGXoh/chF08PSXAyyVmB632wpitfcS6Nrl43Pf8sVS/isebR1I1xEnQofdb42wTUIFBx1GyWAQ1zPLOhwtKX4XtuHr5d8xcScBuhfujuMgE8LECikDmtVYOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLs041OM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLs041OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC3E1F000FF;
	Sun,  4 Oct 2026 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791120312;
	bh=S8JfRD9GH3BjKxXE7cm8G7Z8e3QaQRCrAiAXcY8gZC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SLs041OMqUBDLcrFW9c/GkDb/XulJnQ6qacHbf76qKFlynOEgOOY0oK/kN8xMGO8C
	 FlHjvUabzVxWFcmsl4TwHKIe8DklPjc+NakROBRwVA+1sarDYZEztNAUiKiXnvIk5Q
	 I1n8sXStb0r4oyTPNkrdjhGe6ei+eoYA2bYkhJojIpOr0uvQ9036Mf256RxlzuaCu5
	 QSzFAUX3O99Yr+tMe+CyP6OK2NKh4nzIj/iicbXYHL6XfqRRn2TeZvLtWzUKhdIayF
	 bsDhpSh6Zdumc8KVkI6YtZDviz2PK9sJS0bqkWovnWkK+tK8AXEYSAxgEj1uisxX6u
	 EaUBzQ/eVrJkA==
Date: Sun, 4 Oct 2026 14:25:07 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, praan@google.com,
	kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asJTsw-oWDlSqNa3@willie-the-truck>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>

On Sun, Aug 30, 2026 at 04:18:07PM -0700, Nicolin Chen wrote:
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
> To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
> intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
> in-flight DMAs reusing the crashed kernel's page tables until the endpoint
> device drivers probe and quiesce their respective hardware.
> 
> However, the ARM SMMUv3 architecture specification states that updating the
> SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> 
> This leaves a kdump kernel no choice but to adopt the stream table from the
> crashed kernel.
> 
> Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adopt functions memremapping all the
> stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG. Add them in
> a new arm-smmu-v3-kdump.c, which is only built when CONFIG_CRASH_DUMP=y.
> 
> Note that the adoption of the crashed kernel's stream table follows certain
> strict rules, since the old stream table might be compromised. Thus, apply
> some basic validations against the values read from the registers. If tests
> fail, it means the stream table cannot be trusted, so toss it entirely. To
> avoid OOM due to a potentially corrupted stream table, the memremap for l2
> tables is done lazily on the kdump kernel's demand.
> 
> The new option will be set in a following change, once the device reset and
> the RMR setup are reworked not to overwrite the adopted stream table, and
> the crashed kernel's in-use ASIDs and VMIDs are reserved.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 229 ++++++++++++++++++

Please don't put this here. The live update / handover stuff is going to
need very similar logic (see the RFC from Pranjal) and I don't fancy
having to rename or resplit this file when that comes along.

Maybe just stick all of arm-smmu-v3-kexec.c and arm-smmu-v3-kdump.c into
arm-smmu-v3-handover.c or something?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
> new file mode 100644
> index 0000000000000..a074d59ce3445
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementation of the kdump stream table adoption for ARM SMMUv3
> + *
> + * When the crashed kernel left the SMMU enabled with in-flight DMAs, the kdump
> + * kernel adopts the crashed kernel's stream tables, instead of doing a regular
> + * reset, to keep in-flight DMAs translating until the endpoint device drivers
> + * re-probe and quiesce their devices.
> + *
> + * Note:
> + *  - Adoption only starts on an SMMU that the crashed kernel left enabled, as a
> + *    disabled SMMU (CR0_SMMUEN=0) could hold meaningless register values.
> + *  - Values read from the crashed kernel's registers get structural validation
> + *    only (format, size, span, alignment, and ID range); the physical addresses
> + *    are not vetted, as the kdump kernel has no record of which pages held the
> + *    tables.

Can we at least check that they don't point at the kdump region?

> + *  - A structural inconsistency at adoption time tosses the entire adoption and
> + *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
> + *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
> + *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
> + *    rejects that device alone, as its blast radius is bounded to the bus.
> + *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
> + *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
> + *    the real hardware. Callers of these functions are responsible for gating
> + *    ARM_SMMU_FEAT_COHERENCY once during the probe.

This is an artificial restriction and not one that I'm wild about for kdump:
we should be able to support this for non-coherent SMMUs as well. Is there
anything more to it than using MEMREMAP_WC in that case?

Will
