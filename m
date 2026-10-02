Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAC4EBAE9;
	Fri,  2 Oct 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955609; cv=none; b=kr4TghOq5wgOX5L19h2Snm0ewrb/Gekxt2jZKwRcDwCmwJJJskrSdi80opxLOeow6BQFQgjI+EEbll1iR90ADnX2kTd1B5kDuXLB6RIECRRnJby5c3MtkyJrsGjfnZBDNi323n8BKBC3yCKCMnjmUsWm+dMB1D/op+UbZddExW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955609; c=relaxed/simple;
	bh=m3FvdAyFXZieRr02nJ4owcCPAAVdLgk6MLZpPnf/aIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2C1gB0Hz13+O5+U4JBureo2yLGHOcU6eGThjjmuxUEe5InjXienZUHTl5H1tCGkIoQqqjAlm9njBHFWG6YfQN9KsrhsZoGJzHx0qTtusTMItBYonwpYKj+uk9mNZwyWBx9d2N4V4kfrwUP6nVMCMqVKuGG2lVIjnqYLxq52/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1cCKfVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1cCKfVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540021F00893;
	Fri,  2 Oct 2026 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790955600;
	bh=NUoaeZWBEqi49tG6RXh95F+Nquw14LsgVd4Y+Bv0KE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H1cCKfVYe8PTDI2SW8gRcfNHXyc9n3g8UnpjywsE/9yiJiJv5CZDjeftxarPhJxab
	 sedfIedK3D3yNB2QVWxwVrMnKxj89l3K8Jjg/xk0Ok+Pw5mafJmITp4ykxYEQKxDlv
	 zLiIEzDz4QQ1aZ4auMNhMyz3q1mA7K/1rUeXocjFOm0CmRo9uXj6evrFrazXg8EXl7
	 xdYJtU0LOuyqJduEeojgZFp7Sx221s0I4x3lFySnuy66Yka+wD6egtLLt2Ml9lWkMY
	 IMPKdJ4+LGQsGWVZwKng9I6lMcFApUGdqPImCjCsfApsYk2GAXNKCfvnuw+o1daf5c
	 3hDb03E1v7pMg==
Date: Fri, 2 Oct 2026 16:39:53 +0100
From: Will Deacon <will@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Kyle McMartin <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] iommu/arm-smmu-v3: Make the queue depths tunable,
 and shrink them in a kdump kernel
Message-ID: <ar_QSdV44YzQQ6Yx@willie-the-truck>
References: <20260925141532.1274962-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925141532.1274962-1-kirill@shutemov.name>

On Fri, Sep 25, 2026 at 03:15:28PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> The queues are sized from the IDR1 maxima and allocated at probe, costing
> megabytes per queue per SMMU instance. A kdump capture kernel pays that out
> of a small crashkernel reservation, for queues it barely uses and two of
> which it switches off anyway.
> 
> Patch 1 adds a cmdq_max_n_shift module parameter, decided in a per-queue
> helper and floored at one page. Patch 2 has a kdump kernel size all three
> queues at one page through the same helper. The parameter does not apply
> there.
> 
> Yuanhe Shu tested v6 on an arm64 server with six SMMUv3 instances, 64K
> pages and a 512 MiB crashkernel reservation. Without the series the queues
> took 192 MiB and the capture kernel OOMed before makedumpfile ran. With it
> they take about 1 MiB and the vmcore is saved.
> 
> Measured per instance under QEMU on -M virt,iommu=smmuv3 with the virtio
> devices behind the SMMU, the capture kernel identified by elfcorehdr= on
> the command line:
> 
>                         4K page          64K page
>       cmdq         1 MB -> 4 KB      8 MB -> 64 KB
>       evtq         1 MB -> 4 KB     16 MB -> 64 KB
> 
> cmdq_max_n_shift moves the command queue alone outside kdump and is
> ignored inside it; zero gives one page. QEMU exposes no PRI queue, which
> takes the same path. No CMD_SYNC timeout, GERROR or context fault in any
> run. Build-tested across 4K/16K/64K, TEGRA241_CMDQV=n, CRASH_DUMP=n and
> ARM_SMMU_V3=m, every commit warning-free.
> 
> v7:
>  - Flatten the depth helper as Jason suggested: floor the limit, then min
>    with the hardware maximum; callers pass their alignment cap as the
>    limit.
>  - Initialise cmdq_max_n_shift to CMDQ_MAX_SZ_SHIFT, so zero is no longer
>    the "default" sentinel; it asks for the smallest queue, one page.
>  - A kdump kernel always gets one page; cmdq_max_n_shift no longer
>    overrides it.
>  - Tags: Breno's and Jason's Reviewed-by on patch 1, Jason's Reviewed-by
>    and Yuanhe's Tested-by on patch 2.

Ah, sorry, I missed that you'd already sent a v7! As I said on v6, I don't
have a particularly strong opinion on the naming, so given that Jason is
happy with the logic, I'll just apply this now as-is.

Cheers,

Will
