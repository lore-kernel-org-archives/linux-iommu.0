Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C4224224
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595425; cv=none; b=CmMVrgZ4nJZaI/bwh03MwgkVd5xBUK8FwqMVTfQrNlcq3zBsvAAbZQeEDf4lcAKDzUzOYfVtuPSl7c5nb/snLoB8dBLy0bPh3QFchxFivqCK7/4BliGbX/TdV5KSWYKTvegni3kMUxy8lf/a7uVMXlDZNIBBYRgKS9LOhlNHmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595425; c=relaxed/simple;
	bh=HwN+dMCIV2g3/Ee1xnAmiVbSX//TRUMM3eFefYG1bBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4FJYR6AIOKO+BP9GmGyN+IZ44f9d7VHhH9cLMxYeiozkGRaeWciLOnDMtUqhIjElkL2ziO8/QFs4zh9HmML112Lhsu7FQFVp+1wPJVPvVgfZUFgzIUCqygsA3+fy7tkLU567oO9dmQEPw4tZrUD+FCWYndD+rGtRRbsOWo2DIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=iN7qCdT3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="iN7qCdT3"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0F430451A7;
	Mon, 10 Mar 2025 09:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595064;
	bh=HwN+dMCIV2g3/Ee1xnAmiVbSX//TRUMM3eFefYG1bBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iN7qCdT3QAh3ubv3XH5W2RW8LFNumIbzQ0iAUeAltlJ/sHFGBue9nz54CE1xCkvfZ
	 Td0sAlwGt/WP7ba9RK7yusVD8pVG/9FTZM6uhcwGTKH8lfL8tSXUo9ZPPLYUAA/I4D
	 MpxCijiHKywv/L3I9QfIKoCV1rDaAfUEFpQVtrXBebQXbCmu/aD2KgbNGymSy8oGNr
	 IV2IiFkHQd3H2c+Rnlmz2WIwNh+132+V0o1FEXFGIf6XArjRp0yJC6G6mvoFupzCky
	 GdZIV2LQHUa45YoGZGm0CCXF0lpahbfa5Fe9JCUgPYaaV06+jYbq+eDz5zDTpVhDTs
	 lawg6FmPVzm3w==
Date: Mon, 10 Mar 2025 09:24:22 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, yf.wang@mediatek.com
Subject: Re: [PATCH] iommu/dma: Remove redundant locking
Message-ID: <Z86htswCMoruhkSC@8bytes.org>
References: <a943d4c198e6a1fffe998337d577dc3aa7f660a9.1740585469.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a943d4c198e6a1fffe998337d577dc3aa7f660a9.1740585469.git.robin.murphy@arm.com>

On Wed, Feb 26, 2025 at 03:57:49PM +0000, Robin Murphy wrote:
> This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
> 
> iommu_dma_init_domain() is now only called under the group mutex, as it
> should be given that that the default domain belongs to the group, so
> the additional internal locking is no longer needed.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Applied, thanks.
