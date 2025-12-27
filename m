Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC51DC997;
	Sat, 27 Dec 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766866450; cv=none; b=cxbcapcu3XZ96xzKu9PFkY5orHDhocygNzlc/pvyK4lU6J6Ga06uzmc0BYUk6yLw6p+/z4toPGN+WEwJ9vC40inTUvVORp+PTL5E9m0cF4XxbL0wVAURx8Fq0xDpTOiWk4zKts5/Vw0nB785IFfcMFgYFiuuIQ8vnYoPcshOY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766866450; c=relaxed/simple;
	bh=5BvZzNPtiik1Rf2hGQJZuruUvtsWoa36oLJFsqbPeIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aja0TVQQ18jylb8e0HLP+l9Px0yX0URV8yBPQJqyWEkjOqrIsHY932N3xyz3rcOIoBClh8icrJ04yuuBSIKJuj3ET9Vi33G/fDAVhlcclyYMISJVAtc3JxT7+Zyxc7121thKeLsK09qtNffbL0gfYZi1wQ+AMQD0z3t8y7J4wYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8mX/F/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8mX/F/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32314C4CEF1;
	Sat, 27 Dec 2025 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766866449;
	bh=5BvZzNPtiik1Rf2hGQJZuruUvtsWoa36oLJFsqbPeIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8mX/F/qNxveAViAw3M67+ZlSkxoNkRKoE+i7UiDr/K8/lElkqvuc9vkn65DJgg01
	 pF5Pb5lIKx8k8SBZHzueiJEkrfAz9wVBYC3qQhGt74fNQZUGCOWAUc01JwaEYXMdpM
	 FJit8Tv20CSZzdYdRg0UZB+Yo9Gdf3qhLW7C+ke6SKiJj1zsi7T5LNOYlCoMCpxGoE
	 n5D4Asm3R6CzLphE/Xh5kr1cHps3f5Rhemo2HeOJTBRXD1DzwfYcZIWAAXNYWEBlih
	 bSMq1kRI2kpZ5c18WLkXj+BEo8HgxpRnn/JvRkD8SEbP8nnzGwzQaYj+Higdc0Svrv
	 VyCS4ZKkgq3bA==
Date: Sat, 27 Dec 2025 22:14:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, Barry Song <baohua@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH v2 6/8] dma-mapping: Support batch mode for
 dma_direct_{map,unmap}_sg
Message-ID: <20251227201406.GP11869@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-7-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226225254.46197-7-21cnbao@gmail.com>

On Sat, Dec 27, 2025 at 11:52:46AM +1300, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> Leon suggested extending a flush argument to

Let's move this sentence out of the commit message and place it in the
changelog instead.

> dma_direct_unmap_phys(), dma_direct_map_phys(), and
> dma_direct_sync_single_for_cpu(). For single-buffer cases, this
> would use flush=true, while for SG cases flush=false would be
> used, followed by a single flush after all cache operations are
> issued in dma_direct_{map,unmap}_sg().
> 
> This ultimately benefits dma_map_sg() and dma_unmap_sg().
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Barry Song <baohua@kernel.org>
> ---
>  kernel/dma/direct.c  | 17 +++++++++++++----
>  kernel/dma/direct.h  | 16 ++++++++++------
>  kernel/dma/mapping.c |  6 +++---
>  3 files changed, 26 insertions(+), 13 deletions(-)

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
