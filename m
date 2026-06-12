Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93259331EBF;
	Fri, 12 Jun 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275374; cv=none; b=q+TnzuhPQ4iPx5tC+9HS5QI2K628c55xBLHHGlxhxIDeizza5Z2psAd7SzfruWpuTEXLZSdQvgh5jb4tKAjBrY1eAwO0/0wotlg8LpMG64W22COAUlY8f28R+Pwt64HIaC1C5ZryjTwfXyfrhaIxsZQkolUDfqjNNnwWFeROIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275374; c=relaxed/simple;
	bh=I5GuteDh6Dh4ZtrW8Fiq+TqKm3fLngWvnlVl9sgP45Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srPxK3SPWigwt6iMwR9/eDX5Uie+sK7CB2qp5IgvGhFL/4OUviirUaL7p4sp4BPlq2V11c8wBY7fVn4+jJ4rc6d4EEZmfRKbATIJEjZunEEhfUP0OqvbNAT26pk/PoeFWYIolVMHvSPraKwkRX3XmV8We3k65tBuzky9dSYBZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym/KchFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym/KchFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500E61F00A3A;
	Fri, 12 Jun 2026 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275373;
	bh=8pFVODsK8nCijCDNDLMgxkikkdJrQAhHnV+T+5T5zWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ym/KchFKUOtSqs03zw7p0bBmd751BWdKhFtBdtk19PaYskXhLxCiU2wKH8lvRvWHo
	 gawVbS1RIGNl4PlNWJihz03okzNq9/cp6Ww5XKra5xbbcZYHNQxGCJ0q49orkQAj4O
	 JuLqTbP3nCbWkFMcgWB1ax5EpO+Yvbszkg2J7nRwE6cp4YrWjLJE4Uw3zRwtSxj2zQ
	 Mky2klprkntTIwKWcITUf5mHQeauSd798W7i3fnaExQYmYxPtva2ty6QfcfSaMh22m
	 cuE8Pq1IJy/flcs5MBzQsONPlcb+IxnY5oTx1zADRCEiFV2M8MzGlLx8BMD5waisk/
	 BKTkWBakHuGjw==
Date: Fri, 12 Jun 2026 09:42:52 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
Message-ID: <20260612144252.GB974326-robh@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>

On Wed, May 27, 2026 at 11:29:06AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.
> 
> This series introduces an opt-in 'dumpable' flag [1] on struct
> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> DT-based architectures (arm64, riscv, loongarch). By default reserved
> regions are treated as non-dumpable; CMA regions are explicitly opted
> in because their pages are returned to the buddy allocator and may
> carry key crash-analysis data.
> 
> The series is organized as follows:
> Patches 1-3: Pre-existing fixes and a small prep change.
> Patches 4-5: Restructure to allow appending /memreserve/ entries.
> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
> Patch 8: Add generic kdump helpers.
> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>               elfcorehdr preparation.
> 
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
> 
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>    feedback [1], v2 drop that property and exclude reserve memory
>    by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
> 
> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4
> 
> Wandun Chen (11):
>   of: reserved_mem: handle NULL name in of_reserved_mem_lookup()

>   of: reserved_mem: zero total_reserved_mem_cnt if no valid
>     /reserved-memory entry

I applied these 2 for 7.2.

Rob
