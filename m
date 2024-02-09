Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B6200AA
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475589; cv=none; b=svdhN/hVd1ZjiTS1bjlw6YPOqxznLGo2wICLAnrm0y7BnCrAahKVSzcTVjYyUAvO680tpdDdqBroOPIiz9e5Y3SjeWAe9s+77okantx2ARRzIvOqtZ2pIOMfc0a/cZSb3jA+wEw2yHI8w2Ezk7B4moABn/vwxoSVwpK4Lv0fBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475589; c=relaxed/simple;
	bh=R4zI6wIUf46yPiyX61w0UDvPrA06pOplQ7fo93S+tZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q89saG/Cne6ZnYlTrwsagsEIanwMHr18KeRyINBxbmIDNw0c1NFLS+uyGgeNkggno2HGl/5Dt8A1pe7rkkqPCZvknnEvrDcJcxKvv6O4okxEG/MBX475j6eOvtE5HDq6eMghBLjJvHe0ZF7C9+qGghha0pjcKm19xOX7+rHHMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=dVuH+1j3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="dVuH+1j3"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 83EAA1C1D36;
	Fri,  9 Feb 2024 11:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1707475585;
	bh=R4zI6wIUf46yPiyX61w0UDvPrA06pOplQ7fo93S+tZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVuH+1j3/F7ogwIRlrKLa5RFqdM74UUiiWbUg2DBZKpskujJKavViWbBE2R5u/i3u
	 WwebLeg6OCce0dwepFhAzKh1ViSxASfmYFsYV0NGT9Sq5N/x54oTcIgL8m+lGaYLTT
	 fF8EuAyjX0qTucZqzMTFfPUpl6Mxcr2hOcWZnFksx3cGIVEuH+4dHuRoRcHiShBGsR
	 LVIb9uUeY5OG2dWwBpBqJ2Bq9lrUPWS66Ol87EKwBiPixrgNVzhQ5U5uXU/5On2+QM
	 KbJ3uOa5b6d6+y+fYMzz715z9i1nULpDNGAiKKtXChaIS5qfwKsRPsoUz9nyr82NBs
	 zr7H8zufVeWzQ==
Date: Fri, 9 Feb 2024 11:46:24 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, pasha.tatashin@soleen.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rientjes@google.com, yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 0/3] iommu/iova: use named kmem_cache for iova
 magazines
Message-ID: <ZcYCgG2V_x6o5PFM@8bytes.org>
References: <cover.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707144953.git.robin.murphy@arm.com>

On Mon, Feb 05, 2024 at 03:32:38PM +0000, Robin Murphy wrote:
> Pasha Tatashin (1):
>   iommu/iova: use named kmem_cache for iova magazines
> 
> Robin Murphy (2):
>   iommu/iova: Tidy up iova_cache_get() failure
>   iommu/iova: Reorganise some code
> 
>  drivers/iommu/iova.c | 143 +++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 67 deletions(-)

Applied, thanks Robin.
