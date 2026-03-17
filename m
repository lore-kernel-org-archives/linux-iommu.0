Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D33C5DBC
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750540; cv=none; b=NHv1vw1TAgCE0MDrevbwCVbKECNCbre+nJpX7Ey7kmzNSdX7+W3U43DVnYkid7ht105Gx8lxchsi3t1pXJgpHWfQhXfTPJaSLHudD+5t2W9fLEBZsFyTOTO/64kg2JojTL+QvKGJxT3dMIE/Wma3TF4zmB43xjF5OPbFbG4tJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750540; c=relaxed/simple;
	bh=jyPQW8zhu/nS1p5DspQ8+bXuxeWJXB8HiHs8gHdQ4N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzUdl/z/tzp5YLULZuBuykxGbFFJMFd9kFVg1tXHwExhlZl9h3KDoP9GxwTIYKgSW59Gp2BImDVPJWeQ+ogxNR5cyZaR8eJw9vylLcxYvx1iY5lY7YTJG1/EIYGBT7lYxYTZ6nZMuM8IWfzyJMgOCw46sHneKVpcYTpnd3bghaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=be4up0kH; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="be4up0kH"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 687291A52C5;
	Tue, 17 Mar 2026 13:28:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773750536;
	bh=jyPQW8zhu/nS1p5DspQ8+bXuxeWJXB8HiHs8gHdQ4N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=be4up0kHjdXKwus3fVSokWxD1zKGNGfZI+wwjhtE4McbTe/gUgoYngwhPlVZMuphA
	 1RlG9ybfRWnJhi1Y989a0ZglVYUE13aZV4CYkemTMmJn+skvKN0SJNyc6VsbZeobpl
	 RKN1ww+xw9DbnCvb/n2B9AuNiHdvEfupRZflBj+zwBUKUVlZSHiKI6MVrlQndw4iQL
	 UhVY6PIZwMy5pREyyVm/FVlqdGXxSfXrvnPeNQxMzFJfGruyuEOzfI+oJng+d4riC2
	 Wwtk93o9Hq71ulXqA6ZW+l3WlrXWT9sY5eGBTIZQkMI6IVUVsLjT6zWz5JMWncuJPH
	 SJlqMnLwlI2ew==
Date: Tue, 17 Mar 2026 13:28:55 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Lynn Liu <liulynn@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: Add NULL check in iova_magazine_free()
Message-ID: <hklnp5utjnu433k55hwz44z2oblqmw62fyxhrbfkoeo6benwh5@umkl2nusu3k6>
References: <20260214080919.390846-1-liulynn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214080919.390846-1-liulynn@google.com>

On Sat, Feb 14, 2026 at 08:09:19AM +0000, Lynn Liu wrote:
> From: lynn <liulynn@google.com>
> 
> When iova_domain_init_rcaches() fails to allocate an iova_magazine
> during the initialization of per-cpu rcaches, it jumps to out_err and
> calls free_iova_rcaches() for cleanup.
> 
> In free_iova_rcaches(), the code iterates through all possible CPUs to
> free both cpu_rcache->loaded and cpu_rcache->prev. However, if the
> original allocation failed mid-way through the CPU loop, the pointers
> for the remaining CPUs remain NULL.
> 
> Since kmem_cache_free() does not explicitly handle NULL pointers like
> kfree() does, passing these NULL pointers leads to a kernel paging
> request fault.
> 
> Add a NULL check in iova_magazine_free() to safely handle partially
> initialized rcaches in error paths.
> 
> Signed-off-by: lynn <liulynn@google.com>
> ---
>  drivers/iommu/iova.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
