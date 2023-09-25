Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E7B1428A
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 10:05:38 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 178B61A225C;
	Mon, 25 Sep 2023 12:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695636337;
	bh=DQaSg2H0j5elvnSsey3JSr+pUPErqmdu3mcNBqrqJ4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4d1kXzQffCS+Gs2hfv57CxjKtt/i4jBH7gXRQIguUoJ4iRVyStoAGg73utxAPDA8
	 q+aIJWHcj24jXOkQZ4dXk3A5wxpIGbciBBXrUVUqTFu93PPXLmhE8oslaWLFFjzG7f
	 FHIzeNN6sEseln/k77EoX6SEL7bpLZGXrns+Ir74+TjT7oiaCQxkOSoZzLg8J06CqC
	 jLncQvxPgE0yBQqddRn5UmcINF2wvHIrHQ41glQ/RF1YUfvBuY4mG9MkhaP9lDQ7dP
	 YWyPX99SbHrPG8ExJdEvWcJg/Hj2Qwtyybctl5dsh+mILfUFQErOh4KSCXi1whCAFz
	 skaGvYpEmqU2A==
Date: Mon, 25 Sep 2023 12:05:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 0/8] iommu: Clean up map/unmap ops
Message-ID: <ZRFbbyxB0AwC-V_5@8bytes.org>
References: <cover.1694525662.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694525662.git.robin.murphy@arm.com>

On Tue, Sep 12, 2023 at 05:18:36PM +0100, Robin Murphy wrote:
> Robin Murphy (8):
>   iommu/exynos: Update to {map,unmap}_pages
>   iommu/omap: Update to {map,unmap}_pages
>   iommu/rockchip: Update to {map,unmap}_pages
>   iommu/sun50i: Update to {map,unmap}_pages
>   iommu/tegra-gart: Update to {map,unmap}_pages
>   iommu/tegra-smmu: Update to {map,unmap}_pages
>   iommu: Retire map/unmap ops
>   iommu: Improve map/unmap sanity checks

Applied all except the tegra-gart patch. Tegra-gart has been removed by
Jason in a previous patch. Thanks Robin.

