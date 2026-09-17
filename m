Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD242C508;
	Thu, 17 Sep 2026 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682220; cv=none; b=eemZ9L06jO6sTQukKiMGeWo6U9SCAHv7va1W1fo4aINOgSYckC3LV8H5xNEILXZREgx0ksMppNQGCkKzcY/T1liDRMw6f10aGE1Nu+H9NcPtAOsERcoFPWzdV5lr1iFsB7NMtvrpYHnT3Z9qVzMxPYSy35Ovi/qTqyrRljS0OZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682220; c=relaxed/simple;
	bh=vvN1do1b5vxeWmLcBK5HgVMxtBO1ML3wxGKsgO4thWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAmL7a0f/0zPC+atJPRMtWdb0Yvd84NajFNf/c72fGi0HCgZUAfYvK58bGXNnccIP/oyZmKXxagJ0k1laS1pE7MBUb680ji+t/q2MYswCthAG0z+PtjQ3/RWcf4sj3CJ3+BwGOMkwa9Ih9uhOjX5mYeQngoaTK6XXBs8HcXRDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE+Lz4Bp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE+Lz4Bp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681611F000FF;
	Thu, 17 Sep 2026 21:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789682215;
	bh=kuBtV4+7ALBPAyy2nomafqxqzWcbcsqKb3dSOrzTp7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bE+Lz4BpzH5TSV1jWou2OBtlqHsC//L3WyTj9bXi6va6c8nZfLJ4ol68JuU+o3r2M
	 TAu2icEvroIVO5OuYcPgJYCAhNQXTzOAIclO3FED1OglGnXQvoVgXQi9NkcPaNCm7C
	 NxCHhu8wntvOtj4LO509qvBQvss+eZM34/jEYGD2HXc7uGKovRY4ujMtUk30a4EgKF
	 zPD0eqlpLObbbLfAP2BCbHPLwLZz0rgjBIedFlBVM78LXQPEzVbz5SKMMk3kZSKLLI
	 Ww16aNzudepZDNF3jG6O0DxZCUHUXGJHhXcE+1AZc6MCWnHl/xvccdOs6+sET6/9Sd
	 Dca8d8QUwinxQ==
Date: Thu, 17 Sep 2026 16:56:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: m.szyprowski@samsung.com, hpa@zytor.com, chenhuacai@kernel.org,
	pasha.tatashin@soleen.com, devicetree@vger.kernel.org,
	linux-mm@kvack.org, tglx@kernel.org, robin.murphy@arm.com,
	kernel@xen0n.name, mingo@redhat.com, saravanak@kernel.org,
	loongarch@lists.linux.dev, dave.hansen@linux.intel.com,
	will@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	iommu@lists.linux.dev, mark.rutland@arm.com, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, pjw@kernel.org,
	linux-kernel@vger.kernel.org, baoquan.he@linux.dev,
	aou@eecs.berkeley.edu, kexec@lists.infradead.org,
	pratyush@kernel.org, linux-arm-kernel@lists.infradead.org,
	ruirui.yang@linux.dev, catalin.marinas@arm.com, bp@alien8.de,
	palmer@dabbelt.com, x86@kernel.org
Subject: Re: [PATCH v6 08/10] of: reserved_mem: mark /reserved-memory entries
 with MEMBLOCK_NODUMP
Message-ID: <178968221332.3991643.14928206071521736133.robh@kernel.org>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-9-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-9-chenwandun1@gmail.com>


On Wed, 02 Sep 2026 15:31:14 +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
> kdump can omit them from the vmcore.
> 
> The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
> pay the cost of splitting memblock.memory entries at NODUMP boundaries.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  drivers/of/fdt.c             |  1 +
>  drivers/of/of_private.h      |  1 +
>  drivers/of/of_reserved_mem.c | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

