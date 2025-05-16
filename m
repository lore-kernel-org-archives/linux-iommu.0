Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF821CC4D
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377576; cv=none; b=VBD/iE9x/NK4hqgcdJ6hY1Mok7P7rI82fxr8mE5A2ePU3380KR2goVPmYeq4RRv/Bjt/2s2jWf8TjlbsqA6+UZxvrz0Rij4+gZkCsC/eyuxp/XrUDQKvL8ZPSlLh0OpR4wyUDPuvIFVsHf71HY4J5bw+vTY+0Mi+EpzRpvcl5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377576; c=relaxed/simple;
	bh=ixzCasUR5DlYgcLxz0hPF8VFKi85Ab49CtACUu9qu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toZS5TsYFYZ669164G4sji7y0JpxMKU770yAGjpOdr6kiRhUb1g3CSq4VJOHosSpn0GuOtMBOnzhGn/c7YzgNlzx4Grrvh/q+BqPRKk2XnmhvuwE6P8MXCxPx0fvvNbXJtZ2c/mc6Xxtk5lQTEGnumubOZMFi5bfuxohsyfv/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=S0eikm+E; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="S0eikm+E"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7B6F249E6B;
	Fri, 16 May 2025 08:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747377571;
	bh=ixzCasUR5DlYgcLxz0hPF8VFKi85Ab49CtACUu9qu6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0eikm+EZYq9g5tFFiZ6qfJzDHBvvUft1H/TEEdbipS3WDgXgTPXdax5d0m0CFL3F
	 aReESGOXG+qNVNFqUq/zojJ/KeflAWkgtxltXO3Nynuk6yEh97bQM3xg3mIB9P4Ai9
	 ftxbsYhNj1g2fq1B0VMQ58QdAKp5j8TMU5yInaKMXpX+czkAFsBj+Q331d88sO/g8X
	 MNdDU8DSKmc2t/pPbdo38/p/6Y6Z8VqPCQMS+n/Bhz9Sf9vWVZ/pV9MaWkVBDyXglO
	 WI4UKG4HCHC2/2ew9cx9CBg0kJimwzK4c7XL31z274wwhMe1159zO8X//OZI0i7dUA
	 e75U/LVYYV2SA==
Date: Fri, 16 May 2025 08:39:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/fsl_pamu: remove trailing space after \n
Message-ID: <aCbdoCdyuVhYz6E6@8bytes.org>
References: <20250430151853.923614-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430151853.923614-1-colin.i.king@gmail.com>

On Wed, Apr 30, 2025 at 04:18:53PM +0100, Colin Ian King wrote:
> There is an extraenous space after \n in a pr_debug message. Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

