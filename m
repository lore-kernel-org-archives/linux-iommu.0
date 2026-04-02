Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CD31077A
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115123; cv=none; b=OpuyyMl48Mclta/TAcfg+RA++TSV60gMLBwvs3iDHwpP04sX+VJ3U5dGUbSSWk2zjp38ul0+d5eRlnXWqdc7ZGC8mq4yBU9I8QijOSU0QrzkWpBSg57H6wKZrp+vPjWMU7qjVh2xXlSYCHjpC2S/FdlwrX+M5yIffay902Xv4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115123; c=relaxed/simple;
	bh=jPrWKMWREMrczXN9IDriVeXDnQUMyzhMOjWORppLPnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQZagTrGTHR7s09WsGEvuYV0A1uEH/zS803oncxOPg0pnMocFcvv/ISdyngF4V+maG0uqU3xv6EV3VTOAd+UA4xvRF5tQgkZOjFvzZByhqlMIDGkTrdHIUHi1i9hc9oLkm+CC1HRryEeD9pVqClmk429RMh5RAFx1NKh0nDsi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=qV/NL4T/; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="qV/NL4T/"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3A9F81A7158;
	Thu,  2 Apr 2026 09:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775115120;
	bh=jPrWKMWREMrczXN9IDriVeXDnQUMyzhMOjWORppLPnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qV/NL4T/oSX+vvYWl3AOAReBcyN/oU32mWZN5QcjKJ5e/kBCyLg/NMGetJeNXUcN1
	 zBD7985vJ3CDLtwuF8yzGpf9agDtCDDsav4Lrtr+NBpAJseCzW1hFO0scXA+Bxy7Vw
	 SpUvWCMBBhpmt+3VDSjwYREJZ1wGlvhuT5btxjO0fBVDaLd60P20RF45EGESNQbGne
	 /JoN/UpZTcAufmzOcfDNeuXFCe9Nwswg26wG/5rsnGyCLOpikLTFmwho1FIaz7PfKG
	 0DPzrPQUmXevt5+bd1X9IzNgnuLu8LERb4NYww1AedPrXieQpu2SG1SrvsSkiaMGkS
	 dr2ybfYUVaNvg==
Date: Thu, 2 Apr 2026 09:32:00 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, magnus@dolphinics.com
Subject: Re: [PATCH] iommu/amd: Fix clone_alias() to use the original
 device's devid
Message-ID: <o5t3yjcifueadjk6x6kdlzy6i7qaygsnat4dnddtlgjdfll3cw@llcuoykkcden>
References: <20260401080017.117549-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401080017.117549-1-vasant.hegde@amd.com>

On Wed, Apr 01, 2026 at 08:00:17AM +0000, Vasant Hegde wrote:
> Currently clone_alias() assumes first argument (pdev) is always the
> original device pointer. This function is called by
> pci_for_each_dma_alias() which based on topology decides to send
> original or alias device details in first argument.
> 
> This meant that the source devid used to look up and copy the DTE
> may be incorrect, leading to wrong or stale DTE entries being
> propagated to alias device.
> 
> Fix this by passing the original pdev as the opaque data argument to
> both the direct clone_alias() call and pci_for_each_dma_alias(). Inside
> clone_alias(), retrieve the original device from data and compute devid
> from it.
> 
> Fixes: 3332364e4ebc ("iommu/amd: Support multiple PCI DMA aliases in device table")
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.
