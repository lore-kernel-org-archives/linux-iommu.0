Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C30EEC8
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839300; cv=none; b=D1BmhRFjG7VOJGblFryD/kaof5RUgbkJTQnPRNiBY0ASvq6gVnJcbcnpG5xmm6BBAFNB1zmvbl1PyhmsDpp7NrA/Aal/u1prJPAPhG6JK8fNLIea1zIm5gtBsAlFnbChOLn8ueA0yoXKjaLAcoAe2ikbwZeB68ZQ7UfxXRZcjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839300; c=relaxed/simple;
	bh=jFrsfwfTYQ7dXpFsD3Sru6Up31GNZknEmTipo/HFJpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOPm1gfihgo2Ecq2RQKrVdg0l9mhWp9+Vowap03uWQkYvWhp9OwLriirQa184IGgBAZws8EKKx4xJ5wnL1YdRlL0L9ZGN5aPXLR6dFFQ74eN3yYj5wG2Qui+h3nEo6KOMuIjHcoqCQ4xITvOd8ezSe5Y3YChJSh+M3nrwZEhsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=SEGxtmmi; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SEGxtmmi"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E970549624;
	Mon, 28 Apr 2025 13:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745839298;
	bh=jFrsfwfTYQ7dXpFsD3Sru6Up31GNZknEmTipo/HFJpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEGxtmmik/K6fkhQ4NI7uolht/jxJ7Ow0ZNIw3eNPKa8pjma84lXMpx/iXv2B86PQ
	 JSJlW+c1oBtgwt6dbQucGX8vwX1GDzZApHdak3F2/jwrdVDBKANcA0q2/73qlZZqsw
	 SMxUZMOQch6JXX+1xunhxpCEH6h4Opx7sfEp61vCetlgFNS6BodM0F2vGnjfO+HPDZ
	 vUgIgAPLhkTLSZXOcwwtnptLaLxVvNqACg0Z/VWxtj//g579KADmF/6DcS21NvSBVA
	 s6mhQ9zZ8ikEBXHQ2HqE1a+6JZLrVC3kZFM6/az/rdGTyXQAdGGWi+qWCjJVkx1m+T
	 TpHLA1UysTlIg==
Date: Mon, 28 Apr 2025 13:21:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
	Rob Clark <robdclark@chromium.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iommu/io-pgtable-arm: dynamically allocate selftest
 device struct
Message-ID: <aA9kwHff-88QVkLa@8bytes.org>
References: <20250423164826.2931382-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164826.2931382-1-arnd@kernel.org>

On Wed, Apr 23, 2025 at 06:48:16PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In general a 'struct device' is way too large to be put on the kernel
> stack. Apparently something just caused it to grow a slightly larger,
> which pushed the arm_lpae_do_selftests() function over the warning
> limit in some configurations:
> 
> drivers/iommu/io-pgtable-arm.c:1423:19: error: stack frame size (1032) exceeds limit (1024) in 'arm_lpae_do_selftests' [-Werror,-Wframe-larger-than]
>  1423 | static int __init arm_lpae_do_selftests(void)
>       |                   ^
> 
> Change the function to use a dynamically allocated faux_device
> instead of the on-stack device structure.
> 
> Fixes: ca25ec247aad ("iommu/io-pgtable-arm: Remove iommu_dev==NULL special case")
> Link: https://lore.kernel.org/all/ab75a444-22a1-47f5-b3c0-253660395b5a@arm.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use faux device instead of platform_device, as Robin suggested.
>     The faux device is more appropriate here since the is no actual physical
>     device, though on the other hand the v1 patch had the advantage of not
>     actually needing to register the device.
> ---
>  drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.
