Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4823099F
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195789; cv=none; b=gJu5KGgAkaZLeOiVi+fa2JaEk+5ODFRCtVdbBFELYAlHgnY9qEenFOxEf9Iq/+0PxpEd5OqVCTRZs41BKPNhxoNZWQkhJ6eT3V6Lzprl2Q7MtIWht3H66WqHdAq7i19ryz1mmO14V4l99vusgEQ8HU2aUstra+5ltV1wnlgTp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195789; c=relaxed/simple;
	bh=rg8scUOnYxi+bVfapaE6BRs4ba+F40ddEiWf2X94Xzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik1EhQFeSlAi4doRJHGnfDNxgfW5AICUSrtyGe5KWBrQxCtAC8msSxcxVqtNwq59KCc75yiM0+mVcXAJQ3w/CtN2f8AmRBqSTfpb6yIeLF1oeAvWdmj+YM1YZ7szFBF7gG6WudqW8whtcdgXaK+EL2knchCaYWTzK4xy2EKbKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=I/QRmJnS; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="I/QRmJnS"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AE96C41FFB;
	Mon, 10 Feb 2025 14:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739195785;
	bh=rg8scUOnYxi+bVfapaE6BRs4ba+F40ddEiWf2X94Xzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/QRmJnS6IVNJR8b4xfYiQlO+6x1MAt57tY9PNNlBDLAVudUyQft4qiE8xpUUAcjJ
	 5dWOhFkhzWYalEweRZQm1ElwFdm9MY8MsKZpgZv//NaK4zS3NsAcWRf0GfeobEbw3g
	 pAFpGr1/lAX4sJSY9Mu7ZcT10f561+adaYu40StXZ0ukNdbgvsBeQC35juHm7pcftK
	 BuimgMxlG8e2sMWZNKtp6VZxN258M/ysbBHzeiSgGrGKUSmbCbBpmWCR5PpvS1MzKN
	 LoipCDmhJbQjzFXD3p9FmOO5kRei3FxQQe5/oiyKyrj0L2pO49eTaLUu5RubFs+3yy
	 OunFZhRAKMj2w==
Date: Mon, 10 Feb 2025 14:56:24 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/exynos: Fix typos
Message-ID: <Z6oFiDMauvXp4BmR@8bytes.org>
References: <20250210112027.29791-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210112027.29791-1-algonell@gmail.com>

On Mon, Feb 10, 2025 at 01:20:04PM +0200, Andrew Kreimer wrote:
> There are some typos in comments/messages:
>  - modyfying -> modifying
>  - Unabled -> Unable
> 
> Fix them via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  drivers/iommu/exynos-iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied for -rc, thanks.
