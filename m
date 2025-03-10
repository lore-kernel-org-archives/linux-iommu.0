Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C532153D6
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595260; cv=none; b=EgPNdDlMdE11/6cv1ssa9+nnC1wXRT5/tsLaRbJmvl9dlPfChd2mKAi6PpvicGBWwke+KdNkaHL6/piOj1YpNgU+1nG4Lq8QQ3bcbR6WGYA508vqjJ2Lqx0SML7uVzfHMJAnFeY80tJdOtdIuE9y8iEj+Qmx8lUNNQ6GtNHvqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595260; c=relaxed/simple;
	bh=1o+7ggk9WDZWvfla43JRTpkQ3w/evmZjcXwD4DtKZ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tes2ZkV8Bik8+35GjdeVhyB0e1mJuXYnAwB8M4YEiFV0zpgKtL+M42GF7a5q+YjdhzmQrt3+ObVnqNaa1I+LMpJbzEPogwLdCs797clFTivorodURIRwjGyOM0qI2w8Id2sW+R7t3YRgQWgvnDuixsfNeHU1IzzbyvNN6p/z4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ilhlr305; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ilhlr305"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1DC8945229;
	Mon, 10 Mar 2025 09:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595257;
	bh=1o+7ggk9WDZWvfla43JRTpkQ3w/evmZjcXwD4DtKZ70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilhlr305aJ+jSOqwC6m+9AL/BJRtDbHhDaCJszSvjdmHDVfAuEf51P9V9QqI12ChE
	 yXkzwDAWjiqNS/LDZwPWndESaOA14rHjqHwP4RWsItYOY+jGw1iZ6T/yDkny4odYBR
	 vFG+wV6TaQcUPNseMkGmOWDfMrk6inhtLD7hv0p+cVSPNlB/CuzKfXsYCqnZnEFtj9
	 wMbbWyVn6/5IgA7tLpjtZEY9bDjSKblyh6LIdibMa94r1zATO+oangQUuDuMM/OQ26
	 E+H8bFuGlNs44CZ7apjaUuIf8rL/jlH7iBVAu44uMDQO32AsKxcZcOVYYMVehs57JA
	 WhOPBPmZtlT2A==
Date: Mon, 10 Mar 2025 09:27:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@nvidia.com
Subject: Re: [PATCH v2 0/7] iommu/amd: Trivial fixes
Message-ID: <Z86ieFUA6Fj6emdU@8bytes.org>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>

On Thu, Feb 27, 2025 at 04:23:13PM +0000, Vasant Hegde wrote:
> This series contains minor cleanup and trivial fixes.
> 
> Changes from v1 -> v2:
>   - Consolidated protection domain free code and removed
>     protection_domain_free()
>   - Added Reviewed-by tags
> 
> 
> v1: https://lore.kernel.org/linux-iommu/20250225105345.52143-1-vasant.hegde@amd.com/T/#t
> 
> 
> Vasant Hegde (7):
>   iommu/amd: Log IOMMU control register in event log path
>   iommu/amd: Remove unused variable
>   iommu/amd/pgtbl_v2: Improve error handling
>   iommu/amd: Remove outdated comment
>   iommu/amd: Fix header file
>   iommu/amd: Remove unused forward declaration
>   iommu/amd: Consolidate protection domain free code
> 
>  drivers/iommu/amd/amd_iommu.h       |  8 +++-----
>  drivers/iommu/amd/amd_iommu_types.h |  3 ---
>  drivers/iommu/amd/init.c            |  1 -
>  drivers/iommu/amd/io_pgtable.c      |  7 -------
>  drivers/iommu/amd/io_pgtable_v2.c   |  2 +-
>  drivers/iommu/amd/iommu.c           | 19 ++++++++-----------
>  drivers/iommu/amd/pasid.c           |  2 +-
>  7 files changed, 13 insertions(+), 29 deletions(-)

Applied, thanks Vasant.
