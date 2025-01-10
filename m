Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF120B807
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513628; cv=none; b=H5JIsgEMY+hLFSfI84DxUriOKZQzgKBlGWnIWN8l0sP2J4frQKl9DIJKULjsaQYEd9v0d1PFJoBT5KljtRJph9dyNQkoCzCyb2A4cYmL6itTa5+10xOuj+Tti6zF4sXuPTRz7ESzgcHXh93Y34qeb5QbJjTFMR8LixevnytN1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513628; c=relaxed/simple;
	bh=crMj9+IU7YLi4f1z4d/eNJ89+M+dyB76TszBCnCScYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP5heioiNyGlziiZ+92Oe2TCHarjmc1+ZK5yGDDIDSe7N6nAPJhb4b13c+Lakwp5Tib33ytGTLB++/ky4Ozu86F87TxK1cuUHE/sHBEZl+QZYJ9oMmZswoIpPO3J7SQbDs2Bv12VOD4Dtu/IBQtLWd7lSfchZg4Qlt6J27BBqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no7gD5XX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no7gD5XX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB19EC4CED6;
	Fri, 10 Jan 2025 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513628;
	bh=crMj9+IU7YLi4f1z4d/eNJ89+M+dyB76TszBCnCScYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=no7gD5XXfDy80NSF/WZD290kxzS749dr2H7SvzKRKrpJ0+H3C/FqNLJ1EaHt9is7+
	 CgicRllB6PNi0QAccTXQFwQNTyeu92DaWEjgfRepF9LmqJ20/wYNrLaeCMrX8Am2kk
	 YP0EoAS5iyXUBxBBA1QksFqekQpKuUbKk5E1mVH3gXC/Lf+/PWs2VkqtPZbVYulhM6
	 P5jLFMF+A76mfVC0vBInngznVU21FY2Y/Ec64RE+YiJ4XfRnjgOM9Grjv3ylY9VBSI
	 9aBoRonqcCfi+CKLyvGj+CwCThGq4flhwbeZ4RNYwuJNiTd7CVD2BqH/htnSyOWgXZ
	 r7csoQwn0Yy4w==
Date: Fri, 10 Jan 2025 12:53:43 +0000
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
Message-ID: <20250110125342.GA11431@willie-the-truck>
References: <20250107165100.1093357-1-praan@google.com>
 <CGME20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe@eucas1p2.samsung.com>
 <d07e82a4-2880-4ae3-961b-471bfa7ac6c4@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d07e82a4-2880-4ae3-961b-471bfa7ac6c4@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 10, 2025 at 12:18:02PM +0100, Marek Szyprowski wrote:
> On 07.01.2025 17:51, Pranjal Shrivastava wrote:
> > Adopt the `str_read_write` helper in event logging as highlighted [1].
> >
> > [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
> >
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> This change landed in today's linux-next as commit f2c77f6e41e6 
> ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs"). It fails to 
> build here with arm64/defconfig on my setup. It looks that it misses to 
> add the following include:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0e4cbb2c64d7..a0e395da8a88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -26,6 +26,7 @@
>   #include <linux/pci.h>
>   #include <linux/pci-ats.h>
>   #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>   #include <kunit/visibility.h>
>   #include <uapi/linux/iommufd.h>

Hmm, I build and test my branches before I push them so this is a bit
surprising. I just confirmed that it's building with arm64/defconfig
for me, so lemme dig into this some more...

Will
