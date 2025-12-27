Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B21DC997;
	Sat, 27 Dec 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766866178; cv=none; b=GNbGIrrwuSDKgGqTuiJXdGblMn8+mHd4k32/yxDRkRbAonV3nNKCrN1syg4wM2cyh1fJqy7yWw92+PP6G4i/R3+4YGskSp9ier/gjC2sG+rz1ew9IrpE/MHa6/46hTcPiPKFdpyT6xceQHJ7Yo65c5nvIGQssLB+T4kAyA7E314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766866178; c=relaxed/simple;
	bh=y+u6yKllr0W68e3y8Qfj41GWvPDO6M/CKO30+K0JRSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6yn0FJ8du0bkS63jF3xOLazqyTkaDa0qhoVVDiuB8kZCzwe5vmZq0Z7kRA1443H9vd4sV4ivkoqRtQRYtBoWyZXkPXQ/Hw0k5BogXg2c/nOYXI4jL6UP89rmS34NQoFMoIYJuiRRklHv9jN6/lDkTtyPHppDahvKZWcpBQzbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkotPNQv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkotPNQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A38C4CEF1;
	Sat, 27 Dec 2025 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766866177;
	bh=y+u6yKllr0W68e3y8Qfj41GWvPDO6M/CKO30+K0JRSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkotPNQvY3OS7Z6GK5eJREW5U1iKBosJXAf3OKZhq4w1e63KJ/6n6aLGdvhL0t9RI
	 qsawET5wu8X69005mh6s57Pu51m8COX9B90PGXro409saWdjcvqp/bYQzEVY5S5NG2
	 YIts3LU54RlZXyyGEde8YS5GTaAYv9wggXZREwV5m3akH9NKC8/HO8gZWCEiKuWSvd
	 vxDKsTSMCxwmQr8YlKHrU+GoWa5OP8vubgWVXShl/Qvt0n+FJVsO8VUBJuNf8n4FxZ
	 6khccCuOWwhueLLZ7+uDADNwuxl58ICHfO+AW4UZkA+oc+CY31hC1XeOqeTi+XkKA2
	 5iOODsc1HE7rQ==
Date: Sat, 27 Dec 2025 22:09:33 +0200
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
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for
 dma_direct_sync_sg_for_*
Message-ID: <20251227200933.GO11869@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-6-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226225254.46197-6-21cnbao@gmail.com>

On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> Instead of performing a flush per SG entry, issue all cache
> operations first and then flush once. This ultimately benefits
> __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
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
>  kernel/dma/direct.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

<...>

> -		if (!dev_is_dma_coherent(dev)) {
> +		if (!dev_is_dma_coherent(dev))
>  			arch_sync_dma_for_device(paddr, sg->length,
>  					dir);
> -			arch_sync_dma_flush();
> -		}
>  	}
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_flush();

This patch should be squashed into the previous one. You introduced
arch_sync_dma_flush() there, and now you are placing it elsewhere.

Thanks
