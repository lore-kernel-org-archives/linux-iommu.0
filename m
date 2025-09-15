Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176E2D2488
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932693; cv=none; b=ja+u+eb8obm5ZHn2vTgCZn6lwD2SVplUSD4QhZyFaihoJ1+NJoZgGL1hrrwOitGEXJZhK1hOsSVciQp80fsFmhcs/jYbcqzYxhic17kwXKlNMY0RCP7pASj2p/7e+e656mJjXlwj2CU+8OhupB62rUJ+nbMXNmLH0G1lWv3XSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932693; c=relaxed/simple;
	bh=qJ9kQ8BFAZY2v4fggocnqvi8R1BnMMUDXlwGB+RmYH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaQu7kdAdg+wzHtBelYUbFdseENO3h96UnH+mrwAjLFEDeqjDhWQw8nAtKxsv1VAYPvUNahWIrIeUdcfSV4JC1X/4cndNWFgkb98EoEFab1uMNBa6SjdHQMirL+BHpip1QPlqhu+SUt9BnZJHXF4sCFVxea1BRsMKyGYmKzKJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMxLcgCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMxLcgCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7006C4CEF1;
	Mon, 15 Sep 2025 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757932692;
	bh=qJ9kQ8BFAZY2v4fggocnqvi8R1BnMMUDXlwGB+RmYH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMxLcgCFGdAs6MATYhGGP+jh+ft9np0Fb7ScunMNiJRVJXDUL6wMUqoqbShz6OOvn
	 lqcvod4uqVzBmhRyKFkZOjKbJthLcMrKW02PinbWvimlMKOHJZrXZ1HjF+278V0mHN
	 H9bXnlObipolMo69DvS2bVpT4stzi4OHSJtZJStFPS7Abprg003eu0lV0S7A5o4dCn
	 mfmfx77hf/fH3Kd7Ryyq+7mfBSt89Hh06smcKm4xiI55LiXbf9pYODmFE7uM6gAWKx
	 peCFyjhVMckRq+qELmpKBOiKSgcqzgM5fiUrXKOb0ICG6y3NM+9dHceY7ofxg9AZnS
	 5Xq8EyXap8hug==
Date: Mon, 15 Sep 2025 11:38:07 +0100
From: Will Deacon <will@kernel.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, robin.murphy@arm.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, anxu@bosc.ac.cn, wangran@bosc.ac.cn
Subject: Re: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
Message-ID: <aMfsj1U7NY2m68T4@willie-the-truck>
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>

On Mon, Sep 15, 2025 at 10:09:09AM +0800, Yaxing Guo wrote:
> This patch introduces a performance monitor driver for RISC-V IOMMU
> iohpm implementions that support hardware performance counters.
> The driver expose RISC-V-IOMMU-specific performance events (eg. cycles,
> tlb miss ...)through the Linux perf subsystem, enabling developers
> to profile and optimize I/O translation performance.
> 
> Key features:
> - Implements a perf PMU driver for RISC-V IOMMU.
> 
> - Exposes IOMMU perf events, such as 'cycles', 'tlb_miss'... via
>   /sys/devices/riscv-iommu-pmu/events/, allowing use with perf
>   tools:
>     perf stat -C 0 -e riscv-iommu-pmu/cycles/ ...
>     perf stat -C 0 -e riscv-iommu-pmu/tlb_miss/ ...
>     ...
> - Supports event filtering through configureable attributes exposed
>   in /sys/devices/riscv-iommu-pmu/format/, including:
>   dv_gscv, pv_pscv，did_gscid，pid_pscid，idt (riscv iommu spec 5-23).
> 
> - Implements overflow interrupt handling.
> 
> - Adds device tree binding support via optional 'pmu-name' property
>   allowing platform-specific IOMMU implementations to specify a custom
>   defined event ID list. If not provided, the driver defaults to only
>   supporting 'cycles'. When set to 'dummy', it enables all 9 standard
>   event IDs as defined in riscv iommu spec(5-23).
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
>  drivers/iommu/riscv/iommu-perf.c | 535 +++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu-perf.h |  88 +++++
>  drivers/iommu/riscv/iommu.h      |   8 +
>  3 files changed, 631 insertions(+)
>  create mode 100644 drivers/iommu/riscv/iommu-perf.c
>  create mode 100644 drivers/iommu/riscv/iommu-perf.h

PMU drivers are better placed under drivers/perf/

(the Arm SMMUv3 PMU driver lives there, for example).

Will
