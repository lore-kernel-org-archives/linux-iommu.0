Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F0426693
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535867; cv=none; b=Vh3RCmdy6H+v+yJqFAQ1rZZnFPsfL9cNZh7yB0fjnfpzh1695zGsff0XZ7DM8EUlh6RMLpk+pj+KQEx4ER6mGmTPvbXTpnnSV0H5jENH+8bZwlnrqWYBbSnezuhQPrCSwJYbD7FQzIOZvMBSf9N+04kRup/QAag54YcGrOGi6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535867; c=relaxed/simple;
	bh=92fSs2xz3FU0UFlQ2cAFInK1+NWg6+T1Q4bclgsnaOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+wAM+Q+egr+atgEpRv/+v/vl5xiACxV2h2VrCG/IsFMLeKoaboP+KjtmpkgjXjxqLEh5+2QoI7/OopTtmmLv/IWzTgg9Jt0QXmdxXs/4KmCj2xVnGLPtcMd7DTg6OEl1rzJzxVqbQBtzrhpUKho4cCD6vDzsiVeMCjX13IavsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AD38A1C77A4;
	Fri,  9 Oct 2026 10:51:03 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:51:02 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, jgg@nvidia.com
Subject: Re: [PATCH] iommu/dma: Clean up redundant MSI cookie check
Message-ID: <asiq6U_zcZdqoAoi@8bytes.org>
References: <214eb3e383431f48b517c4bd2ba4f329579a442e.1790958898.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214eb3e383431f48b517c4bd2ba4f329579a442e.1790958898.git.robin.murphy@arm.com>

On Fri, Oct 02, 2026 at 05:34:58PM +0100, Robin Murphy wrote:
> The has_msi_cookie() condition only mattered transiently as an artefact
> of the cookie rework being done in parallel with the sw_msi rework. Once
> combined, calls to iommu_dma_sw_msi() are themselves dispatched based on
> domain->cookie_type, so checking again is clearly redundant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 11 -----------
>  1 file changed, 11 deletions(-)

Applied, thanks.
