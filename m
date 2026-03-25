Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E504292B2E;
	Wed, 25 Mar 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448209; cv=none; b=L8bIczU5NwHkpOAFbRL86CvZba9cSLdygCvzkswdspNYsGZ6lcH/cCyzjfmchF3EjE0QW2qzFS46nPfC6ikT23HpHLyo0n4xMvWRvHT2JRSLh+7UYQJfLjA9A0Tc7r/FJU7MoWPsI52UYoD4bdwoLf2JUt5/+G0mijsfgCqaqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448209; c=relaxed/simple;
	bh=8ngHDk8lWpxvFOPiWfS0KRFxiWHuNBJQ/GDAuJ99gWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP8LUpahFfj3A8ihnGIJdgQkq3GXZfCfsOFQ+QkNJxehxu+Um6nSQrDrx2y7aitCEPL6yqzgp/89xDlR4j7eAqilLg7n72C95JM7KcVKhRnE2cjuO3sknQhCiBZpQlYHVNijdnfTsKN1HPSimKJcbsCvcJi1BBbdsWdBL9GAtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbEu0mJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbEu0mJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294DC4CEF7;
	Wed, 25 Mar 2026 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774448209;
	bh=8ngHDk8lWpxvFOPiWfS0KRFxiWHuNBJQ/GDAuJ99gWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbEu0mJ2dvQV/K5tuQS9fLd/5QfQEZJ1AuXyxzFLEGHOPmX5Q5RgBY6Jb9MLmGgtP
	 KsXdOxp0Un8VMpdkZZOGbRjtlpT/NkkOP82QEqIB2TcMAdq/EqKujVy+tPpPvQIkv5
	 GbYswH+1Ovsc9ReRSRi3irUbs9cbqZCSAHKsmXELTAWcvrkD9tj6Dw48Cp+Oft1n9j
	 1oQBHLA5Jew9pc0r+xH8xc93+iTk5hiDatPmX3eECeN8S9hy/8aG+afOr90uhU3zf1
	 g/CvKeLb54HC8JWQKCb0cTXVUoiXukXE4RvG36Z5jozMro9gcDV3tXQCzc5Yt/a4O4
	 77Agr73H0j61A==
Date: Wed, 25 Mar 2026 09:16:48 -0500
From: Rob Herring <robh@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 0/7] Refactor reserved memory regions handling code
Message-ID: <20260325141648.GA2685599-robh@kernel.org>
References: <CGME20260325090029eucas1p1932917cc4839c3349932aeda37a7125d@eucas1p1.samsung.com>
 <20260325090023.3175348-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325090023.3175348-1-m.szyprowski@samsung.com>

On Wed, Mar 25, 2026 at 10:00:16AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> The reserved memory regions handling code was reworked to handle
> unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
> reserved_mem: Add code to dynamically allocate reserved_mem array").
> 
> The side effect of this rework was a set of bugs fixed later by commits
> 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
> "cma=" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructure
> call site for dma_contiguous_early_fixup()"). As a result, the code in
> drivers/of/of_reserved_mem.c became a mix of generic code and CMA
> specific fixups.
> 
> In this patchset I try to untangle this spaghetti and perform some code
> cleanup. I hope nothing breaks this time.
> 
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 
> Changelog:
> 
> v3:
> - fixed more issues pointed by Sashiko in
>   https://sashiko.dev/#/patchset/20260323100901.4079171-1-m.szyprowski@samsung.com
>   (restored use of _OF_DECLARE macro, extended some comments and commit
>   descriptions, the remaining items I consider not relevant)
> 
> v2: https://lore.kernel.org/all/20260323100901.4079171-1-m.szyprowski@samsung.com/
> - added missing ops assignment removal in tegra210-emc-table and swiotlb
>   drivers
> - fixed issues pointed by kernel test robot and Sashiko: removed typos,
>   improved comments
> - fixed incorrect node passed to fdt_validate_reserved_mem_node() in
>   fdt_scan_reserved_mem_reg_nodes()
> 
> v1: https://lore.kernel.org/all/20260313150802.1121442-1-m.szyprowski@samsung.com/
> - initial version
> 
> 
> Patch summary:
> 
> Marek Szyprowski (7):
>   of: reserved_mem: remove fdt node from the structure
>   of: reserved_mem: use -ENODEV instead of -ENOENT
>   of: reserved_mem: switch to ops based OF_DECLARE()
>   of: reserved_mem: replace CMA quirks by generic methods
>   of: reserved_mem: rearrange code a bit
>   of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
>   of: reserved_mem: rework fdt_init_reserved_mem_node()

I've applied the series, thanks!

Rob
