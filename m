Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13313DDBA
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270104; cv=none; b=agEau+RNOUh+uQFb4WeSKrOgbjZWRHtcacDpvrBSV1PwW5h55gMyJ9VOXMDbXWuhIkwyRgqfjZ62GbCjBm/DjZVP8b0Rg5RK/LZZslpaEuq9S86x09k0feAEkp7qXEfCFsKaD1Z2yfWmgkPLwEYf5+l8UcQRWrbisZ0gQvSenYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270104; c=relaxed/simple;
	bh=bpGRNbBfCqyFGfItJ4k3/3+Ze/L/FmzCPu/d7k2QK9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6QMF3VPcGj4iIFzMGerUfszeS9gSa40YjdHNc97kuO+93y5Mudp7/DGlNdmU9rkR+gBWPm5mUhkCehAc4I3dvvsv7NW6oHVewQHOuZi7apCte2Xmp5MGQDDhi2tOP2zTfZozRHTsqK5+fDFRWpSm3f/8JbVZQxtUjyklNXp5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UHTBUjHo; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UHTBUjHo"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1ECB21C81F5;
	Thu, 13 Jun 2024 11:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1718270101;
	bh=bpGRNbBfCqyFGfItJ4k3/3+Ze/L/FmzCPu/d7k2QK9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHTBUjHosfefB0JjjGbC1Zqu0+8+z3UFWdNufPd4Alr3tWHxUlRIvdZ1lQp+Xrq82
	 lnHt7nNcem8ME68XtDxOqJouMxUanx2JoVQ9/dzEXDLldkBjfCIXJfpy/X5wTrG9/g
	 37AYEMYGCnsXCsYtzXiMDDD7pCohfuPmYM9TCsUY7Q5Ouoqd+hCaJzAvuagrXWEoN0
	 B5b9Eydm2be/N46yMh9sCWfujJIzgRTrxupPlyp6qnvDp5k3XJ4NTxyy8XsPO77FPI
	 sRfm8+RBZGbTt33QlLaI+6GvKP/ivy3bLrZ+gLYpQfhKyjS/EsK03pQ2pHVJmqaeaC
	 /Nsr4CJAhJ7OQ==
Date: Thu, 13 Jun 2024 11:15:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Message-ID: <Zmq4lJCHJSmQ-vJf@8bytes.org>
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528045458.81458-1-baolu.lu@linux.intel.com>

On Tue, May 28, 2024 at 12:54:58PM +0800, Lu Baolu wrote:
> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
> static.
> 
> On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
> removal of inline code avoids potential confusion.
> 
> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 8 --------
>  drivers/iommu/iommu-sva.c | 6 ++++--
>  2 files changed, 4 insertions(+), 10 deletions(-)

Applied, thanks.
