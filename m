Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92022126B
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368315; cv=none; b=qnY5uGLOccmWpvcvrAj7GN+L2vhqLo4Fi5USrflCxdwgZtbnhNvm3eTuSA7mljnHvL//Ta6ZDu9Y86pic0zqxB1sswYQno11IJSnxmZfEGL3NfPNAgToqM9oeSo3xBgw60yNJRGMbSaBsiDIdZocu2IHfP0cj+MLHT2it+6pgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368315; c=relaxed/simple;
	bh=2K2UtTXIu1TLmaoMSN6Rl21RoiWylh/+IQqQ++fQ1oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs7bag4TXhtMv4UcejYtcBymgUf6IJeso4k22PUXelaQLvu/qGTCan1CvodmevvV2aXovl7n5NKBZHBtVPBJSbpevI3Hjxp27QkoE6SG17uvoMe5Hk7K4v52F/HJmRQuKCR2sQTyy6lLgSFxj2hrFJLVH7YS+DYFT8b7RFXA2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xQGjZOiX; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xQGjZOiX"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CF96D47D2D;
	Fri, 11 Apr 2025 12:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744368311;
	bh=2K2UtTXIu1TLmaoMSN6Rl21RoiWylh/+IQqQ++fQ1oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xQGjZOiXT4O1vOT67iNfe/6y1h61IBPDdS6R64Pmwrb5MbJI7Uoj0BIGWwSOGxBdM
	 QVTJcnmovZrc8mxAc1n4rRVmEudBfT3HmOGHmclBWH+iSp1NNCzc2F0KxdATVzQfpD
	 PtiwYdmoQdAeilf/MejyRqXLty62Df3wadu8JcqF0yapGWGgfhTkg8Zt+ITklOacTy
	 pNYzZQcNsdoKOlstPqh/kzNZxZafaca+gBACZtj/wRsNxpSiM5QYpbqWU++KF/JuZp
	 9Zu3KLtRmCos8yZUpU7YO+RSai2RKs7jBmYBt3WJM+G7Kc9lm55S5Jwz5RAygaCW72
	 eEPPOKqY+hIGA==
Date: Fri, 11 Apr 2025 12:45:10 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com, robin.murphy@arm.com, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc v2] iommu/tegra241-cmdqv: Fix warnings due to
 dmam_free_coherent()
Message-ID: <Z_jytpEPKzzKAxKo@8bytes.org>
References: <20250407201908.172225-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407201908.172225-1-nicolinc@nvidia.com>

On Mon, Apr 07, 2025 at 01:19:08PM -0700, Nicolin Chen wrote:
> Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v2
>  * Fail tegra241_cmdqv_init_structures() and let devres take care of the
>    lvcmdq queue memory space
> v1
>  https://lore.kernel.org/all/cover.1744014481.git.nicolinc@nvidia.com/
> 
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 32 +++----------------
>  1 file changed, 5 insertions(+), 27 deletions(-)

Applied, thanks.
