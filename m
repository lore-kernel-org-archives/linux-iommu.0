Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A9923CC;
	Mon,  5 Dec 2022 10:53:18 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E2AC52202AB;
	Mon,  5 Dec 2022 11:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1670237598;
	bh=6FHDaNEUvC+Otfa6SO4ujCIHCtJA8iZiWNcWrFniOc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePZmoXfI68UsYR+OLH7xxXKuTmuGm0CRbPQKXxhpC5MDtgrj++kkXGm7E42G/vGKd
	 OOwUZ1dymkzxf7O6CX7MQSJ12iuy6ENMQ6KWJywvZOaHTyZqNe8q0uuOY+I5VDak02
	 7ipP2sKGnvVSOxi40K5vP+CukP/wuwXQ3cvP+glETZ7oJzCx8cNd7MGXVHeKqvT1m2
	 2NtnfKqj9a5d5QBvNfps+TskFAqxMi6Gor8BmtqXnGc8CksImogPdsl97Enwl9p+D2
	 TQPs609ogM79efiuaBxwsp5ZcCrA/7AQAmCKe0NtNrpo12P/G+tRKlXoyoI//HHA2b
	 Y4ReGn3ZiU05A==
Date: Mon, 5 Dec 2022 11:53:16 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/sun50i: Remove IOMMU_DOMAIN_IDENTITY
Message-ID: <Y43NnDhS8saBM/JP@8bytes.org>
References: <0-v1-97f0adf27b5e+1f0-s50_identity_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-97f0adf27b5e+1f0-s50_identity_jgg@nvidia.com>

On Mon, Nov 28, 2022 at 10:06:28AM -0400, Jason Gunthorpe wrote:
> This driver treats IOMMU_DOMAIN_IDENTITY the same as UNMANAGED, which
> cannot possibly be correct.
> 
> UNMANAGED domains are required to start out blocking all DMAs. This seems
> to be what this driver does as it allocates a first level 'dt' for the IO
> page table that is 0 filled.
> 
> Thus UNMANAGED looks like a working IO page table, and so IDENTITY must be
> a mistake. Remove it.
> 
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Applied, thanks.

