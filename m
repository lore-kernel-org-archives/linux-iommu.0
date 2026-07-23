Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D70391E52;
	Thu, 23 Jul 2026 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850088; cv=none; b=QOggmjj3YL5Wu+/j/bo4cnDDUxu7QxHkjji0mlbmGl2xeGuCz58uPEYu504EvQO8Z+WzVTNa7+juil4kNKcgqfJ6R00iWY53pwXwUgtehQewUH9Osq/JVV+ZochEL6/xFeiodftht/P6yuIJEciy48QxlBA2dMSdJObmHq/EXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850088; c=relaxed/simple;
	bh=rsLBmWPt+d8HynrSKwwtAyKBlpprMn+1W/b6KFlRyoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suyJy93I60GYPhH8KIUfIxbKiHwou3T0C8E0b954sifcGKASN/nd6FFzqCt9Qw9sNu82E8cNd5lLn5Rk3cfSEgvAi8BUvFJw1LGQQF66f98BV5V+uUJWfbQ9+4azJakVAATAFF50z1uh/GxKGCwXfcg2Z0zwHWJE9uK+xgUAlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpEjksWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpEjksWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB031F000E9;
	Thu, 23 Jul 2026 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784850087;
	bh=aTz69KdUrI3yfZjC00J0USCMLwe6vP8ekewkBIJx+Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpEjksWjdQXtZwWWaMoVcRqzfxVl8o/AELIT483th2iPV4PHPE/tXzOrxye73GGrd
	 0BduEfPAauWn/khDpp+SpMMp5BWZvjrO1h6Lrojf3nqUJGzS/WLpuRDW/gTlJmL4Vg
	 +Zd57H+BfepSW0VaRvrbPBkJ909SGIvyXaANU5sn/1GxbMrwPXrtbu5drYbbCKzDM2
	 IGVmciX6iYsLqEMnwMp03bZa5ucXZSmDr4/K8XqYsjTBbHYyB1gofwdafgzCkK5TkZ
	 OdF0R/ZVRPfKlT8yEMf2WRFGE10m8S8sEtQmLe04rNEvyhBP35pujz6Rl6lppsYd1Y
	 ua08B36pmYRYg==
Date: Thu, 23 Jul 2026 18:41:26 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
	bhe@redhat.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev,
	m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [PATCH v4 00/10] kdump: reduce vmcore size and capture time
Message-ID: <20260723234126.GA3253409-robh@kernel.org>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>

On Tue, Jun 30, 2026 at 03:47:04PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.

What about reserved regions on ACPI based systems?

> This series introduces an opt-in 'dumpable' flag [1] on struct
> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> DT-based architectures (arm64, riscv, loongarch). By default reserved
> regions are treated as non-dumpable; CMA regions are explicitly opted
> in because their pages are returned to the buddy allocator and may
> carry key crash-analysis data.

I never like seeing the same change being made to each architecture. 
That's generally a sign of restructuring needed. loongarch and arm64 
prepare_elf_headers() look about the same. riscv version uses 
walk_system_ram_res() for some reason. 

Perhaps the dumpable flag belongs in memblock instead? Then at least we 
wouldn't need more DT APIs exposed to the arch code, and the code stays 
independent of the firmware API.

I'd really like Marek's review on the reserved memory code changes.

Rob
