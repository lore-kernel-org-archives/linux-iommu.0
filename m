Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890582DC765;
	Wed, 25 Mar 2026 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461387; cv=none; b=l3Ltw3L5wDI5sT2CQQaGw5jGqOZmDgY9izjD69mqXo/wxzSNPrwEKILWhtolT92QD4fgDzY4HbnsJuPBEiT/AXNN79gOq4yqxkKRa1w/16x6Yk/VwS8nzVH+RuH+nVgppKa3mLRPD4WnFWiDj2qL7n/jw7iHVcZTfXJs5RIE7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461387; c=relaxed/simple;
	bh=tiWAIK7f5uEDs4KjDPjwPVo3mK9lVorkQhptY/3rlig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPgAfi/Iv7bmwygsCiEgC/w7vPJmHvYA4yJIJwpD2Un9wsHQDIBQ+5h3mmmBbYIx6OQtAbN4hyx+0JUno/qYmqH7lOOrZko3yi9mK0QkDG0u0qfZR1QfPFqJ6yFlLWcNZHqvaLHlUGzYw0jcH7iUhCWQ37gd3drSea1Uj5UZkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcHldscE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcHldscE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D1C4CEF7;
	Wed, 25 Mar 2026 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461387;
	bh=tiWAIK7f5uEDs4KjDPjwPVo3mK9lVorkQhptY/3rlig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcHldscELnoPAv4Csmh+g6cJ5n05Km8qvIiHMbZqmEEaojRPSkwlXercUY/xRv/u/
	 7m2qMEGsQ/EwUm0gDWhFojYwyNouyIvN+JBdOn6uxgJOhfh8EJOEPFu6oa812EGFUq
	 Jr7CHr6CN219a4BsyDKuHCEOZEUvsods28399SxC+q5xZIPY+8+LE9/zjx0NtRpq9H
	 x1WI6njJGv6jjPm6iWaaBLA0d/DyilftamdcOi62KhtlzCWN5VFCC/tRDMMSmhHzuw
	 l+TKMhs1icbFDSK0iXeYCHZyERi13HDVxFUjqnHGru6WGp7TWANzOt9U7DWZmiDIY7
	 qqZxI+xgqMFMw==
Date: Wed, 25 Mar 2026 19:56:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: ensure mappings are created and released with
 matching attributes
Message-ID: <20260325175622.GS814676@unreal>
References: <CGME20260323202058eucas1p1946c1763123f2ceb493ebef25165f453@eucas1p1.samsung.com>
 <20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com>
 <6d0eabf8-06c6-4b87-ac73-e6e4136c0691@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d0eabf8-06c6-4b87-ac73-e6e4136c0691@samsung.com>

On Wed, Mar 25, 2026 at 06:28:41PM +0100, Marek Szyprowski wrote:
> On 23.03.2026 21:20, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> >
> > The DMA API expects that callers use the same attributes when mapping
> > and unmapping. Add tracking to verify this and catch mismatches.
> >
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Applied to dma-mapping-for-next, thanks!

Thanks a lot.

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 
