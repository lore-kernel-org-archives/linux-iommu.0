Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0EC4E06CF
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553546; cv=none; b=kr2QqpSxGPFgGFqqS++/idfkrQHtne7w9KazcSI39FVhhyrh/55ysRuq4EHnJjxPlAVqS7jT+hKM0INT358in9wWNsZnkX/A/woBOaaabO9Fcn4noxPpm6zEpqX5yBLuH8+mZWKjcALV+wqv7ws9PH8jcsi1OpZ+tGvBuICdE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553546; c=relaxed/simple;
	bh=DD1Dd6zQCZIL1Q8on/NlVlUe2Wldo3fQEOD4meT8UxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C64k2CDhnfBnaNPO9FqJilPKaUbyFRXZLVhuSbTIC1n54bLMpvC/W0PC2ygDi2k3Rb8pkagva7WhBGvgigPVtWjNcO+L24BKx+xG8rRA2XZ8rNRvpm9S7ggtunpIz2luNFvG8R7LX9ZfZACRkdZBHPR9y+2l3pBt7moVCpqRmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gnLpuRok; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gnLpuRok"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB151BB2;
	Fri,  9 Oct 2026 06:45:40 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B52B03F882;
	Fri,  9 Oct 2026 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791553543; bh=DD1Dd6zQCZIL1Q8on/NlVlUe2Wldo3fQEOD4meT8UxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gnLpuRokbn1clWc8EJwJHhsNy/Pb86hrST53B1KzKMlyIgxZehwb5uWYNwr3oOCJD
	 dAr7z4W2wZj60KnLrUHoeEsllqOyaRk9qT9U6IS7jDoRB7iX4OANYSmO3jgIVspmBe
	 UGog5Sc1MD57YnI2+FApvh7BCBCeCXf4k19knFp4=
Message-ID: <e055558e-7142-4fb3-bf53-19c8c929e51f@arm.com>
Date: Fri, 9 Oct 2026 14:45:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] iommu, drm/rockchip: Map private-domain imports
 from DMA addresses
To: Karl Mehltretter <kmehltretter@gmail.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Cc: Diederik de Haas <diederik@cknow-tech.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261009002114.67851-1-kmehltretter@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261009002114.67851-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2026 1:21 am, Karl Mehltretter wrote:
> Diederik reported failed video-buffer imports on RK3588 with
> DMABUF_DEBUG. The proposed warn-only mode [1] confirmed CPU-side
> attachment access in rockchip_gem_iommu_map() during Sway video resizing.
> 
> This RFC keeps Rockchip's private scanout domain. Patch 1 copies live
> iommu-dma mappings into another domain. Patch 2 uses it for PRIME
> imports. Unsupported inputs keep the old page-based path, which remains
> unfixed under strict DMABUF_DEBUG.
> 
> Rob's MSM approach assumes direct DMA [2]. Rockchip's attachment instead
> provides IOVAs from the VOP's default domain, which cannot be mapped
> unchanged into the private domain. Each import retains both mappings
> and adds one reverse lookup per 4 KiB.
> 
> Christian rejected reverse translation in the earlier MSM proposal [3].
> Robin NAKed exporting iommu_get_dma_domain() [4]. Keeping the helper in
> dma-iommu.c does not resolve the physical-address objection.

And if I'd had the context of the whole series, I would have said what I 
can see now, that the entire premise is fundamentally wrong, 
irrespective of abusing the internal helper or not.

> Sharing the first VOP's default DMA domain, as Exynos does, would avoid
> the translation but also change native-buffer mapping.
> 
> Is retaining the private domain and reverse-translating the DMA mappings
> an acceptable direction? If so, I'll address the remaining limitations
> before posting a non-RFC version.

No. If a driver has attached the device to its own unmanaged IOMMU 
domain then it is using that domain, not the default domain, and thus 
has even less reason to go poking at the default domain than usual 
(where the "usual" is tenuous enough in itself). In this situation DMA 
mapping only needs to take care of non-coherent cache maintenance, and 
32-bit ARM is actually the better example here.

The fact that iommu-dma does a load of unnecessary work and returns a 
bogus DMA address just to still get the cache maintenance as a 
side-effect is a hideous inefficiency (which folks have complained about 
before...) and absolutely should not be relied upon. It needs to go 
away. There were reasons why in the original iommu_dma_ops design it was 
rather impractical to do better (in fact iommu_get_dma_domain() itself 
is largely just a hack around some of those limitations), but since 
b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()") and 
particularly b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu"), 
it now really could and should be cleaned up - it just needs something 
slightly different from the standard dma-direct behaviour, as for this 
case we need to ignore the DMA mask and any bouncing conditions.

Thanks,
Robin.
> Base: mainline 602042bf29f6. The warn-only RFC is not a prerequisite.
> No stable backport requested. Strict-by-default DMABUF_DEBUG took effect
> in v7.3-rc4.
> 
> Testing (builds and QEMU only):
> 
> - W=1 object and stub builds passed on arm64, ARM32 with/without LPAE,
>    x86-64 GCC/Clang, i386, s390, RISC-V and UML, including dynamic SWIOTLB.
> - Rockchip strict/warn A/B reproduced the control failure and warning.
>    Treatments checked every page and byte in 83 imports each. Primary
>    buffers had 1/127/507 DMA segments under the default 64 KiB limit.
> - SMMUv3 strict/lazy tests, missing-source, bounds and rollback tests
>    passed. Real bounced attachments exercised alignment and pool
>    rejection with no target mapping or DMA.
> - Invalid forced-SWIOTLB Rockchip provider runs are excluded. Expected
>    segment-limit and unsupported-fallback diagnostics remain.
> 
> The rig uses a custom Rockchip IOMMU model and the real GEM callback in a
> test module, not VOP2, Sway or a real exporter. RK3588 hardware, two-VOP
> and 32-bit ARM runtime testing are outstanding.
> 
> Hardware testing is welcome, particularly with Diederik's Sway resize
> workload. Compare control and both patches on the same base/config,
> first with strict DMABUF_DEBUG, then with the warn-only RFC on both.
> Please report full dmesg, config, exporter and visible display problems.
> Keep a known-good boot kernel. DMABUF_DEBUG=n testing is welcome too.
> 
> Developed and tested with LLM assistance.
> 
> [1] https://lore.kernel.org/r/20261005064133.7305-1-kmehltretter@gmail.com/
> [2] https://lore.kernel.org/r/20261006131000.81501-1-robin.clark@oss.qualcomm.com/
> [3] https://lore.kernel.org/r/bd4e5ece-1358-4e0b-bb04-ba9de62d26f6@amd.com/
> [4] https://lore.kernel.org/r/47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com/
> 
> Reports:
> https://lore.kernel.org/r/DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com/
> https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/
> 
> Karl Mehltretter (2):
>    iommu: Add iommu_map_sgtable_dma()
>    drm/rockchip: Map imported buffers from DMA addresses
> 
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  19 ++-
>   drivers/iommu/dma-iommu.c                   | 131 ++++++++++++++++++++
>   include/linux/iommu.h                       |  12 ++
>   3 files changed, 157 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5

