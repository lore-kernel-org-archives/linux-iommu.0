Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4813C690
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595204; cv=none; b=E8OxQ530ZbfnoRNGq6i4x7VTG59/Ldj18W1Hqt1zYyx+Nr4GgB3D5TTg3ECOIAZWzuulwBz3RYG91EJdDQUU0OYPTUCSFjTLmOiFv+/Yf45fSH0OJP0eyFVT7pbocq7T46I9IeBWf4hV7c38M0K0TP0YnZIIj8KQjtRC3hYyAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595204; c=relaxed/simple;
	bh=bE01/5HtYQ+8KrJnIhvUfa6n4CzDCTpfid7pjy+W+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heo/cUMzJn8AWZmgZFWzipWnfyRnPmOc7t4kixHUb2kbQ/DZvhSk5FNFud5WnvIWgpfPqSkAJ8eGGR9bdkVN8SVPFIMjjwsMpaTXeKv6sj0FUboZryKSgFDkXbU7/EDaz0jz/zRDJfhQhzxp8dehXRUIWrkm1imkqoZM19keGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FFkQWUmF; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FFkQWUmF"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 687D345229;
	Mon, 10 Mar 2025 09:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595200;
	bh=bE01/5HtYQ+8KrJnIhvUfa6n4CzDCTpfid7pjy+W+BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFkQWUmFfWfepYBo/07hceo5T4Pq9/ordsitcigm4MztDsEYQsIjKQeLEN/kN6GD+
	 klLprkMo4MTJ6Rn/zYTAuwVcyCixdbgFJRGVmUZHMZJ2FqJBrlxX4mFTZU/noyeNfS
	 8WBajjZcCha47RqIm+8uhGfSS4wb2qa/GMfkRlXflKToMST+qRcGdhjq0fPWe+JCUH
	 J9xCgJsVJiPD4kDY/Oq/pcxUX5szf3hm87LEAeOMYCQ2D3auNpxXCqR3S2kyffSlRE
	 qyve6Nb9bJkAqjggMNJIrNN8793QFgh1Fn7zfMla3gD3dnFnw5RIRGDdl/jk//Oh37
	 GoDhO8nrCGS0A==
Date: Mon, 10 Mar 2025 09:26:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com
Subject: Re: [PATCH] iommu: Unexport iommu_fwspec_free()
Message-ID: <Z86iP6_qe5HwndM7@8bytes.org>
References: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>

On Thu, Feb 27, 2025 at 02:47:47PM +0000, Robin Murphy wrote:
> The drivers doing their own fwspec parsing have no need to call
> iommu_fwspec_free() since fwspecs were moved into dev_iommu, as
> returning an error from .probe_device will tear down the whole lot
> anyway. Move it into the private interface now that it only serves
> for of_iommu to clean up in an error case.
> 
> I have no idea what mtk_v1 was doing in effectively guaranteeing
> a NULL fwspec would be dereferenced if no "iommus" DT property was
> found, so add a check for that to at least make the code look sane.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  1 -
>  drivers/iommu/iommu-priv.h            |  2 ++
>  drivers/iommu/iommu.c                 |  1 -
>  drivers/iommu/mtk_iommu_v1.c          | 14 ++++----------
>  drivers/iommu/tegra-smmu.c            |  1 -
>  include/linux/iommu.h                 |  5 -----
>  6 files changed, 6 insertions(+), 18 deletions(-)

Applied, thanks.
