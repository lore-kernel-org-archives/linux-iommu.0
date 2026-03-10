Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427A38A719
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150958; cv=none; b=fUSfP+KQ8jJLEVl31ng1K2oXfzJLdYl8kkmKAJ9KKGttOEYzqaD61/62tgMLy7mDHJJWPe5w41Ll/Co0JSIM6pjCUVjyoTETFybMkE9ZvVOVHYHKLeAbNQyQkNhDKUHY3Fx0pWLyBVxqN3oBWH7m0G9xx6M/aJyGYJ7D+ju9VHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150958; c=relaxed/simple;
	bh=e7NYteQ5BI9gllCVncwSRKMX6uvb3dsirYmr21SRthw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy9Xxm0DiB6QdoCpUiZehwYSLbcEUWNidiq6AhaJpSC5XwpYDwIkVPGMCuYQlLKzMImTISEohCFAyVhfw3PsPchoGWMNRnW39AM/oV5h1Z+S078io+gi51JldzKEXcdX/m5skUrpDQKdAUyZG+DrRyV44YJYESWtGi/uCb1V9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97DE9169C;
	Tue, 10 Mar 2026 06:55:50 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D98E3F73B;
	Tue, 10 Mar 2026 06:55:55 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:55:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH 1/2] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <abAi6NeKb4m_RbwV@arm.com>
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-2-smostafa@google.com>
 <abAeSML-7ziLeIvv@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abAeSML-7ziLeIvv@arm.com>

On Tue, Mar 10, 2026 at 01:36:08PM +0000, Catalin Marinas wrote:
> However, it's unclear to me whether we can get encrypted pages when
> is_swiotlb_for_alloc() == false, remap == true and
> force_dma_unencrypted() == true in dma_direct_alloc().
> dma_set_decrypted() is only called on the !remap path.

Ah, I can see Anneesh trying to address this here:

https://lore.kernel.org/r/yq5abjjl4o0j.fsf@kernel.org

-- 
Catalin
