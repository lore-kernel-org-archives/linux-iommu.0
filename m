Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39637B41B
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921678; cv=none; b=iCCau07Piq4liL/pimjHf3W2SxJHxs7w4T1b4rkPz47FAAmF1Ly8sqoa28t1fBznHCvvixjOa9sPY4QhtBktjTnyDLh5mVse7G64g/mINoRdblzQwCAGGhOXuk5w++OOqDmZaIigdsrNIpdWN14wkNz9IoSbspbwe5yUhBi1Ysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921678; c=relaxed/simple;
	bh=DxcoaEYoLChrj5grxWa8igvy3Cb20LS0Uf4S/T1ix3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeYNIWCPSdMpDRC6c+SpnCeohQTO9aCGdhvIojNASB266CAWtyYTS5/oY7jBM8aSXKENJ2WxuD5rHzp4/HHJt6tJD3usd82oSmVT/iqFJ+vPKbvL5wuvEzfxI1hHnkbeNqVvqe3jnG5zty8swnMrB/GS0H1Mb1U3YiHPuwxOwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrOmA5UA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrOmA5UA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD81F000FF;
	Sun, 20 Sep 2026 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789921673;
	bh=G0aH2QteQlvith2oeQOpW/91R4PxOs+itHsYqMZOYZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nrOmA5UAxZMflC9DFk5u3xGNfwl7/aB8h5SX2oIZh4DS6YMmDmOOrLfOshIP910dM
	 th0PiVXPq2uHp0RkVVAJypflZrHljyb64bJKopULaHhBx7mb3kCufafpa4aD40dVWn
	 vhJarQyhw3nw4yhI8ydmFNUR889+2sfJ3RZ2zdwRKKH9qcnA7UJTioD643EZAitPdB
	 dAIoofcKtZaUGh1oN5p8FrdEtiu9eZyK4g5H83DqGLRset28TU87ohm4Yd/FF2dXBs
	 TgUugxxhOS+vSAbrJynkRBAQQqlSsQP9MPs47JCSotIWRyujgQ5Mtna4ISL0vZQvZ3
	 TqRV6JQBZ3m1A==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id E35D6F40066;
	Sun, 20 Sep 2026 12:27:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 20 Sep 2026 12:27:51 -0400
X-ME-Sender: <xms:hwmwag-8OZRzozfhb4hAR1s1sWhhjwKEAIhkulRcUHz53Rta1nYNBg>
    <xme:hwmwaqTJDI7p1POnCDegfcDn3sL402NsO16qEyTTJzhsttCxMFmJ2BzyiVhlDsHyw
    B_1IHLWOem_L4DeY2dZG6FLPcQq5lNvElX4OgAlhD7GjgyDhppwkL8l>
X-ME-Received: <xmr:hwmwalTJVVr90M0Lz9gs3itxD51n1ZrVGfB5fV0EJcBC8u8IYC-mbBSPp-wT>
X-ME-Proxy-Cause: dmFkZTFQBlKfBejJMxy2fjGQd5Zy/4Jgy+UYZkOSEq/hJ78JRDrZC4yIeRSwVK3b1Zxn8y
    33HaMdrV3pAIigfYfzOnP/+owvFCZsOnO79Uqx9cUnZopkWFBicGWCd+wHlO6ltJFC8hSB
    hkmOiy1t1TfccKXd4k3BCUw1FJowThmHAOk0vsorkhA/d3f3Kqt5CPZojdNG/lWBSnHXFs
    gDX1qfRIt1eHECd5lxI5mfbS5yzupoOkUgiC3GTSKrosvFnlzgdOofwRJ/xtC2u2K/4LaX
    dAhydxr/MVt9T36adpwpTPxNawIfSufU8D/JOsBDiLg80GsAlzskZW+3NPhcDp3Iwn9Bd2
    WcfcH07s+9v83iSDHyrv5ZrPTIGT4SNVEr1xaUYHmk4pUXQVPOhl8BWcU8ixal4JixYvdM
    RVLISF07fDnpXNClLIaqCzbotiO0xq+OzIgv/YQfBDfi5OmAfLPLeWHQjPmH3jBR/i2nHA
    AwigZLfEexqQcBKmo3L9cvXRD6Cb0REpAgJW6EUvrVsPNpguLToc5/hidujuhfslqFCel+
    wzcdpdte77Ilf2A5ptw5C8PnYACp22kSm4tnkp1OxbFUbvzIlkcO06Am6gU6ek+gm54Buk
    U+vbGK1sP7CxxU5kClsxOgLPa7/5AAiOi1PNVkxh8IQh/0NcdXE1pd7qiZXQ
X-ME-Proxy: <xmx:hwmwam4C1yVFwOvoblge-DNE-hK-N_i7bmOwusoWb5z7jbs1ews83g>
    <xmx:hwmwaqXqu7P2cZGnuUy3AKovz3mgex_Nv-ejuBqBz1W2trNOOuwsrg>
    <xmx:hwmwas-kWRTdFBGb-OTmmOfiVBBpFkc5-gCet1WPI9s5i2vuyPVBow>
    <xmx:hwmwaqpHASIpK3AAhFH31zGDgzFU0O304JRD2crrQ7ebj7NWmcN3ig>
    <xmx:hwmwavLeE4Pj6lNRTqJt5dAfu_zmEfgQqNJgWfoIupa6NLnJ2RFxDa0q>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 12:27:50 -0400 (EDT)
Date: Sun, 20 Sep 2026 17:27:49 +0100
From: Boqun Feng <boqun@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>
Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
Message-ID: <arAJhXi14ptZRkcP@MacBook-0RXW5>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-1-mario.limonciello@amd.com>

On Mon, Sep 07, 2026 at 11:12:05PM -0500, Mario Limonciello wrote:
> Add support for the AMD IOMMU Performance Optimization (PerfOpt)
> feature as defined in the AMD I/O Virtualization Technology (IOMMU)
> Specification, Section 3.4.9 (MMIO Offset 016Ch).
> 
> This feature allows privileged integrated I/O devices (GPUs) to bypass
> the IOMMU when directly accessing system memory.  The IOMMU only
> enforces the IR/IW permission bits without GPA->SPA translations.
> 
> Drivers will opt into this behavior, and enable amdgpu to turn this
> feature on when an integrated GPU is already in identity mode.
> If a user prefers to keep it always off (even with identity mode)
> there is also a module parameter to force it off.
> 

Our GPU memory accessing benchmark confirms the improvement: without the
patchset, GTT is 2x - 3x slower than VRAM, after this, the latency gap
is almost gone (within 10%). Nice work!

Tested-by: Boqun Feng (Netflix) <boqun@kernel.org>

Regards,
Boqun

> v2:
>  * Rebase on 7.3-rc2
>  * Adjust amdgpu parameter behavior
> 
> Mario Limonciello (2):
>   iommu/amd: Add PerfOpt IOMMU performance optimization support
>   drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
>     identity domain
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
>  drivers/iommu/amd/amd_iommu.h              |   3 +
>  drivers/iommu/amd/amd_iommu_types.h        |   7 +
>  drivers/iommu/amd/init.c                   |  43 +++++
>  drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
>  include/linux/amd-iommu.h                  |  11 ++
>  8 files changed, 341 insertions(+)
> 
> -- 
> 2.43.0
> 
