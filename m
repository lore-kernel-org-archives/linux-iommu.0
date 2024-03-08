Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC342D634
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884758; cv=none; b=pzDuLgBm7ENgJjYjDR1KDVpuqlxGSBv4TRM9Qp4KyEY8rvv5Dv4h74r1IFLNRFot3IxhBiRqVlEhSoNMKxf5l0A4O9g8K/A+sfJOqY7EV+hu/whtLYRD07PRoHMobDclirXn+IoJ5R3lGKmPNeIPBnAoRJI9u0ZMOhfTBr7WA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884758; c=relaxed/simple;
	bh=eotilOTTCCHE+83invpPHFgTQ065jrmvOIJHiBprTHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVQgVg0bcFa4x8oRGZP+BJqCf4N4iCHaRaoEU1T62v/vzUzxd7fGtxVQc9L+hXw+xoLHOCN2WPrI23FhgIfD8VswENCZ4B5cwiodCH+fNKSRTLCXldXj50J8lNKTZT4un3sFS1grMOpMkk4oaAlAyf74EEQu6t4lmur5/esUf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=D/T45uAO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="D/T45uAO"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BD4FA1C69F6;
	Fri,  8 Mar 2024 08:58:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709884732;
	bh=eotilOTTCCHE+83invpPHFgTQ065jrmvOIJHiBprTHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/T45uAOCY7JJu7csyxTa/V5MhvMHdekeMnw0Ndly5oN6X71sRUM6HpM9wm+RmCkB
	 JmI+9IjwgOvUg4fGGm2R3YtZW/vLLY0GC+xjXXJLqLDI3qjE2U9zafOs5jRo610wZy
	 fleD8TplaPhK8LIRffHEiFx5PGtrhex0Q+P9kv6Sad6CjThpeaGIUsqlivuicCwhpD
	 M5xyKJ/FpHHCSOAaapBl6gklj0pQDGjoPAXNLh8GCtvLSNb3s8DizZTU6QlqOXi+37
	 PAn/4BcVqTxUXybmmUbB9XaNnHkTJCtqSLeEleOzKu8+uB7nu+NzHfHFALh5uMduED
	 quxGEZfQXFzcg==
Date: Fri, 8 Mar 2024 08:58:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iommu/amd: Fix sleeping in atomic context
Message-ID: <ZerFO7wiYEYVe6i0@8bytes.org>
References: <20240307052738.116035-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307052738.116035-1-vasant.hegde@amd.com>

On Thu, Mar 07, 2024 at 05:27:38AM +0000, Vasant Hegde wrote:
> Commit cf70873e3d01 ("iommu/amd: Refactor GCR3 table helper functions")
> changed GFP flag we use for GCR3 table. Original plan was to move GCR3
> table allocation outside spinlock. But this requires complete rework of
> attach device path. Hence we didn't do it as part of SVA series. For now
> revert the GFP flag to ATOMIC (same as original code).
> 
> Fixes: cf70873e3d01 ("iommu/amd: Refactor GCR3 table helper functions")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
