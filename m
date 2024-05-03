Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14514BF85;
	Fri,  3 May 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731169; cv=none; b=KUodiy9g5q+kq+HcE8JHo136CFO1u6XeIQ/PZe6vrADjvJUIoAQEvx5LYIP6vJgZ5Oo81EE0yvJ5PLC2WZ7RFnO6finFYGZdIY54uX8++qBJLV4cgKMaZPPDu77v5WbS/Tt3kaAFCaerNm4JS14IBvCVKrNj6+7FXPA8fzrzmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731169; c=relaxed/simple;
	bh=ZNkkgfUgblxttORpbrcYRrdNu8y94sD78Bf9M/Ujacg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLbIZX5Q2NC2LtOzxX35rKt6WE9TL27IhKj9d2qrzEa7jUvL273/iLuf+qf0pXYLdfvSFCZzQ/f+QKxQPxyJr+xDuwXn0W21s0n84wl/yfcEUXWLMpiz5YBWQqyrJeuMuOqHMHeALx0aE1AfW6v7DyNvFhdx/MSvmKEufNOTPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JMMpJYtU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JMMpJYtU"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 008D01C0C95;
	Fri,  3 May 2024 12:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714731160;
	bh=ZNkkgfUgblxttORpbrcYRrdNu8y94sD78Bf9M/Ujacg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMMpJYtUPxC8L2Z/3QBXO8LuGNO8wc6UhzEadiLNKfZQjMgJhbC1rY2XTMpo9C68K
	 +4ERF56ePef8zFOMQq7UN//bdeLW+wMU8iYfcceYor7dtmF8yV7tLMIne3SPOZQCFX
	 oI27K9g0CaTpTgpgXfyqWL3ge0AG5+2NybT9imvYIr8qlRI2yZdN4R5vUlajZj+nAN
	 f0oX96y+sfWqRfrSZKEPK4yHV2tGs7PYbBzqXPqY21vJ59Duqjnl5BJzYAv3PGFIA5
	 WcP5KjYYQXcwdC6N/qbPQ4wIBUqNbWAFBgnBTBuN3GOFxdgMBR7nVhymmSAA9g7fIP
	 1a1JJEFLQJV1w==
Date: Fri, 3 May 2024 12:12:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] iommu/amd: Fix compilation error
Message-ID: <ZjS4ljD-NurzIa3y@8bytes.org>
References: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>

On Mon, Apr 29, 2024 at 02:17:07PM +0300, Andy Shevchenko wrote:
>  drivers/iommu/amd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

