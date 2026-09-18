Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D13101C0;
	Fri, 18 Sep 2026 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714857; cv=none; b=d4PsbhOnR0I0hJ09l+cLM4tF6shnCeZAlh+iMM3ymnc8akrVWHjTDjHumHycnn31Iut25LhBjat7u/bMcRmNxzSpPo9PqT4+82YMGu5JC6A3eK4xTPZj+uKXzsCZIDTKfOZzrJBjVQGvYcxlQEy5YSvwzCTE1/quU9tLcTNQv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714857; c=relaxed/simple;
	bh=CFwJEKxFbVk2oXpA6XmCb4eB1YfIUvoG93k8Zl1da0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDWp9w1t6TvjexH2SwRXs55mPJ/d+btEf8hPhzuh0UX7aEZTShgsyuYYltfyJT2Xq38Nfjt3AvheNNigUvX8nIQr0cH1TCgvjj/kDw+s526tdcx4Ut07AeEoRuRtWz8/9NfTopBT88O8MEuj2DSBAaQhesE7Qp2AeXb18cqoaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddEaqhLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddEaqhLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881A21F000FF;
	Fri, 18 Sep 2026 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789714854;
	bh=xoKeOk0v0E+lrs5eZG2JMMltTlaNFbdGi9KSvcSzDqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddEaqhLhDpDSoBo7I/HnGD6o5TYNSCCk1vbkXYkLf2/bYgvnrydMc+ZR6x61gKESK
	 UGKv/IbSNvNPBR1vOqX+r9JgWXrjvDTCFcOrJvX6CibAfDXYyk6MiteN00P/s7B3u+
	 4zD3d4ENXshV5oFAYsQ0wtE3JwGN5yRx90fDESoEzj0+9cqfqRYDfdP6RS+BNKREuT
	 If8/BphX6k0RBR5SE1XpB9ELckQp2CWM3mcQAwcOTD/Cv/a+7A17/8AghwaLxNVQ0B
	 eUvYhxRKtRV4PGfHxJCp8USPFFWEE1cSPHIbDRVKPWKtzqf+hzV40iuv2VjMTh+sI1
	 CPFp1z3iL/qqw==
Date: Fri, 18 Sep 2026 10:00:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org,
	baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com,
	kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <aqzhnOKOq5m4klFU@kernel.org>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-7-chenwandun1@gmail.com>

On Wed, Sep 02, 2026 at 03:31:12PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> kdump vmcores.
> 
> The flag is meant for reserved memory that carries no data useful for
> crash analysis. Reusable reserved regions such as CMA may hold useful
> data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> patches wire this up for /reserved-memory and /memreserve/ entries.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/memblock.h |  9 +++++++++
>  mm/memblock.c            | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)

-- 
Sincerely yours,
Mike.
