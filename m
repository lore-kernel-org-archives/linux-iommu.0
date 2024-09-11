Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6C185606
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059307; cv=none; b=eo8IfHyZ3bucPidPLLDKOoZ/x4/r8wonxzPKWAC8LXEUjsTD+kgHECM64Hz9BvrxvenXM/iS/WEcepUAUr2qle4SDhvZht6phva/SWtAK3MmfEtpZWeolwWX9BI8yx58y07SjsTMnnCRHBNADLWUOSL0t1+1/QYE1rcsn8+r7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059307; c=relaxed/simple;
	bh=P2X2f/Vt21m4UEENdFSR9DCNS5Bzz8h38CsrE0XkktQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5Ba1/lM6Cf5MNKfb8FqbYFPgrZALXXKP3qsn7xXlx4z9dwYQQn1xn0X/guwGMSrgb/mx/1lRLEFF02h9gIoXCY+1sQu5w/Kw4XZURxIIENqkXAOvFDf4rSmv0XXHbgnxYprtyZy+2erY7iViTtTtIRIM+ZpSxrI+DVDEujtewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dZgD4TQc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dZgD4TQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726059297;
	bh=P2X2f/Vt21m4UEENdFSR9DCNS5Bzz8h38CsrE0XkktQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZgD4TQcl2yjaIbLz6I/my0M2Zm3WILSoj5NF6ugqLfl0YrZmxhcdmPYIJAMDkTf7
	 XZ++yRQGoXbj6IfLmcRdZVUd7k+RP1E9wWWQQcqEelgDQA8ugwAlSegZmO4l0qKywz
	 +zbgp7F0NbhHnhlpR2XNChseV2uGVU0o/+9rtYjx6KT+SOYVTZ1KDj9k+6pFKaJijk
	 zPYdq+Opw3R4rg21BsTpwwT4eAtRMo8TKiX7gd0MGD90cXXZtYhar6NhFh5MEX6oNc
	 FrQDYR9+1dIwu71vVGLJ5cD5M00o8eFf38Mjha8SJukO7/BDE/vJuuD5e74t/OHAU0
	 xhfa0eUzBswbg==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE0D717E121F;
	Wed, 11 Sep 2024 14:54:56 +0200 (CEST)
Date: Wed, 11 Sep 2024 08:54:54 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: reliably inform about DMA support for IOMMU
Message-ID: <b33079e1-b370-4584-90db-2737f49b2751@notapiano>
References: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>

On Wed, Sep 11, 2024 at 01:15:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> If the DMA IOMMU path is going to be used, the appropriate check should
> return that DMA is supported.
> 
> Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
> Closes: https://lore.kernel.org/all/181e06ff-35a3-434f-b505-672f430bd1cb@notapiano
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thank you for the quick patch. It fixes the reported issue.

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
