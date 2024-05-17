Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33E12FB33;
	Fri, 17 May 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963867; cv=none; b=YEeLSjNVS6bzKHyv8DD4+WKVcZv+YpPXf/tVqK0Nrf9Gnc9OcGvxCiDevHalO7RbqYR1GdguM1/DGqlZLhtj597a2RYQ/2Ad+xIRzmCTJEmKskZACwxlXhSlGIxWpi0GTMZ6V5TbeJYMe+0HI2y5HtGmThF8FWNpFyAs3O51qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963867; c=relaxed/simple;
	bh=gA3mNN9MSiUL2l01xoNls8gykjiUtJVzzR6Yjq2NXA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf6p973oNT0z/8YUCkagpTVA6wJ4xtXOTF2IUrt5T3ChVJUQ1XlO4lgdWqtvDLrVhFh95ObqkxzL4fewaUTkSvJY5dsLfFOsvGsDX7uykAE1WI2JINkAYnC+/iLRH1P8UhnXSZ4yzs4MgUmKz4raETOfUcXuzi0GmY5znm9fGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt6AWjSH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt6AWjSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB186C2BD10;
	Fri, 17 May 2024 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715963867;
	bh=gA3mNN9MSiUL2l01xoNls8gykjiUtJVzzR6Yjq2NXA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lt6AWjSHgZTioAB8W3Cl7gBYgJ06Fj/XwuSJFRHTZaCxs5+9k8l4+9RL06sWr5reR
	 5Enz+EN/pSoXlIIKh1hghqoX8L/h7oMVFr9LSm+2TpRayQwTBzZiUWmViloILf1XuL
	 zeE+s+ROfP/ri7VVZ0O+O5xQhSzYU3vD47TWcsAXTjwSE8O4IW14GBlH2m/BlHHI6e
	 iXSYlOzimRvjkWnMs6I+8CvZEIQr4STvetqtfi3pt4IgehHeu3PpT1qwPGklucwDv7
	 a/5IdQtZ8hEVUAYJwmpWABIf0FhsKfpscAwz7o9VYf7MoEAAZE6s6ySZbf4snxy9tk
	 XKhPffVTmGYwA==
Date: Fri, 17 May 2024 17:37:42 +0100
From: Will Deacon <will@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Stephen Boyd <swboyd@chromium.org>, Chen Lin <chen45464546@163.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
Message-ID: <20240517163742.GA525@willie-the-truck>
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Doug,

On Mon, May 13, 2024 at 04:13:47PM -0700, Douglas Anderson wrote:
> On sc7180 trogdor devices we get a scary warning at bootup:
>   arm-smmu 15000000.iommu:
>   Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK
> 
> We spent some time trying to figure out how we were going to fix these
> errata and whether we needed to do a firmware update. Upon closer
> inspection, however, we realized that the errata don't apply to us.
> Specifically, the errata document says that for these errata:
> * Found in: r0p0
> * Fixed in: r2p2
> 
> ...and trogdor devices appear to be running r2p4. That means that they
> are unaffected despite the scary warning.
> 
> The issue is that the kernel unconditionally tries to disable the
> prefetcher even on unaffected devices and then warns when it's unable
> to.
> 
> Let's change the kernel to only disable the prefetcher on affected
> devices, which will get rid of the scary warning on devices that are
> unaffected. As per the comment the prefetcher is
> "not-particularly-beneficial" but it shouldn't hurt to leave it on for
> devices where it doesn't cause problems.
> 
> Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)


Just curious, but did you see any performance impact (good or bad) as a
result of this patch? The next-page prefetcher has always looked a little
naive to me and, with a tendency for tiny TLBs in some implementations,
there's a possibility it could do more harm than good.

Will
