Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B639A06B;
	Sat,  8 Aug 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208862; cv=none; b=dY5mm1tSei1R1enPEAZBTniGMJ3CuYHp5pQmjdneXgUdY9jIgm8SRA+jUqVVvUkGa8AJJrnW3sC7TqhCAMjIFBTzRaYqFMiLZ3FlrXgVDRbqNmnZgHDaBohnNK3E2aLrFCexKCUPyn/3F5d0E0halcs4FmGgO21SYXcKX/KpAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208862; c=relaxed/simple;
	bh=Cbe4a50Wo3yQ5YnrOL+KyHPWvwCwhzKq9Ds6GgnjbB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScLe8DzhT/NcwWDEjDJXuyyV06U20PpUIc5eajSRuh9Tp7t1koeEq6PbinQld6IshAyI6QdOm1E4g1zWG5Fdt6B1q6UXyIkAA5ssi8fqlt6x037UlMcL/4zCh73R08/K2tJXpaTd3TSG6KmfNGlPm4WvvYXgjZfu+IZXG5NQr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEFiTAk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEFiTAk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AA41F000E9;
	Sat,  8 Aug 2026 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786208860;
	bh=RZkqPDjuFooi7QGj5t/O5g20eJ3XuiiAxeKTnLb8vz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kEFiTAk6dJwIY8ucP0WzJtmpjuaY0C2iT2p+mcdqjztfYKRa56w+59ixsW4besMiB
	 I+LCAEHif77oFP0PO5ikGI93N7c9RiayxBy4AKiD/ui5Acq2aLvitujKgo2Vey5Z1X
	 1zbbFnwgJJamAgXfbqv767RaOdSui+4dLoTiG/sFVkZ1U5G9ERjZqWwHc1dglNP08S
	 e8rSud3pG8YZyO+oCPNUfNGfGMTQGgu9lAVS4kak6v+q2o+CgyPniHNZHvpuSNYF1l
	 coWzoRoN/7Kuc4DeESugxBCGrzNB5GAjf8SKquYJXGkGJKuWlXEdimU3XE6THBUlhU
	 NA69MO+GnjKhw==
Date: Sat, 8 Aug 2026 10:07:38 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net,
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 4/7] iommu/riscv: Program QoS IDs for assigned groups
Message-ID: <andiWrKhz5rLPVuq@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-5-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-5-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:54PM +0800, Zhanpeng Zhang wrote:
> Program RCID and MCID for RISC-V IOMMU groups through the device context
> TA fields. The resctrl group assignment is per device group, so reject
> BARE mode where only the per-IOMMU iommu_qosid global default is
> available.
> 
> Validate every group member, firmware ID, device context, field value,
> and QoS ID capability before changing hardware. Then update all members
> through the checked IOMMU group helper so a validation failure leaves the
> group unchanged.
> 
> Serialize DC.ta changes with context setup under qosid_lock. Change only
> the RCID and MCID fields with ordinary accesses so fixed DDT mappings are
> not subject to atomic LR/SC operations, invalidate active device contexts
> after an update, and clear the IDs when a device is released.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  arch/riscv/include/asm/qos.h     |  16 +++
>  drivers/iommu/riscv/iommu-bits.h |  15 +++
>  drivers/iommu/riscv/iommu.c      | 200 ++++++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h      |   3 +
>  4 files changed, 232 insertions(+), 2 deletions(-)
> 
[..]
> +static void riscv_iommu_dc_update_qosid(struct riscv_iommu_device *iommu,
> +					struct riscv_iommu_dc *dc,
> +					u32 rcid, u32 mcid)
> +{
> +	u64 qos_ta = riscv_iommu_qosid_ta(rcid, mcid);
> +	u64 ta;
> +
> +	lockdep_assert_held(&iommu->qosid_lock);

It seems that qosid_lock is not defined until the next patch. I think
you should move the definition to this patch so that the series is
bisectable.

Thanks,
Drew
