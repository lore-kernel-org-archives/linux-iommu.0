Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7D2E7658;
	Tue, 12 Aug 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994338; cv=none; b=pteFq1OC8nkG4BUrchrSuel+hN04aaFDQ8CoUxffD2ReJ/few7rC7x4dHVrT2vmTrlooyZuzHN5lNxu9ZoCZJQOWq239I3MPEm5zcMkeDe29J4xdymrzIQdIfo/13N8kZDijNmbIXU1UXRirKUhQfLTbg8Csy6XTiIc+Jw+ENTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994338; c=relaxed/simple;
	bh=DiWMJDZpjo9wJTQrpVdyTjIpXEQ2ScmTy6fBslbzay0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtuUjoWIKrwaWBF2DoHt5FnmYu0jkx3zYpcjonzG9Dyb2YpIpjTT5kc4V/jvk9Hl6tWtjyaU37+cDMSa3NIHeBKHoioKm68XhlCWsJi/hkqsV4j4MUBzKn7ZgxiLeLCynoGgPjRi6C4eiFXoMbAE9ujzlUSk8cumbP3X9JFimRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60766C4CEF0;
	Tue, 12 Aug 2025 10:25:35 +0000 (UTC)
Date: Tue, 12 Aug 2025 11:25:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>,
	Mike Rapoport <rppt@kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
	Jason Sequeira <jsequeira@nvidia.com>, Dev Jain <dev.jain@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma/pool: Ensure DMA_DIRECT_REMAP allocations are
 decrypted
Message-ID: <aJsWnSm7un-EUmed@arm.com>
References: <20250811181759.998805-1-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811181759.998805-1-sdonthineni@nvidia.com>

On Mon, Aug 11, 2025 at 01:17:59PM -0500, Shanker Donthineni wrote:
> When CONFIG_DMA_DIRECT_REMAP is enabled, atomic pool pages are
> remapped via dma_common_contiguous_remap() using the supplied
> pgprot. Currently, the mapping uses
> pgprot_dmacoherent(PAGE_KERNEL), which leaves the memory encrypted
> on systems with memory encryption enabled (e.g., ARM CCA Realms).
> 
> This can cause the DMA layer to fail or crash when accessing the
> memory, as the underlying physical pages are not configured as
> expected.
> 
> Fix this by requesting a decrypted mapping in the vmap() call:
> pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL))
> 
> This ensures that atomic pool memory is consistently mapped
> unencrypted.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
