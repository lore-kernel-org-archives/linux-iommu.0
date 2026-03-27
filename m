Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169473D75A0
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601012; cv=none; b=YVIslLXDF9+LyKklWp1/to3tFGXaGHb1eABajq18Jly1mdd650LpmYDBa8wh/rD6N0E1kK6X55AR4qsS3j9lNIgOZNzy5AQaLJAkG8XK9MXtZ+CeF+8pu2qI5ImWmoN+nKE1N+2S0K/MwPAATO05mghY8tTF2Trtevxoz7qdQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601012; c=relaxed/simple;
	bh=c4qhmYWqfFAdPSpKaXZVPgx+asSzL/8eDpH47ZX2TLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X25nchkJAdP4g6ukRCcSqTwTv0olMz+SPoLChktHUVPKd8H7BkSLKmyQX+z2V2pt8QeYb/sDY5mg1pX+Fcsf88kUMx5UAqHtdy3JM8vQEeXBvMd76zH8E6rduX38AGp7XOG3UE7HfZunYZ71DbvqXZhOCCQ92MSuPL9eqFeBLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=bZKTr1ZK; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bZKTr1ZK"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0100D1A62FE;
	Fri, 27 Mar 2026 09:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1774601010;
	bh=c4qhmYWqfFAdPSpKaXZVPgx+asSzL/8eDpH47ZX2TLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZKTr1ZK9Guedwdeh8At+Lq7d0f2t2CRTm7pt2h1GiMb3VG5/QeJzDXqoOAk/VX8I
	 ihWjNYR3vafJoRb5MEsieh0C4SLeiQx9iB4WOubdgsrtO/iNOxVud4uyvu5xMjcOxV
	 qNt+7rjdRqS0iXF7523akNu8jMAel++wIVoXfOfwL2W1ZFhJVTeAO5/vVCvoto0zyP
	 Jz6tnB/04owoF2phuwwbWaWj9tN1fr4qG2S3fHg2hguqOUeaqmLzZD9n5bhOJ2fIrh
	 Tad4XJNn/i20ncogNAGK9K8zYZT0IDIA5uyHZS9v0TdJYSxl9khFCLkxHw0GKAkfe1
	 sRgVWFJYHe1eQ==
Date: Fri, 27 Mar 2026 09:43:28 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: jgg@nvidia.com, joerg.roedel@amd.com, kevin.tian@intel.com, 
	vasant.hegde@amd.com, will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommupt/amdv1: mark amdv1pt_install_leaf_entry as
 __always_inline
Message-ID: <avxxdtn6x7ydl5scmdtllxaxc6dv3ffu7pyrv7xt3enqkrai4v@vfmt6flv55sa>
References: <20260326161719.1329502-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326161719.1329502-1-sherry.yang@oracle.com>

On Thu, Mar 26, 2026 at 09:17:19AM -0700, Sherry Yang wrote:
> Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
> ---
>  drivers/iommu/generic_pt/fmt/amdv1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
