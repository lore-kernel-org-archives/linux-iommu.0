Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC515487
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tWIHKPxK"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 16D351A6642;
	Mon, 27 Nov 2023 10:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701077649;
	bh=EG/ojyaJMccrAOcLiHosq+7W8xRv5y9RB3ExJ0LaSHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWIHKPxK+fK08TN+PjJHjtm9snevJGnWXWZjpi45V5XvqVScYs07M8EaA15xPd5dK
	 Inu2yd8INV5jcFskBypJSKEjP+qwV33Tw8D1Uj38F6DZqzob4v6P8WGf+rRfBbrP2K
	 VAfBO/MWO32hNrApDADvxNiiyx60zRBe6DLHdMYGh+I61vEthnNeuZUCXypmTeYfrf
	 DuqXMScEZzJpmhNa0k6eT1IYvzbzuh1p7/i/PEllZkIRnMXDdPnPxEqlqhQ/Uo3Vl2
	 o905wAv32XTH7BbpM8c8GiQdhXev2co92o45hovaVXKI1r7Klmv/oTL9NZyIdrr8Jd
	 cke2ivDtbI6bA==
Date: Mon, 27 Nov 2023 10:34:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v2] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <ZWRij0ZHnXSejDaV@8bytes.org>
References: <0-v2-55ae413017b8+97-domain_alloc_err_ptr_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-55ae413017b8+97-domain_alloc_err_ptr_jgg@nvidia.com>

On Wed, Nov 01, 2023 at 08:28:11PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/iommu.c | 59 ++++++++++++++++++++++++++++---------------
>  1 file changed, 39 insertions(+), 20 deletions(-)

Applied, thanks.
